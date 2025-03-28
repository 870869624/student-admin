package api

import (
	"backend/model"
	"backend/pkg/xcode"
	"backend/pkg/xres"

	"github.com/gin-gonic/gin"
)

func AnnounceAdd(c *gin.Context) {
	r := &model.Announce{}
	if err := c.ShouldBindJSON(r); err != nil {
		xres.ErrorMessage(c, xcode.Error, "参数错误")
		return
	}

	if err := announceService.Add(r); err != nil {
		xres.ErrorMessage(c, xcode.Error, err.Error())
		return
	}
	xres.Success(c)
}

func AnnounceList(c *gin.Context) {
	r := &model.AnnounceListRequest{}
	if err := c.ShouldBindJSON(r); err != nil {
		xres.ErrorMessage(c, xcode.Error, "参数错误")
		return
	}

	total, size, pages, records, err := announceService.List()
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

func AnnounceDelete(c *gin.Context) {
	r := &model.DeleteRequest{}
	if err := c.ShouldBindJSON(r); err != nil {
		xres.ErrorMessage(c, xcode.Error, "参数错误")
		return
	}
	if err := announceService.Delete(r); err != nil {
		xres.ErrorMessage(c, xcode.Error, err.Error())
		return
	}
	xres.Success(c)
}
