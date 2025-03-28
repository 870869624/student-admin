package api

import (
	"backend/model"
	"backend/pkg/xcode"
	"backend/pkg/xres"
	"github.com/gin-gonic/gin"
)

func RoleAdd(c *gin.Context) {
	r := &model.RoleAddRequest{}
	if err := c.ShouldBindJSON(r); err != nil {
		xres.ErrorMessage(c, xcode.Error, "参数错误")
		return
	}
	if err := roleService.Add(r); err != nil {
		xres.ErrorMessage(c, xcode.Error, err.Error())
		return
	}
	xres.Success(c)
}

func RoleDelete(c *gin.Context) {
	r := &model.DeleteRequest{}
	if err := c.ShouldBindJSON(r); err != nil {
		xres.ErrorMessage(c, xcode.Error, "参数错误")
		return
	}
	if err := roleService.Delete(r); err != nil {
		xres.ErrorMessage(c, xcode.Error, err.Error())
		return
	}
	xres.Success(c)
}

func RoleList(c *gin.Context) {
	r := &model.Page{}
	if err := c.ShouldBindJSON(r); err != nil {
		xres.ErrorMessage(c, xcode.Error, "参数错误")
		return
	}

	total, size, pages, records, err := roleService.List(r)
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

func RoleUpdate(c *gin.Context) {
	r := &model.RoleUpdateRequest{}
	if err := c.ShouldBindJSON(r); err != nil {
		xres.ErrorMessage(c, xcode.Error, "参数错误")
		return
	}
	if err := roleService.Update(r); err != nil {
		xres.ErrorMessage(c, xcode.Error, err.Error())
		return
	}
	xres.Success(c)
}

func RolePermission(c *gin.Context) {
	r := &model.RolePermissionAddRequest{}
	if err := c.ShouldBindJSON(r); err != nil {
		xres.ErrorMessage(c, xcode.Error, "参数错误")
		return
	}
	if err := roleService.PermissionAdd(r); err != nil {
		xres.ErrorMessage(c, xcode.Error, err.Error())
		return
	}
	xres.Success(c)
}
