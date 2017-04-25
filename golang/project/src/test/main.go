package main

import (
	"context"
	"fmt"
	"time"
)

func Add(ctx context.Context, a, b int) int {
	time.Sleep(5 * time.Second)
	select {
	case <-ctx.Done():
		return -1
	default:
	}
	return a + b
}

func main() {
	{
		a := 3
		b := 6
		timeout := 6 * time.Second
		ctx, _ := context.WithTimeout(context.Background(), timeout)
		res := Add(ctx, a, b)
		if nil != ctx.Err() {
			fmt.Println(ctx.Err().Error())
		}
		fmt.Printf("%d+%d=%d\n", a, b, res)
	}

	{
		a := 1
		b := 2
		ctx, cancel := context.WithCancel(context.Background())
		go func() {
			time.Sleep(2 * time.Second)
			cancel()
		}()
		res := Add(ctx, 1, 2)
		if nil != ctx.Err() {
			fmt.Println(ctx.Err().Error())
		}
		fmt.Printf("%d+%d=%d\n", a, b, res)
	}
}
