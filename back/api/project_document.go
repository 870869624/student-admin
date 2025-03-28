package api

import (
	"backend/model"
	"backend/pkg/xcode"
	"backend/pkg/xres"
	"github.com/gin-gonic/gin"
)

func ProjectDocumentList(c *gin.Context) {
	r := &model.Page{}
	if err := c.ShouldBindJSON(r); err != nil {
		xres.ErrorMessage(c, xcode.Error, "参数错误")
		return
	}

	total, size, pages, records, err := projectDocumentService.List(r)
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
