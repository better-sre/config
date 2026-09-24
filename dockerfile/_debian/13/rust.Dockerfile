# ============================================================
# Rust 构建基镜像
# 基础: Debian 13 (Trixie) slim
# 包含: Rust stable (rustup) + cargo + 常用构建/开发依赖
# 用途: Rust 业务应用打包构建的 base image
# ============================================================
FROM debian:trixie-slim

LABEL maintainer="build-base-image"
LABEL description="Debian 13 (Trixie) + Rust stable (rustup) 构建基镜像"
LABEL org.opencontainers.image.source="build-base-image"

# ------------------------------------------------------------
# 环境变量
# ------------------------------------------------------------
ENV DEBIAN_FRONTEND=noninteractive \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    # 时区环境变量（解决日志/终端中文环境下的时间显示）
    TZ=Asia/Shanghai \
    # Rust / cargo 相关
    RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH="/usr/local/cargo/bin:${PATH}" \
    # 非交互安装 rustup
    RUSTUP_INIT_SKIP_PATH_CHECK=yes \
    CARGO_NET_GIT_FETCH_WITH_CLI=true

# ------------------------------------------------------------
# 1. 配置 APT 源（国内可用，如在海外可注释掉这一段）
# ------------------------------------------------------------
# 使用清华 TUNA 镜像加速（可选，按需注释/修改）
# RUN sed -i 's|deb.debian.org|mirrors.tuna.tsinghua.edu.cn|g' \
#      /etc/apt/sources.list.d/debian.sources

# ------------------------------------------------------------
# 2. 系统更新 + 常用构建工具 + 链接器（Rust crates 编译需要）
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
    # ---- 版本控制 / 构建工具（cargo build 需要 cc/ld/make） ----
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
    # ---- 常用 C 库（很多 Rust crate 需要，例如 openssl-sys / libsqlite3-sys） ----
    libssl-dev \
    libffi-dev \
    libxml2-dev \
    libxslt1-dev \
    libjpeg-dev \
    libpng-dev \
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
# 3. 安装 Rust（rustup 官方安装脚本，stable 工具链）
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
# 4. 配置 cargo 国内 crates.io 镜像（可选，按需注释）
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
# 5. 创建工作目录
# ------------------------------------------------------------
WORKDIR /app

# ------------------------------------------------------------
# 6. 验证 Rust 环境
# ------------------------------------------------------------
RUN rustc --version && \
    cargo --version && \
    rustup show && \
    # 验证中文支持：C.UTF-8 locale 已生成、Rust 标准输出编码为 utf-8
    locale -a | grep -iE 'C\.?utf-?8' && \
    # 验证 cargo 可正常拉取/编译一个最小 crate（离线环境下可注释掉这一行）
    echo "=== Build base image ready ===" && \
    echo "Rust:   $(rustc --version)" && \
    echo "Cargo:  $(cargo --version)" && \
    echo "Debian: $(cat /etc/debian_version)"

# 默认命令
CMD ["rustc", "--version"]
