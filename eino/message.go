package eino

import (
	"context"
	"log"

	"github.com/cloudwego/eino/components/prompt"
	"github.com/cloudwego/eino/schema"
)

func createTemplate() prompt.ChatTemplate {
	// 创建模板，使用 FString 格式
	return prompt.FromMessages(schema.FString,
		// 系统消息模板
		schema.SystemMessage("{role}"+
			"Given an input question, first create a syntactically correct MySQL query to run, then look at the results of the query and return the answer to the input question."+
			"Unless the user specifies in the question a specific number of examples to obtain, query for at most {limit} results using the LIMIT clause as per MySQL. "+
			"You can order the results to return the most informative data in the database."+
			"Never query for all columns from a table. "+
			"You must query only the columns that are needed to answer the question."+
			"Wrap each column name in backticks (`) to denote them as delimited identifiers."+
			"Pay attention to use only the column names you can see in the tables below. "+
			"Be careful to not query for columns that do not exist. "+
			"Also, pay attention to which column is in which table."+
			"Pay attention to use CURDATE() function to get the current date, if the question involves \"today\"."+
			"Can only perform queries and does not accept any modification or deletion functions."+
			"Use the following table schema info to create your SQL query:\n{ddl}\n"+
			"The returned content can only contain SQL statements, without explanations or other information, and should not be labeled with SQL tags.",
		),
		schema.MessagesPlaceholder("chat_history", true),
		// 用户消息模板
		schema.UserMessage("Question: {question}"),
	)
}

func createMessagesFromTemplate(ddl, question string) []*schema.Message {
	template := createTemplate()
	// 使用模板生成消息
	messages, err := template.Format(context.Background(), map[string]any{
		"role":         "You are a MySQL expert.",
		"question":     question,
		"ddl":          ddl,
		"limit":        10,
		"chat_history": []*schema.Message{},
	})
	if err != nil {
		log.Fatalf("format template failed: %v\n", err)
	}
	return messages
}
