package router

import (
	"backend/api"
	"github.com/gin-gonic/gin"
)

func InitProjectDocumentRouter(router *gin.RouterGroup) {
	projectDocumentRouter := router.Group("project/document")
	{
		projectDocumentRouter.POST("list", api.ProjectDocumentList)
	}
}
