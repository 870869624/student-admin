package router

import (
	"backend/api"
	"github.com/gin-gonic/gin"
)

func InitProjectDelayRouter(router *gin.RouterGroup) {
	projectDelayRouter := router.Group("project/delay")
	{
		projectDelayRouter.POST("delete", api.ProjectDelayDelete)
		projectDelayRouter.POST("add", api.ProjectDelayAdd)
	}
}
