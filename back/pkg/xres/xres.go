package xres

import (
	"backend/pkg/xcode"
	"github.com/gin-gonic/gin"
	"net/http"
)

type Response struct {
	Code int         `json:"code"`
	Data interface{} `json:"data"`
	Msg  string      `json:"msg"`
}

type PageResponse struct {
	Total   int64       `json:"total"`
	Size    int         `json:"size"`
	Pages   int         `json:"pages"`
	Records interface{} `json:"records"`
}

func result(c *gin.Context, code int, data interface{}, msg string) {
	c.JSON(http.StatusOK, Response{
		Code: code,
		Data: data,
		Msg:  msg,
	})
}

func Success(c *gin.Context) {
	result(c, xcode.Success, nil, "success")
}

func SuccessMessage(c *gin.Context, msg string) {
	result(c, xcode.Success, nil, msg)
}

func SuccessData(c *gin.Context, data interface{}) {
	result(c, xcode.Success, data, "success")
}

func SuccessDetailed(c *gin.Context, msg string, data interface{}) {
	result(c, xcode.Success, data, msg)
}

func Error(c *gin.Context, code int) {
	result(c, code, nil, xcode.GetMsg(code))
}

func ErrorMessage(c *gin.Context, code int, msg string) {
	result(c, code, nil, msg)
}

func ErrorDetailed(c *gin.Context, code int, data interface{}, msg string) {
	result(c, code, data, msg)
}
