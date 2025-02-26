package mysql

import "testing"

func TestMysql(t *testing.T) {
	db := &Db{
		DataSourceName: "root:@tcp(127.0.0.1:3306)/note?charset=utf8mb4&parseTime=True&loc=Local",
	}
	if err := db.Init(); err != nil {
		t.Error(err)
		return
	}
	ddl := db.GetDdl()
	t.Log(ddl)
}
