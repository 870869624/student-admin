package service

import (
	"backend/global"
	"backend/model"
	"errors"
)

type AnnounceService struct {
}

func (s *AnnounceService) Delete(req *model.DeleteRequest) error {
	if err := global.Db.Where("id = ?", req.Id).Delete(&model.Announce{}).Error; err != nil {
		return errors.New("系统错误")
	}
	return nil
}

func (s *AnnounceService) Add(req *model.Announce) error {
	if err := global.Db.Create(req).Error; err != nil {
		return errors.New("系统错误")
	}
	return nil
}

func (s *AnnounceService) List() (int64, int, int, []*model.Announce, error) {
	query := global.Db.Model(&model.Announce{})

	total := int64(0)
	if err := query.Count(&total).Error; err != nil {
		return 0, 0, 0, nil, err
	}

	announce := make([]*model.Announce, 0)
	if err := query.Find(&announce).Error; err != nil {
		return 0, 0, 0, nil, errors.New("系统错误")
	}

	return total, len(announce), 0, announce, nil
}
