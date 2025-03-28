package router

import (
	"backend/api"
	"github.com/gin-gonic/gin"
)

func InitProjectDownRouter(router *gin.RouterGroup) {
	projectDownRouter := router.Group("/project/down")
	{
		projectDownRouter.POST("/add", api.ProjectDownAdd)
	}
}
