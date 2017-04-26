// db2js project main.go
package main

import (
	"bytes"
	"compress/gzip"
	"context"
	"database/sql"
	"flag"
	"fmt"
	"net/http"
	"os"
	"os/signal"
	"strconv"
	"strings"
	"sync"
	"syscall"
	"time"

	"github.com/j003918/sql2json"

	_ "github.com/go-sql-driver/mysql"
	_ "github.com/mattn/go-oci8"
	_ "github.com/mattn/go-sqlite3"
)

var (
	db         *sql.DB
	methodSql  map[string]string
	cmdArgs    map[string]string
	curReqNum  = 0
	curReqLock sync.Mutex
)

func init() {
	methodSql = make(map[string]string)
	cmdArgs = make(map[string]string)

	tls := flag.Int("tls", 0, "0:disable 1:enable")
	port := flag.Int("port", 80, "http:80 https:443")
	strConf := flag.String("conf", "config.txt", "")
	strDBDriver := flag.String("dbdriver", "mysql", "mysql:oci8")
	strDBHost := flag.String("dbhost", "127.0.0.1", "")
	strDBPort := flag.String("dbport", "3306", "")
	strDBUser := flag.String("dbuser", "root", "")
	strDBPass := flag.String("dbpass", "root", "")
	strDBName := flag.String("dbname", "mysql", "")
	strDBCharset := flag.String("dbcharset", "utf8", "")
	flag.Parse()

	cmdArgs["tls"] = strconv.Itoa(*tls)
	cmdArgs["port"] = strconv.Itoa(*port)
	cmdArgs["conf"] = *strConf
	cmdArgs["dbdriver"] = *strDBDriver
	cmdArgs["dbhost"] = *strDBHost
	cmdArgs["dbport"] = *strDBPort
	cmdArgs["dbuser"] = *strDBUser
	cmdArgs["dbpass"] = *strDBPass
	cmdArgs["dbname"] = *strDBName
	cmdArgs["dbcharset"] = *strDBCharset

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
	case "sqlite3":
		strDSN += cmdArgs["dbname"]
	default:
	}

	db, err = sql.Open(cmdArgs["dbdriver"], strDSN)
	if err != nil {
		panic(err.Error())
	}

	db.SetMaxOpenConns(80)
	db.SetMaxIdleConns(20)

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

	http.HandleFunc("/get", worker)

	http.HandleFunc("/info/service", listMethod)
	http.HandleFunc("/info/online", activeGuest)

	http.HandleFunc("/cfg", setConfig)
	http.HandleFunc("/m/del", delMethod)

	s := &http.Server{
		Addr:           listen_addr,
		Handler:        http.DefaultServeMux,
		ReadTimeout:    10 * time.Second,
		WriteTimeout:   10 * time.Second,
		MaxHeaderBytes: 1 << 20,
	}

	go func() {
		if "1" == cmdArgs["tls"] {
			fmt.Println(s.ListenAndServeTLS("./ca/ca.crt", "./ca/ca.key"))
		} else {
			fmt.Println(s.ListenAndServe())
		}

		fmt.Println("server shutdown")

	}()

	ch := make(chan os.Signal)
	signal.Notify(ch, syscall.SIGINT, syscall.SIGTERM)
	_ = <-ch

	fmt.Println("server shutting down......")
	//Wait gorotine print shutdown message
	ctx, _ := context.WithTimeout(context.Background(), 30*time.Second)
	s.Shutdown(ctx)
	if nil != ctx.Err() {
		fmt.Println(ctx.Err().Error())
	}
}

func setConfig(w http.ResponseWriter, r *http.Request) {
	r.ParseForm()
	cfgKey := r.Form.Get("k")
	cfgVal := r.Form.Get("v")
	if _, ok := cmdArgs[cfgKey]; ok {
		cmdArgs[cfgKey] = cfgVal
	}
}

func delMethod(w http.ResponseWriter, r *http.Request) {
	r.ParseForm()
	delete(methodSql, r.Form.Get("m"))
}

func listMethod(w http.ResponseWriter, r *http.Request) {
	strTmp := ""
	for k, v := range methodSql {
		strTmp += k + "{" + string('\n') + v + string('\n') + "}" + strings.Repeat(string('\n'), 2)
	}
	w.Write([]byte(strTmp))
}

func activeGuest(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte(strconv.Itoa(curReqNum)))
}

func incGuest() {
	curReqLock.Lock()
	curReqNum++
	curReqLock.Unlock()
}

func decGuest() {
	curReqLock.Lock()
	curReqNum--
	curReqLock.Unlock()
}

//http://127.0.0.1/get?m=fee&param=w
func worker(w http.ResponseWriter, r *http.Request) {
	incGuest()
	defer decGuest()
	timeout := 30 * time.Second
	r.ParseForm()
	strCmd := r.Form.Get("m")
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
		ctx, _ := context.WithTimeout(context.Background(), timeout)
		err = sql2json.GetJson(ctx, db, strSql, &bufdata)
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
