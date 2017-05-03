// tinydb
package main

import (
	"database/sql"
	"fmt"

	_ "github.com/go-sql-driver/mysql"
	_ "github.com/mattn/go-oci8"
	_ "github.com/mattn/go-sqlite3"
)

func chekError(err error, output bool) bool {
	if err != nil {
		if output {
			fmt.Println(err.Error())
		}
		return true
	}
	return false
}

func OpenDb(driver, dsn string, maxOpen, maxIdle int) (*sql.DB, error) {
	//mydb, err := sql.Open(driver, dsn)

	mydb, err := sql.Open(driver, dsn)
	if err != nil {
		fmt.Println(err.Error())
		return nil, err
	}

	mydb.SetMaxOpenConns(maxOpen)
	mydb.SetMaxIdleConns(maxIdle)

	err = mydb.Ping()
	if err != nil {
		fmt.Println(err.Error())
		return nil, err
	}

	return mydb, err
}

func GetTabRows(mydb *sql.DB, rows *sql.Rows, strsql string, args ...interface{}) error {
	stmt, err := mydb.Prepare(strsql)
	if err != nil {
		return err
	}

	rows, err = stmt.Query(args...)
	return err

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

	stmt.Close()
	return count, true
}
