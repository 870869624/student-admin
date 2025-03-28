package model

import "time"

type Project struct {
	Id              int64     `json:"id" db:"id"`
	Name            string    `json:"name" db:"name"`
	Description     string    `json:"description" db:"description"`
	StartDate       time.Time `json:"start_date" db:"start_date"`
	ExpectedEndDate time.Time `json:"expected_end_date,omitempty" db:"expected_end_date"`
	Status          string    `json:"status" db:"status"`
	UserId          int64     `json:"user_id" db:"user_id"`
	Department      string    `json:"department" db:"department"`
	TeacherId       int64     `json:"teacher_id" db:"teacher_id"`
	Batch           string    `json:"batch" db:"batch"`
	Source          string    `json:"source" db:"source"`
	Participant     string    `json:"participant,omitempty" db:"participant"`
	ResultType      string    `json:"result_type" db:"result_type"`
}

type ProjectResponse struct {
	Id                     int64   `json:"id"`
	Name                   string  `json:"name"`
	Description            string  `json:"description"`
	StartDate              int64   `json:"start_date"`
	ExpectedEndDate        int64   `json:"expected_end_date"`
	Status                 string  `json:"status"`
	UserId                 int64   `json:"user_id"`
	Department             string  `json:"department"`
	TeacherId              int64   `json:"teacher_id"`
	Batch                  string  `json:"batch"`
	Source                 string  `json:"source"`
	Participant            []int64 `json:"participant"`
	ResultType             string  `json:"result_type"`
	FilePath               string  `json:"file_path"`
	StageId                int64   `json:"stage_id"`
	StageStatus            string  `json:"stage_status"`
	RequestedExtensionDate int64   `json:"requested_extension_date"`
	DelayStatus            string  `json:"delay_status"`
	ApprovalDate           int64   `json:"approval_date"`
	DownReason             string  `json:"down_reason"`
}

type ProjectAddRequest struct {
	Name            string  `json:"name"`
	Description     string  `json:"description"`
	StartDate       int64   `json:"start_date"`
	ExpectedEndDate int64   `json:"expected_end_date"`
	UserId          int64   `json:"user_id"`
	Department      string  `json:"department"`
	TeacherId       int64   `json:"teacher_id"`
	Batch           string  `json:"batch"`
	Source          string  `json:"source"`
	Participant     []int64 `json:"participant"`
	ResultType      string  `json:"result_type"`
	FilePath        string  `json:"file_path"`
}

type ProjectUpdateRequest struct {
	Id              int64   `json:"id"`
	Name            string  `json:"name"`
	Description     string  `json:"description"`
	StartDate       int64   `json:"start_date"`
	ExpectedEndDate int64   `json:"expected_end_date" `
	Status          string  `json:"status"`
	UserId          int64   `json:"user_id"`
	Department      string  `json:"department"`
	TeacherId       int64   `json:"teacher_id"`
	Batch           string  `json:"batch"`
	Source          string  `json:"source"`
	Participant     []int64 `json:"participant"`
	ResultType      string  `json:"result_type"`
	FilePath        string  `json:"file_path"`
	StageId         int64   `json:"stage_id"`
	StageStatus     string  `json:"stage_status"`
}

type ProjectListRequest struct {
	Page
	Name        string `json:"name"`
	Description string `json:"description"`
	Department  string `json:"department"`
	Batch       string `json:"batch"`
	Source      string `json:"source"`
	ResultType  string `json:"result_type"`
	Status      string `json:"status"`
	UserId      int64  `json:"user_id"`
}

type ProjectUpdateStatusRequest struct {
	ProjectId int64  `json:"project_id"`
	Status    string `json:"status"`
}
