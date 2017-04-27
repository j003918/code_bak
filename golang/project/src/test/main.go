package main

import (
	"fmt"
	"time"
	//	"fmt"
	//"strconv"
	//"crypto/md5"
	//"encoding/hex"
	//"time"
	"github.com/j003918/datastruct/safemap"
)

func delKey(val interface{}) bool {
	if val.(int) > 5 {
		return true
	}
	return false
}

func main() {
	aa := safemap.NewSafeMap()
	for i := 0; i < 10; i++ {
		aa.Set(i, i)
	}
	aa.Println()
	aa.RangeDel(delKey)
	aa.Println()

	st := time.Now().Unix()
	time.Sleep(3 * time.Second)
	et := time.Now().Unix()

	fmt.Println(st, et, (et - st))

}
