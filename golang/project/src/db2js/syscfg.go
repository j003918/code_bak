// syscfg
package main

import (
	"crypto/md5"
	"database/sql"
	"encoding/hex"
	"fmt"
	"time"

	"github.com/j003918/datastruct/safemap"
)

var (
	sysconfigDbName = "bdgfcsys"
	MapDbDriver     *safemap.SafeMap
	MapMethod       *safemap.SafeMap

	SysTabCreate_sys_user = `		
		CREATE TABLE IF NOT EXISTS [sys_user] 
		(
    		[id]			NVARCHAR2(128) PRIMARY KEY NOT NULL, 
    		[pass]			NVARCHAR2(128) NOT NULL, 
			[sign]			VARCHAR2(32) NOT NULL DEFAULT "*", 
    		[trustzone] 	VARCHAR2(1024) NOT NULL DEFAULT "*", 
    		[status]		INTEGER NOT NULL DEFAULT 0, 
    		[login_time]	DATETIME NOT NULL DEFAULT (DATETIME ('now', 'localtime')), 
    		[create_time]	DATETIME NOT NULL DEFAULT (DATETIME ('now', 'localtime'))
		);`

	SysTabCreate_sys_dsn = `		
		CREATE TABLE IF NOT EXISTS [sys_dsn] 
		(
			[id]		INTEGER PRIMARY KEY AUTOINCREMENT,
    		[driver]	CHAR(64) NOT NULL, 
    		[dsn] 		NVARCHAR2(256) NOT NULL,
			[status] 	INTEGER NOT NULL DEFAULT 0,
			[info]		NVARCHAR2(64)
		);`

	SysTabCreate_sys_method = `		
		CREATE TABLE IF NOT EXISTS [sys_method] 
		(
			[method]		VARCHAR2(128) PRIMARY KEY NOT NULL, 
    		[content]		NVARCHAR2(1024) NOT NULL, 
    		[dsn_id]		INTEGER NOT NULL, 
    		[update_time]	DATETIME NOT NULL DEFAULT (DATETIME ('now', 'localtime')), 
    		[create_time]	DATETIME NOT NULL DEFAULT (DATETIME ('now', 'localtime'))
		);`

	sysTab_sys_user_queryAll       = `select * from sys_user`
	sysTab_sys_user_add            = `insert into sys_user(id,pass) values(?,?)`
	sysTab_sys_user_set_login_time = `update sys_user set login_time=DATETIME('now', 'localtime') where user_id=? and user_pass=?`
	sysTab_sys_user_set_pass       = `update sys_user set pass=? where id=? and pass=?`

	sysTab_sys_dsn_queryAll   = `select * from sys_dsn`
	sysTab_sys_dsn_add        = `insert into sys_dsn(driver,dsn,info) values(?,?,?)`
	sysTab_sys_dsn_set_driver = `update sys_dsn set driver=? where id=?`
	sysTab_sys_dsn_set_dsn    = `update sys_dsn set dsn=? where id=?`

	sysTab_sys_method_queryAll   = `select method,content,dsn_id from sys_method`
	sysTab_sys_method_add        = `insert into sys_method(method,content,dsn_id) values(?,?,?)`
	sysTab_sys_method_setMethod  = `update sys_method set method=? where method=?`
	sysTab_sys_method_setContent = `update sys_method set content=? where method=?`
	sysTab_sys_method_set_dsn_id = `update sys_method set dsn_id=? where method=?`
)

type MethdContent struct {
	Method  string
	Content string
	Mthdb   *sql.DB
}

func init() {
	mydb, err := OpenDb("sqlite3", sysconfigDbName)
	if err != nil {
		panic(err)
	}

	MapDbDriver = safemap.NewSafeMap()
	MapMethod = safemap.NewSafeMap()
	MapDbDriver.Set(1, mydb)

	//initSysDB(mydb)

	go reloadDriver(30)
	go reloadMethod(15)
}

func loopMethod(v interface{}) bool {
	return true
}

func loopDb(v interface{}) bool {
	//mydb := v.(*MethdContent).Mthdb
	//mydb.Close()
	return true
}

func CloseAll() {
	MapMethod.LoopDel(loopMethod)
	MapDbDriver.LoopDel(loopDb)
}

func reloadDriver(sec time.Duration) {
	setupDriver()
	timerDriver := time.NewTicker(sec * time.Second)
	for {
		select {
		case <-timerDriver.C:
			setupDriver()
		}
	}
}

func reloadMethod(sec time.Duration) {
	setupMethod()
	timerMethod := time.NewTicker(sec * time.Second)
	for {
		select {
		case <-timerMethod.C:
			setupMethod()
		}
	}
}

