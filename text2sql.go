package text2sql

import (
	"log"
	"strings"
	"sync"
	"unicode"

	"github.com/wangle201210/text2sql/eino"
	"github.com/wangle201210/text2sql/mysql"
)

type Text2sql struct {
	DbLink     string
	Try        int  // 如果失败，尝试多少次
	ShouldRun  bool // 生成后是否需要run
	Times      int  // 选填，1-10之间，同时生成*个sql后选出最合适的个，注意这个数越大消耗的token越多
	db         *mysql.Db
	ddl        string
	question   string
	sqls       []string
	removeSqls []string
}

func (x *Text2sql) Do(question string) (sql string, runResult map[string]interface{}, err error) {
	if x.Times == 0 {
		x.Times = 1 // 至少要运行一次
	}
	if x.Times > 10 {
		x.Times = 10 // 最多10次
	}
	db := &mysql.Db{
		DataSourceName: x.DbLink,
	}
	if err = db.Init(); err != nil {
		return
	}
	x.db = db
	x.ddl = db.GetDdl()
	x.question = question
	if err = x.getAllSql(); err != nil {
		return
	}
	sql, err = x.choice()
	if err != nil {
		return
	}
	if x.ShouldRun {
		runResult = db.DoSQL(sql)
	}
	return
}

func (x *Text2sql) removeWhitespace() {
	x.removeSqls = []string{}
	for _, sql := range x.sqls {
		x.removeSqls = append(x.removeSqls, removeWhitespace(sql))
	}
}

func (x *Text2sql) uniqSql() {
	list := map[string]int{}
	for i, sql := range x.removeSqls {
		list[sql] = i // 存下最后一次出现的角标
	}
	var sqls []string
	for _, i := range list {
		sqls = append(sqls, x.sqls[i])
	}
	x.sqls = sqls
}

func (x *Text2sql) findMostCommonSql() string {
	// 创建一个 map 来记录每个去空白字符后的字符串出现次数
	countMap := make(map[string]int)
	for _, s := range x.removeSqls {
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
	if float64(maxCount) <= float64(len(x.sqls))/2 {
		return ""
	}
	// 返回该字符串在原数组中的第一个索引
	for i, s := range x.removeSqls {
		if s == mostCommonString {
			return x.sqls[i]
		}
	}
	return ""
}

// 从多个sql中选择一个最适合的
func (x *Text2sql) choice() (sql string, err error) {
	// 移除空白后进行对比
	x.removeWhitespace()
	// 如果有一个sql数量超过一半就直接使用该sql
	if commonSql := x.findMostCommonSql(); len(commonSql) > 0 {
		return commonSql, nil
	}
	// 去重
	x.uniqSql()
	// 如果只有一个了就直接返回
	if len(x.sqls) == 1 {
		sql = x.sqls[0]
		return
	}
	// 从候选项里面选一个
	var sqls string
	for _, s := range x.sqls {
		sqls += s
		sqls += "\n"
	}
	sql = eino.ChoiceSQL(sqls, x.ddl, x.question)
	err = x.db.CheckSQL(sql)
	try := x.Try
	for err != nil && try > 0 {
		try--
		log.Printf("try: %d, err: %v\n", x.Try-try, err)
		sql = eino.ChoiceSQL(sqls, x.ddl, x.question)
		err = x.db.CheckSQL(sql)
	}
	if err != nil {
		return
	}
	return
}

func (x *Text2sql) getAllSql() (err error) {
	wg := &sync.WaitGroup{}

	for i := 0; i < x.Times; i++ {
		wg.Add(1)
		// 循环生成多次，取最相关的一次
		go func() {
			defer wg.Done()
			if onceSql, err := x.once(); err == nil {
				x.sqls = append(x.sqls, onceSql)
			}
		}()
	}
	wg.Wait()
	return
}

func (x *Text2sql) once() (sql string, err error) {
	sql = eino.GetSQL(x.ddl, x.question)
	err = x.db.CheckSQL(sql)
	try := x.Try
	for err != nil && try > 0 {
		try--
		log.Printf("try: %d, err: %v\n", x.Try-try, err)
		sql = eino.GetSQL(x.ddl, x.question)
		err = x.db.CheckSQL(sql)
	}
	if err != nil {
		return
	}
	return
}

func removeWhitespace(input string) string {
	input = strings.ReplaceAll(input, "`", "")
	var result []rune
	for _, r := range input {
		if !unicode.IsSpace(r) { // 如果字符不是空白字符
			result = append(result, r)
		}
	}
	return string(result)
}
