package router

import (
	"backend/api"
	"github.com/gin-gonic/gin"
)

func InitUserRouter(router *gin.RouterGroup) {
	userRouter := router.Group("user")
	{
		userRouter.POST("register", api.UserRegister)
		userRouter.POST("login", api.UserLogin)
		userRouter.POST("update", api.UserUpdate)
		userRouter.POST("list", api.UserList)
		userRouter.POST("delete", api.UserDelete)
		userRouter.GET("get", api.UserGet)
	}
}
