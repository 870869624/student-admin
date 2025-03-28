package model

import "time"

type ProjectStage struct {
	Id        int64      `json:"id" db:"id"`
	ProjectId int64      `json:"project_id" db:"project_id"`
	Name      string     `json:"name" db:"name"`
	StartDate time.Time  `json:"start_date" db:"start_date"`
	EndDate   *time.Time `json:"end_date,omitempty" db:"end_date"`
	Status    string     `json:"status" db:"status"`
}

type ProjectStageAddRequest struct {
	ProjectId int64     `json:"project_id"`
	Name      string    `json:"name"`
	StartDate time.Time `json:"start_date"`
	Status    string    `json:"status"`
}

type ProjectStageUpdateRequest struct {
	Id     int64  `json:"id" db:"id"`
	Status string `json:"status"`
}
