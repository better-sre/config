# docker-ubuntu

- <https://hub.docker.com/_/ubuntu>
- <https://github.com/docker-library/official-images>
- <https://ubuntu.com/about/release-cycle>

> 说明:

- ✅ LTS 版本: `维护周期 = 10年`

## 🔥 自主构建的镜像

- ✅ 集成:
  - `uv`: 用于管理 python 环境
  - `tini`: 解决容器退出后, 子进程无法正常退出的问题
- ✅ 镜像: `ubuntu:22-uv`, 相比 `debian:12-uv` 占用空间更小.
- ✅ 目前已经发布到 `ghcr.io`: <https://github.com/orgs/better-sre/packages/container/package/ubuntu>

```ruby
# 使用方式:
docker pull ghcr.io/better-sre/ubuntu:22-uv

# 国内镜像加速
docker pull ghcr.nju.edu.cn/better-sre/ubuntu:22-uv

```

- ✅ 本地构建:

```ruby
# 构建
task b22

❯ docker images
REPOSITORY                                                                  TAG            IMAGE ID       CREATED          SIZE
ubuntu                                                                      22-uv          e2a45809fec8   9 seconds ago    430MB
debian                                                                      12-uv          18d0a5b7849f   28 minutes ago   577MB

```

- ✅ 发布到 ghcr.io:

```ruby
# 打标签
task tag

# login ghcr.io
task login

# 发布到 ghcr.io
task rel
```

## Ubuntu 版本选择

- 💡 截至当前: `2025-05`.
- ✅ `22.04 LTS (Jammy Jellyfish)` 依然是首选推荐版本, 稳定可靠.
- ❌ `24.04`  但是不推荐使用, 很多依赖有各种问题, 不值得浪费时间修复无意义的错误!!!

## Ubuntu 22.04 LTS

- ✅ 当前推荐
- ✅ [22.04 LTS (Jammy Jellyfish)](https://hub.docker.com/layers/library/ubuntu/22.04/images/sha256-0eb0f877e1c869a300c442c41120e778db7161419244ee5cbc6fa5f134e74736?context=explore)
- ✅ size: `28.17 MB`

```ruby
# 2025-05: ubuntu  22.04   c42dedf797ba   7 days ago   77.9MB
docker pull ubuntu:22.04

# 官方 ARM 镜像, for Apple M1
docker pull arm64v8/ubuntu:22.04
# https://docker.nju.edu.cn/


# test run:
docker run --rm -it ubuntu:22.04 bash

```

## ❌ Ubuntu 24.04 LTS

- ✅ [24.04 LTS (Noble Numbat)](https://hub.docker.com/layers/library/ubuntu/24.04/images/sha256-3963c438d67a34318a3672faa6debd1dfff48e5d52de54305988b932c61514ca?context=explore)
- ❌ 当前依然不推荐使用, 问题很多.

```ruby
docker pull ubuntu:24.04

```

## Ubuntu + 中间件

- <https://hub.docker.com/u/ubuntu>

### + Python

- <https://hub.docker.com/r/ubuntu/python>

### + Redis

- <https://hub.docker.com/r/ubuntu/redis>

## Reference

### 参考 dockerfile

- [uv + ubuntu](https://github.com/astral-sh/uv/blob/main/Dockerfile)
