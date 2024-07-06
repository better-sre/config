# Python Dockerfile:

- https://hub.docker.com/_/python

## FastApi:

- https://github.com/tiangolo/uvicorn-gunicorn-fastapi-docker

## Python 3.12:

-

## Python 3.6:

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


