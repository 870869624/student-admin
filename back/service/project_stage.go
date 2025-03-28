package service

import (
	"backend/global"
	"backend/model"
	"errors"
	"github.com/jinzhu/copier"
)

type ProjectStageService struct{}

func (s *ProjectStageService) Add(req *model.ProjectStageAddRequest) (*model.ProjectStage, error) {
	projectStage := &model.ProjectStage{}
	if err := copier.Copy(projectStage, req); err != nil {
		return nil, errors.New("系统错误")
	}
	if err := global.Db.Create(projectStage).Error; err != nil {
		return nil, errors.New("系统错误")
	}
	return projectStage, nil
}

func (s *ProjectStageService) Query(conditions string, args ...interface{}) (*model.ProjectStage, error) {
	projectStage := &model.ProjectStage{}
	if err := global.Db.Where(conditions, args...).First(projectStage).Error; err != nil {
		return nil, err
	}
	return projectStage, nil
}

func (s *ProjectStageService) Delete(projectId int64) error {
	if err := global.Db.Where("project_id = ?", projectId).Delete(&model.ProjectStage{}).Error; err != nil {
		return err
	}
	return nil
}

func (s *ProjectStageService) Update(req *model.ProjectStageUpdateRequest) error {
	projectStage := &model.ProjectStage{}
	if err := copier.Copy(projectStage, req); err != nil {
		return err
	}
	if err := global.Db.Model(projectStage).Updates(projectStage).Error; err != nil {
		return err
	}
	return nil
}
