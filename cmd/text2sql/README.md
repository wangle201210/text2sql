## Text2SQL

text2sql还提供了命令行工具，可以直接在终端中使用：

```bash
# 安装命令行工具
go install github.com/wangle201210/text2sql/cmd/text2sql@latest

# 使用示例
text2sql -l "root:password@tcp(127.0.0.1:3306)/database" -q "王五的openid" -t 5 -r -n 3
```

参数说明：
- `-l`: MySQL数据库连接信息（必填）
- `-q`: 查询语句描述（必填）
- `-t`: 失败后重试次数（可选，默认5次）
- `-r`: 是否执行生成的SQL（可选，默认false）
- `-n`: 同时生成SQL的次数（可选，默认1）
    - 取值范围：1-10
    - 数值越大，生成的SQL候选数越多，选择最合适的SQL的准确率越高
    - 注意：数值越大消耗的token也越多
