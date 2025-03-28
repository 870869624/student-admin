package service

import (
	"backend/global"
	"backend/model"
	"errors"
)

type PermissionService struct{}

func (s *PermissionService) List(req *model.Page) (int64, int, int, []*model.PermissionResponse, error) {
	permissions := make([]*model.Permission, 0)
	total := int64(0)

	if err := global.Db.Model(&model.Permission{}).Count(&total).Error; err != nil {
		return 0, 0, 0, nil, errors.New("系统错误")
	}

	if err := global.Db.Model(&model.Permission{}).
		Offset((req.Current - 1) * req.PageSize).
		Limit(req.PageSize).
		Find(&permissions).Error; err != nil {
		return 0, 0, 0, nil, errors.New("系统错误")
	}

	permissionRes := make([]*model.PermissionResponse, 0)
	for _, permission := range permissions {
		roles := make([]*model.Role, 0)

		if err := global.Db.Table("role").
			Select("role.id, role.name").
			Joins("JOIN role_permission ON role_permission.role_id = role.id").
			Where("role_permission.permission_id = ?", permission.Id).
			Scan(&roles).Error; err != nil {
			return 0, 0, 0, nil, errors.New("系统错误")
		}

		permissionRes = append(permissionRes, &model.PermissionResponse{
			Id:    permission.Id,
			Name:  permission.Name,
			Roles: roles,
		})
	}

	pages := int((total + int64(req.PageSize) - 1) / int64(req.PageSize))

	return total, len(permissionRes), pages, permissionRes, nil
}
