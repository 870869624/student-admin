package model

import "time"

type PreProject struct {
	Id              int64     `json:"id" db:"id"`
	Name            string    `json:"name" db:"name"`
	Description     string    `json:"description" db:"description"`
	StartDate       time.Time `json:"start_date" db:"start_date"`
	ExpectedEndDate time.Time `json:"expected_end_date,omitempty" db:"expected_end_date"`
	Status          string    `json:"status" db:"status"`
	UserId          int64     `json:"user_id" db:"user_id"`
}

type PreProjectResponse struct {
	Id              int64  `json:"id"`
	Name            string `json:"name"`
	Description     string `json:"description"`
	StartDate       int64  `json:"start_date"`
	ExpectedEndDate int64  `json:"expected_end_date"`
	Status          string `json:"status"`
	UserId          int64  `json:"user_id"`
}

type PreProjectAddRequest struct {
	Name            string `json:"name"`
	Description     string `json:"description"`
	StartDate       int64  `json:"start_date"`
	ExpectedEndDate int64  `json:"expected_end_date"`
	UserId          int64  `json:"user_id"`
}

type PreProjectUpdateRequest struct {
	Id              int64  `json:"id"`
	Name            string `json:"name"`
	Description     string `json:"description"`
	StartDate       int64  `json:"start_date"`
	ExpectedEndDate int64  `json:"expected_end_date" `
	Status          string `json:"status"`
	UserId          int64  `json:"user_id"`
}

type AllPreProjectListRequest struct {
	Page
	Name        string `json:"name"`
	Description string `json:"description"`
	UserId      int64  `json:"user_id"`
}

type MyPreProjectListRequest struct {
	Page
	Name        string `json:"name"`
	Description string `json:"description"`
	Status      string `json:"status"`
	UserId      int64  `json:"user_id"`
}

type OPreProjectListRequest struct {
	Page
}

type PreProjectUpdateStatusRequest struct {
	ProjectId int64  `json:"project_id"`
	Status    string `json:"status"`
}
