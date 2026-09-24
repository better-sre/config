# ============================================================
# Python 构建基镜像
# 基础: Debian 13 (Trixie) slim
# 包含: Python 3.13 + uv + 常用构建/开发依赖
# 用途: 业务应用打包构建的 base image
# ============================================================

FROM debian:trixie-slim

LABEL maintainer="build-base-image"
LABEL description="Debian 13 (Trixie) + Python 3.13 + uv 构建基镜像"
LABEL org.opencontainers.image.source="build-base-image"

# ------------------------------------------------------------
# 环境变量
# ------------------------------------------------------------
ENV DEBIAN_FRONTEND=noninteractive \
  LANG=C.UTF-8 \
  LC_ALL=C.UTF-8 \
  # 强制 Python UTF-8 模式（与 C.UTF-8 locale 双重保险，确保标准输出编码为 utf-8）
  PYTHONUTF8=1 \
  # 时区环境变量（解决日志/终端中文环境下的时间显示）
  TZ=Asia/Shanghai \
  PYTHONUNBUFFERED=1 \
  PYTHONDONTWRITEBYTECODE=1 \
  PIP_NO_CACHE_DIR=1 \
  PIP_DISABLE_PIP_VERSION_CHECK=1 \
  UV_NO_CACHE=0 \
  UV_LINK_MODE=copy \
  UV_PYTHON_DOWNLOADS=never \
  UV_PROJECT_ENVIRONMENT=/opt/venv \
  PATH="/opt/venv/bin:${PATH}"

# ------------------------------------------------------------
# 1. 配置 APT 源（国内可用，如在海外可注释掉这一段）
# ------------------------------------------------------------
# 使用清华 TUNA 镜像加速（可选，按需注释/修改）
# RUN sed -i 's|deb.debian.org|mirrors.tuna.tsinghua.edu.cn|g' \
#      /etc/apt/sources.list.d/debian.sources

# ------------------------------------------------------------
# 2. 系统更新 + 常用构建工具 + Python 3.13
# ------------------------------------------------------------
RUN set -eux; \
  apt-get update && \
  apt-get install -y --no-install-recommends \
  # ---- 基础工具 ----
  ca-certificates \
  curl \
  wget \
  gnupg \
  lsb-release \
  locales \
  tzdata \
  # ---- 网络调试 ----
  iproute2 \
  iputils-ping \
  dnsutils \
  netcat-openbsd \
  telnet \
  # ---- 版本控制 / 构建工具 ----
  git \
  make \
  build-essential \
  gcc \
  g++ \
  cmake \
  pkg-config \
  autoconf \
  automake \
  libtool \
  # ---- Python 运行时 ----
  python3 \
  python3-dev \
  python3-pip \
  python3-venv \
  python3-wheel \
  # ---- 常用 C 库（很多 Python 包需要） ----
  libssl-dev \
  libffi-dev \
  libxml2-dev \
  libxslt1-dev \
  libjpeg-dev \
  libpng-dev \
  libfreetype6-dev \
  libpq-dev \
  libmariadb-dev \
  libsqlite3-dev \
  zlib1g-dev \
  libbz2-dev \
  liblzma-dev \
  libreadline-dev \
  libcurl4-openssl-dev \
  # ---- 其他常用 ----
  unzip \
  zip \
  bzip2 \
  xz-utils \
  tar \
  gzip \
  vim-tiny \
  less \
  procps \
  htop \
  # ---- 时区 ----
  tzdata \
  && \
  # 生成 locale（显式写入 locale.gen，确保 C.UTF-8 生效，解决终端中文日志乱码）
  echo "C.UTF-8 UTF-8" > /etc/locale.gen && \
  locale-gen C.UTF-8 && \
  # 设置时区为 Asia/Shanghai
  ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
  echo "Asia/Shanghai" > /etc/timezone && \
  # 清理 APT 缓存，减小镜像体积
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# ------------------------------------------------------------
# 3. 创建虚拟环境（uv 默认环境）
# ------------------------------------------------------------
RUN python3 -m venv /opt/venv && \
  /opt/venv/bin/pip install --upgrade pip

# ------------------------------------------------------------
# 4. 安装 uv（Astral 官方安装脚本）
# ------------------------------------------------------------
RUN curl -LsSf https://astral.sh/uv/install.sh | sh && \
  mv /root/.local/bin/uv /usr/local/bin/uv && \
  mv /root/.local/bin/uvx /usr/local/bin/uvx && \
  rm -rf /root/.local

# 验证 uv 安装
RUN uv --version

# ------------------------------------------------------------
# 5. 配置 uv 使用国内 PyPI 镜像（可选，按需注释）
# ------------------------------------------------------------
# RUN uv pip install --system --index-url https://pypi.tuna.tsinghua.edu.cn/simple pip

# 全局 uv 配置文件
RUN mkdir -p /root/.config/uv && \
  echo '[pip]' > /root/.config/uv/uv.toml && \
  echo 'index-url = "https://pypi.tuna.tsinghua.edu.cn/simple"' >> /root/.config/uv/uv.toml

# ------------------------------------------------------------
# 6. 创建工作目录
# ------------------------------------------------------------
WORKDIR /app

# ------------------------------------------------------------
# 7. 验证 Python 环境
# ------------------------------------------------------------
RUN python3 --version && \
  pip --version && \
  uv --version && \
  # 验证中文支持：C.UTF-8 locale 已生成、Python 标准输出编码为 utf-8
  locale -a | grep -iE 'C\.?utf-?8' && \
  python3 -c "import sys; print('stdout encoding:', sys.stdout.encoding); assert sys.stdout.encoding.lower() == 'utf-8', sys.stdout.encoding" && \
  python3 -c "print('中文日志测试：OK')" && \
  echo "=== Build base image ready ===" && \
  echo "Python: $(python3 --version)" && \
  echo "uv:     $(uv --version)" && \
  echo "Debian: $(cat /etc/debian_version)"

# 默认命令
CMD ["python3", "--version"]
