package router

import (
	"backend/global"
	"backend/middleware"

	"github.com/gin-gonic/gin"
)

// Router 初始化总路由
func Router() *gin.Engine {
	if global.Config.Server.Mode == "public" {
		gin.SetMode(gin.ReleaseMode)
	}

	router := gin.New()
	router.Use(gin.Recovery())
	if global.Config.Server.Mode != "public" {
		router.Use(gin.Logger())
	}

	router.Use(middleware.Cors())

	group := router.Group(global.Config.Server.RouterPrefix)
	{
		InitUserRouter(group)
		InitRoleRouter(group)
		InitPermissionRouter(group)
		InitFileRouter(group)
		InitProjectRouter(group)
		InitProjectStageRouter(group)
		InitProjectDelayRouter(group)
		InitProjectDocumentRouter(group)
		InitProjectDownRouter(group)
		InitAnnounceRouter(group)
		InitNoteRouter(group)
	}

	return router
}
