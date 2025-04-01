package eino

import (
	"context"
	"encoding/json"
	"fmt"
	"strings"
)

func GetSQL(ddl, question string) (sql string, err error) {
	ctx := context.Background()
	messages, err := ddl2sqlMessages(ddl, question)
	if err != nil {
		return "", err
	}

	cm, err := createOpenAIChatModel(ctx)
	if err != nil {
		return "", err
	}
	result, err := generate(ctx, cm, messages)
	if err != nil {
		return "", fmt.Errorf("生成SQL失败: %w", err)
	}
	sql = result.Content
	return trimSql(sql), nil
}

func ChoiceSQL(sqls, ddl, question string) (sql string, err error) {
	ctx := context.Background()
	messages, err := choiceSqlMessages(sqls, ddl, question)
	if err != nil {
		return "", err
	}

	cm, err := createOpenAIChatModel(ctx)
	if err != nil {
		return "", err
	}
	result, err := generate(ctx, cm, messages)
	if err != nil {
		return "", fmt.Errorf("选择SQL失败: %w", err)
	}
	sql = result.Content
	return trimSql(sql), nil
}

func PrettyRes(sql, question string, runResult []map[string]interface{}) (res string, err error) {
	ctx := context.Background()
	marshal, err := json.Marshal(runResult)
	if err != nil {
		return "", err
	}
	messages, err := prettyMessages(question, sql, string(marshal))
	if err != nil {
		return "", err
	}

	cm, err := createOpenAIChatModel(ctx)
	if err != nil {
		return "", err
	}
	result, err := generate(ctx, cm, messages)
	if err != nil {
		return "", fmt.Errorf("优化回答失败: %w", err)
	}
	return result.Content, nil
}

// 如果有sql tag 就删除
func trimSql(sql string) string {
	if strings.HasPrefix(sql, "```sql\n") {
		sql = strings.TrimLeft(sql, "```sql\n")
		sql = strings.TrimRight(sql, "\n```")
	}
	return sql
}
