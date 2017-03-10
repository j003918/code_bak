// comm project stack.go
package comm

import (
	"container/list"
)

type Stack struct {
	l *list.List
}

func NewStack() *Stack {
	l := list.New()
	return &Stack{l}
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
