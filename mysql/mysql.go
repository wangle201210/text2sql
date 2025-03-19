package mysql

import (
	"context"
	"errors"
	"strings"
	"time"
)

import (
	"fmt"

	"gorm.io/driver/mysql"
	"gorm.io/gorm"
)

// Db 封装数据库操作的结构体
type Db struct {
	DataSourceName string   // 数据库连接字信息
	db             *gorm.DB // gorm数据库实例
	ddl            []string // 数据库表结构定义列表

	OnlyView  bool // 是否只使用 视图
	OnlyTable bool // 是否只使用 表
}

// Init 初始化数据库连接并获取表结构
func (x *Db) Init() error {
	if x.DataSourceName == "" {
		return errors.New("数据库连接字信息不能为空")
	}

	// 初始化数据库连接
	db, err := gorm.Open(mysql.Open(x.DataSourceName), &gorm.Config{})
	if err != nil {
		return fmt.Errorf("连接数据库失败: %w", err)
	}
	x.db = db

	// 获取表结构
	ddls, err := x.getDdl()
	if err != nil {
		return fmt.Errorf("获取表结构失败: %w", err)
	}
	x.ddl = ddls
	return nil
}

// getDdl 获取所有表的建表语句
func (x *Db) getDdl() ([]string, error) {
	if x.db == nil {
		return nil, errors.New("数据库连接未初始化")
	}

	// 获取所有表名
	list, err := x.db.Migrator().GetTables()
	if err != nil {
		return nil, fmt.Errorf("获取表名列表失败: %w", err)
	}

	// 获取每个表的建表语句
	ddls := make([]string, 0, len(list))
	for _, tableName := range list {
		result := map[string]interface{}{}
		if err := x.db.Raw(fmt.Sprintf("SHOW CREATE TABLE `%s`", tableName)).Scan(&result).Error; err != nil {
			return nil, fmt.Errorf("获取表%s的结构失败: %w", tableName, err)
		}
		if d, e := result["Create Table"]; e {
			if x.OnlyView {
				continue
			}
			createTable := d.(string)
			ddls = append(ddls, createTable)
			continue
		}
		if v, e := result["View"]; e {
			if x.OnlyTable {
				continue
			}
			var columns []ColumnMeta
			// 其实table也可以这样使用
			if err := x.db.Raw(fmt.Sprintf("SHOW FULL COLUMNS FROM %s", v)).Scan(&columns).Error; err != nil {
				return nil, fmt.Errorf("获取表%s的结构失败: %w", tableName, err)
			}
			createTable := fmt.Sprintf("CREATE VIEW `%s` (", v)
			for _, column := range columns {
				createTable += fmt.Sprintf("\n`%s` %s", column.Field, column.Type)
				if column.Comment != "" {
					createTable += fmt.Sprintf(" COMMENT '%s'", column.Comment)
				}
				createTable += ","
			}
			createTable = createTable[:len(createTable)-1]
			createTable += ")"
			ddls = append(ddls, createTable)
			continue
		}
		return nil, fmt.Errorf("获取表%s的结构失败: %w", tableName, err)
	}
	return ddls, nil
}

// GetDdl 获取所有表结构的字符串表示
func (x *Db) GetDdl() string {
	if len(x.ddl) == 0 {
		return ""
	}

	// 使用strings.Builder优化字符串拼接
	var builder strings.Builder
	for _, s := range x.ddl {
		builder.WriteString(s)
		builder.WriteString(";\n")
	}
	return builder.String()
}

// CheckSQL 检查SQL语句的语法正确性
func (x *Db) CheckSQL(sql string) error {
	if x.db == nil {
		return errors.New("数据库连接未初始化")
	}
	if sql == "" {
		return errors.New("SQL语句不能为空")
	}

	// 使用EXPLAIN验证SQL语句
	return x.db.Exec(fmt.Sprintf("EXPLAIN %s", sql)).Error
}

// DoSQL 执行SQL查询并返回结果
func (x *Db) DoSQL(sql string) (res []map[string]interface{}, err error) {
	// 创建只读事务
	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()

	tx := x.db.WithContext(ctx).Begin()
	defer func() {
		if r := recover(); r != nil {
			tx.Rollback()
		}
	}()

	// 设置只读模式
	tx.Set("gorm:query_option", "FOR READ ONLY")

	// 执行查询
	res = []map[string]interface{}{}
	if err = tx.Raw(sql).Scan(&res).Error; err != nil {
		tx.Rollback()
		return
	}

	// 提交事务
	if err = tx.Commit().Error; err != nil {
		return
	}

	return
}
