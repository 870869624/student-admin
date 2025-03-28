package router

import (
	"backend/api"

	"github.com/gin-gonic/gin"
)

func InitAnnounceRouter(router *gin.RouterGroup) {
	announceRouter := router.Group("announce")
	{
		announceRouter.POST("add", api.AnnounceAdd)
		announceRouter.POST("delete", api.AnnounceDelete)
		announceRouter.GET("list", api.AnnounceList)
	}
}
