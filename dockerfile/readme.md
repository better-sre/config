
# Dockerfile

- <https://github.com/service-mesh/dockerfile>
- awesome dockerfile for docker

## 国内镜像加速方案

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
