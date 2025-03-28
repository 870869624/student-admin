package model

type ProjectDown struct {
	Id        int64  `json:"id" db:"id"`
	ProjectId int64  `json:"project_id" db:"project_id"`
	Reason    string `json:"reason" db:"reason"`
}

type ProjectDownAddRequest struct {
	ProjectId int64  `json:"project_id"`
	Reason    string `json:"reason"`
}
