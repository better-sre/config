# try-nats

## Nats Python

- https://github.com/nats-io/nats.py

```ruby

pip install nats-py

```

### 说明:

- ✅ 给出了`多个 worker`, `唯一性`消费的示例, 非常简单.

### Nats 官方示例:

- https://github.com/nats-io/nats.py/tree/main/examples

### Nats web ui:

- https://natsdashboard.com/
  - https://github.com/mdawar/nats-dashboard
- https://github.com/piotrpersona/nats-streaming-ui
- https://github.com/DefactoTechnology/nats-ui

## Deployment(Docker-compose):

- 基于 `docker-compose` 部署


### build

- build base image:

```ruby

# build python3.12 base images:
task df:py:bt312

# build nats base image:
task pkg:npy:ops:base -- build


```


### deploy `pub` service:

- run:


```ruby

task pkg:npy:ops:pub -- up -d

```

### deploy `sub` service:

- run:

```ruby
# 方式 1: 启动 1 个容器实例
task pkg:npy:ops:sub -- up -d
task pkg:npy:ops:sub -- logs -f

# 方式 2: 启动 3 个容器实例
docker-compose -f compose-sub.yml up -d --scale py-nats-sub=3

```