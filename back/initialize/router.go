package initialize

import (
	"backend/global"
	"backend/router"
	"fmt"
)

func InitRouter() {
	routers := router.Router()
	address := fmt.Sprintf(":%d", global.Config.Server.Port)
	routers.Run(address)
}
