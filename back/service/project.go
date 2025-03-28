package service

import (
	"backend/global"
	"backend/model"
	"encoding/json"
	"errors"
	"fmt"
	"github.com/jinzhu/copier"
	"time"
)

type ProjectService struct{}

func (s *ProjectService) Add(req *model.ProjectAddRequest) error {
	// 项目表
	project := &model.Project{}
	if err := copier.Copy(project, req); err != nil {
		return err
	}
	project.StartDate = time.Unix(req.StartDate, 0)
	project.ExpectedEndDate = time.Unix(req.ExpectedEndDate, 0)
	project.Status = "declared"
	participant, _ := json.Marshal(req.Participant)
	project.Participant = string(participant)
	if err := global.Db.Create(project).Error; err != nil {
		return errors.New("系统错误")
	}

	// 项目阶段表
	projectStageService := &ProjectStageService{}
	projectStageRequest := &model.ProjectStageAddRequest{
		ProjectId: project.Id,
		Name:      "declared",
		StartDate: project.StartDate,
		Status:    "pending",
	}
	projectStage, err := projectStageService.Add(projectStageRequest)
	if err != nil {
		return errors.New("系统错误")
	}

	// 项目文件表
	projectDocumentService := &ProjectDocumentService{}
	projectDocumentAddRequest := &model.ProjectDocumentAddRequest{
		ProjectId: project.Id,
		StageId:   projectStage.Id,
		FilePath:  req.FilePath,
	}
	if err = projectDocumentService.Add(projectDocumentAddRequest); err != nil {
		return errors.New("系统错误")
	}
	return nil
}

func (s *ProjectService) Update(req *model.ProjectUpdateRequest) error {
	project := &model.Project{}
	if err := copier.Copy(project, req); err != nil {
		return err
	}
	if err := global.Db.Model(project).Updates(project).Error; err != nil {
		return err
	}
	projectDocumentService := &ProjectDocumentService{}
	projectDocumentUpdateRequest := &model.ProjectDocumentUpdateRequest{
		ProjectId: project.Id,
		StageId:   req.StageId,
		FilePath:  req.FilePath,
	}
	if err := projectDocumentService.Update(projectDocumentUpdateRequest); err != nil {
		return err
	}
	return nil
}

func (s *ProjectService) Delete(req *model.DeleteRequest) error {
	project := &model.Project{}
	if err := global.Db.Where("id = ?", req.Id).First(project).Error; err != nil {
		return errors.New("系统错误")
	}
	if err := global.Db.Delete(project).Error; err != nil {
		return errors.New("系统错误")
	}

	// 删除阶段表的数据
	projectStageService := &ProjectStageService{}
	if err := projectStageService.Delete(project.Id); err != nil {
		return errors.New("系统错误")
	}

	// 删除文件信息
	projectDocumentService := &ProjectDocumentService{}
	if err := projectDocumentService.Delete(project.Id); err != nil {
		return errors.New("系统错误")
	}

	return nil
}

