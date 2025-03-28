package api

import (
	"backend/global"
	"backend/pkg/file"
	"backend/pkg/xcode"
	"backend/pkg/xres"
	"fmt"
	"net/http"
	"os"
	"path/filepath"

	"github.com/gin-gonic/gin"
)

func Upload(c *gin.Context) {
	fileHeader, err := c.FormFile("file")
	if err != nil {
		fmt.Println(err)
		xres.ErrorMessage(c, xcode.Error, "参数错误")
		return
	}

	fileURL, err := file.SaveFileLocal(fileHeader)
	if err != nil {
		xres.ErrorMessage(c, xcode.Error, "系统错误")
		return
	}

	xres.SuccessData(c, fileURL)
}

func Download(c *gin.Context) {
	fileName := c.Param("filename")
	if fileName == "" {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Filename is required"})
		return
	}

	filePath := filepath.Join(".", global.Config.Server.FilePath, fileName)

	if _, err := os.Stat(filePath); os.IsNotExist(err) {
		c.JSON(http.StatusNotFound, gin.H{"error": "File not found"})
		return
	}

	c.Header("Content-Description", "File Transfer")
	c.Header("Content-Disposition", "attachment; filename="+fileName)
	c.Header("Content-Type", "application/octet-stream")

	c.File(filePath)
}
