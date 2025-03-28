package initialize

import (
	"backend/global"
	"context"
	"github.com/redis/go-redis/v9"
	"go.uber.org/zap"
)

func InitRedis() {
	r := &global.Config.Redis
	// 创建客户端
	client := redis.NewClient(r.Options())
	pong, err := client.Ping(context.Background()).Result()
	if err != nil {
		global.Log.Error("redis connect ping failed, err:", zap.Error(err))
		panic(err)
	} else {
		global.Log.Info("redis connect ping xres:", zap.String("pong", pong))
		global.Redis = client
	}
}