func (s *ProjectService) List(req *model.ProjectListRequest) (int64, int, int, []*model.ProjectResponse, error) {
	query := global.Db.Model(&model.Project{})
	if req.UserId != 0 {
		query = query.Where("user_id = ?", req.UserId)
	}
	if req.Status != "" {
		query = query.Where("status = ?", req.Status)
	}
	if req.Name != "" {
		query = query.Where("name like ?", "%"+req.Name+"%")
	}
	if req.Description != "" {
		query = query.Where("description like ?", "%"+req.Description+"%")
	}
	if req.Department != "" {
		query = query.Where("department like ?", "%"+req.Department+"%")
	}
	if req.Batch != "" {
		query = query.Where("batch like ?", "%"+req.Batch+"%")
	}
	if req.Source != "" {
		query = query.Where("source like ?", "%"+req.Source+"%")
	}
	if req.ResultType != "" {
		query = query.Where("result_type = ?", req.ResultType)
	}

	total := int64(0)
	if err := query.Count(&total).Error; err != nil {
		return 0, 0, 0, nil, errors.New("系统错误")
	}

	projects := make([]*model.Project, 0)
	if err := query.Offset((req.Current - 1) * req.PageSize).Limit(req.PageSize).Find(&projects).Error; err != nil {
		return 0, 0, 0, nil, errors.New("系统错误")
	}

	pages := int((total + int64(req.PageSize) - 1) / int64(req.PageSize))

	projectRes := make([]*model.ProjectResponse, len(projects))
	for i, project := range projects {
		projectRes[i] = &model.ProjectResponse{}
		if err := copier.Copy(projectRes[i], project); err != nil {
			fmt.Println(err)
			return 0, 0, 0, nil, errors.New("系统错误")
		}
		projectRes[i].StartDate = project.StartDate.Unix()
		projectRes[i].ExpectedEndDate = project.ExpectedEndDate.Unix()
		participants := make([]int64, 0)
		if err := json.Unmarshal([]byte(project.Participant), &participants); err != nil {
			return 0, 0, 0, nil, errors.New("系统错误")
		}
		projectRes[i].Participant = participants

		// 获取当前项目阶段的数据
		projectStageService := &ProjectStageService{}
		projectStage, err := projectStageService.Query("project_id = ? AND name = ?", project.Id, project.Status)
		if err != nil {
			return 0, 0, 0, nil, errors.New("系统错误")
		}

		// 获取文件数据
		projectDocumentService := &ProjectDocumentService{}
		projectDocument, err := projectDocumentService.Query("project_id = ? AND stage_id = ?", project.Id, projectStage.Id)
		if err != nil {
			return 0, 0, 0, nil, errors.New("系统错误")
		}

		projectRes[i].FilePath = projectDocument.FilePath
		projectRes[i].StageId = projectStage.Id
		projectRes[i].StageStatus = projectStage.Status
		if project.Status == "extended" {
			projectDelayService := &ProjectDelayService{}
			projectDelay, err := projectDelayService.Query("project_id = ?", project.Id)
			if err != nil {
				return 0, 0, 0, nil, errors.New("系统错误")
			}
			projectRes[i].RequestedExtensionDate = projectDelay.RequestedExtensionDate.Unix()
			projectRes[i].ApprovalDate = projectDelay.ApprovalDate.Unix()
			projectRes[i].DelayStatus = projectDelay.Status
		}
		if project.Status == "down" {
			projectDownService := &ProjectDownService{}
			projectDown, err := projectDownService.Query("project_id = ?", project.Id)
			if err != nil {
				return 0, 0, 0, nil, errors.New("系统错误")
			}
			projectRes[i].DownReason = projectDown.Reason
		}
	}

	return total, len(projectRes), pages, projectRes, nil
}

func (s *ProjectService) UpdateStatus(req *model.ProjectUpdateStatusRequest) error {
	if err := global.Db.Model(&model.Project{}).Where("id = ?", req.ProjectId).Update("status", req.Status).Error; err != nil {
		return errors.New("系统错误")
	}

	// 下一个阶段
	projectStageService := &ProjectStageService{}
	projectStageRequest := &model.ProjectStageAddRequest{
		ProjectId: req.ProjectId,
		Name:      req.Status,
		StartDate: time.Now(),
		Status:    "pending",
	}
	projectStage, err := projectStageService.Add(projectStageRequest)
	if err != nil {
		return errors.New("系统错误")
	}

	projectDocumentService := &ProjectDocumentService{}
	projectDocumentAddRequest := &model.ProjectDocumentAddRequest{
		ProjectId: req.ProjectId,
		StageId:   projectStage.Id,
		FilePath:  "",
	}
	if err = projectDocumentService.Add(projectDocumentAddRequest); err != nil {
		return errors.New("系统错误")
	}
	return nil
}

func (s *ProjectService) GetById(id int64) (*model.Project, error) {
	project := &model.Project{}
	if err := global.Db.Where("id = ?", id).First(project).Error; err != nil {
		return nil, err
	}
	return project, nil
}
