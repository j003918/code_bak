// syscfg
package main

import (
	"crypto/md5"
	"database/sql"
	"encoding/hex"
	"fmt"

	_ "github.com/mattn/go-sqlite3"
)

var (
	sysCfgDb              *sql.DB
	sysDbErr              error
	DbName                = "bdgfcsys"
	SysTabCreate_sys_user = `		
		CREATE TABLE IF NOT EXISTS sys_user 
		(
			--id 			INTEGER PRIMARY KEY AUTOINCREMENT,
			user_id		VARCHAR(128) PRIMARY KEY NOT NULL,
			user_pass 	VARCHAR(128) NOT NULL,
			user_sign	VARCHAR(32) DEFAULT NULL,
			trustzone	VARCHAR(256) DEFAULT NULL,
			user_status	INTEGER DEFAULT 1 NOT NULL,
			last_login 	DATETIME DEFAULT NULL,
			create_time DATETIME DEFAULT(DATETIME('now', 'localtime')) NOT NULL
		);`
	sysTab_sys_user_list    = `select * from sys_user`
	sysTab_sys_user_add     = `insert into sys_user(user_id,user_pass) values(?,?)`
	sysTab_sys_user_Login   = `update sys_user set last_login=DATETIME('now', 'localtime') where user_id=? and user_pass=?`
	sysTab_sys_user_SetPass = `update sys_user set user_pass=? where user_id=? and user_pass=?`

	SysTabCreate_sys_cfg = `		
		CREATE TABLE IF NOT EXISTS sys_method 
		(
			--id 			INTEGER PRIMARY KEY AUTOINCREMENT,
			method_name		VARCHAR(128) PRIMARY KEY NOT NULL,
			method_content 	VARCHAR(128) NOT NULL,
			dbdriver		VARCHAR(32) DEFAULT NULL,
			update_time 	DATETIME DEFAULT NULL,
			create_time 	DATETIME DEFAULT(DATETIME('now', 'localtime')) NOT NULL
		);`
	sysTab_sys_method_list         = `select method_name,method_content,dbdriver from sys_method`
	sysTab_sys_method_add          = `insert into sys_method(method_name,method_content,dbdriver) values(?,?,?)`
	sysTab_sys_method_Content_Set  = `update sys_method set method_content=? where method_name=?`
	sysTab_sys_method_Dbdriver_set = `update sys_method set dbdriver=? where method_name=?`
)

func init() {

	sysCfgDb = OpenDb("sqlite3", DbName)
	if sysCfgDb == nil {
		panic("open db error")
	}

	ModifyTab(sysCfgDb, SysTabCreate_sys_user)

	AddUser("jhf", "123")
	AddUser("tf", "tfpass")
	PrinTab(sysCfgDb, sysTab_sys_user_list)

	ChangeUserPass("jhf", "123", "3456")
	PrinTab(sysCfgDb, sysTab_sys_user_list)
}

func str2md5(str string) string {
	sum := md5.Sum([]byte(str))
	return hex.EncodeToString(sum[:])
}

func chekError(err error, output bool) bool {
	if err != nil {
		if output {
			fmt.Println(err.Error())
		}
		return true
	}
	return false
}

func OpenDb(driver, dsn string) *sql.DB {
	mydb, err := sql.Open(driver, dsn)
	if chekError(err, true) {
		return nil
	}

	return mydb
}

func PrinTab(mydb *sql.DB, strsql string, args ...interface{}) {
	stmt, err := mydb.Prepare(strsql)
	if chekError(err, true) {
		return
	}
	defer stmt.Close()

	rows, err := stmt.Query(args...)
	if chekError(err, true) {
		return
	}

	columns, err := rows.Columns()
	if chekError(err, true) {
		return
	}
	defer rows.Close()

	//fix bug time.Time nil
	//values := make([]sql.RawBytes, len(columns))
	values := make([]sql.NullString, len(columns))
	scans := make([]interface{}, len(columns))

	for i := range values {
		scans[i] = &values[i]
	}

	for rows.Next() {
		err = rows.Scan(scans...)
		if chekError(err, true) {
			return
		}

		strVal := ""
		for _, col := range values {
			if !col.Valid {
				strVal = "NULL"
			} else {
				strVal = col.String
			}
			fmt.Printf(strVal, " ")
		}
		fmt.Println()
	}
}

//for insert update delete use
func ModifyTab(mydb *sql.DB, strsql string, args ...interface{}) (RowsAffected int64, ok bool) {
	stmt, err := mydb.Prepare(strsql)
	if chekError(err, true) {
		return -1, false
	}
	defer stmt.Close()

	rst, err := stmt.Exec(args...)
	if chekError(err, true) {
		return -1, false
	}

	count, err := rst.RowsAffected()
	if chekError(err, true) {
		return -1, false
	}

	return count, true
}

func AddUser(id, pass string) bool {
	_, ok := ModifyTab(sysCfgDb, sysTab_sys_user_add, id, str2md5(id+pass))
	return ok
}

func CheckUser(id, pass string) bool {
	count, ok := ModifyTab(sysCfgDb, sysTab_sys_user_Login, id, str2md5(id+pass))
	return ok && count == 1
}

func ChangeUserPass(id, pass, newPass string) bool {
	count, ok := ModifyTab(sysCfgDb, sysTab_sys_user_SetPass, str2md5(id+newPass), id, str2md5(id+pass))
	return ok && count == 1
}
