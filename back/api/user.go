package api

import (
	"backend/model"
	"backend/pkg/jwt"
	"backend/pkg/token"
	"backend/pkg/verify"
	"backend/pkg/xcode"
	"backend/pkg/xres"
	"github.com/gin-gonic/gin"
)

func UserRegister(c *gin.Context) {
	r := &model.UserRegisterRequest{}
	if err := c.ShouldBindJSON(r); err != nil {
		xres.ErrorMessage(c, xcode.Error, "参数错误")
		return
	}
	if ok, s := validRequest(r.Account, r.Password, r.Phone, r.Email, r.Gender, r.Organization, r.Job, r.RoleId); !ok {
		xres.ErrorMessage(c, xcode.Error, s)
		return
	}

	if err := userService.Register(r); err != nil {
		xres.ErrorMessage(c, xcode.Error, err.Error())
		return
	}
	xres.Success(c)
}

func UserLogin(c *gin.Context) {
	r := &model.UserLoginRequest{}
	if err := c.ShouldBindJSON(r); err != nil || verify.IsAnyBlank(r.Account, r.Password) {
		xres.ErrorMessage(c, xcode.Error, "参数错误")
		return
	}
	user, err := userService.Login(r)
	if err != nil {
		xres.ErrorMessage(c, xcode.Error, err.Error())
		return
	}

	j := jwt.NewJwt()
	tok, err := j.CreateToken(user.Id)
	if err != nil {
		xres.Error(c, xcode.Error)
		return
	}

	token.SetToken(c, tok)
	xres.Success(c)
}

func UserUpdate(c *gin.Context) {
	r := &model.UserUpdateRequest{}
	if err := c.ShouldBindJSON(r); err != nil {
		xres.ErrorMessage(c, xcode.Error, "参数错误")
		return
	}
	if ok, s := validRequest(r.Account, r.Password, r.Phone, r.Email, r.Gender, r.Organization, r.Job, r.RoleId); !ok {
		xres.ErrorMessage(c, xcode.Error, s)
		return
	}

	if err := userService.Update(r); err != nil {
		xres.ErrorMessage(c, xcode.Error, err.Error())
		return
	}
	xres.Success(c)
}

func UserList(c *gin.Context) {
	r := &model.UserListRequest{}
	if err := c.ShouldBindJSON(r); err != nil {
		xres.ErrorMessage(c, xcode.Error, "参数错误")
		return
	}

	total, size, pages, records, err := userService.List(r)
	if err != nil {
		xres.ErrorMessage(c, xcode.Error, err.Error())
		return
	}

	xres.SuccessData(c, xres.PageResponse{
		Total:   total,
		Size:    size,
		Records: records,
		Pages:   pages,
	})
}

func UserDelete(c *gin.Context) {
	r := &model.DeleteRequest{}
	if err := c.ShouldBindJSON(r); err != nil {
		xres.ErrorMessage(c, xcode.Error, "参数错误")
		return
	}
	if err := userService.Delete(r); err != nil {
		xres.ErrorMessage(c, xcode.Error, err.Error())
		return
	}
	xres.Success(c)
}

func UserGet(c *gin.Context) {
	j := jwt.NewJwt()
	id, err := j.ParseToken(token.GetToken(c))
	if err != nil {
		xres.Error(c, xcode.Error)
		return
	}
	user, err := userService.GetUser(id)
	if err != nil {
		xres.Error(c, xcode.Error)
		return
	}
	xres.SuccessData(c, user)
}

func validRequest(account, password, phone, email, gender, organization, job string, roleId int64) (bool, string) {
	if verify.IsAnyBlank(account, password, phone, email, gender, organization, job, roleId) {
		return false, "参数不能为空"
	}
	if len(account) < 4 || len(password) < 6 {
		return false, "账号不能小于4位，密码不能小于6位"
	}
	if !verify.IsValidPhone(phone) {
		return false, "手机号码不符合规则"
	}
	if !verify.IsValidEmail(email) {
		return false, "邮箱不符合规则"
	}
	return true, ""
}
