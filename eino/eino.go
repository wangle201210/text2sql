package eino

import (
	"context"
	"encoding/json"
	"fmt"
	"strings"

	"github.com/cloudwego/eino-ext/components/model/openai"
	"github.com/cloudwego/eino/components/model"
)

type Eino struct {
	cm model.ChatModel
}

func NewEino(cfg *openai.ChatModelConfig) (res *Eino, err error) {
	chatModel, err := openai.NewChatModel(context.Background(), cfg)
	if err != nil {
		return nil, err
	}
	return &Eino{cm: chatModel}, nil
}

func (x *Eino) GetSQL(ddl, question string) (sql string, err error) {
	ctx := context.Background()
	messages, err := ddl2sqlMessages(ddl, question)
	if err != nil {
		return "", err
	}
	result, err := generate(ctx, x.cm, messages)
	if err != nil {
		return "", fmt.Errorf("生成SQL失败: %w", err)
	}
	sql = result.Content
	return trimSql(sql), nil
}

func (x *Eino) ChoiceSQL(sqls, ddl, question string) (sql string, err error) {
	ctx := context.Background()
	messages, err := choiceSqlMessages(sqls, ddl, question)
	if err != nil {
		return "", err
	}

	result, err := generate(ctx, x.cm, messages)
	if err != nil {
		return "", fmt.Errorf("选择SQL失败: %w", err)
	}
	sql = result.Content
	return trimSql(sql), nil
}

func (x *Eino) PrettyRes(sql, question string, runResult []map[string]interface{}) (res string, err error) {
	marshal, err := json.Marshal(runResult)
	if err != nil {
		return "", err
	}
	messages, err := prettyMessages(question, sql, string(marshal))
	if err != nil {
		return "", err
	}

	result, err := generate(context.Background(), x.cm, messages)
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
