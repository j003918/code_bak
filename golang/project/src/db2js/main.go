// db2js project main.go
package main

import (
	"bytes"
	"comm"
	"database/sql"
	"encoding/json"
	"flag"
	"net/http"
	"strconv"
	"strings"
	"time"

	_ "github.com/go-sql-driver/mysql"
)

var db *sql.DB
var ds_sql map[string]string

func iner_init(strconn string) {
	var err error
	db, err = sql.Open("mysql", strconn)
	if err != nil {
		panic(err.Error())
	}

	ds_sql = make(map[string]string)
	update_config()

	db.SetMaxOpenConns(200)
	db.SetMaxIdleConns(100)

	err = db.Ping()
	if err != nil {
		panic(err.Error())
	}
}

func timer1() {
	timer1 := time.NewTicker(60 * time.Second)
	for {
		select {
		case <-timer1.C:
			update_config()
		}
	}
}

func main() {
	tls := flag.Int("tls", 0, "0:disable 1:enable")
	port := flag.Int("port", 80, "http:80 https:443")
	str_DBHost := flag.String("dbhost", "127.0.0.1", "")
	str_DBPort := flag.String("dbport", "3306", "")
	str_DBUser := flag.String("dbuser", "root", "")
	str_DBPass := flag.String("dbpass", "root", "")
	str_DBName := flag.String("dbname", "mysql", "")
	str_DBCharset := flag.String("dbcharset", "utf8", "")
	flag.Parse()

	str_conn := *str_DBUser + ":" + *str_DBPass
	str_conn += "@tcp(" + *str_DBHost + ":" + *str_DBPort + ")/"
	str_conn += *str_DBName + "?charset=" + *str_DBCharset

	iner_init(str_conn)

	listen_addr := ":"
	if 80 == *port && 1 == *tls {
		listen_addr += "443"
	} else {
		listen_addr += strconv.Itoa(*port)
	}

	defer db.Close()
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

//http://127.0.0.1/do?cmd=method&param={%22sid%22:%221%22,%22eid%22:%223%22}
func ds(w http.ResponseWriter, r *http.Request) {
	r.ParseForm()
	strCmd := r.Form.Get("cmd")
	strParam := r.Form.Get("param")

	strRst := ""
	strMsg := ""
	strVal := ""
	var err error
	var json_buf bytes.Buffer
	strSql := ds_sql[strCmd]

	var m_param map[string]string
	if err = json.Unmarshal([]byte(strParam), &m_param); err == nil {
		for k, v := range m_param {
			strSql = strings.Replace(strSql, "#"+k+"#", v, -1)
		}

		strVal, err = comm.Sql2Json(db, strSql)
		if nil != err {
			strRst = "-1"
			strMsg = err.Error()
			strVal = "null"
		} else {
			strRst = "0"
			strMsg = "ok"
		}
	} else {
		strRst = "-1"
		strMsg = "param error"
	}

	json_buf.WriteString(`{"result":` + strRst + ",")
	json_buf.WriteString(`"msg":"` + strMsg + `",`)
	json_buf.WriteString(`"data":` + strVal + "}")

	json_buf.Reset()

	w.Write(json_buf.Bytes())
}
