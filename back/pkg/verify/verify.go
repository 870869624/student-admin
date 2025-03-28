package verify

import (
	"reflect"
	"regexp"
)

// IsAnyBlank 判断传入的值是否有空值，如果有为空，就返回 true
func IsAnyBlank(values ...interface{}) bool {
	for _, v := range values {
		if isBlank(v) {
			return true
		}
	}
	return false
}

// isBlank 判断单个值是否为空
func isBlank(value interface{}) bool {
	v := reflect.ValueOf(value)
	switch v.Kind() {
	case reflect.String:
		return v.Len() == 0
	case reflect.Array, reflect.Slice, reflect.Map, reflect.Chan:
		return v.Len() == 0
	case reflect.Ptr, reflect.Interface:
		return v.IsNil()
	default:
		return false
	}
}

func IsValidPhone(phone string) bool {
	// 假设手机号格式为 11 位数字
	phoneRegex := `^\d{11}$`
	re := regexp.MustCompile(phoneRegex)
	return re.MatchString(phone)
}

func IsValidEmail(email string) bool {
	// 基本的邮箱格式正则表达式
	emailRegex := `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$`
	re := regexp.MustCompile(emailRegex)
	return re.MatchString(email)
}
