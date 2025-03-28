package router

import (
	"backend/api"
	"github.com/gin-gonic/gin"
)

func InitProjectStageRouter(router *gin.RouterGroup) {
	projectStageRouter := router.Group("project/stage")
	{
		projectStageRouter.POST("update", api.ProjectStageUpdate)
	}
}
