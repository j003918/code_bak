// sql2json
package comm

import (
	"database/sql"
	"fmt"
	"strings"
)

func Sql2Json(db *sql.DB, strSql string) (string, error) {
	rows, err := db.Query(strSql)
	if err != nil {
		return "", err
	}

	columns, err := rows.Columns()
	if err != nil {
		return "", err
	}
	defer rows.Close()

	colVals := make([]sql.RawBytes, len(columns))
	colKeys := make([]interface{}, len(colVals))

	for i := range colVals {
		colKeys[i] = &colVals[i]
	}

	strJson := "["

	for rows.Next() {
		err = rows.Scan(colKeys...)
		if err != nil {
			fmt.Println("log:", err)
			panic(err.Error())
		}

		row := "{"
		var strVal string
		for i, col := range colVals {
			if col == nil {
				strVal = "NULL"
			} else {
				strVal = string(col)
			}

			columName := strings.ToLower(columns[i])

			cell := fmt.Sprintf(`"%v":"%v"`, columName, strVal)
			row = row + cell + ","
		}
		row = row[0 : len(row)-1]
		row += "}"
		strJson = strJson + row + ","

	}
	strJson = strJson[0 : len(strJson)-1]
	strJson += "]"

	return strJson, nil
	//fmt.Println(list)
}
