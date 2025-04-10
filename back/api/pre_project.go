package api

import (
	"backend/model"
	"backend/pkg/verify"
	"backend/pkg/xcode"
	"backend/pkg/xres"

	"github.com/gin-gonic/gin"
)

func PreProjectAdd(c *gin.Context) {
	r := &model.PreProjectAddRequest{}
	if err := c.ShouldBindJSON(r); err != nil || verify.IsAnyBlank(r.Name, r.Description, r.StartDate, r.ExpectedEndDate, r.UserId) {
		xres.ErrorMessage(c, xcode.Error, "参数错误")
		return
	}
	if err := PreProjectService.Add(r); err != nil {
		xres.ErrorMessage(c, xcode.Error, err.Error())
		return
	}
	xres.Success(c)
}

func AllPreProjectList(c *gin.Context) {
	r := &model.AllPreProjectListRequest{}
	if err := c.ShouldBindJSON(r); err != nil {
		xres.ErrorMessage(c, xcode.Error, "参数错误")
		return
	}

	total, size, pages, records, err := PreProjectService.List(r)
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

func MyPreProjectList(c *gin.Context) {
	r := &model.MyPreProjectListRequest{}
	if err := c.ShouldBindJSON(r); err != nil {
		xres.ErrorMessage(c, xcode.Error, "参数错误")
		return
	}

	total, size, pages, records, err := PreProjectService.MyList(r)
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

// 可申报列表
func OPreProjectList(c *gin.Context) {
	r := &model.OPreProjectListRequest{}
	if err := c.ShouldBindJSON(r); err != nil {
		xres.ErrorMessage(c, xcode.Error, "参数错误")
		return
	}

	total, size, pages, records, err := PreProjectService.OList(r)
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

func PreProjectUpdate(c *gin.Context) {
	r := &model.PreProjectUpdateRequest{}
	if err := c.ShouldBindJSON(r); err != nil {
		xres.ErrorMessage(c, xcode.Error, "参数错误")
		return
	}
	if err := PreProjectService.Update(r); err != nil {
		xres.ErrorMessage(c, xcode.Error, err.Error())
		return
	}
	xres.Success(c)
}

func PreProjectDelete(c *gin.Context) {
	r := &model.DeleteRequest{}
	if err := c.ShouldBindJSON(r); err != nil {
		xres.ErrorMessage(c, xcode.Error, "参数错误")
		return
	}
	if err := PreProjectService.Delete(r); err != nil {
		xres.ErrorMessage(c, xcode.Error, err.Error())
		return
	}
	xres.Success(c)
}

func PreProjectUpdateStatus(c *gin.Context) {
	r := &model.PreProjectUpdateStatusRequest{}
	if err := c.ShouldBindJSON(r); err != nil {
		xres.ErrorMessage(c, xcode.Error, "参数错误")
		return
	}
	if err := PreProjectService.UpdateStatus(r); err != nil {
		xres.ErrorMessage(c, xcode.Error, err.Error())
		return
	}
	xres.Success(c)
}
