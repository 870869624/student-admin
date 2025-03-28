package model

type ProjectDocument struct {
	Id        int64  `json:"id" db:"id"`
	ProjectId int64  `json:"project_id" db:"project_id"`
	StageId   int64  `json:"stage_id" db:"stage_id"`
	FilePath  string `json:"file_path" db:"file_path"`
}

type ProjectDocumentAddRequest struct {
	ProjectId int64  `json:"project_id"`
	StageId   int64  `json:"stage_id"`
	FilePath  string `json:"file_path"`
}

type ProjectDocumentUpdateRequest struct {
	Id        int64  `json:"id"`
	ProjectId int64  `json:"project_id"`
	StageId   int64  `json:"stage_id"`
	FilePath  string `json:"file_path"`
}

type ProjectDocumentResponse struct {
	Id          int64  `json:"id"`
	ProjectId   int64  `json:"project_id"`
	StageId     int64  `json:"stage_id"`
	ProjectName string `json:"project_name"`
	StageName   string `json:"stage_name"`
	FilePath    string `json:"file_path"`
}
