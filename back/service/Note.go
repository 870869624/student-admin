package service

import (
	"backend/global"
	"backend/model"
	"errors"
)

type NoteService struct {
}

// 0未读，1已读
func (s *NoteService) Update(req *model.DeleteRequest) error {
	if err := global.Db.Table("note").Where("id = ?", req.Id).Update("status", "1").Error; err != nil {
		return errors.New("系统错误")
	}
	return nil
}

func (s *NoteService) List(userId int64) (int64, int, int, []*model.Note, error) {
	query := global.Db.Model(&model.Note{})
	total := int64(0)
	if err := query.Count(&total).Error; err != nil {
		return 0, 0, 0, nil, err
	}

	note := make([]*model.Note, 0)
	if err := query.Where("user_id = ? and status = '0'", userId).Find(&note).Error; err != nil {
		return 0, 0, 0, nil, errors.New("系统错误")
	}

	return total, len(note), 0, note, nil
}
