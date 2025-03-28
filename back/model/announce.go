package model

type Announce struct {
	ID      uint   `json:"id" gorm:"primarykey"`
	Title   string `json:"title" gorm:"type:varchar(255);not null"`
	Content string `json:"content" gorm:"type:text;not null"`
}

type AnnounceListRequest struct {
	Page
	ID      uint   `json:"id" gorm:"primarykey"`
	Title   string `json:"title" gorm:"type:varchar(255);not null"`
	Content string `json:"content" gorm:"type:text;not null"`
}
