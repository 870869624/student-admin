package service

import (
	"backend/global"
	"backend/model"
	"errors"
	"time"
)

type ProjectDownService struct{}

func (s *ProjectDownService) Add(req *model.ProjectDownAddRequest) error {
	projectDown := &model.ProjectDown{
		ProjectId: req.ProjectId,
		Reason:    req.Reason,
	}
	if err := global.Db.Create(projectDown).Error; err != nil {
		return errors.New("系统错误")
	}

	// 更新项目延期
	projectService := &ProjectService{}
	project, err := projectService.GetById(projectDown.ProjectId)
	if err != nil {
		return errors.New("系统错误")
	}
	project.Status = "down"
	if err = global.Db.Model(project).Updates(project).Error; err != nil {
		return errors.New("系统错误")
	}

	// 创建项目阶段
	projectStageService := &ProjectStageService{}
	projectStageAddRequest := &model.ProjectStageAddRequest{
		ProjectId: project.Id,
		Name:      "down",
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

func (s *ProjectDownService) Query(conditions string, args ...interface{}) (*model.ProjectDown, error) {
	projectDown := &model.ProjectDown{}
	if err := global.Db.Where(conditions, args...).First(projectDown).Error; err != nil {
		return nil, err
	}
	return projectDown, nil
}
