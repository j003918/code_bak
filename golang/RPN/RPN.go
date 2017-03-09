// RPN project RPN.go
package RPN

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

func opr_level(opr string) int {
	switch opr {
	case "+":
		fallthrough
	case "-":
		return 1
	case "*":
		fallthrough
	case "/":
		return 2
	case "(":
		fallthrough
	case ")":
		fallthrough
	default:
		return 0
	}
}

func Parse_Exp(expression string) string {
	str_rpn := ""
	str_tmp := ""
	ch := ""
	rpn := NewStack()
	opr := NewStack()

	for _, v := range expression {
		ch = string(v)
		if ch == " " {
			continue
		}

		switch ch {
		case "(":
			if str_tmp != "" {
				rpn.Push(str_tmp)
				str_tmp = ""
			}
			opr.Push(ch)
		case ")":
			if str_tmp != "" {
				rpn.Push(str_tmp)
				str_tmp = ""
			}
			str := ""
			for !opr.Empty() {
				str = opr.Pop().(string)
				if str == "(" {
					break
				}
				rpn.Push(str)
			}
		case "+":
			fallthrough
		case "-":
			fallthrough
		case "*":
			fallthrough
		case "/":
			if str_tmp != "" {
				rpn.Push(str_tmp)
				str_tmp = ""
			}

			for !opr.Empty() {
				if opr_level(opr.Top().(string)) >= opr_level(ch) {
					rpn.Push(opr.Pop())
				} else {
					break
				}
			}
			opr.Push(ch)
		default:
			str_tmp += ch
		}
	}
	if str_tmp != "" {
		rpn.Push(str_tmp)
	}

	for !opr.Empty() {
		rpn.Push(opr.Pop())
	}

	for e := rpn.List().Front(); e != nil; e = e.Next() {
		str_rpn += e.Value.(string) // + ","
	}

	return str_rpn //[:len(rp_exp)-1]
}
