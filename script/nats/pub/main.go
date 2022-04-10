package main

import (
	"fmt"
	"time"

	"github.com/nats-io/nats.go"
)

func main() {

	// 连接Nats服务器
	nc, _ := nats.Connect("nats://127.0.0.1:4222")

	sub1 := "test1"
	sub2 := "test2"
	sub3 := "test3"

	// 发布-订阅 模式，向 test1 发布一个 `Hello World` 数据
	_ = nc.Publish(sub1, []byte("Hello World"))

	// 队列 模式，发布是一样的，只是订阅不同，向 test2 发布一个 `Hello zngw` 数据
	_ = nc.Publish(sub2, []byte("Hello zngw"))

	// 请求-响应， 向 test3 发布一个 `help me` 请求数据，设置超时间3秒，如果有多个响应，只接收第一个收到的消息
	msg, err := nc.Request(sub3, []byte("help me"), 3*time.Second)
	if err != nil {
		fmt.Println(err)
	} else {
		fmt.Printf("help answer : %s\n", string(msg.Data))
	}

	// 持续发送不需要关闭
	//_ = nc.Drain()

	// 关闭连接
	//nc.Close()
}
