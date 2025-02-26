package eino

import (
	"context"
	"log"
	"os"

	"github.com/cloudwego/eino-ext/components/model/openai"
	"github.com/cloudwego/eino/components/model"
)

func createOpenAIChatModel(ctx context.Context) model.ChatModel {
	m := os.Getenv("OPENAI_MODEL_NAME")
	if m == "" {
		log.Fatalf("请在环境变量中设置你的 OPENAI_MODEL_NAME")
	}
	apikey := os.Getenv("OPENAI_API_KEY")
	if apikey == "" {
		log.Fatalf("请在环境变量中设置你的 OPENAI_API_KEY")
	}
	chatModel, err := openai.NewChatModel(ctx, &openai.ChatModelConfig{
		Model:   os.Getenv("OPENAI_MODEL_NAME"),
		APIKey:  os.Getenv("OPENAI_API_KEY"),
		BaseURL: os.Getenv("OPENAI_BASE_URL"),
	})
	if err != nil {
		log.Fatalf("create openai chat model failed, err=%v", err)
	}
	return chatModel
}
