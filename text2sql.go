package text2sql

import (
	"context"
	"errors"
	"fmt"
	"strings"
	"sync"
	"time"
	"unicode"

	"github.com/wangle201210/text2sql/eino"
	"github.com/wangle201210/text2sql/mysql"
)

// Text2sql 结构体定义了文本到SQL转换的核心配置和状态
type Text2sql struct {
	Config
	eino *eino.Eino
	db   *mysql.Db // 数据库连接实例
	ddl  string    // 数据库表结构
}

type Config struct {
	DbLink    string // 数据库连接字符串
	Try       int    // 单次生成失败后的重试次数
	ShouldRun bool   // 是否执行生成的SQL
	Times     int    // 并发生成SQL的次数（1-10）
	OnlyView  bool   // 是否只使用 视图
	OnlyTable bool   // 是否只使用 表
}

func NewText2sql(conf *Config, eino *eino.Eino) *Text2sql {
	if conf.Try == 0 {
		conf.Try = 1
	}
	// 规范化Times参数
	if conf.Times <= 0 {
		conf.Times = 1 // 至少运行一次
	} else if conf.Times > 10 {
		conf.Times = 10 // 最多10次
	}
	return &Text2sql{
		Config: *conf,
		eino:   eino,
	}
}

func (x *Text2sql) Pretty(question string) (sql string, runResult string, err error) {
	var res []map[string]interface{}
	sql, res, err = x.Do(question)
	if len(res) == 0 {
		runResult = ""
		return
	}
	// 优化回答
	runResult, err = x.eino.PrettyRes(sql, question, res)
	if err != nil {
		err = fmt.Errorf("优化回答失败: %w", err)
		return
	}
	return
}

// Do 执行文本到SQL的转换过程
func (x *Text2sql) Do(question string) (sql string, runResult []map[string]interface{}, err error) {
	// 参数验证和初始化
	if question == "" {
		return "", nil, errors.New("问题不能为空")
	}
	if x.db == nil {
		if x.DbLink == "" {
			return "", nil, errors.New("数据库连接信息不能为空")
		}
		// 初始化数据库连接
		db := &mysql.Db{DataSourceName: x.DbLink, OnlyView: x.OnlyView, OnlyTable: x.OnlyTable}
		if err = db.Init(); err != nil {
			err = fmt.Errorf("初始化数据库失败: %w", err)
			return
		}
		x.db = db
		x.ddl = db.GetDdl()
	}
	// 生成SQL
	var sqls []string
	if sqls, err = x.getAllSql(question); err != nil {
		err = fmt.Errorf("生成SQL失败: %w", err)
		return
	}

	// 选择最佳SQL
	if sql, err = x.choice(sqls, question); err != nil {
		err = fmt.Errorf("选择SQL失败: %w", err)
		return
	}

	// 执行SQL（如果需要）
	if x.ShouldRun && sql != "" {
		if runResult, err = x.db.DoSQL(sql); err != nil {
			err = fmt.Errorf("sql执行失败，sql %s, err: %w", sql, err)
			return
		}
	}
	return
}

func (x *Text2sql) removeWhitespace(sqls []string) (res []string) {
	for _, sql := range sqls {
		res = append(res, removeWhitespace(sql))
	}
	return
}

func (x *Text2sql) uniqSql(sqls []string) (res []string) {
	list := map[string]int{}
	for i, sql := range sqls {
		list[sql] = i // 存下最后一次出现的角标
	}
	res = []string{}
	for s, _ := range list {
		res = append(res, s)
	}
	return res
}

func (x *Text2sql) findMostCommonSql(sqlsTemp []string) (idx int) {
	// 创建一个 map 来记录每个去空白字符后的字符串出现次数
	countMap := make(map[string]int)
	for _, s := range sqlsTemp {
		countMap[s]++
	}

	// 找到出现次数最多的字符串
	var mostCommonString string
	maxCount := 0
	for cleanedString, count := range countMap {
		if count > maxCount {
			mostCommonString = cleanedString
			maxCount = count
		}
	}
	// 数量 > 1/2就直接使用
	if float64(maxCount) <= float64(len(sqlsTemp))/2 {
		return -1
	}
	// 返回该字符串在原数组中的第一个索引
	for i, s := range sqlsTemp {
		if s == mostCommonString {
			return i
		}
	}
	return -1
}

