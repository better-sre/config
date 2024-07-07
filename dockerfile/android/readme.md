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


# 本地 Mac 安装版本对比:
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

