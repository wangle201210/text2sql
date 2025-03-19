package mysql

// ColumnMeta 定义列的元数据
type ColumnMeta struct {
	Field   string // 列名
	Type    string // 数据类型
	Key     string
	Comment string // 备注，很重要
}
