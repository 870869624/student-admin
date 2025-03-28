package jwt

import (
	"backend/global"
	"errors"
	"github.com/golang-jwt/jwt/v4"
	"time"
)

type Jwt struct {
	SigningKey []byte
}

func NewJwt() *Jwt {
	return &Jwt{
		SigningKey: []byte(global.Config.JWT.SigningKey),
	}
}

func (j *Jwt) CreateToken(id int64) (string, error) {
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, jwt.MapClaims{
		"userId": id,
		"exp":    time.Now().Add(time.Hour * 24 * 14).Unix(),
	})
	tokenString, err := token.SignedString(j.SigningKey)
	if err != nil {
		return "", errors.New("系统错误")
	}
	return tokenString, nil
}

func (j *Jwt) ParseToken(tokenString string) (int64, error) {
	token, err := jwt.Parse(tokenString, func(token *jwt.Token) (interface{}, error) {
		if _, ok := token.Method.(*jwt.SigningMethodHMAC); !ok {
			return nil, errors.New("签名方法不匹配")
		}
		return j.SigningKey, nil
	})

	if err != nil {
		var ve *jwt.ValidationError
		if errors.As(err, &ve) {
			if ve.Errors&jwt.ValidationErrorExpired != 0 {
				return 0, errors.New("token 已过期")
			}
			return 0, errors.New("token 验证失败")
		}
		return 0, err
	}

	if claims, ok := token.Claims.(jwt.MapClaims); ok && token.Valid {
		if userId, exists := claims["userId"]; exists {
			if floatId, ok := userId.(float64); ok {
				return int64(floatId), nil
			}
			return 0, errors.New("用户Id格式错误，userId 不是 float64 类型")
		}
		return 0, errors.New("用户Id不存在")
	}

	return 0, errors.New("无效的token")
}
