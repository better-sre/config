# Debian

## 🔥 自主构建镜像

- ✅ 集成:
  - `uv`: 用于管理 python 环境
  - `tini`: 解决容器退出后, 子进程无法正常退出的问题
- ✅ 镜像: `ubuntu:22-uv`, 相比 `debian:12-uv` 占用空间更小.
- ✅ 目前已经发布到 `ghcr.io`: <https://github.com/orgs/better-sre/packages/container/package/debian>

```ruby
# 使用方式:
docker pull ghcr.io/better-sre/debian:12-uv

# 国内镜像加速
docker pull ghcr.nju.edu.cn/better-sre/debian:12-uv

```

- ✅ 本地构建:

```ruby
# run:
task b12

# size:
❯ docker images
REPOSITORY                                                                  TAG            IMAGE ID       CREATED          SIZE
ubuntu                                                                      22-uv          e2a45809fec8   9 seconds ago    430MB
debian                                                                      12-uv          18d0a5b7849f   28 minutes ago   577MB

# 测试容器效果:
docker run -it --name debain12-test debian:12-uv  bash
# or:
docker run --rm -it debian:12-uv bash

# 进入:
docker exec -it debain12-test bash

```

## 基镜像版本

- [debian](https://hub.docker.com/_/debian)

### Slim

- 特点：基于Debian，但只包含必要的软件包，以减少镜像大小。
- 适用场景：适用于那些希望保持Debian稳定性同时又需要较小镜像的应用。
- 典型大小（以Python为例）：
  - python:3.11-slim: 大约110 MB
  - node:18-slim: 大约110 MB
  - openjdk:17-slim: 大约110 MB

### Bookworm (Debian 12)

- 最新稳定版：提供最新的安全更新和软件包。
- 适用场景：适合追求最新特性和安全性的项目。

### Bullseye (Debian 11)

- 长期支持：提供长期的支持和维护。
- 适用场景：适合那些需要稳定性和长期支持的企业级应用。

## 镜像

```ruby


docker pull debian


docker pull debian:11
docker pull debian:12


# 
docker pull debian:11-slim
docker pull debian:12-slim


```

## 镜像大小对比

```ruby
docker images
REPOSITORY                                                                  TAG            IMAGE ID       CREATED         SIZE

arm64v8/ubuntu                                                              22.04          1c48965c5eed   7 days ago      69.2MB
ubuntu                                                                      22.04          1c48965c5eed   7 days ago      69.2MB

debian                                                                      12             827eb53164e3   8 days ago      139MB
debian                                                                      12-slim        d7d888c58aab   8 days ago      97.2MB

```

## Reference

### 参考 dockerfile

- [uv + ubuntu](https://github.com/astral-sh/uv/blob/main/Dockerfile)

### 讨论

- [2025 年了，大家服务器用的什么 Linux 版本](https://v2ex.com/t/1105283?p=3)
- [大家制作 docker 镜像时操作系统层通常用哪个镜像？](https://www.v2ex.com/t/931409)
