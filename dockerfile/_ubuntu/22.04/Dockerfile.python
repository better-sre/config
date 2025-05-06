# FROM debian:12 AS build
FROM --platform=$BUILDPLATFORM ubuntu:22.04 AS build

# 维护者信息
LABEL maintainer="hhglory@outlook.com"

WORKDIR /app

################################################################

# env
ENV TZ=Asia/Shanghai
ENV TIME_ZONE=Asia/Shanghai
ENV PATH="/opt/venv/bin:$PATH"

# 设置环境变量，以避免在安装软件包时交互提示
ENV DEBIAN_FRONTEND=noninteractive

################################################################

# python3 python3-dev python3-pip curl cmake
RUN apt update \
    && DEBIAN_FRONTEND=noninteractive \
    apt install -y --no-install-recommends \
    build-essential \
    tini \
    tzdata \
    python3-venv \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

################################################################

# python 3.11.2 + venv
RUN python3 -m venv /opt/venv

# install uv
RUN python3 -m pip install --upgrade pip
RUN pip install uv --upgrade

################################################################

# user project


################################################################


# ENTRYPOINT ["/tini", "--"]
ENTRYPOINT ["/usr/bin/tini", "--"]

CMD ["uv run python3"]
