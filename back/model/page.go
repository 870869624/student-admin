package model

type Page struct {
	Current  int `json:"current"`   // 当前页号
	PageSize int `json:"page_size"` // 页的大小
}

type DeleteRequest struct {
	Id int64 `json:"id"`
}
