package text2sql

import "testing"

func TestText2sql(t *testing.T) {
	data := &Text2sql{
		DbLink:    "root:@tcp(127.0.0.1:3306)/note?charset=utf8mb4&parseTime=True&loc=Local",
		Try:       5,
		ShouldRun: true,
	}
	sql, res, err := data.Do("王五在2025年1月上旬的餐饮食品类别总额")
	if err != nil {
		t.Error(err)
		return
	}
	t.Logf("sql: %s\nres: %v\n", sql, res)
	sql, res, err = data.Do("王五的openid")
	if err != nil {
		t.Error(err)
		return
	}
	t.Logf("sql: %s\nres: %v\n", sql, res)
	sql, res, err = data.Do("《我从哪里来》这篇文章的作者叫什么名字")
	if err != nil {
		t.Error(err)
		return
	}
	t.Logf("sql: %s\nres: %v\n", sql, res)
}
