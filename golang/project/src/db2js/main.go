// db2js project main.go
package main

import (
	"bytes"
	"compress/gzip"
	"database/sql"
	"encoding/json"
	"flag"
	"fmt"
	"net/http"
	//	_ "net/http/pprof"
	"strconv"
	"strings"

	_ "github.com/go-sql-driver/mysql"
	"github.com/j003918/sql2json"
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

	db.SetMaxOpenConns(100)
	db.SetMaxIdleConns(50)

	err = db.Ping()
	if err != nil {
		panic(err.Error())
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

	db.Close()
}

//http://127.0.0.1/do?cmd=fee&param={"sid":"1","eid":"3"}
func ds(w http.ResponseWriter, r *http.Request) {
	var err error
	var json_buf bytes.Buffer
	var m_param map[string]string

	strRst := ""
	strMsg := ""
	strVal := ""

	r.ParseForm()
	strCmd := r.Form.Get("cmd")
	strParam := r.Form.Get("param")
	strSql := ds_sql[strCmd]

	if strCmd == "" || strSql == "" {
		strRst = "-1"
		strMsg = "cmd error"
		strVal = "null"
		goto WRITE_JSON
	}

	err = json.Unmarshal([]byte(strParam), &m_param)
	if strParam != "" {
		err = json.Unmarshal([]byte(strParam), &m_param)
		if nil != err {
			strRst = "-1"
			strMsg = "param error"
			strVal = "null"
			goto WRITE_JSON
		} else {
			for k, v := range m_param {
				strSql = strings.Replace(strSql, "#"+k+"#", v, -1)
			}
		}
	}

	strVal, err = sql2json.GetJson(db, strSql)
	if nil != err {
		strRst = "-1"
		strMsg = err.Error()
		strVal = "null"
	} else {
		strRst = "0"
		strMsg = "ok"
	}

WRITE_JSON:
	json_buf.WriteString(`{"result":` + strRst + ",")
	json_buf.WriteString(`"msg":"` + strMsg + `",`)
	json_buf.WriteString(`"data":`)
	json_buf.WriteString(strVal)
	json_buf.WriteString("}")

	w.Header().Set("Connection", "close")
	w.Header().Set("Content-Type", "application/json;charset=UTF-8")
	w.Header().Set("Cache-Control", "no-cache")
	w.Header().Set("Pragma", "no")

	if strings.Contains(r.Header.Get("Accept-Encoding"), "gzip") && json_buf.Len() >= 1024 {
		var gzbuf bytes.Buffer
		gz := gzip.NewWriter(&gzbuf)
		defer gz.Close()
		_, err = gz.Write(json_buf.Bytes())
		gz.Flush()
		if err == nil {
			w.Header().Set("Content-Encoding", "gzip")
			w.Header().Set("Content-Length", strconv.Itoa(gzbuf.Len()))
			w.Write(gzbuf.Bytes())
		} else {
			fmt.Println(err.Error())
			w.Write(json_buf.Bytes())
			return
		}
	} else {
		w.Write(json_buf.Bytes())
	}
}
