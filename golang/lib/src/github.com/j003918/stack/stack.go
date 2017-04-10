// stack project stack.go
package stack

import (
	"container/list"
	"sync"
)

type Stack struct {
	l   *list.List
	mux *sync.Mutex
}

func NewStack() *Stack {
	return &Stack{list.New(), new(sync.Mutex)}
}

func (s *Stack) Lock() {
	s.mux.Lock()
}

func (s *Stack) Unlock() {
	s.mux.Unlock()
}

func (s *Stack) List() *list.List {
	return s.l
}

func (s *Stack) Empty() bool {
	return s.l.Len() == 0
}

func (s *Stack) Len() int {
	return s.l.Len()
}

func (s *Stack) Top() interface{} {
	e := s.l.Back()
	if e != nil {
		return e.Value
	}
	return nil
}

func (s *Stack) Pop() interface{} {
	e := s.l.Back()
	if e != nil {
		s.l.Remove(e)
		return e.Value
	}
	return nil
}

func (s *Stack) Push(v interface{}) {
	s.l.PushBack(v)
}

func (s *Stack) Clean() {
	//add "n" for modify list.remove bug??
	var n *list.Element
	for e := s.l.Front(); e != nil; e = n {
		n = e.Next()
		s.l.Remove(e)
	}
}
