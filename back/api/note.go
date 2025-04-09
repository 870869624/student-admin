package api

import (
	"backend/model"
	"backend/pkg/jwt"
	"backend/pkg/token"
	"backend/pkg/xcode"
	"backend/pkg/xres"

	"github.com/gin-gonic/gin"
)

// AnnounceAdd 新增公告
func NoteUpdate(c *gin.Context) {
	var req *model.DeleteRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		xres.ErrorMessage(c, xcode.Error, err.Error())
		return
	}

	if err := noteService.Update(req); err != nil {
		xres.ErrorMessage(c, xcode.Error, err.Error())
		return
	}

	xres.Success(c)
}

// AnnounceList 获取所有公告
func NoteList(c *gin.Context) {
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
	total, size, pages, records, err := noteService.List(user.Id)
	if err != nil {
		xres.ErrorMessage(c, xcode.Error, err.Error())
		return
	}

	for i := range records {
		switch records[i].Content {
		case "declared":
			records[i].Content = "项目申报审核已通过"
		case "initiated":
			records[i].Content = "项目立项审核已通过"
		case "progress":
			records[i].Content = "项目中检审核已通过"
		case "completed":
			records[i].Content = "项目结项审核已通过"
		case "extended":
			records[i].Content = "项目已延期"
		case "terminated":
			records[i].Content = "项目已被终止"
		case "down":
			records[i].Content = "项目已被驳回"
		default:
			records[i].Content = "未知状态"
		}
	}
	xres.SuccessData(c, xres.PageResponse{
		Total:   total,
		Size:    size,
		Records: records,
		Pages:   pages,
	})
}
