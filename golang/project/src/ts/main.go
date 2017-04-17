// ts project main.go
package main

import (
	"container/ring"
	"fmt"
	"net"
	"net/http"
	"os"
	/*
		"strconv"
		"time"
	*/)

var uclient *ring.Ring

func init() {
	uclient = ring.New(100)
}

func listClient(w http.ResponseWriter, r *http.Request) {
	rl := uclient
	os.OpenFile()

	for i := 0; i < rl.Len(); i++ {
		fmt.Println(rl.Value)
		if rl.Value != nil {
			w.Write([]byte(rl.Value.(string) + string('\n')))
		}
		rl = rl.Next()
	}
}

func httpList() {
	http.HandleFunc("/", listClient)
	http.ListenAndServe(":9657", nil)
}

func main() {
	addr, err := net.ResolveUDPAddr("udp", ":6000")
	if err != nil {
		fmt.Println("net.ResolveUDPAddr fail.", err)
		os.Exit(1)
	}

	conn, err := net.ListenUDP("udp", addr)
	if err != nil {
		fmt.Println("net.ListenUDP fail.", err)
		os.Exit(1)
	}
	defer conn.Close()

	/*
		for i := 0; i < 30; i++ {
			r.Value = i
			r = r.Next()
		}
		for i := 0; i < r.Len(); i++ {
			fmt.Println(r.Value)
			r = r.Next()
		}
	*/

	uclient.Value = "127.0.0.1:765"
	uclient = uclient.Next()

	go httpList()
	for {
		buf := make([]byte, 1024)
		_, raddr, err := conn.ReadFromUDP(buf)
		if err != nil {
			fmt.Println("conn.ReadFromUDP fail.", err)
			continue
		}
		uclient.Value = raddr.String()
		uclient = uclient.Next()
	}

}

/*
type Request struct {
	isCancel bool
	reqSeq   int
	reqPkg   []byte
	rspChan  chan<- []byte
}

func main() {
	addr, err := net.ResolveUDPAddr("udp", ":6000")
	if err != nil {
		fmt.Println("net.ResolveUDPAddr fail.", err)
		os.Exit(1)
	}

	conn, err := net.ListenUDP("udp", addr)
	if err != nil {
		fmt.Println("net.ListenUDP fail.", err)
		os.Exit(1)
	}
	defer conn.Close()

	reqChan := make(chan *Request, 1000)
	go connHandler(reqChan)

	var seq int = 0
	for {
		buf := make([]byte, 1024)
		rlen, remote, err := conn.ReadFromUDP(buf)
		if err != nil {
			fmt.Println("conn.ReadFromUDP fail.", err)
			continue
		}
		seq++
		go processHandler(conn, remote, buf[:rlen], reqChan, seq)
	}
}

func processHandler(conn *net.UDPConn, remote *net.UDPAddr, msg []byte, reqChan chan<- *Request, seq int) {
	rspChan := make(chan []byte, 1)
	reqChan <- &Request{false, seq, []byte(strconv.Itoa(seq)), rspChan}
	select {
	case rsp := <-rspChan:
		fmt.Println("recv rsp. rsp=%v", string(rsp))
	case <-time.After(2 * time.Second):
		fmt.Println("wait for rsp timeout.")
		reqChan <- &Request{isCancel: true, reqSeq: seq}
		conn.WriteToUDP([]byte("wait for rsp timeout."), remote)
		return
	}

	conn.WriteToUDP([]byte("all process succ."), remote)
}

func connHandler(reqChan <-chan *Request) {
	addr, err := net.ResolveUDPAddr("udp", ":6001")
	if err != nil {
		fmt.Println("net.ResolveUDPAddr fail.", err)
		os.Exit(1)
	}

	conn, err := net.DialUDP("udp", nil, addr)
	if err != nil {
		fmt.Println("net.DialUDP fail.", err)
		os.Exit(1)
	}
	defer conn.Close()

	sendChan := make(chan []byte, 1000)
	go sendHandler(conn, sendChan)

	recvChan := make(chan []byte, 1000)
	go recvHandler(conn, recvChan)

	reqMap := make(map[int]*Request)
	for {
		select {
		case req := <-reqChan:
			if req.isCancel {
				delete(reqMap, req.reqSeq)
				fmt.Println("CancelRequest recv. reqSeq=%v", req.reqSeq)
				continue
			}
			reqMap[req.reqSeq] = req
			sendChan <- req.reqPkg
			fmt.Println("NormalRequest recv. reqSeq=%d reqPkg=%s", req.reqSeq, string(req.reqPkg))
		case rsp := <-recvChan:
			seq, err := strconv.Atoi(string(rsp))
			if err != nil {
				fmt.Println("strconv.Atoi fail. err=%v", err)
				continue
			}
			req, ok := reqMap[seq]
			if !ok {
				fmt.Println("seq not found. seq=%v", seq)
				continue
			}
			req.rspChan <- rsp
			fmt.Println("send rsp to client. rsp=%v", string(rsp))
			delete(reqMap, req.reqSeq)
		}
	}
}

func sendHandler(conn *net.UDPConn, sendChan <-chan []byte) {
	for data := range sendChan {
		wlen, err := conn.Write(data)
		if err != nil || wlen != len(data) {
			fmt.Println("conn.Write fail.", err)
			continue
		}
		fmt.Println("conn.Write succ. data=%v", string(data))
	}
}

func recvHandler(conn *net.UDPConn, recvChan chan<- []byte) {
	for {
		buf := make([]byte, 1024)
		rlen, err := conn.Read(buf)
		if err != nil || rlen <= 0 {
			fmt.Println(err)
			continue
		}
		fmt.Println("conn.Read succ. data=%v", string(buf))
		recvChan <- buf[:rlen]
	}
}
*/
