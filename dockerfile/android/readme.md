# Android Docker 开发环境搭建

- 基于 Ubuntu 22.04 LTS 版本

## Android + Ubuntu + Python

- android tool 调试环境
- https://developer.android.com/tools/releases/platform-tools?hl=zh-cn#downloads.html
- https://developer.android.com/tools?hl=zh-cn#tools-platform
- https://developer.android.com/tools/sdkmanager?hl=zh-cn

### 安装列表:

> android 开发环境:

- `Java JDK 11`
- `Android SDK Platform-Tools`
- `Android SDK Build-Tools`
- `Android SDK Platform`
- `Android SDK Tools`
- `Android Emulator`
- `Android Support Repository`

```ruby

# docker 容器安装版本:
dev@c0d77efbced9:~$ adb --version
Android Debug Bridge version 1.0.41
Version 28.0.2-debian  # 此版本低了, 需要安装 35 版本, 已经修复为最新版下载链接
Installed as /usr/lib/android-sdk/platform-tools/adb


# docker 容器安装版本:(修复 $PATH, 正确的版本号: v35)
dev@e78bf036eb60:/app$ adb version
Android Debug Bridge version 1.0.41
Version 35.0.1-11580240
Installed as /usr/local/android-sdk/platform-tools/adb
Running on Linux 6.5.13-orbstack-00116-gb64875927ef8 (x86_64)


# 本地 M1 Mac 安装版本对比:
❯ adb --version
Android Debug Bridge version 1.0.41
Version 35.0.1-11580240
Installed as /Users/dev/Library/Android/sdk/platform-tools/adb
Running on Darwin 21.6.0 (arm64)


```



> python 开发环境:

- `Python3.10`
- `pip3`
- `pdm`: 支持 `.venv` 创建不同版本的 python 环境


### 使用方式:

- 配对:

```ruby

# 容器内版本:
dev@e78bf036eb60:/app$ uname -a
Linux e78bf036eb60 6.5.13-orbstack-00116-gb64875927ef8 #1 SMP Wed Dec  6 22:19:46 UTC 2023 x86_64 x86_64 x86_64 GNU/Linux


# 配对手机:
dev@e78bf036eb60:/app$ adb pair 10.211.1.129:42641
Enter pairing code: 322393
Successfully paired to 10.211.1.129:42641 [guid=adb-ab3015d3-d2orWm]
dev@e78bf036eb60:/app$ 


# 连接手机:
dev@e78bf036eb60:/app$ adb connect 10.211.1.129:42119
connected to 10.211.1.129:42119


# 进入手机 shell:
dev@e78bf036eb60:/app$ adb shell
alioth:/ $                                                                                                                                                                                                 
alioth:/ $ 
alioth:/ $ uname -a
Linux localhost 4.19.157-perf-g92c089fc2d37 #1 SMP PREEMPT Wed Jun 5 13:27:08 UTC 2024 aarch64 Toybox

# 查看手机安装的应用:
alioth:/ $ pm list packages -3   
```



## FAQ:

### M1 Mac 运行报错问题:

- `CPU` 架构问题: `m1 arm64` vs `x86_64`
- 需要构建 `amd64` 版本的镜像: `docker buildx build --platform linux/amd64 --load`
- dockerfile 内指定 `platform` 版本: `FROM --platform=linux/amd64 ubuntu:20.04`