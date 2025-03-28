package model

import "time"

type ProjectDelay struct {
	Id                     int64     `json:"id" db:"id"`
	ProjectId              int64     `json:"project_id" db:"project_id"`
	RequestedExtensionDate time.Time `json:"requested_extension_date,omitempty" db:"requested_extension_date"`
	Reason                 string    `json:"reason" db:"reason"`
	Status                 string    `json:"status" db:"status"`
	ApprovalDate           time.Time `json:"approval_date,omitempty" db:"approval_date"`
}

type ProjectDelayAddRequest struct {
	ProjectId    int64  `json:"project_id"`
	Reason       string `json:"reason"`
	ApprovalDate int64  `json:"approval_date"`
}
