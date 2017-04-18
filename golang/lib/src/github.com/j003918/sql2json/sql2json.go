// sql2json project sql2json.go
package sql2json

import (
	"bytes"
	"database/sql"
	"encoding/json"
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

	//fix bug time.Time nil
	//values := make([]sql.RawBytes, len(columns))
	values := make([]sql.NullString, len(columns))
	scans := make([]interface{}, len(columns))

	for i := range values {
		scans[i] = &values[i]
	}

	type Jitem struct {
		Item string `json:"e"`
	}
	var jitem Jitem

	json_buf.WriteByte('[')
	for rows.Next() {
		err = rows.Scan(scans...)
		if err != nil {
			panic(err.Error())
		}

		json_buf.WriteByte('{')
		var strVal string
		for i, col := range values {
			if !col.Valid {
				strVal = "null"
			} else {
				jitem.Item = col.String
				bs, _ := json.Marshal(&jitem)
				strVal = string(bs[6 : len(bs)-2])
			}

			columName := strings.ToLower(columns[i])
			cell := fmt.Sprintf(`"%v":"%v"`, columName, strVal)
			json_buf.WriteString(cell + ",")
		}
		json_buf.Bytes()[json_buf.Len()-1] = '}'
		json_buf.WriteByte(',')
	}
	json_buf.Bytes()[json_buf.Len()-1] = ']'
	return json_buf.String(), nil
}
