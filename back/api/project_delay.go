package api

import (
	"backend/model"
	"backend/pkg/xcode"
	"backend/pkg/xres"
	"github.com/gin-gonic/gin"
)

func ProjectDelayAdd(c *gin.Context) {
	r := &model.ProjectDelayAddRequest{}
	if err := c.ShouldBindJSON(r); err != nil {
		xres.ErrorMessage(c, xcode.Error, "参数错误")
		return
	}
	if err := projectDelayService.Add(r); err != nil {
		xres.ErrorMessage(c, xcode.Error, err.Error())
		return
	}
	xres.Success(c)
}

func ProjectDelayDelete(c *gin.Context) {
	r := &model.DeleteRequest{}
	if err := c.ShouldBindJSON(r); err != nil {
		xres.ErrorMessage(c, xcode.Error, "参数错误")
		return
	}
	if err := projectDelayService.Delete(r.Id); err != nil {
		xres.ErrorMessage(c, xcode.Error, err.Error())
		return
	}
	xres.Success(c)
}
