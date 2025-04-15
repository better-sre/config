# config

[简体中文](./README_CN.md) | [English](./README.md)

- Contains a large number of `installation/deployment` scripts that developers need to use in their daily work.
- Automatically supports `cross-platform` installation.
- Thanks to the [go-task](https://github.com/go-task/task) project.

> included:

- `docker-compose`
- `dockerfile`
- `Taskfile`

## How to use

### way1: by `git clone`

- `git clone`, with `--depth=1`: 只克隆最新的一个 commit

```ruby

# run:
task dl

# or
tasks:
  dl:
    cmds:
      - mkdir -p .task/
      - |
        git clone --depth=1 \
          https://github.com/better-sre/config.git \
          ./.task/sre
    ignore_error: true

```

- add to your `Taskfile.yml`:

```yml
includes:
  x:
    taskfile: .task/sre/ # by git clone
    dir: .
    optional: true


```

### way2: by `rsync`

- `rsync` mirror

```ruby
# run
task rsync

# or
tasks:
  # by rsync
  rsync:
    aliases: ["mirror", "mr"]
    cmds:
      - mkdir -p .task/
      - |
        rsync \
          --exclude=".git" \
          --exclude=".task" \
          --exclude=".github" \
          --exclude=".vscode" \
          --exclude="tmp" \
          --exclude="./*.*" \
          --include="Taskfile.yml" \
          -av \
          --delete \
          . ./.task/config  # TODO: please set your own source path to the config dir!!!
    dir: .


```

- add to your `Taskfile.yml`:

```yml
includes:
  x:
    taskfile: .task/config/ # by rsync
    dir: .
    optional: true

```

## Manual

- ✅ [Manual](./manual.md)

## Contents

### Docker-compose

- ✅ [docker-compose/local](docker-compose/local)

### Docker + Dockerfile

- ✅ [Dockerfile](./dockerfile)

#### Python + Ubuntu + Dockerfile

- ✅ [dockerfile/python](dockerfile/python)

```ruby

# build ubuntu + python:3.12
task df:py:b312

# test container:
task df:py:t312

```
