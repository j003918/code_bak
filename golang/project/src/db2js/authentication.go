// authentication
package main

import (
	"crypto/md5"
	"encoding/hex"
	"strings"
	"time"

	"github.com/j003918/datastruct/safemap"
)

var (
	//seconds
	Check_Interval time.Duration = 3
	//seconds
	KnockTimeOut int64 = 15
)

var signMap *safemap.SafeMap

func init() {
	signMap = safemap.NewSafeMap()
	go func() {
		timer1 := time.NewTicker(Check_Interval * time.Second)
		for {
			select {
			case <-timer1.C:
				knockout()
			}
		}
	}()
}

func loop(val interface{}) bool {
	if time.Now().Unix()-val.(int64) >= KnockTimeOut {
		return true
	}
	return false
}

func knockout() {
	signMap.LoopDel(loop)
}

func genToken(guestIP, user string) (token string, ok bool) {
	strSign := guestIP + user
	if strings.TrimSpace(strSign) == "" {
		return "", false
	}

	byte_md5 := md5.Sum([]byte(strSign))
	return hex.EncodeToString(byte_md5[:]), true
}

func AddAuth(guestIP, user string) bool {
	strSign, ok := genToken(guestIP, user)
	if !ok {
		return false
	}
	signMap.Set(strSign, time.Now().Unix())
	return true
}

func CheckAuth(guestIP, user string) bool {
	strSign, ok := genToken(guestIP, user)
	if !ok {
		return false
	}
	//return signMap.Check(strSign)
	return signMap.CheckWithUpdate(strSign, time.Now().Unix())
}
