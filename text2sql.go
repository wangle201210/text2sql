package text2sql

import (
	"errors"
	"log"
	"strings"

	"github.com/wangle201210/text2sql/eino"
	"github.com/wangle201210/text2sql/mysql"
)

type Text2sql struct {
	DbLink    string
	Try       int  // 如果失败，尝试多少次
	ShouldRun bool // 生成后是否需要run
}

func (x *Text2sql) Do(question string) (sql string, runResult map[string]interface{}, err error) {
	db := &mysql.Db{
		DataSourceName: x.DbLink,
	}
	if err = db.Init(); err != nil {
		return
	}
	ddl := db.GetDdl()
	sql = eino.GetSQL(ddl, question)
	if strings.HasPrefix(sql, eino.UnrelatedQuestion) {
		err = errors.New(sql)
		return
	}
	err = db.CheckSQL(sql)
	try := x.Try
	for err != nil && try > 0 {
		log.Printf("try: %d, err: %v\n", x.Try-try, err)
		try--
		sql = eino.GetSQL(ddl, question)
		err = db.CheckSQL(sql)
	}
	if err != nil {
		return
	}
	if x.ShouldRun {
		runResult = db.DoSQL(sql)
	}
	return
}
