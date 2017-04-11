// sql2json project sql2json.go
package sql2json

import (
	"bytes"
	"database/sql"
	"errors"
	"fmt"
	"strings"
)

func GetJson(db *sql.DB, strSql string) (string, error) {
	var json_buf bytes.Buffer

	if "" == strings.Trim(strSql, " ") {
		return "", errors.New("err msg")
	}

	rows, err := db.Query(strSql)
	if err != nil {
		return "", err
	}
	defer rows.Close()

	columns, err := rows.Columns()

	if err != nil {
		return "", err
	}

	colVals := make([]sql.RawBytes, len(columns))
	colKeys := make([]interface{}, len(colVals))

	for i := range colVals {
		colKeys[i] = &colVals[i]
	}

	json_buf.WriteString("[")
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
				strVal = "null"
			} else {
				strVal = string(col)
			}

			columName := strings.ToLower(columns[i])
			cell := fmt.Sprintf(`"%v":"%v"`, columName, strVal)
			row = row + cell + ","
		}
		row = row[0 : len(row)-1]
		row += "}"
		json_buf.WriteString(row + ",")
	}
	strJson := json_buf.String()
	strJson = strJson[0 : len(strJson)-1]
	strJson += "]"

	return strJson, nil
}
