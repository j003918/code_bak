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
			user_status	INTEGER DEFAULT 0 NOT NULL,
			last_login 	DATETIME DEFAULT NULL,
			create_time DATETIME DEFAULT(DATETIME('now', 'localtime')) NOT NULL
		);`
	sysTab_sys_user_list    = `select * from sys_user`
	sysTab_sys_user_add     = `insert into sys_user(user_id,user_pass) values(?,?)`
	sysTab_sys_user_Login   = `update sys_user set last_login=DATETIME('now', 'localtime') where user_id=? and user_pass=?`
	sysTab_sys_user_SetPass = `update sys_user set user_pass=? where user_id=? and user_pass=?`
)

func init() {
	sysCfgDb, sysDbErr = sql.Open("sqlite3", DbName)
	if sysDbErr != nil {
		panic(sysDbErr)
	}
	_, sysDbErr := sysCfgDb.Exec(SysTabCreate_sys_user)
	if nil != sysDbErr {
		fmt.Println(sysDbErr.Error())
	}

	AddUser("jhf", "123")
	AddUser("tf", "tfpass")
	listuser()

	ChangeUserPass("jhf", "123", "3456")
	listuser()

}

func str2md5(str string) string {
	sum := md5.Sum([]byte(str))
	return hex.EncodeToString(sum[:])
}

func AddUser(id, pass string) bool {
	stmt, err := sysCfgDb.Prepare(sysTab_sys_user_add)
	if nil != err {
		fmt.Println(err.Error())
		return false
	}
	defer stmt.Close()

	_, err = stmt.Exec(id, str2md5(id+pass))
	if nil != err {
		return true
	}
	return false
}

func CheckUser(id, pass string) bool {
	stmt, err := sysCfgDb.Prepare(sysTab_sys_user_Login)
	if nil != err {
		fmt.Println(err.Error())
		return false
	}
	defer stmt.Close()

	rst, err := stmt.Exec(id, str2md5(id+pass))
	count, _ := rst.RowsAffected()
	if 1 == count {
		return true
	}

	return false
}

func ChangeUserPass(id, pass, newPass string) bool {
	stmt, err := sysCfgDb.Prepare(sysTab_sys_user_SetPass)
	if nil != err {
		fmt.Println(err.Error())
		return false
	}
	defer stmt.Close()

	rst, err := stmt.Exec(str2md5(id+newPass), id, str2md5(id+pass))
	if nil != err {
		fmt.Println(err.Error())
		return false
	}
	count, err := rst.RowsAffected()

	if nil != err {
		fmt.Println(err.Error())
		return false
	}

	if 1 == count {
		fmt.Println("change pass ok")
		return true
	}

	return false
}

func listuser() {
	rows, err := sysCfgDb.Query(sysTab_sys_user_list)
	if err != nil {
		return
	}
	defer rows.Close()

	columns, err := rows.Columns()

	if err != nil {
		return
	}

	//fix bug time.Time nil
	//values := make([]sql.RawBytes, len(columns))
	values := make([]sql.NullString, len(columns))
	scans := make([]interface{}, len(columns))

	for i := range values {
		scans[i] = &values[i]
	}

	for rows.Next() {
		err = rows.Scan(scans...)
		if err != nil {
			panic(err.Error())
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
