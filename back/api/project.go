package api

import (
	"backend/model"
	"backend/pkg/verify"
	"backend/pkg/xcode"
	"backend/pkg/xres"
	"github.com/gin-gonic/gin"
)

func ProjectAdd(c *gin.Context) {
	r := &model.ProjectAddRequest{}
	if err := c.ShouldBindJSON(r); err != nil || verify.IsAnyBlank(r.Name, r.Description, r.StartDate, r.ExpectedEndDate, r.UserId, r.Department, r.TeacherId, r.Batch, r.Source, r.ResultType, r.FilePath) {
		xres.ErrorMessage(c, xcode.Error, "参数错误")
		return
	}
	if err := projectService.Add(r); err != nil {
		xres.ErrorMessage(c, xcode.Error, err.Error())
		return
	}
	xres.Success(c)
}

func ProjectList(c *gin.Context) {
	r := &model.ProjectListRequest{}
	if err := c.ShouldBindJSON(r); err != nil {
		xres.ErrorMessage(c, xcode.Error, "参数错误")
		return
	}

	total, size, pages, records, err := projectService.List(r)
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

func ProjectUpdate(c *gin.Context) {
	r := &model.ProjectUpdateRequest{}
	if err := c.ShouldBindJSON(r); err != nil {
		xres.ErrorMessage(c, xcode.Error, "参数错误")
		return
	}
	if err := projectService.Update(r); err != nil {
		xres.ErrorMessage(c, xcode.Error, err.Error())
		return
	}
	xres.Success(c)
}

func ProjectDelete(c *gin.Context) {
	r := &model.DeleteRequest{}
	if err := c.ShouldBindJSON(r); err != nil {
		xres.ErrorMessage(c, xcode.Error, "参数错误")
		return
	}
	if err := projectService.Delete(r); err != nil {
		xres.ErrorMessage(c, xcode.Error, err.Error())
		return
	}
	xres.Success(c)
}

func ProjectUpdateStatus(c *gin.Context) {
	r := &model.ProjectUpdateStatusRequest{}
	if err := c.ShouldBindJSON(r); err != nil {
		xres.ErrorMessage(c, xcode.Error, "参数错误")
		return
	}
	if err := projectService.UpdateStatus(r); err != nil {
		xres.ErrorMessage(c, xcode.Error, err.Error())
		return
	}
	xres.Success(c)
}
