// test project main.go
package main

import (
	"container/list"
	"fmt"
	//	"fmt"
	"sync"
	//"runtime"
)

//var ch  = make(chan,int)

type Stack1 struct {
	l   *list.List
	mux *sync.Mutex
}

func NewStack() *Stack1 {
	l := list.New()
	mux := new(sync.Mutex)
	return &Stack1{l, mux}
}

func (s *Stack1) Lock() {
	s.mux.Lock()
}

func (s *Stack1) Unlock() {
	s.mux.Unlock()
}

func (s *Stack1) List() *list.List {
	return s.l
}

func (s *Stack1) Empty() bool {
	return s.l.Len() == 0
}

func (s *Stack1) Len() int {
	return s.l.Len()
}

func (s *Stack1) Top() interface{} {
	e := s.l.Back()
	if e != nil {
		return e.Value
	}
	return nil
}

func (s *Stack1) Pop() interface{} {
	e := s.l.Back()
	if e != nil {
		s.l.Remove(e)
		return e.Value
	}
	return nil
}

func (s *Stack1) Push(v interface{}) {
	s.l.PushBack(v)
}

func (s *Stack1) Clean() {
	//add "n" for modify list.remove bug??
	var n *list.Element
	for e := s.l.Front(); e != nil; e = n {
		n = e.Next()
		s.l.Remove(e)
	}
}

func foo(s *Stack1, ch chan int, i int) {
	//s.Lock()
	for j := 0; j < 1000; j++ {
		//fmt.Printf("%d,%d ", i, j)
		s.Push(j)
	}
	//s.Unlock()
	ch <- i
}

func main() {
	ch := make(chan int)
	ss := NewStack()
	//runtime.GOMAXPROCS(2)
	//fmt.Println(runtime.NumCPU())
	go foo(ss, ch, 1)
	go foo(ss, ch, 2)
	go foo(ss, ch, 3)
	go foo(ss, ch, 4)
	<-ch
	<-ch
	<-ch
	<-ch
	fmt.Println(ss.Len())
}
