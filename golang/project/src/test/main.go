// test project main.go
package main

import (
	"encoding/json"
	//"encoding/json"
	"fmt"

	//"github.com/j003918/datastruct/hashset"
)

func main() {
	aa := ``

	//bb := "dddd"

	type Jitem struct {
		Val string `json:"t"`
	}

	var p *Jitem = &Jitem{
		Val: aa,
	}

	if bs, err := json.Marshal(&p); err != nil {
		panic(err)
	} else {
		//result --> {"username":"brainwu","Age":21,"Gender":true,"Profile":"I am Wujunbin","Count":"0"}
		fmt.Println(string(bs))
		fmt.Println(string(bs[6 : len(bs)-2]))
	}

	//fmt.Println(aa)
}
