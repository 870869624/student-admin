package router

import (
	"backend/api"

	"github.com/gin-gonic/gin"
)

func InitNoteRouter(router *gin.RouterGroup) {
	announceRouter := router.Group("note")
	{
		announceRouter.POST("update", api.NoteUpdate)
		announceRouter.GET("list", api.NoteList)
	}
}
