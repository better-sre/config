
# python 3.6:


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