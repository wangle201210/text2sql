package eino

import (
	"context"
)

func GetSQL(ddl, question string) (sql string) {
	ctx := context.Background()
	messages := ddl2sqlMessages(ddl, question)
	cm := createOpenAIChatModel(ctx)
	result := generate(ctx, cm, messages)
	sql = result.Content
	return
}

func ChoiceSQL(sqls, ddl, question string) (sql string) {
	ctx := context.Background()
	messages := choiceSqlMessages(sqls, ddl, question)
	cm := createOpenAIChatModel(ctx)
	result := generate(ctx, cm, messages)
	sql = result.Content
	return
}
