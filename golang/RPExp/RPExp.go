// RPExp project RPExp.go
package RPExp

import (
	"container/list"
)

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

func stack_push(l *list.List, v interface{}) {
	l.PushBack(v)
}

func stack_pop(l *list.List) string {
	e := l.Back()
	if e == nil {
		return ""
	}
	l.Remove(e)
	return e.Value.(string)
}

func stack_top(l *list.List) string {
	e := l.Back()
	if e == nil {
		return ""
	}
	return e.Value.(string)
}

func Parse_exp(exp string) string {
	rp_exp := ""
	tmp_str := ""
	ch := ""
	list_exp := list.New()
	list_opr := list.New()

	for _, v := range exp {
		ch = string(v)
		if ch == " " {
			continue
		}

		switch ch {
		case "(":
			if tmp_str != "" {
				stack_push(list_exp, tmp_str)
			}
			tmp_str = ""
			list_opr.PushBack(ch)
		case ")":
			if tmp_str != "" {
				stack_push(list_exp, tmp_str)
			}
			tmp_str = ""

			for str := stack_pop(list_opr); str != ""; str = stack_pop(list_opr) {
				if str == "(" || str == "" {
					break
				}
				stack_push(list_exp, str)
			}
		case "+":
			fallthrough
		case "-":
			fallthrough
		case "*":
			fallthrough
		case "/":
			if tmp_str != "" {
				stack_push(list_exp, tmp_str)
			}
			tmp_str = ""

			for opr_level(stack_top(list_opr)) >= opr_level(ch) {
				stack_push(list_exp, stack_pop(list_opr))

			}

			stack_push(list_opr, ch)
		default:
			tmp_str += ch
		}
	}
	if tmp_str != "" {
		stack_push(list_exp, tmp_str)
	}

	for stack_top(list_opr) != "" {
		stack_push(list_exp, stack_pop(list_opr))
	}

	for e := list_exp.Front(); e != nil; e = e.Next() {
		rp_exp += e.Value.(string) // + ","
	}

	return rp_exp //[:len(rp_exp)-1]
}
