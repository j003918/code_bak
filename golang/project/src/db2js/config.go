// config
package main

import (
	"bufio"
	"fmt"
	"io"
	"os"
	"strings"
	"time"
)

const CFG_FILE_REFRESH = 30

var CFG_FILE_NAME string = "config.txt"

func timer1() {
	timer1 := time.NewTicker(CFG_FILE_REFRESH * time.Second)
	for {
		select {
		case <-timer1.C:
			update_config()
		}
	}
}

func update_config() {
	f, err := os.Open(CFG_FILE_NAME)
	if err != nil {
		return
	}
	defer f.Close()

	strTmp := ""
	strCmd := ""
	buf := bufio.NewReader(f)
	for {
		line, err := buf.ReadString('\n')
		if strings.TrimSpace(line) != "" && string(line[0]) == "#" {
			continue
		}

		for _, v := range line {
			switch v {
			case rune('{'):
				strCmd = strings.TrimSpace(strTmp)
				strTmp = ""
			case rune('}'):
				if _, ok := ds_sql[strCmd]; false == ok {
					ds_sql[strCmd] = strings.TrimSpace(strTmp)
					fmt.Println("load method:", strCmd)
				}
				ds_sql[strCmd] = strTmp
				strTmp = ""
			default:
				strTmp += string(v)
			}
		}

		if err != nil {
			break
			if err != io.EOF {
				fmt.Println(err.Error())
			}
		}
	}
}
