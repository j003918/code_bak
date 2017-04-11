// list_stack project liststack.go
package liststack

import (
	"container/list"
	"sync"
)

type ListStack struct {
	list.List
	sync.Mutex
}

func New() *ListStack {
	return new(ListStack)

}

func (s *ListStack) Empty() bool {
	return s.Len() == 0
}

func (s *ListStack) Top() interface{} {
	e := s.Back()
	if e != nil {
		return e.Value
	}
	return nil
}

func (s *ListStack) Pop() interface{} {
	e := s.Back()
	if e != nil {
		s.Remove(e)
		return e.Value
	}
	return nil
}

func (s *ListStack) Push(v interface{}) {
	s.PushBack(v)
}

func (s *ListStack) Clean() {
	//add "n" for modify list.remove bug??
	var n *list.Element
	for e := s.Front(); e != nil; e = n {
		n = e.Next()
		s.Remove(e)
	}
}
