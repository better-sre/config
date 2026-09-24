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

# for uv
# 旧版本 env，已经废弃，不建议使用
# ENV UV_INDEX_URL=https://pypi.tuna.tsinghua.edu.cn/simple
# ENV UV_DEFAULT_INDEX="https://pypi.tuna.tsinghua.edu.cn/simple"

# 腾讯云镜像
ENV UV_DEFAULT_INDEX="https://mirrors.cloud.tencent.com/pypi/simple"

# github 加速网关: https://gh-proxy.com/
# 加速安装 uv install python3.12
# "https://gh-proxy.com/github.com/indygreg/python-build-standalone/releases/download"
ENV UV_PYTHON_INSTALL_MIRROR="https://gh-proxy.com/github.com/astral-sh/python-build-standalone/releases/download"
# ENV UV_PYTHON_INSTALL_MIRROR="https://gh-proxy.com/github.com/indygreg/python-build-standalone/releases/download"

# 设置环境变量，以避免在安装软件包时交互提示
ENV DEBIAN_FRONTEND=noninteractive
ARG DEBIAN_FRONTEND=noninteractive
################################################################


# 腾讯云公网源（内外网均可解析；内网源 mirrors.cloud.tencentyun.com 在容器构建时可能无法解析内网 DNS）
RUN sed -i 's/archive.ubuntu.com/mirrors.cloud.tencent.com/g' /etc/apt/sources.list && \
  sed -i 's/security.ubuntu.com/mirrors.cloud.tencent.com/g' /etc/apt/sources.list

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


# # 清华镜像
# RUN pip config set global.index-url https://mirrors.tuna.tsinghua.edu.cn/pypi/simple/ \
#   && pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple \
#   && pip config set install.trusted-host mirrors.tuna.tsinghua.edu.cn \
#   && pip config set install.trusted-host pypi.tuna.tsinghua.edu.cn


# 阿里云镜像
# RUN pip config set global.index-url https://mirrors.aliyun.com/pypi/simple/ \
#   && pip config set install.trusted-host mirrors.aliyun.com


# 腾讯云镜像
RUN pip config set global.index-url https://mirrors.cloud.tencent.com/pypi/simple/ \
  && pip config set install.trusted-host mirrors.cloud.tencent.com


# install uv
RUN python3 -m pip install --upgrade pip
RUN pip install uv --upgrade


# 安装 python3.12，使用镜像加速
RUN uv python install 3.12 -v


# 验证 uv，pip 源生效
# RUN uv pip debug --verbose
################################################################

# user project


################################################################


# ENTRYPOINT ["/tini", "--"]
ENTRYPOINT ["/usr/bin/tini", "--"]

CMD ["uv run python3"]
