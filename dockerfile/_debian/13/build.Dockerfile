# ============================================================
# 全家桶开发环境构建基镜像 (build-all)
# 基础: Debian 13 (Trixie) slim
# 包含:
#   - Python 3.13 + uv           （后端 / 脚本 / 包管理）
#   - Rust stable (rustup)        （Rust 编译 / cargo 构建）
#   - Node.js (LTS) + pnpm        （前端构建环境）
# 用途: 业务应用打包构建的 all-in-one base image
# ============================================================

FROM debian:trixie-slim

LABEL maintainer="build-base-image"
LABEL description="Debian 13 (Trixie) + Python3.13 + uv + Rust stable + Node.js + pnpm 全家桶开发环境基镜像"
LABEL org.opencontainers.image.source="build-base-image"

# ------------------------------------------------------------
# 环境变量
# ------------------------------------------------------------
# 注意: PATH 需要同时包含
#   - /opt/venv/bin    : Python 虚拟环境 (uv 默认环境)
#   - /usr/local/cargo/bin : Rust / cargo
#   - 其余保留 Debian 默认 PATH
ENV DEBIAN_FRONTEND=noninteractive \
  LANG=C.UTF-8 \
  LC_ALL=C.UTF-8 \
  # 强制 Python UTF-8 模式（与 C.UTF-8 locale 双重保险，确保标准输出编码为 utf-8）
  PYTHONUTF8=1 \
  # 时区环境变量（解决日志/终端中文环境下的时间显示）
  TZ=Asia/Shanghai \
  # ---- Python / uv ----
  PYTHONUNBUFFERED=1 \
  PYTHONDONTWRITEBYTECODE=1 \
  PIP_NO_CACHE_DIR=1 \
  PIP_DISABLE_PIP_VERSION_CHECK=1 \
  UV_NO_CACHE=0 \
  UV_LINK_MODE=copy \
  UV_PYTHON_DOWNLOADS=never \
  UV_PROJECT_ENVIRONMENT=/opt/venv \
  # ---- Rust / cargo ----
  RUSTUP_HOME=/usr/local/rustup \
  CARGO_HOME=/usr/local/cargo \
  # 非交互安装 rustup
  RUSTUP_INIT_SKIP_PATH_CHECK=yes \
  CARGO_NET_GIT_FETCH_WITH_CLI=true \
  # ---- Node.js / pnpm ----
  NODE_OPTIONS=--max-old-space-size=4096 \
  # 统一 PATH（Python venv 在前，其次 cargo，其余沿用 Debian 默认）
  PATH="/opt/venv/bin:/usr/local/cargo/bin:${PATH}"

# ------------------------------------------------------------
# 1. 配置 APT 源（国内可用，如在海外可注释掉这一段）
# ------------------------------------------------------------
# 使用清华 TUNA 镜像加速（可选，按需注释/修改）
# RUN sed -i 's|deb.debian.org|mirrors.tuna.tsinghua.edu.cn|g' \
#      /etc/apt/sources.list.d/debian.sources

# ------------------------------------------------------------
# 2. 系统更新 + 常用构建工具 + (Python / Rust / Node 编译所需依赖)
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
  # ---- 版本控制 / 构建工具（cargo build 需要 cc/ld/make；Node 原生模块编译也需要） ----
  git \
  make \
  build-essential \
  gcc \
  g++ \
  clang \
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
  # ---- 常用 C 库（Python 包 / Rust crate / Node 原生模块 均可能需要） ----
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
# 6. 安装 Rust（rustup 官方安装脚本，stable 工具链）
# ------------------------------------------------------------
# 使用 rustup 安装，便于后续通过 rustup toolchain 切换版本
# RUSTUP_HOME / CARGO_HOME 已指向 /usr/local，镜像内全局可用
RUN curl -LsSf https://sh.rustup.rs -o /tmp/rustup-init.sh && \
  sh /tmp/rustup-init.sh -y --no-modify-path --profile minimal --default-toolchain stable && \
  rm -f /tmp/rustup-init.sh && \
  # 预编译一些常用组件（可选，按需增删）
  rustup component add rustfmt clippy && \
  # 清理 rustup 临时缓存
  rm -rf /tmp/* && \
  chmod -R a+rwx "${CARGO_HOME}" "${RUSTUP_HOME}"

# 验证 Rust 安装
RUN rustc --version && cargo --version && rustup --version

# ------------------------------------------------------------
# 7. 配置 cargo 国内 crates.io 镜像（可选，按需注释）
# ------------------------------------------------------------
# 使用 RsProxy（字节跳动维护），海外可替换为官方源或注释本段
RUN mkdir -p "${CARGO_HOME}" && \
  cat > "${CARGO_HOME}/config.toml" <<'EOF'
[source.crates-io]
replace-with = 'rsproxy-sparse'

[source.rsproxy]
registry = "https://rsproxy.cn/crates.io-index"

[source.rsproxy-sparse]
registry = "sparse+https://rsproxy.cn/index/"

[registries.rsproxy]
index = "https://rsproxy.cn/crates.io-index"

[net]
git-fetch-with-cli = true
EOF

# ------------------------------------------------------------
# 8. 安装 Node.js (LTS) + pnpm（前端构建环境）
# ------------------------------------------------------------
# 使用 NodeSource 官方仓库安装 Node.js LTS
# NODE_MAJOR 可在 build 时通过 --build-arg 覆盖，默认 22 (LTS)
ARG NODE_MAJOR=22
RUN set -eux; \
  curl -fsSL "https://deb.nodesource.com/setup_${NODE_MAJOR}.x" -o /tmp/nodesource-setup.sh && \
  bash /tmp/nodesource-setup.sh && \
  rm -f /tmp/nodesource-setup.sh && \
  apt-get install -y --no-install-recommends nodejs && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# 启用 corepack 并安装 pnpm（pnpm 也可通过 `npm install -g pnpm` 安装）
RUN corepack enable && \
  corepack prepare pnpm@latest --activate

# 验证 Node.js / pnpm 安装
RUN node --version && npm --version && pnpm --version

# ------------------------------------------------------------
# 9. 配置 npm / pnpm 国内镜像（可选，按需注释）
# ------------------------------------------------------------
# RUN npm config set registry https://registry.npmmirror.com && \
#     pnpm config set registry https://registry.npmmirror.com

# ------------------------------------------------------------
# 10. 创建工作目录
# ------------------------------------------------------------
WORKDIR /app

# ------------------------------------------------------------
# 11. 验证全家桶环境
# ------------------------------------------------------------
RUN python3 --version && \
  pip --version && \
  uv --version && \
  rustc --version && \
  cargo --version && \
  rustup show && \
  node --version && \
  npm --version && \
  pnpm --version && \
  # 验证中文支持：C.UTF-8 locale 已生成、Python 标准输出编码为 utf-8
  locale -a | grep -iE 'C\.?utf-?8' && \
  python3 -c "import sys; print('stdout encoding:', sys.stdout.encoding); assert sys.stdout.encoding.lower() == 'utf-8', sys.stdout.encoding" && \
  python3 -c "print('中文日志测试：OK')" && \
  echo "=== Build base image ready (all-in-one) ===" && \
  echo "Debian: $(cat /etc/debian_version)" && \
  echo "Python: $(python3 --version)" && \
  echo "uv:     $(uv --version)" && \
  echo "Rust:   $(rustc --version)" && \
  echo "Cargo:  $(cargo --version)" && \
  echo "Node:   $(node --version)" && \
  echo "npm:    $(npm --version)" && \
  echo "pnpm:   $(pnpm --version)"

# 默认命令
CMD ["bash"]
