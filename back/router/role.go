package router

import (
	"backend/api"
	"github.com/gin-gonic/gin"
)

func InitRoleRouter(router *gin.RouterGroup) {
	roleRouter := router.Group("role")
	{
		roleRouter.POST("add", api.RoleAdd)
		roleRouter.POST("update", api.RoleUpdate)
		roleRouter.POST("delete", api.RoleDelete)
		roleRouter.POST("list", api.RoleList)
		roleRouter.POST("permission", api.RolePermission)
	}
}
