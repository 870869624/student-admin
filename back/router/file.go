package router

import (
	"backend/api"

	"github.com/gin-gonic/gin"
)

func InitFileRouter(router *gin.RouterGroup) {
	fileRouter := router.Group("/files")
	{
		fileRouter.POST("/upload", api.Upload)
		fileRouter.GET("/:filename", api.Download)
		fileRouter.GET("/view/:filename", api.View)
	}
}
