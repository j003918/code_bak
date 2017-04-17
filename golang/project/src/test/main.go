// test project main.go
package main

import (
	"fmt"

	"github.com/j003918/datastruct/hashset"
)

func main() {
	//hashset.
	aa := hashset.New()

	aa.Set(1)
	aa.Set("2")

	if aa.Contains(1) {
		fmt.Println("1 ok")
	}

	aa.Del(1)

	if !aa.Contains(1) {
		fmt.Println("1 err")
	}

}
