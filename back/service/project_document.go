package service

import (
	"backend/global"
	"backend/model"
	"errors"
	"fmt"
	"github.com/jinzhu/copier"
)

type ProjectDocumentService struct{}

func (s *ProjectDocumentService) Add(req *model.ProjectDocumentAddRequest) error {
	projectDocument := &model.ProjectDocument{}
	if err := copier.Copy(projectDocument, req); err != nil {
		return errors.New("系统错误")
	}
	if err := global.Db.Create(projectDocument).Error; err != nil {
		return errors.New("系统错误")
	}
	return nil
}

func (s *ProjectDocumentService) Delete(projectId int64) error {
	if err := global.Db.Where("project_id = ?", projectId).Delete(&model.ProjectDocument{}).Error; err != nil {
		return err
	}
	return nil
}

func (s *ProjectDocumentService) Query(conditions string, args ...interface{}) (*model.ProjectDocument, error) {
	projectDocument := &model.ProjectDocument{}
	if err := global.Db.Where(conditions, args...).First(projectDocument).Error; err != nil {
		return nil, err
	}
	return projectDocument, nil
}

func (s *ProjectDocumentService) Update(req *model.ProjectDocumentUpdateRequest) error {
	projectDocument := &model.ProjectDocument{}
	if err := copier.Copy(projectDocument, req); err != nil {
		return err
	}
	if err := global.Db.Where("project_id = ? AND stage_id = ?", req.ProjectId, req.StageId).Model(projectDocument).Updates(projectDocument).Error; err != nil {
		fmt.Println(err)
		return err
	}
	return nil
}

func (s *ProjectDocumentService) List(req *model.Page) (int64, int, int, []*model.ProjectDocumentResponse, error) {
	// 1.查询到所有的 project
	projects := make([]*model.Project, 0)
	if err := global.Db.Model(&model.Project{}).Find(&projects).Error; err != nil {
		return 0, 0, 0, nil, errors.New("系统错误")
	}
	projectDocumentResponses := make([]*model.ProjectDocumentResponse, 0)
	for _, project := range projects {
		projectStage := &model.ProjectStage{}
		if err := global.Db.Where("project_id = ?", project.Id).First(projectStage).Error; err != nil {
			return 0, 0, 0, nil, errors.New("系统错误")
		}
		projectDocument := &model.ProjectDocument{}
		if err := global.Db.Where("project_id = ? AND stage_id = ?", project.Id, projectStage.Id).First(projectDocument).Error; err != nil {
			return 0, 0, 0, nil, errors.New("系统错误")
		}
		projectDocumentResponses = append(projectDocumentResponses, &model.ProjectDocumentResponse{
			ProjectId: project.Id,
			StageId:   projectStage.Id,
			StageName: projectStage.Name,
			FilePath:  projectDocument.FilePath,
		})
	}

	start := (req.Current - 1) * req.PageSize
	end := start + req.PageSize
	if start >= len(projectDocumentResponses) {
		return int64(len(projectDocumentResponses)), 0, req.PageSize, nil, nil
	}
	if end > len(projectDocumentResponses) {
		end = len(projectDocumentResponses)
	}
	paginatedResults := projectDocumentResponses[start:end]

	return int64(len(projectDocumentResponses)), len(paginatedResults), req.PageSize, paginatedResults, nil
}
