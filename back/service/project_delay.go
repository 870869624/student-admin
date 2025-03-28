package service

import (
	"backend/global"
	"backend/model"
	"errors"
	"github.com/jinzhu/copier"
	"time"
)

type ProjectDelayService struct{}

func (s *ProjectDelayService) Delete(projectId int64) error {
	if err := global.Db.Where("project_id = ?", projectId).Delete(&model.ProjectDelay{}).Error; err != nil {
		return err
	}
	return nil
}

func (s *ProjectDelayService) Add(req *model.ProjectDelayAddRequest) error {
	projectDelay := &model.ProjectDelay{
		Status:                 "pending",
		RequestedExtensionDate: time.Now(),
	}
	projectDelay.ApprovalDate = time.Unix(req.ApprovalDate, 0)
	if err := copier.Copy(projectDelay, req); err != nil {
		return errors.New("系统错误")
	}
	if err := global.Db.Create(projectDelay).Error; err != nil {
		return errors.New("系统错误")
	}

	// 更新项目延期
	projectService := &ProjectService{}
	project, err := projectService.GetById(projectDelay.ProjectId)
	if err != nil {
		return errors.New("系统错误")
	}
	project.Status = "extended"
	if err = global.Db.Model(project).Updates(project).Error; err != nil {
		return errors.New("系统错误")
	}

	// 创建项目阶段
	projectStageService := &ProjectStageService{}
	projectStageAddRequest := &model.ProjectStageAddRequest{
		ProjectId: project.Id,
		Name:      "extended",
		StartDate: time.Now(),
		Status:    "pending",
	}
	projectStage, err := projectStageService.Add(projectStageAddRequest)
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

func (s *ProjectDelayService) Query(conditions string, args ...interface{}) (*model.ProjectDelay, error) {
	projectDelay := &model.ProjectDelay{}
	if err := global.Db.Where(conditions, args...).First(projectDelay).Error; err != nil {
		return nil, err
	}
	return projectDelay, nil
}
