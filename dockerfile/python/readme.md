# Python Dockerfile:

- https://hub.docker.com/_/python

## FastApi:

- https://github.com/tiangolo/uvicorn-gunicorn-fastapi-docker

## Python 3.12:

- 安装了 `PDM/Pip/PipX` 包管理工具, 通过 `pdm` 创建 `.venv` 来安装不同版本的 python.
- 安装了 `go-task` 工具, 通过 go-task 来管理任务.
- 安装了 `curl` 工具, 通过 curl 来下载文件.
- 安装了 `tini`, 通过 `tini` 来启动容器(解决 docker 容器退出后, 容器内的`子进程`无法正常退出的问题).

## Python 3.6:

- 过时的文件, 不再使用.

## docker pull:

```

docker pull servicemesh/dockerfile:tagname

```

## docker build:

- https://docs.docker.com/engine/reference/commandline/build/#use-a-dockerignore-file

## fix install mysql client:

- https://nickjanetakis.com/blog/docker-tip-9-installing-popular-packages-on-alpine

```dockerfile


RUN apk add --no-cache alpine-sdk
RUN apk add --no-cache mysql-client
RUN apk add --no-cache mariadb-dev
RUN apk add --no-cache libffi-dev
# RUN apk add --no-cache openssl-dev
# fix openssl conflicts:
RUN apk add --no-cache libressl-dev


```

## reference:

- https://cloud.tencent.com/developer/article/2242308

> ubuntu:

- https://hub.docker.com/_/ubuntu
- https://ubuntu.com/about/release-cycle
- 推荐版本: `维护 10 年`
  - `22.04 LTS (Jammy Jellyfish)`
  - `24.04 LTS (Noble Numbat)`


