// test project main.go
package main

import (
	"database/sql"
	"log"

	_ "github.com/mattn/go-oci8"
)

func test_oci() {

	db1, err := sql.Open("oci8", "system/manager@HIS")
	if err != nil {
		log.Fatal(err)
	}
	defer db1.Close()

	rows, err := db1.Query(`select ITEM_NAME from COMM.PRICE_LIST where ITEM_CODE = '30130002050'`)
	if err != nil {
		log.Fatal(err)
	}

	for rows.Next() {
		var name string
		rows.Scan(&name)
		log.Printf("Name = %s, len=%d", name, len(name))
	}
	rows.Close()
}

func main() {
	test_oci()

}
