package router

import (
	"backend/api"

	"github.com/gin-gonic/gin"
)

func InitPreProjectRouter(router *gin.RouterGroup) {
	projectRouter := router.Group("preProject")
	{
		projectRouter.POST("add", api.PreProjectAdd)
		projectRouter.POST("allList", api.AllPreProjectList)
		projectRouter.POST("myList", api.MyPreProjectList)
		projectRouter.POST("oList", api.OPreProjectList)
		projectRouter.POST("delete", api.PreProjectDelete)
		projectRouter.POST("update", api.PreProjectUpdate)
		projectRouter.POST("update/status", api.PreProjectUpdateStatus)
	}
}
