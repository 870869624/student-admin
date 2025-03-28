package model

type Note struct {
	Id      int    `json:"id"`
	Title   string `json:"title"`
	UserId  int    `json:"user_id"`
	Status  int    `json:"status"`
	Content string `json:"content"`
}
