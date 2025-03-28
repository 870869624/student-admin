package xcode

const (
	Success = 0
	Error   = 1
)

var msgFlags = map[int]string{
	Success: "ok",
	Error:   "error",
}

func GetMsg(code int) string {
	msg, ok := msgFlags[code]
	if !ok {
		return msgFlags[Error]
	}
	return msg
}
