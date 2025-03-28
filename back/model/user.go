package model

type User struct {
	Id           int64  `json:"id" db:"id"`
	Account      string `json:"account" db:"account"`
	Password     string `json:"password" db:"password"`
	Position     string `json:"position" db:"position"`
	Phone        string `json:"phone" db:"phone"`
	Email        string `json:"email" db:"email"`
	Department   string `json:"department" db:"department"`
	Username     string `json:"username" db:"username"`
	RoleId       int64  `json:"role_id" db:"role_id"`
	Gender       string `json:"gender" db:"gender"`
	Organization string `json:"organization" db:"organization"`
	Job          string `json:"job" db:"job"`
}

type UserResponse struct {
	User
	PermissionIds []int64 `json:"permission_ids"`
}

type UserRegisterRequest struct {
	Account      string `json:"account"`
	Password     string `json:"password"`
	Position     string `json:"position"`
	Phone        string `json:"phone"`
	Email        string `json:"email"`
	Department   string `json:"department"`
	Username     string `json:"username"`
	RoleId       int64  `json:"role_id"`
	Gender       string `json:"gender"`
	Organization string `json:"organization"`
	Job          string `json:"job"`
}

type UserLoginRequest struct {
	Account  string `json:"account"`
	Password string `json:"password"`
}

type UserUpdateRequest struct {
	Id           int64  `json:"id"`
	Account      string `json:"account"`
	Password     string `json:"password"`
	Position     string `json:"position"`
	Phone        string `json:"phone"`
	Email        string `json:"email"`
	Department   string `json:"department"`
	Username     string `json:"username"`
	RoleId       int64  `json:"role_id"`
	Gender       string `json:"gender"`
	Organization string `json:"organization"`
	Job          string `json:"job"`
}

type UserListRequest struct {
	Page
	Account      string `json:"account"`
	Username     string `json:"username"`
	Department   string `json:"department"`
	Organization string `json:"organization"`
	Job          string `json:"job"`
	RoleId       int64  `json:"role_id"`
}
