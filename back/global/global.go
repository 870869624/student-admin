package global

import (
	"backend/config"
	"github.com/redis/go-redis/v9"
	"go.uber.org/zap"
	"gorm.io/gorm"
)

var (
	Db     *gorm.DB      // 数据库
	Config config.Config // 配置信息
	Log    *zap.Logger   // 日志
	Redis  *redis.Client // redis 客户端
)
