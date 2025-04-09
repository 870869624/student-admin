package service

import (
	"backend/global"
	"backend/model"
	"backend/pkg/crypt"
	"errors"

	"github.com/jinzhu/copier"
	"gorm.io/gorm"
)

type UserService struct {
}

func (s *UserService) Register(req *model.UserRegisterRequest) error {
	if !errors.Is(global.Db.Where("account = ?", req.Account).First(&model.User{}).Error, gorm.ErrRecordNotFound) {
		return errors.New("账号已经存在")
	}
	user := &model.User{}
	if err := copier.Copy(user, req); err != nil {
		return errors.New("系统错误")
	}
	user.Password = crypt.BcryptHash(user.Password)
	if err := global.Db.Create(user).Error; err != nil {
		return errors.New("系统错误")
	}
	return nil
}

func (s *UserService) Login(req *model.UserLoginRequest) (*model.User, error) {
	user := &model.User{}
	if err := global.Db.Where("account = ?", req.Account).First(user).Error; err != nil {
		return nil, errors.New("账号不存在")
	}
	if ok := crypt.BcryptCheck(req.Password, user.Password); !ok {
		return nil, errors.New("密码错误")
	}
	return user, nil
}

func (s *UserService) GetUser(id int64) (*model.UserResponse, error) {
	user := &model.User{}
	if err := global.Db.Where("id = ?", id).First(user).Error; err != nil {
		return nil, errors.New("用户不存在")
	}
	userRes := &model.UserResponse{}
	if err := copier.Copy(userRes, user); err != nil {
		return nil, errors.New("系统错误")
	}

	var permissions []model.Permission
	if err := global.Db.
		Table("permission").
		Select("permission.id").
		Joins("JOIN role_permission ON role_permission.permission_id = permission.id").
		Where("role_permission.role_id = ?", user.RoleId).
		Find(&permissions).Error; err != nil {
		return nil, errors.New("系统错误")
	}

	permissionIDs := make([]int64, len(permissions))
	for i, perm := range permissions {
		permissionIDs[i] = perm.Id
	}
	userRes.PermissionIds = permissionIDs

	return userRes, nil
}

func (s *UserService) Update(req *model.UserUpdateRequest) error {
	req.Password = crypt.BcryptHash(req.Password)
	if err := global.Db.Model(&model.User{}).Where("id = ?", req.Id).Updates(req).Error; err != nil {
		return errors.New("系统错误")
	}
	return nil
}

func (s *UserService) Delete(req *model.DeleteRequest) error {
	if err := global.Db.Where("id = ?", req.Id).Delete(&model.User{}).Error; err != nil {
		return errors.New("系统错误")
	}
	return nil
}

func (s *UserService) List(req *model.UserListRequest) (int64, int, int, []*model.User, error) {
	query := global.Db.Model(&model.User{})
	if req.Account != "" {
		query = query.Where("account LIKE ?", "%"+req.Account+"%")
	}
	if req.Username != "" {
		query = query.Where("username LIKE ?", "%"+req.Username+"%")
	}
	if req.Department != "" {
		query = query.Where("department LIKE ?", "%"+req.Department+"%")
	}
	if req.Organization != "" {
		query = query.Where("organization LIKE ?", "%"+req.Organization+"%")
	}
	if req.Job != "" {
		query = query.Where("job LIKE ?", "%"+req.Job+"%")
	}
	if req.RoleId != 0 {
		query = query.Where("role_id = ?", req.RoleId)
	}

	total := int64(0)
	if err := query.Count(&total).Error; err != nil {
		return 0, 0, 0, nil, err
	}

	users := make([]*model.User, 0)
	if err := query.Offset((req.Current - 1) * req.PageSize).Limit(req.PageSize).Find(&users).Error; err != nil {
		return 0, 0, 0, nil, errors.New("系统错误")
	}

	pages := int((total + int64(req.PageSize) - 1) / int64(req.PageSize))

	return total, len(users), pages, users, nil
}
