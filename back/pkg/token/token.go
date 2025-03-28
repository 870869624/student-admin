package token

import (
	"fmt"
	"net"

	"github.com/gin-gonic/gin"
)

const cookieName = "a-token"

func GetToken(c *gin.Context) string {
	token, _ := c.Cookie(cookieName)
	if token == "" {
		token = c.Request.Header.Get(cookieName)
	}
	return token
}

func SetToken(c *gin.Context, token string) {
	maxAge := 14 * 24 * 60 * 60 // 14 天的秒数

	host, _, err := net.SplitHostPort(c.Request.Host)
	if err != nil {
		host = c.Request.Host
	}
	fmt.Println(token)
	c.SetCookie(cookieName, token, maxAge, "/", host, false, false)

	str := fmt.Sprintf("a-token=%s; Path=/; Domain=%s; Max-Age=%d; Secure; HttpOnly; SameSite=None", token, host, maxAge)
	c.Header("Set-Cookie", str)
}
