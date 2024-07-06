# config

[简体中文](./README_CN.md) | [English](./README.md)

## 说明:

- Contains a large number of `installation/deployment` scripts that developers need to use in their daily work.
- Automatically supports `cross-platform` installation.
- Thanks to the [go-task + Taskfile](https://github.com/go-task/task) project.

> included:

- `docker-compose`
- `dockerfile`
- `Taskfile`

## Docker + Dockerfile:


### Python

- [dockerfile/python](dockerfile/python)


```ruby

# build ubuntu + python:3.12
task df:py:b312

# test container:
task df:py:t312

```

