package router

import (
	"backend/api"

	"github.com/gin-gonic/gin"
)

func InitAnnounceRouter(router *gin.RouterGroup) {
	userRouter := router.Group("announce")
	{
		userRouter.POST("register", api.UserRegister)
		userRouter.POST("delete", api.UserDelete)
		userRouter.GET("get", api.UserGet)
	}
}
