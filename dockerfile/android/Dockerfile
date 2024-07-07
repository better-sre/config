FROM ubuntu:22.04


# 维护者信息
LABEL maintainer="hhglory@outlook.com"

#
# TODO X: 有效设置 env:
#

# 设置时区
ENV TZ=Asia/Shanghai
ENV TIME_ZONE=Asia/Shanghai

# 设置环境变量，以避免在安装软件包时交互提示
ENV DEBIAN_FRONTEND=noninteractive

ENV PATH="/app/.venv/bin:~/.local/bin:$PATH"

# 设置环境变量
ENV ANDROID_HOME=/usr/local/android-sdk
ENV PATH=$PATH:$ANDROID_HOME/cmdline-tools/bin
ENV PATH=$PATH:$ANDROID_HOME/cmdline-tools/tools/bin


# 创建一个新用户（非 root 用户）
RUN useradd -m dev && echo "dev:dev" | chpasswd && adduser dev sudo


######################################################################################################
#  install Python & Tools:
######################################################################################################


# TODO X: install python3.10
RUN apt-get update && apt-get install -y python3 python3-pip curl

# TODO X: install pipx
RUN apt update && apt install -y tzdata pipx tini

# TODO X: fix env for pipx, pdm
RUN pipx ensurepath

# TODO X: install pdm
RUN pipx install pdm

# Install go-task
RUN sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b ~/.local/bin


# TODO X: 更新软件包列表并安装必要的软件包
RUN apt-get update && apt-get install -y \
    android-tools-adb \
    android-tools-fastboot \
    unzip \
    wget \
    curl \
    sudo \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# TODO X: 安装 Java JDK（如果需要与 Android SDK 一起使用）
RUN apt-get update && apt-get install -y openjdk-11-jdk && apt-get clean && rm -rf /var/lib/apt/lists/*


# TODO X: 下载并安装 Android SDK（如果需要完整的 Android 开发环境）
RUN wget -q https://dl.google.com/android/repository/commandlinetools-linux-7302050_latest.zip -O /tmp/cmdline-tools.zip && \
    mkdir -p /usr/local/android-sdk/cmdline-tools && \
    unzip /tmp/cmdline-tools.zip -d /usr/local/android-sdk/cmdline-tools && \
    rm /tmp/cmdline-tools.zip


######################################################################################################
# python src codes:
######################################################################################################

# TODO X: copy src codes
COPY . /app

######################################################################################################

# 切换到非 root 用户
USER dev

# 将 ADB 端口（默认 5037）暴露出来
EXPOSE 5037

# TODO X: set work dir
WORKDIR /app

# TODO X: Add entrypoint, required!!!
ENTRYPOINT ["tini", "--"]

# 启动 ADB 服务器
CMD ["adb", "-a", "nodaemon", "server"]

