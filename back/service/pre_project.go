package service

import (
	"backend/global"
	"backend/model"
	"errors"
	"fmt"
	"time"

	"github.com/jinzhu/copier"
)

type PreProjectService struct{}

func (s *PreProjectService) Add(req *model.PreProjectAddRequest) error {
	// 项目表
	project := &model.PreProject{}
	if err := copier.Copy(project, req); err != nil {
		return err
	}
	project.StartDate = time.Unix(req.StartDate, 0)
	project.ExpectedEndDate = time.Unix(req.ExpectedEndDate, 0)
	project.Status = "0" //0待审核，1审核通过，2审核不通过

	if err := global.Db.Create(project).Error; err != nil {
		return errors.New("系统错误")
	}

	return nil
}

func (s *PreProjectService) Update(req *model.PreProjectUpdateRequest) error {
	project := &model.PreProject{}
	if err := copier.Copy(project, req); err != nil {
		return err
	}
	project.Status = "0"
	if err := global.Db.Model(project).Updates(project).Error; err != nil {
		return err
	}
	return nil
}

func (s *PreProjectService) Delete(req *model.DeleteRequest) error {
	project := &model.PreProject{}
	if err := global.Db.Where("id = ?", req.Id).First(project).Error; err != nil {
		return errors.New("系统错误")
	}
	if err := global.Db.Delete(project).Error; err != nil {
		return errors.New("系统错误")
	}

	return nil
}

func (s *PreProjectService) List(req *model.AllPreProjectListRequest) (int64, int, int, []*model.PreProjectResponse, error) {
	query := global.Db.Model(&model.PreProject{})

	query = query.Where("status = 1")

	if req.Name != "" {
		query = query.Where("name like ?", "%"+req.Name+"%")
	}
	if req.Description != "" {
		query = query.Where("description like ?", "%"+req.Description+"%")
	}

	total := int64(0)
	if err := query.Count(&total).Error; err != nil {
		return 0, 0, 0, nil, errors.New("系统错误")
	}

	projects := make([]*model.PreProject, 0)
	if err := query.Offset((req.Current - 1) * req.PageSize).Limit(req.PageSize).Find(&projects).Error; err != nil {
		return 0, 0, 0, nil, errors.New("系统错误")
	}

	pages := int((total + int64(req.PageSize) - 1) / int64(req.PageSize))

	projectRes := make([]*model.PreProjectResponse, len(projects))
	for i, project := range projects {
		projectRes[i] = &model.PreProjectResponse{}
		if err := copier.Copy(projectRes[i], project); err != nil {
			fmt.Println(err)
			return 0, 0, 0, nil, errors.New("系统错误")
		}
		projectRes[i].StartDate = project.StartDate.Unix()
		projectRes[i].ExpectedEndDate = project.ExpectedEndDate.Unix()

	}

	return total, len(projectRes), pages, projectRes, nil
}

func (s *PreProjectService) MyList(req *model.MyPreProjectListRequest) (int64, int, int, []*model.PreProjectResponse, error) {
	query := global.Db.Model(&model.PreProject{})
	if req.UserId != 0 {
		query = query.Where("user_id = ?", req.UserId)
	}

	if req.Name != "" {
		query = query.Where("name like ?", "%"+req.Name+"%")
	}
	if req.Description != "" {
		query = query.Where("description like ?", "%"+req.Description+"%")
	}

	total := int64(0)
	if err := query.Count(&total).Error; err != nil {
		return 0, 0, 0, nil, errors.New("系统错误")
	}

	projects := make([]*model.PreProject, 0)
	if err := query.Offset((req.Current - 1) * req.PageSize).Limit(req.PageSize).Find(&projects).Error; err != nil {
		return 0, 0, 0, nil, errors.New("系统错误")
	}

	pages := int((total + int64(req.PageSize) - 1) / int64(req.PageSize))

	projectRes := make([]*model.PreProjectResponse, len(projects))
	for i, project := range projects {
		projectRes[i] = &model.PreProjectResponse{}
		if err := copier.Copy(projectRes[i], project); err != nil {
			fmt.Println(err)
			return 0, 0, 0, nil, errors.New("系统错误")
		}
		projectRes[i].StartDate = project.StartDate.Unix()
		projectRes[i].ExpectedEndDate = project.ExpectedEndDate.Unix()

	}

	return total, len(projectRes), pages, projectRes, nil
}

func (s *PreProjectService) OList(req *model.OPreProjectListRequest) (int64, int, int, []*model.PreProjectResponse, error) {
	query := global.Db.Model(&model.PreProject{})

	query = query.Where("status = 1")

	total := int64(0)
	if err := query.Count(&total).Error; err != nil {
		return 0, 0, 0, nil, errors.New("系统错误")
	}

	projects := make([]*model.PreProject, 0)
	if err := query.Offset((req.Current - 1) * req.PageSize).Limit(req.PageSize).Find(&projects).Error; err != nil {
		return 0, 0, 0, nil, errors.New("系统错误")
	}

	pages := int((total + int64(req.PageSize) - 1) / int64(req.PageSize))

	projectRes := make([]*model.PreProjectResponse, len(projects))
	for i, project := range projects {
		projectRes[i] = &model.PreProjectResponse{}
		if err := copier.Copy(projectRes[i], project); err != nil {
			fmt.Println(err)
			return 0, 0, 0, nil, errors.New("系统错误")
		}
		projectRes[i].StartDate = project.StartDate.Unix()
		projectRes[i].ExpectedEndDate = project.ExpectedEndDate.Unix()

	}

	return total, len(projectRes), pages, projectRes, nil
}

func (s *PreProjectService) UpdateStatus(req *model.PreProjectUpdateStatusRequest) error {
	if err := global.Db.Model(&model.PreProject{}).Where("id = ?", req.ProjectId).Update("status", req.Status).Error; err != nil {
		return errors.New("系统错误")
	}

	// 下一个阶段

	return nil
}

func (s *PreProjectService) GetById(id int64) (*model.Project, error) {
	project := &model.Project{}
	if err := global.Db.Where("id = ?", id).First(project).Error; err != nil {
		return nil, err
	}
	return project, nil
}
