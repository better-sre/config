# Fluent Bit

## 介绍

- <https://docs.fluentbit.io/manual/about/what-is-fluent-bit>
- Fluent Bit是一个开源遥测代理，专门设计用于高效应对在各种环境（从受限系统到复杂的云基础架构）中收集和处理遥测数据的挑战。
- Fluent Bit 支持供应商中立的方法，可与 Prometheus 和 OpenTelemetry 等其他生态系统无缝集成。

## 特性

- <https://docs.fluentbit.io/manual>
- 高性能：高吞吐量，低资源消耗
- 数据解析
  - 使用我们的解析器转换您的非结构化消息：JSON、Regex、LTSV和Logfmt
- 指标支持：兼容 Prometheus 和 OpenTelemetry
- 可靠性和数据完整性
  - 背压处理
  - 内存和文件系统中的数据缓冲
- 联网
  - 安全性：内置 TLS/SSL 支持
  - 异步 I/O

## Reference

- [fluent-bit](https://github.com/fluent/fluent-bit)
- <https://fluentbit.io/how-it-works/>
- <https://docs.fluentbit.io/manual/about/what-is-fluent-bit>

> 教程

- [Kubernetes日志采集——Fluent Bit详细介绍（一）](https://www.cnblogs.com/zhangmingcheng/p/15784496.html)
- [使用fluent bit+ClickHouse 实现K8s日志采集](https://cloud.tencent.com/developer/article/1926584)
- [使用 Fluentbit 采集夜莺日志写入 ElasticSearch](https://flashcat.cloud/blog/collect-n9e-logs-by-fluentbit/)
- <https://docs.docker.com/engine/logging/drivers/fluentd/>

```ruby

docker run --log-driver=fluentd --log-opt fluentd-address=fluentdhost:24224
```

- <https://kevcodez.de/posts/2019-08-10-fluent-bit-docker-logging-driver-elasticsearch/>

```ruby

version: "3.5"
services:
  elasticsearch:
    image: elasticsearch:7.3.0
    ports:
      - "9200:9200"
      - "9300:9300"
    environment:
      - "ES_JAVA_OPTS=-Xms512m -Xmx512m"
      - discovery.type=single-node
  
  fluentbit:
    build: .
    ports:
      - "24224:24224"
      - "24224:24224/udp"
    depends_on:
      - elasticsearch
  
  ubuntu:
    image: ubuntu
    command: [/bin/echo, "Kevcodez"]
    depends_on:
      - fluentbit
    logging: # 日志 driver
      driver: fluentd
      options:
        tag: docker-ubuntu
```
