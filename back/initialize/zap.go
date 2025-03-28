package initialize

import (
	"backend/core"
	"backend/global"
	"backend/pkg/file"
	"fmt"
	"go.uber.org/zap"
	"go.uber.org/zap/zapcore"
	"os"
)

func InitZap() {
	if ok := file.DirExistOrNot(global.Config.Zap.Directory); !ok {
		fmt.Printf("create %v directory\n", global.Config.Zap.Directory)
		_ = os.Mkdir(global.Config.Zap.Directory, os.ModePerm)
	}

	z := &global.Config.Zap
	cores := core.Zap.GetZapCores()
	logger := zap.New(zapcore.NewTee(cores...))

	// 是否显示行号
	if z.ShowLine {
		logger = logger.WithOptions(zap.AddCaller())
	}
	global.Log = logger
}
