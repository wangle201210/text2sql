package main

import (
	"flag"
	"fmt"
	"log"
	"os"

	"github.com/wangle201210/text2sql"
)

func main() {

	var (
		link     string
		question string
		try      int
		run      bool
		times    int
	)

	flag.StringVar(&link, "l", "", "mysql链接信息")
	flag.StringVar(&question, "q", "", "查询语句描述")
	flag.IntVar(&try, "t", 5, "失败后重试次数")
	flag.BoolVar(&run, "r", false, "获取到sql后是否执行")
	flag.IntVar(&times, "n", 1, "同时生成SQL的次数(1-10之间)，数值越大准确率越高，但消耗的token也越多")
	flag.Parse()
	if link == "" || question == "" {
		fmt.Println("请输入正确参数")
		os.Exit(1)
	}

	ts := &text2sql.Text2sql{
		DbLink:    link,
		Try:       try,
		ShouldRun: run,
		Times:     times,
	}
	sql, result, err := ts.Do(question)
	if err != nil {
		log.Fatalf("text2sql err: %+v", err)
	}
	fmt.Printf("sql: %s \n", sql)
	if run {
		fmt.Printf("result: %+v \n", result)
	}
}
