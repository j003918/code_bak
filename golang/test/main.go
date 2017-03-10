// test project main.go
package main

import (
	"comm"
	"fmt"
)

func main() {
	str_exp := "a+b"
	fmt.Println(comm.Get_RPN(str_exp, ""))
}
