package mysql

import (
	"fmt"

	"gorm.io/driver/mysql"
	"gorm.io/gorm"
)

type Db struct {
	DataSourceName string
	db             *gorm.DB
	ddl            []string
}

func (x *Db) Init() (err error) {
	db, err := gorm.Open(mysql.Open(x.DataSourceName), &gorm.Config{})
	if err != nil {
		return
	}
	x.db = db
	ddls, err := x.getDdl()
	if err != nil {
		return
	}
	x.ddl = ddls
	return
}

func (x *Db) getDdl() (ddls []string, err error) {
	list, err := x.db.Migrator().GetTables()
	for _, tableName := range list {
		result := map[string]interface{}{}
		err = x.db.Raw(fmt.Sprintf("SHOW CREATE TABLE %s", tableName)).Scan(result).Error
		if err != nil {
			return
		}
		ddls = append(ddls, result["Create Table"].(string))
	}
	return
}

func (x *Db) GetDdl() (ddl string) {
	for _, s := range x.ddl {
		ddl += s
		ddl += ";\n"
	}
	return
}

func (x *Db) CheckSQL(sql string) error {
	return x.db.Exec(fmt.Sprintf("EXPLAIN %s", sql)).Error
}

func (x *Db) DoSQL(sql string) (res map[string]interface{}) {
	tx := x.db.Begin()
	tx.Set("gorm:query_option", "FOR READ ONLY")
	res = map[string]interface{}{}
	tx.Raw(sql).Scan(res)
	tx.Commit()
	return
}
