# Manual:

## Setup:

> 🍄 before use, please install [go-task](https://github.com/go-task/task).

- https://taskfile.dev/#/installation

```ruby

# macos:
brew install go-task/tap/go-task

# linux:
sudo snap install task --classic

# windows:
choco install go-task


# check: go-task version
task --version

```

> 🍄 then, clone the repo.

- There are `3 ways` to use it, just choose the way you like.

```ruby

# way1: flexible path (not your project path)
cd your-workspace/
git clone https://github.com/better-sre/config.git

# way2: global path
mkdir ~/.task/
cd ~/.task/
git clone https://github.com/better-sre/config.git


#
# recommended way:
#
# way3: local path(under your project)
cd your-project/
mkdir .task/
cd .task/
git clone https://github.com/better-sre/config.git



```

- 🍄 add these content to your `Taskfile.yml` file.

```yaml
includes:
  # way1: flexible path
  sre:
    taskfile: ~/your-real-path-to/better-sre/config/Taskfile.yml # TODO: please set your own path to the config dir
    dir: ~/your-real-path-to/better-sre/config # TODO: please set your own path to the config dir
    optional: true # safeguard, if not found, no error

  # way2: global path
  sre2:
    taskfile: ~/.task/config/Taskfile.yml # TODO: please create `~/.task/` first before use
    dir: ~/.task/config # global path
    optional: true # safeguard, if not found, no error

  # way3: local path(recommended)
  sre3:
    taskfile: ./.task/config/Taskfile.yml # TODO: under your project, please add `.task/` to your `.gitignore` file
    dir: ./.task/config # local path
    optional: true # safeguard, if not found, no error
```

> 🍄 usages: (with `go-task` + [Taskfile.yml](./Taskfile.yml))

- with `sre:` prefix, in your own project.

```ruby

#
# install rust/go/python/flutter: (support cross-platform installation)
#
task rust:install
task go:install
task python:install
task flutter:install

# for docker: check details in ./taskfile/Taskfile_infra_docker.yml
task docker:local:up:mysql
task docker:local:up:redis
task docker:local:up:rabitmq
task docker:local:up:kafka

# for git:
task git:push
task push  # auto push to github

```

> ❓ Note that when using in your project, you need to use the [sre:]() `prefix` to use the following scripts.
> like this:

```ruby

#
# with `sre` prefix:
#
task sre:rust:install
task sre:go:install

```

- 😄 enjoy!

## Contents:

- [docker-compose/local](docker-compose/local)
- [dockerfile](dockerfile)
- [Taskfile](taskfile)

> Attention:

- 重度使用 [go-task(Taskfile)](https://github.com/go-task/task) 替代 GNU Make(Makefile).
- 平台兼容性说明:
  - Mac: Mac First. 😄 因为我日常主要使用 Mac 开发, so 所有的配置脚本, 都保证在 Mac 下正常工作.
  - Linux: 理论上, 这些脚本都能在 Linux 上运行良好.
  - Windows: 可以参考脚本细节, 自行改写, 同时欢迎 PR 进来. 我会 merge 的.
- 部分脚本写了跨平台, 比较少, 如果有兴趣, 欢迎 PR 支持.
- Taskfile 原生支持跨平台, 改写起来也简单, 只是我没有太多精力, 照顾不到.😄

## Related:

- https://github.com/service-mesh/devops
