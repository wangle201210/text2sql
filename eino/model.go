package eino

import (
	"context"
	"fmt"
	"log"
	"os"

	"github.com/cloudwego/eino-ext/components/model/openai"
	"github.com/cloudwego/eino/components/model"
)

// createOpenAIChatModel 创建OpenAI聊天模型实例
func createOpenAIChatModel(ctx context.Context) (model.ChatModel, error) {
	// 验证必需的环境变量
	modelName := os.Getenv("OPENAI_MODEL_NAME")
	if modelName == "" {
		return nil, fmt.Errorf("环境变量OPENAI_MODEL_NAME未设置")
	}

	apiKey := os.Getenv("OPENAI_API_KEY")
	if apiKey == "" {
		return nil, fmt.Errorf("环境变量OPENAI_API_KEY未设置")
	}

	// 获取可选的baseURL
	baseURL := os.Getenv("OPENAI_BASE_URL")
	if baseURL == "" {
		log.Println("未设置OPENAI_BASE_URL，将使用默认API地址")
	}

	// 创建聊天模型
	chatModel, err := openai.NewChatModel(ctx, &openai.ChatModelConfig{
		Model:   modelName,
		APIKey:  apiKey,
		BaseURL: baseURL,
	})
	if err != nil {
		return nil, fmt.Errorf("创建OpenAI聊天模型失败: %w", err)
	}

	return chatModel, nil
}
