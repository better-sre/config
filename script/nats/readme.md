# nats test:

- 验证 nats 中间件部署正常.

## usage:

- 先 sub, 后 pub.

```ruby 

# 订阅:
go run sub/main.go

# 发布:
go run pub/main.go

```

## reference:

- https://www.jianshu.com/p/82ffdc7c9c74
