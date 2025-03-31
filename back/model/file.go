package model

type File struct {
	ID        uint   `json:"id" gorm:"primarykey"`
	ProjectId uint   `json:"project_id" gorm:"type:uint;not null"`
	Status    string `json:"status" db:"status"`
	Content   string `json:"content" gorm:"type:text;not null"`
}
