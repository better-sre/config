package main

import (
	"fmt"
	"os/signal"
	"runtime"
	"syscall"

	"github.com/nats-io/nats.go"
)

func main() {
	// 连接Nats服务器
	nc, _ := nats.Connect("nats://127.0.0.1:4222")

	sub1 := "test1"
	sub2 := "test2"
	sub3 := "test3"

	// 发布-订阅 模式，异步订阅 test1
	_, _ = nc.Subscribe(sub1, func(m *nats.Msg) {
		fmt.Printf("Subject: %s, Received a message Received a message: %s\n", sub1, string(m.Data))
	})

	// 队列 模式，订阅 test2， 队列为queue, test2 发向所有队列，同一队列只有一个能收到消息
	_, _ = nc.QueueSubscribe(sub2, "queue", func(msg *nats.Msg) {
		fmt.Printf("Subject: %s, Queue a message: %s\n", sub2, string(msg.Data))
	})

	// 请求-响应， 响应 test3 消息。
	_, _ = nc.Subscribe(sub3, func(m *nats.Msg) {
		fmt.Printf("Subject: %s, Reply a message: %s\n", sub3, string(m.Data))

		// 发送响应消息:
		_ = nc.Publish(m.Reply, []byte("I can help!!  from sub side"))
	})

	// 持续发送不需要关闭
	//_ = nc.Drain()

	// 关闭连接
	//nc.Close()

	// 阻止进程结束而收不到消息
	signal.Ignore(syscall.SIGHUP)
	runtime.Goexit()
}
