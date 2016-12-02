package main

import (
	"flag"
	"fmt"
	"lbs"
	"log"
	"net/http"
	"strings"
)

func get_lbs(w http.ResponseWriter, r *http.Request) {
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
	fmt.Fprintf(w, lbs.Req_lbs(str_ip))
}

func get_ip(w http.ResponseWriter, r *http.Request) {
	r.ParseForm()
	fmt.Fprintf(w, strings.Split(r.RemoteAddr, ":")[0])
}

func get_ip_port(w http.ResponseWriter, r *http.Request) {
	r.ParseForm()
	fmt.Fprintf(w, r.RemoteAddr)
}

func main() {
	i_port := flag.String("port", "9655", "default server port 9655")
	i_tls := flag.Int("tls", 1, "default enable tls")
	flag.Parse()

	http.Handle("/", http.FileServer(http.Dir("./html/")))
	http.HandleFunc("/ip", get_ip)
	http.HandleFunc("/ip_port", get_ip_port)
	http.HandleFunc("/lbs", get_lbs)

	if *i_tls == 1 {
		log.Fatal(http.ListenAndServeTLS(":"+*i_port, "./ca/ca.crt", "./ca/ca.key", nil))
	} else {
		log.Fatal(http.ListenAndServe(":"+*i_port, nil))
	}

}
