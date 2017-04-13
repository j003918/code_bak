// config
package main

import (
	"bufio"
	"fmt"
	"io"
	//	"log"
	"os"
	"strings"
	"time"
	//	_ "github.com/mattn/go-sqlite3"
)

const CFG_FILE_REFRESH = 30

var CFG_FILE_NAME string = "config.txt"
var CFG_DB string = "bd.gfc"
var (
	str_t_syscfg_db_type = `		
		CREATE TABLE IF NOT EXISTS syscfg_db_type 
		(
			type_id integer PRIMARY KEY autoincrement,
			type_name varchar(50),
			drive_name varchar(50),
			status integer default 0,
			create_time datetime default(datetime('now', 'localtime'))
		);`
	str_t_syscfg_db_info = `		
		CREATE TABLE IF NOT EXISTS syscfg_db_info 
		(
			id integer PRIMARY KEY autoincrement,
			db_type integer,
			db_port integer,
			db_host varchar(256),
			db_name varchar(128),
			db_user varchar(128),
			db_pass varchar(128),
			charset varchar(64),
			create_time datetime default (datetime('now', 'localtime'))
			);`
	str_t_call_method = `		
		CREATE TABLE IF NOT EXISTS call_method
		(
			id integer PRIMARY KEY autoincrement,
			method_name varchar(64),
			method_content text,
			create_time datetime default (datetime('now', 'localtime'))
		);`
)

func ReloadConfig(sec time.Duration) {
	timer1 := time.NewTicker(sec * time.Second)
	for {
		select {
		case <-timer1.C:
			update_config()
		}
	}
}

/*
func test_sqlite() {
	//os.Remove(CFG_DB)

	db, err := sql.Open("sqlite3", CFG_DB)
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	_, err = db.Exec(str_t_syscfg_db_type)
	_, err = db.Exec(str_t_syscfg_db_info)
	_, err = db.Exec(str_t_call_method)
	if err != nil {
		log.Printf("%s", err.Error())
		return
	}
	/*
		stmt, err := db.Prepare("insert into syscfg_db_type(type_name, drive_name) values(?, ?)")
		if err != nil {
			fmt.Println(err.Error())
			return
		}
		defer stmt.Close()

		if result, err := stmt.Exec("mysql", "mysql"); err == nil {
			if id, err := result.LastInsertId(); err == nil {
				fmt.Println("insert id : ", id)
			}
		}
		if result, err := stmt.Exec("sqlite", "sqlite3"); err == nil {
			if id, err := result.LastInsertId(); err == nil {
				fmt.Println("insert id : ", id)
			}
		}
*/
/*
	rows, err := db.Query("select type_id, type_name,drive_name,status,create_time from syscfg_db_type")
	if err != nil {
		log.Fatal(err)
	}
	defer rows.Close()
	for rows.Next() {
		var type_id, status int
		var type_name, drive_name, create_time string
		err = rows.Scan(&type_id, &type_name, &drive_name, &status, &create_time)
		if err != nil {
			log.Fatal(err)
		}
		fmt.Println(type_id, type_name, drive_name, status, create_time)
	}
}
*/
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
				if _, ok := methodSql[strCmd]; !ok {
					methodSql[strCmd] = strings.TrimSpace(strTmp)
					fmt.Println("load method:", strCmd)
				}
				//ds_sql[strCmd] = strTmp
				strTmp = ""
			default:
				strTmp += string(v)
			}
		}

		if err != nil {
			if err != io.EOF {
				fmt.Println(err.Error())
			}
			break
		}
	}
}
