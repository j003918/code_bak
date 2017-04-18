// sql2json project sql2json.go
package sql2json

import (
	"bytes"
	"database/sql"
	//"database/sql/driver"
	"errors"
	"fmt"
	"strings"
	//"time"
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

	//fix bug time.Time nil
	//values := make([]sql.RawBytes, len(columns))
	values := make([]sql.NullString, len(columns))
	scans := make([]interface{}, len(columns))

	for i := range values {
		scans[i] = &values[i]
	}

	json_buf.WriteString("[")
	for rows.Next() {
		err = rows.Scan(scans...)
		if err != nil {
			panic(err.Error())
		}

		row := "{"
		var strVal string
		for i, col := range values {
			if !col.Valid {
				strVal = "null"
			} else {
				strVal = col.String
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
