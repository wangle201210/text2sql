package eino

import (
	"context"
)

func GetSQL(ddl, question string) (sql string) {
	ctx := context.Background()
	messages := createMessagesFromTemplate(ddl, question)
	cm := createOpenAIChatModel(ctx)
	result := generate(ctx, cm, messages)
	sql = result.Content
	return
}
