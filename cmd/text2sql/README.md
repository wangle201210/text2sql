## Text2SQL

text2sql还提供了命令行工具，可以直接在终端中使用：

```bash
# 安装命令行工具
go install github.com/wangle201210/text2sql/cmd/text2sql@latest

# 使用示例
text2sql -l "root:password@tcp(127.0.0.1:3306)/database?charset=utf8mb4&parseTime=True&loc=Local" -q "王五的openid" -t 5 -r
```

参数说明：
- `-l`: MySQL数据库连接信息（必填）
- `-q`: 查询语句描述（必填）
- `-t`: 失败后重试次数（可选，默认5次）
- `-r`: 是否执行生成的SQL（可选，默认false）
