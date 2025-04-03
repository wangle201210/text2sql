package text2sql

import (
	"os"
	"sync"
	"testing"

	"github.com/cloudwego/eino-ext/components/model/openai"
	"github.com/wangle201210/text2sql/eino"
)

func TestText2sql(t *testing.T) {
	cfg := &Config{
		DbLink:    "root:123456@tcp(127.0.0.1:3306)/note",
		Try:       5,
		ShouldRun: true,
		Times:     2,
	}
	newEino, err := eino.NewEino(&openai.ChatModelConfig{
		APIKey:  os.Getenv("OPENAI_API_KEY"),
		BaseURL: os.Getenv("OPENAI_BASE_URL"),
		Model:   os.Getenv("OPENAI_MODEL_NAME"),
	})
	if err != nil {
		t.Error(err)
		return
	}
	t2s := NewText2sql(cfg, newEino)
	question := []string{
		"王五在2025年1月上旬的餐饮食品类别总额",
		"王五的openid",
		"《我从哪里来》这篇文章的作者叫什么名字",
	}
	wg := &sync.WaitGroup{}
	for _, s := range question {
		wg.Add(1)
		go func() {
			defer wg.Done()
			sql, res, err := t2s.Pretty(s)
			if err != nil {
				t.Error(err)
				return
			}
			t.Logf("sql: %s\n res: %v\n", sql, res)
		}()
	}
	wg.Wait()
}
