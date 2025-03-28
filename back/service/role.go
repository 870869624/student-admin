package service

import (
	"backend/global"
	"backend/model"
	"errors"
	"gorm.io/gorm"
)

type RoleService struct{}

func (s *RoleService) Add(req *model.RoleAddRequest) error {
	if !errors.Is(global.Db.Where("name = ?", req.Name).First(&model.Role{}).Error, gorm.ErrRecordNotFound) {
		return errors.New("角色已经存在")
	}
	role := &model.Role{Name: req.Name}
	if err := global.Db.Create(role).Error; err != nil {
		return errors.New("系统错误")
	}
	return nil
}

func (s *RoleService) Update(req *model.RoleUpdateRequest) error {
	if err := global.Db.Model(&model.Role{}).Where("id = ?", req.Id).Updates(map[string]interface{}{
		"name": req.Name,
	}).Error; err != nil {
		return errors.New("系统错误")
	}
	return nil
}

func (s *RoleService) Delete(req *model.DeleteRequest) error {
	if err := global.Db.Where("id = ?", req.Id).Delete(&model.Role{}).Error; err != nil {
		return errors.New("系统错误")
	}
	return nil
}

func (s *RoleService) List(req *model.Page) (int64, int, int, []*model.RoleResponse, error) {
	roles := make([]*model.Role, 0)
	total := int64(0)

	if err := global.Db.Model(&model.Role{}).Count(&total).Error; err != nil {
		return 0, 0, 0, nil, errors.New("系统错误")
	}

	if err := global.Db.Model(&model.Role{}).
		Offset((req.Current - 1) * req.PageSize).
		Limit(req.PageSize).
		Find(&roles).Error; err != nil {
		return 0, 0, 0, nil, errors.New("系统错误")
	}

	roleRes := make([]*model.RoleResponse, 0)
	for _, role := range roles {
		permissions := make([]*model.Permission, 0)

		if err := global.Db.Table("permission").
			Select("permission.id, permission.name").
			Joins("JOIN role_permission ON role_permission.permission_id = permission.id").
			Where("role_permission.role_id = ?", role.Id).
			Scan(&permissions).Error; err != nil {
			return 0, 0, 0, nil, errors.New("系统错误")
		}

		roleRes = append(roleRes, &model.RoleResponse{
			Id:          role.Id,
			Name:        role.Name,
			Permissions: permissions,
		})
	}

	pages := int((total + int64(req.PageSize) - 1) / int64(req.PageSize))

	return total, len(roleRes), pages, roleRes, nil
}

func (s *RoleService) PermissionAdd(req *model.RolePermissionAddRequest) error {
	rolePermission := &model.RolePermission{
		RoleId:       req.RoleId,
		PermissionId: req.PermissionId,
	}
	if err := global.Db.Create(rolePermission).Error; err != nil {
		return errors.New("系统错误")
	}
	return nil
}
