package eino

import (
	"context"
	"fmt"
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
	return result.Content, nil
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
	return result.Content, nil
}
