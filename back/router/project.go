package router

import (
	"backend/api"
	"github.com/gin-gonic/gin"
)

func InitProjectRouter(router *gin.RouterGroup) {
	projectRouter := router.Group("project")
	{
		projectRouter.POST("add", api.ProjectAdd)
		projectRouter.POST("list", api.ProjectList)
		projectRouter.POST("delete", api.ProjectDelete)
		projectRouter.POST("update", api.ProjectUpdate)
		projectRouter.POST("update/status", api.ProjectUpdateStatus)
	}
}
