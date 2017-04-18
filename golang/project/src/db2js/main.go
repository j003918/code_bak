// db2js project main.go
package main

import (
	"bytes"
	"compress/gzip"
	"database/sql"
	"flag"
	"fmt"
	"net/http"
	"os"
	"strconv"
	"strings"

	"github.com/j003918/sql2json"

	_ "github.com/go-sql-driver/mysql"
	_ "github.com/mattn/go-oci8"
)

var (
	db        *sql.DB
	methodSql map[string]string
	cmdArgs   map[string]string
)

func init() {
	methodSql = make(map[string]string)
	cmdArgs = make(map[string]string)

	tls := flag.Int("tls", 0, "0:disable 1:enable")
	port := flag.Int("port", 80, "http:80 https:443")
	str_DBDriver := flag.String("dbdriver", "mysql", "mysql:oci8")
	str_DBHost := flag.String("dbhost", "130.1.10.230", "")
	str_DBPort := flag.String("dbport", "3306", "")
	str_DBUser := flag.String("dbuser", "root", "")
	str_DBPass := flag.String("dbpass", "root", "")
	str_DBName := flag.String("dbname", "mysql", "")
	str_DBCharset := flag.String("dbcharset", "utf8", "")
	flag.Parse()

	cmdArgs["tls"] = strconv.Itoa(*tls)
	cmdArgs["port"] = strconv.Itoa(*port)
	cmdArgs["dbdriver"] = *str_DBDriver
	cmdArgs["dbhost"] = *str_DBHost
	cmdArgs["dbport"] = *str_DBPort
	cmdArgs["dbuser"] = *str_DBUser
	cmdArgs["dbpass"] = *str_DBPass
	cmdArgs["dbname"] = *str_DBName
	cmdArgs["dbcharset"] = *str_DBCharset

	update_config()
	initDB()
}

/* liteide *.env add ENV support oci8
MINGW64=D:/mingw-w64/mingw64
instantclient=D:/instantclient_12_2
PKG_CONFIG_PATH=%instantclient%/pkg-config
TNS_ADMIN=%instantclient%/network/admin
PATH=%PATH%;%MINGW64%/bin;%GOROOT%/bin;%instantclient%;%instantclient%/pkg-config
*/
func initDB() {
	var err error

	strDSN := ""
	switch cmdArgs["dbdriver"] {
	case "mysql":
		strDSN += cmdArgs["dbuser"] + ":" + cmdArgs["dbpass"] //*str_DBPass
		strDSN += "@tcp(" + cmdArgs["dbhost"] + ":" + cmdArgs["dbport"] + ")/"
		strDSN += cmdArgs["dbname"] + "?charset=" + cmdArgs["dbcharset"]
	case "oci8":
		os.Setenv("NLS_LANG", "AMERICAN_AMERICA.AL32UTF8")
		strDSN += cmdArgs["dbuser"] + "/" + cmdArgs["dbpass"] + "@" + cmdArgs["dbname"]
	default:
	}

	db, err = sql.Open(cmdArgs["dbdriver"], strDSN)
	if err != nil {
		panic(err.Error())
	}

	db.SetMaxOpenConns(100)
	db.SetMaxIdleConns(50)

	err = db.Ping()
	if err != nil {
		panic(err.Error())
	}
}

func main() {
	listen_addr := ":"
	if "80" == cmdArgs["port"] && "1" == cmdArgs["tls"] {
		listen_addr += "443"
	} else {
		listen_addr += cmdArgs["port"]
	}

	defer db.Close()
	go ReloadConfig(30)

	http.Handle("/", http.FileServer(http.Dir("./html/")))
	http.HandleFunc("/do", ds)
	http.HandleFunc("/m/list", methodList)
	http.HandleFunc("/m/del", methodDel)

	if "1" == cmdArgs["tls"] {
		panic(http.ListenAndServeTLS(listen_addr, "./ca/ca.crt", "./ca/ca.key", nil))
	} else {
		panic(http.ListenAndServe(listen_addr, nil))
	}
}

func methodDel(w http.ResponseWriter, r *http.Request) {
	r.ParseForm()
	delete(methodSql, r.Form.Get("m"))
}

func methodList(w http.ResponseWriter, r *http.Request) {
	strTmp := ""
	for k, v := range methodSql {
		strTmp += k + "{" + string('\n') + v + string('\n') + "}" + strings.Repeat(string('\n'), 2)
	}
	w.Write([]byte(strTmp))
}

//http://127.0.0.1/do?cmd=fee&param=w
func ds(w http.ResponseWriter, r *http.Request) {
	r.ParseForm()
	strCmd := r.Form.Get("cmd")
	strSql := methodSql[strCmd]
	for k, _ := range r.Form {
		strSql = strings.Replace(strSql, "#"+k+"#", r.Form.Get(k), -1)
	}

	strRst := "-1"
	strMsg := "error"
	strVal := ""
	var err error
	var bufdata bytes.Buffer

	if strCmd == "" || strSql == "" || strings.ContainsAny(strSql, "#") {
		strRst = "-1"
		strMsg = "cmd or param error"
		strVal = "null"
	} else {
		err = sql2json.GetJson(db, strSql, &bufdata)
		if nil != err {
			strRst = "-1"
			strMsg = err.Error()
			strVal = "null"
		} else {
			strRst = "0"
			strMsg = "ok"
		}
	}

	var json_buf bytes.Buffer
	json_buf.WriteString(`{"result":` + strRst + ",")
	json_buf.WriteString(`"msg":"` + strMsg + `",`)
	json_buf.WriteString(`"data":`)
	if "" == strVal {
		json_buf.Write(bufdata.Bytes())
	} else {
		json_buf.WriteString(strVal)
	}
	json_buf.WriteString("}")

	w.Header().Set("Connection", "close")
	w.Header().Set("CharacterEncoding", "utf-8")
	w.Header().Set("Content-Type", "application/json; charset=utf-8")
	w.Header().Set("Pragma", "no-cache")
	w.Header().Set("Cache-Control", "no-cache, no-store, max-age=0")
	w.Header().Set("Expires", "1L")

	if strings.Contains(r.Header.Get("Accept-Encoding"), "gzip") && json_buf.Len() >= 1024 {
		var gzbuf bytes.Buffer
		gz := gzip.NewWriter(&gzbuf)
		_, err = gz.Write(json_buf.Bytes())
		gz.Close()
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
