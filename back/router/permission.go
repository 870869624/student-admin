package router

import (
	"backend/api"
	"github.com/gin-gonic/gin"
)

func InitPermissionRouter(router *gin.RouterGroup) {
	permissionRouter := router.Group("permission")
	{
		permissionRouter.POST("list", api.PermissionList)
	}
}