// choice 从多个SQL中选择一个最适合的
func (x *Text2sql) choice(sqls []string, question string) (sql string, err error) {
	// 移除空白后进行对比
	sqlsTemp := x.removeWhitespace(sqls)
	// 如果有一个sql数量超过一半就直接使用该sql
	if idx := x.findMostCommonSql(sqlsTemp); idx > 0 {
		return sqls[idx], nil
	}
	// 去重
	sqls = x.uniqSql(sqls)
	// 如果只有一个了就直接返回
	if len(sqls) == 1 {
		return sqls[0], nil
	}

	// 使用strings.Builder优化字符串拼接
	var builder strings.Builder
	for _, s := range sqls {
		builder.WriteString(s)
		builder.WriteString("\n")
	}
	sqlstr := builder.String()

	// 选择并验证SQL
	for i := 0; i < x.Try; i++ {
		sql, err = x.eino.ChoiceSQL(sqlstr, x.ddl, question)
		if err != nil {
			continue
		}

		if err = x.db.CheckSQL(sql); err == nil {
			return sql, nil
		}
	}
	err = fmt.Errorf("SQL选择达到最大重试次数(%d)，最后一次错误: %w", x.Try, err)
	return
}

// getAllSql 并发生成多个SQL候选项
func (x *Text2sql) getAllSql(question string) (sqls []string, err error) {
	ctx, cancel := context.WithTimeout(context.Background(), 60*time.Second)
	defer cancel()

	wg := &sync.WaitGroup{}
	sqlChan := make(chan string, x.Times) // 使用channel收集结果
	errChan := make(chan error, 1)        // 用于传递第一个错误

	// 启动goroutine池
	for i := 0; i < x.Times; i++ {
		wg.Add(1)
		go func() {
			defer wg.Done()
			select {
			case <-ctx.Done():
				return
			default:
				if onceSql, genErr := x.once(question); genErr == nil && onceSql != "" {
					select {
					case sqlChan <- onceSql:
					case <-ctx.Done():
						return
					}
				} else if genErr != nil {
					select {
					case errChan <- genErr: // 只传递第一个错误
					default:
					}
				}
			}
		}()
	}

	// 使用done channel来确保所有资源都被正确清理
	done := make(chan struct{})
	go func() {
		wg.Wait()
		close(done)
	}()

	// 收集结果
	for {
		select {
		case <-done:
			if len(sqls) == 0 {
				err = errors.New("未能生成有效的SQL")
				return
			}
			return
		case sql := <-sqlChan:
			sqls = append(sqls, sql)
		case err = <-errChan:
			cancel() // 发生错误时取消所有正在进行的操作
			err = fmt.Errorf("生成SQL过程中发生错误: %w", err)
			return
		case <-ctx.Done():
			err = errors.New("生成SQL超时")
			return
		}
	}
}

// once 尝试生成一个有效的SQL
func (x *Text2sql) once(question string) (sql string, err error) {
	if x.ddl == "" {
		return "", errors.New("没获取到表结构")
	}

	for i := 0; i < x.Try; i++ {
		sql, err = x.eino.GetSQL(x.ddl, question)
		if sql == "" {
			continue
		}
		if err = x.db.CheckSQL(sql); err == nil {
			return sql, nil
		}
	}

	return "", fmt.Errorf("达到最大重试次数(%d)，最后一次错误: %w", x.Try, err)
}

// removeWhitespace 移除字符串中的所有空白字符和反引号
func removeWhitespace(input string) string {
	// 预分配合适的容量以减少内存分配
	result := make([]rune, 0, len(input))
	// 移除反引号和空白字符
	for _, r := range strings.ReplaceAll(input, "`", "") {
		if !unicode.IsSpace(r) {
			result = append(result, r)
		}
	}
	return string(result)
}
