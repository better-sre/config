
# Dockerfile

- <https://github.com/service-mesh/dockerfile>
- awesome dockerfile for docker

## 国内镜像加速方案

### 🔥 gh-proxy 加速

- <https://gh-proxy.com/>
- <https://gh-proxy.com/docker>
- <https://gh-proxy.com/docs/docker-mirror>

```ruby

# 1. 官方 Docker Hub 基础镜像 (library/ 默认分组)
docker pull gh-proxy.org/docker/nginx:latest
docker pull gh-proxy.org/docker/ubuntu:22.04

# 2. 带系统架构前缀镜像
docker pull gh-proxy.org/docker/amd64/nginx:latest

# 3. Docker Hub 第三方开源镜像
docker pull gh-proxy.org/docker/cleverest/crproxy
docker pull gh-proxy.org/docker/adguard/adguardhome
docker pull gh-proxy.org/docker/docker.io/adguard/adguardhome

# 4. Google 容器注册表 (GCR)
docker pull gh-proxy.org/docker/gcr.io/kaniko-project/executor:debug

# 5. GitHub 容器注册表 (GHCR)
docker pull gh-proxy.org/docker/ghcr.io/openfaas/queue-worker

# 9. Microsoft 容器注册表 (MCR)
docker pull gh-proxy.org/docker/mcr.microsoft.com/powershell


```

#### 🚀 git clone 镜像加速

- <https://gh-proxy.com/docs/git-config>

```ruby
# 配置 git clone 加速
git config --global url."https://gh-proxy.org/https://github.com/".insteadOf "https://github.com/"


# 取消加速
git config --global --unset url."https://gh-proxy.org/https://github.com/".insteadOf
```

- 加速 ohmyzsh

```ruby

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# 下载脚本
sh -c "$(curl -fsSL https://gh-proxy.org/https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

```

#### 🍄 Podman 镜像源配置

- Podman 镜像源配置

```ruby
# 编辑 /etc/containers/registries.conf
[[registry]]
prefix = "ghcr.io"
location = "gh-proxy.org/docker/ghcr.io"
```

### 🔥 daocloud 加速

- <https://www.daocloud.io/>
- <https://github.com/DaoCloud/public-image-mirror>

|原镜像|daocloud 加速|
|:--|:--|
|docker.elastic.co|elastic.m.daocloud.io|
|docker.io|docker.m.daocloud.io|
|dhi.io|dhi.m.daocloud.io|
|gcr.io|gcr.m.daocloud.io|
|ghcr.io|ghcr.m.daocloud.io|
|k8s.gcr.io|k8s-gcr.m.daocloud.io|
|registry.k8s.io|k8s.m.daocloud.io|
|quay.io|quay.m.daocloud.io|
|mcr.microsoft.com|mcr.m.daocloud.io|
|nvcr.io|nvcr.m.daocloud.io|
|registry.ollama.ai|ollama.m.daocloud.io|

#### docker 镜像加速

添加到 /etc/docker/daemon.json

```json
{
  "registry-mirrors": [
    "https://docker.m.daocloud.io"
  ]
}
```

### 🔥 1ms.run 加速

- <https://1ms.run/>
- <https://docker.1ms.run>
- <https://mdoc.cc/mliev/1ms/v1.0.0/3>
  - 免费用户仅支持 docker.io、ghcr.io

|原镜像|1ms.run 加速|
|:--|:--|
|docker.io|docker.1ms.run|
|ghcr.io|ghcr.1ms.run|  

```ruby

# nginx
docker pull docker.1ms.run/nginx:latest
# 1ms.run 加速 + docker
docker pull docker.1ms.run/nginx

# linuxserver/webtop
docker pull ghcr.io/linuxserver/webtop:latest
# 1ms.run 加速 + ghcr
docker pull ghcr.1ms.run/linuxserver/webtop:latest

```

### 🔥 南京大学镜像站

- [南京大学镜像站](https://sci.nju.edu.cn/9e/05/c30384a564741/page.htm)

```ruby
# 使用方式:
docker pull ghcr.io/better-sre/ubuntu:22-uv
docker pull ghcr.io/better-sre/debian:12-uv

# 国内镜像加速
docker pull ghcr.nju.edu.cn/better-sre/ubuntu:22-uv
docker pull ghcr.nju.edu.cn/better-sre/debian:12-uv

```

## ✅ Active

### 🔥 [Debian](_debian)

- 包含最新在使用的镜像

### 🔥 [Ubuntu](_ubuntu)

- 包含最新在使用的镜像

## ❌ Archived

- 归档列表
- ✅ 如下都已经废弃, 请只使用 `_debian`和 `_ubuntu` 镜像.(包含废弃的镜像支持)

### Nginx

- nginx web server:
- nginx lb server:

### Golang

- <https://github.com/docker/awesome-compose/blob/master/nginx-golang/backend/Dockerfile>

### Python 3.6

- base: `python:3.6.5-alpine3.6`
- install:

```

django 1.11
django-rest-framework


```

### Java(OpenJDK)

- <https://github.com/docker-library/openjdk>
- <https://github.com/spotify/dockerfile-maven>
- <https://segmentfault.com/a/1190000016449865>

## Reference

### awesome

- <https://docs.docker.com/develop/develop-images/dockerfile_best-practices/>
- <https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#use-multi-stage-builds>
- <https://github.com/docker-library/official-images>
- <https://github.com/docker-library/python>
- <https://github.com/docker-library/openjdk>

### Docker Hub

- <https://hub.docker.com/u/servicemesh/>
