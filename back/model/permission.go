package model

type Permission struct {
	Id   int64  `json:"id" db:"id"`
	Name string `json:"name" db:"name"`
}

type PermissionResponse struct {
	Id    int64   `json:"id"`
	Name  string  `json:"name"`
	Roles []*Role `json:"roles"`
}
