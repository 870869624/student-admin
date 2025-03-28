package api

import (
	"backend/model"
	"backend/pkg/xcode"
	"backend/pkg/xres"
	"github.com/gin-gonic/gin"
)

func ProjectDownAdd(c *gin.Context) {
	r := &model.ProjectDownAddRequest{}
	if err := c.ShouldBindJSON(r); err != nil {
		xres.ErrorMessage(c, xcode.Error, "参数错误")
		return
	}
	if err := projectDownService.Add(r); err != nil {
		xres.ErrorMessage(c, xcode.Error, err.Error())
		return
	}
	xres.Success(c)
}
