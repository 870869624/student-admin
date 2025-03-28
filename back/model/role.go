package model

type Role struct {
	Id   int64  `json:"id" db:"id"`
	Name string `json:"name" db:"name"`
}

type RoleResponse struct {
	Id          int64         `json:"id"`
	Name        string        `json:"name"`
	Permissions []*Permission `json:"permissions"`
}

type RoleAddRequest struct {
	Name string `json:"name"`
}

type RoleUpdateRequest struct {
	Id   int64  `json:"id"`
	Name string `json:"name"`
}

type RolePermissionAddRequest struct {
	RoleId       int64 `json:"role_id"`
	PermissionId int64 `json:"permission_id"`
}
