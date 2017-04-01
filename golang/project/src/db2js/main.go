// db2js project main.go
package main

import (
	"bufio"
	"comm"
	"database/sql"
	"flag"
	"fmt"
	"net/http"
	"os"
	"strconv"
	"strings"
	"time"

	_ "github.com/go-sql-driver/mysql"
)

var db_mysql *sql.DB
var ds_sql map[string]string

func init() {
	var err error
	db_mysql, err = sql.Open("mysql", "root:root@tcp(172.25.125.101:3306)/oa0618?charset=utf8")
	if err != nil {
		panic(err.Error())
	}

	ds_sql = make(map[string]string)
	loadconfig()

	db_mysql.SetMaxOpenConns(200)
	db_mysql.SetMaxIdleConns(100)

	err = db_mysql.Ping()
	if err != nil {
		panic(err.Error())
	}
}

func timer1() {
	timer1 := time.NewTicker(30 * time.Second)
	for {
		select {
		case <-timer1.C:
			loadconfig()
		}
	}
}

func loadconfig() {
	f, err := os.Open("config.txt")
	if err != nil {
		return
	}
	defer f.Close()

	buf := bufio.NewReader(f)
	for {
		line, err := buf.ReadString('\n')
		line = strings.TrimSpace(line)
		kv := strings.Split(line, "^")
		if _, ok := ds_sql[kv[0]]; len(kv) == 2 && false == ok {
			ds_sql[kv[0]] = kv[1]
			fmt.Println("load cmd:", kv[0], "exec_sql:", kv[1])
		}

		if err != nil {
			break
		}
	}
}

func main() {
	tls := flag.Int("tls", 0, "0 disable tls 1 enable tls")
	port := flag.Int("port", 80, "default port http:80 https:443")
	flag.Parse()
	listen_addr := ":"
	if 80 == *port && 1 == *tls {
		listen_addr += "443"
	} else {
		listen_addr += strconv.Itoa(*port)
	}

	defer db_mysql.Close()
	go timer1()

	http.Handle("/", http.FileServer(http.Dir("./html/")))
	http.HandleFunc("/do", ds)

	var err error
	if *tls == 1 {
		err = http.ListenAndServeTLS(listen_addr, "./ca/ca.crt", "./ca/ca.key", nil)
	} else {
		err = http.ListenAndServe(listen_addr, nil)
	}

	if err != nil {
		panic(err.Error())
	}
}

func ds(w http.ResponseWriter, r *http.Request) {
	r.ParseForm()

	strRst := ""
	strMsg := ""
	strVal, err := comm.Sql2Json(db_mysql, ds_sql[r.Form.Get("cmd")])
	if nil != err {
		strRst = "-1"
		strMsg = err.Error()
		strVal = "null"
	} else {
		strRst = "0"
		strMsg = "ok"
	}
	strJson := `{"result":` + strRst + ","
	strJson += `"msg":"` + strMsg + `",`
	strJson += `"data":` + strVal + "}"

	w.Write([]byte(strJson))
}