func setupDriver() {
	if !MapDbDriver.Check(1) {
		return
	}

	rows, err := MapDbDriver.Get(1).(*sql.DB).Query(`select id,driver,dsn from sys_dsn where status=0 and driver <> 'sqlite3'`)
	if err != nil {
		return
	}
	defer rows.Close()

	id, driver, dsn := -1, "", ""

	for rows.Next() {
		id, driver, dsn = -1, "", ""
		err = rows.Scan(&id, &driver, &dsn)
		if err != nil {
			fmt.Println("setupDriver error:", err.Error())
			return
		}

		if !MapDbDriver.Check(id) {
			newdb, err := OpenDb(driver, dsn)
			if err == nil {
				MapDbDriver.Set(id, newdb)
				//fmt.Println("load db driver ", id, driver, dsn)
			}
		}
	}
}

func setupMethod() {
	if !MapDbDriver.Check(1) {
		return
	}

	rows, err := MapDbDriver.Get(1).(*sql.DB).Query(sysTab_sys_method_queryAll)
	if err != nil {
		fmt.Println(err.Error())
		return
	}
	defer rows.Close()

	dsn_id, method, content := -1, "", ""
	for rows.Next() {
		dsn_id, method, content = -1, "", ""
		err = rows.Scan(&method, &content, &dsn_id)
		if err != nil {
			fmt.Println("setupMethod error:", err.Error())
			return
		}

		if !MapDbDriver.Check(dsn_id) {
			continue
		}

		if !MapMethod.Check(method) {
			mc := new(MethdContent)
			mc.Method = method
			mc.Content = content
			mc.Mthdb = MapDbDriver.Get(dsn_id).(*sql.DB)
			MapMethod.Set(method, mc)
			fmt.Println("load method ", method)
		}
	}
}

func initSysDB(mydb *sql.DB) {
	ModifyTab(mydb, SysTabCreate_sys_user)
	ModifyTab(mydb, SysTabCreate_sys_dsn)
	ModifyTab(mydb, SysTabCreate_sys_method)

	ModifyTab(mydb, sysTab_sys_user_add, "admin", str2md5("admin"+"czzyy_123"))

	ModifyTab(mydb, sysTab_sys_dsn_add, "sqlite3", sysconfigDbName, "sysconfig db")
	ModifyTab(mydb, sysTab_sys_dsn_add, "oci8", `system/manager@his`, "his")
	ModifyTab(mydb, sysTab_sys_dsn_add, "mysql", `root:root@tcp(172.25.125.101:3306)/oa0618?charset=utf8`, "oa")
	ModifyTab(mydb, sysTab_sys_dsn_add, "mysql", `root:root@tcp(130.1.10.230:3306)/zyyoutdoor?charset=utf8`, "zyyoutdoor")

	ModifyTab(mydb, sysTab_sys_method_add, "sysuser", `select * from sys_user`, 1)
	ModifyTab(mydb, sysTab_sys_method_add, "hisalluser", `select * from staff_dict`, 2)
	ModifyTab(mydb, sysTab_sys_method_add, "hisuser", `select * from staff_dict where user_name='#un#'`, 2)
}

func str2md5(str string) string {
	sum := md5.Sum([]byte(str))
	return hex.EncodeToString(sum[:])
}

//SCUAdd table sys_user add new user
func SCUAdd(mydb *sql.DB, id, pass string) bool {
	_, ok := ModifyTab(mydb, sysTab_sys_user_add, id, str2md5(id+pass))
	return ok
}

//SCUCheck table sys_user user login chek
func SCUCheck(mydb *sql.DB, id, pass string) bool {
	count, ok := ModifyTab(mydb, sysTab_sys_user_set_login_time, id, str2md5(id+pass))
	return ok && count == 1
}

//SCUChangePass table sys_user change password
func SCUChangePass(mydb *sql.DB, id, pass, newPass string) bool {
	count, ok := ModifyTab(mydb, sysTab_sys_user_set_pass, str2md5(id+newPass), id, str2md5(id+pass))
	return ok && count == 1
}

//SCDAdd table sys_dsn add new dsn
func SCDAdd(mydb *sql.DB, driver, dsn, info string) bool {
	count, ok := ModifyTab(mydb, sysTab_sys_dsn_add, driver, dsn, info)
	return ok && count == 1
}

//SCDAdd table sys_dsn set driver
func SCDSetDriver(mydb *sql.DB, driver, id string) bool {
	count, ok := ModifyTab(mydb, sysTab_sys_dsn_set_driver, driver, id)
	return ok && count == 1
}

//SCDAdd table sys_dsn set dsn
func SCDSetDSN(mydb *sql.DB, dsn, id string) bool {
	count, ok := ModifyTab(mydb, sysTab_sys_dsn_set_dsn, id)
	return ok && count == 1
}
