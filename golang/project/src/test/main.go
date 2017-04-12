// test project main.go
package main

import (
	"container/list"
	"fmt"
	"time"
	//	"fmt"
	"sync"
	//"runtime"
	//	"github.com/robfig/cron"
	"github.com/j003918/liststack"
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

func foo1() {
	fmt.Println(time.Now())
}

type sstack struct {
	list.List
}

func ss_new() *sstack {
	return new(sstack)
}

func (s *sstack) Top() interface{} {
	return s.Front().Value
}

func (s *sstack) Pop() interface{} {

	e := s.Back()
	s.Remove(e)
	return e.Value
}

func (s *sstack) Push(v interface{}) {

	s.PushBack(v)
}

func main() {

	ss := liststack.New()

	ss.Lock()
	ss.Push(1)
	ss.Unlock()
	ss.Push(2)
	ss.Push(3)
	ss.Push("a")
	ss.Push("b")
	ss.Push("c")

	fmt.Println(ss.Pop())
	fmt.Println(ss.Pop())
	fmt.Println(ss.Pop())
	fmt.Println(ss.Pop())
	fmt.Println(ss.Pop())
	fmt.Println(ss.Pop())

}
