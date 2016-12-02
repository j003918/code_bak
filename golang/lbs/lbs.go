// lbs project lbs.go
package lbs

import (
	"io/ioutil"
	"net/http"
)

func Req_lbs(qcip string) string {
	/*
		http://lbsyun.baidu.com/index.php?title=webapi/high-acc-ip
	*/
	http_client := &http.Client{}
	req_url := "http://api.map.baidu.com/highacciploc/v1?qcip="
	req_url += qcip
	req_url += "&qterm=pc&extensions=3&ak=691877440e377e5896acad424ca64732&coord=bd09ll"

	http_req, err := http.NewRequest("GET", req_url, nil)
	http_req.Header.Add("Accept-Language", "zh-cn,zh;q=0.8,en-us;q=0.5,en;q=0.3")
	http_req.Header.Add("User-Agent", "Mozilla/5.0 (Windows NT 6.3; WOW64; rv:39.0) Gecko/20100101 Firefox/39.0")
	http_rsp, err := http_client.Do(http_req)

	if err != nil {
		return ""
	}
	defer http_rsp.Body.Close()

	var body []byte
	body, _ = ioutil.ReadAll(http_rsp.Body)
	return string(body)
}

/*
func Get_lbs(w http.ResponseWriter, r *http.Request) {
	var str_ip string
	str_ip = ""
	r.ParseForm()
	if len(r.Form["ip"]) > 0 {
		str_ip = r.Form["ip"][0]
	} else {
		str_ip = strings.Split(r.RemoteAddr, ":")[0]
	}
	fmt.Fprintf(w, "{req_addr:")
	fmt.Fprintf(w, r.RemoteAddr)
	fmt.Fprintf(w, ", location_ip:")
	fmt.Fprintf(w, str_ip)
	fmt.Fprintf(w, "},")
	fmt.Fprintf(w, req_lbs(str_ip))
}

func Get_ip(w http.ResponseWriter, r *http.Request) {
	r.ParseForm()
	fmt.Fprintf(w, strings.Split(r.RemoteAddr, ":")[0])
}

func Get_ip_port(w http.ResponseWriter, r *http.Request) {
	r.ParseForm()
	fmt.Fprintf(w, r.RemoteAddr)
}
*/
