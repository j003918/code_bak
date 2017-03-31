// db2js project main.go
package main

import (
	"comm"
	"database/sql"
	"flag"
	"net/http"
	"strconv"

	_ "github.com/go-sql-driver/mysql"
)

var db *sql.DB

func init() {
	var err error
	db, err = sql.Open("mysql", "root:root@tcp(172.25.125.101:3306)/oa0618?charset=utf8")
	if err != nil {
		panic(err.Error())
	}

	db.SetMaxOpenConns(200)
	db.SetMaxIdleConns(100)

	err = db.Ping()
	if err != nil {
		panic(err.Error())
	}
}

func getdept(w http.ResponseWriter, r *http.Request) {
	val, _ := comm.Sql2Json(db, "select * from v_jhf_dept")
	w.Write([]byte(val))
}

func getuser(w http.ResponseWriter, r *http.Request) {
	val, _ := comm.Sql2Json(db, "select a.username,a.userid,a.fullname,a.depid,b.depname from app_user a left join oa0618.department b on a.depid=b.depid")
	w.Write([]byte(val))
}

func getfee(w http.ResponseWriter, r *http.Request) {
	val, _ := comm.Sql2Json(db, "select name,id from reimbursement_fee_type;")
	w.Write([]byte(val))
}

func main() {
	tls := flag.Int("tls", 0, "0 disable tls 1 enable tls")
	port := flag.Int("port", 9653, "default server port 9653")
	flag.Parse()
	listen_addr := ":" + strconv.Itoa(*port)

	defer db.Close()

	http.Handle("/", http.FileServer(http.Dir("./html/")))
	http.HandleFunc("/getdept", getdept)
	http.HandleFunc("/getuser", getuser)
	http.HandleFunc("/getfee", getfee)

	var err error
	if *tls == 1 {
		err = http.ListenAndServeTLS(listen_addr, "./ca/ca.crt", "./ca/ca.key", nil)
	} else {
		err = http.ListenAndServe(listen_addr, nil)
	}

	//err := http.ListenAndServe(":9090", nil)
	if err != nil {
		panic(err.Error())
	}
}
