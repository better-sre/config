# config

- Contains a large number of installation/deployment scripts that developers need to use in their daily work, and automatically supports cross-platform installation.
- Thanks to the [go-task](https://github.com/go-task/task) project.

> Related:

- https://github.com/service-mesh/devops

## Usage:

> 🍄 before use, please install [go-task](https://github.com/go-task/task).

- https://taskfile.dev/#/installation

```ruby
# instasll:
brew install go-task/tap/go-task

# check: go-task version
task --version

```

> 🍄 then, clone the repo.


```ruby 

git clone https://github.com/better-sre/config.git 


```

- 🍄 add these content to your `Taskfile.yml` file.

```yaml

includes:
  std:
    taskfile: ~/your-real-path-to/better-sre/config/Taskfile.yml # TODO: please set your own path to the config dir
    dir: ~/your-real-path-to/better-sre/config  # TODO: please set your own path to the config dir
    optional: true  # safeguard, if not found, no error

```



> 🍄 usages: (with `go-task` + [Taskfile.yml](./Taskfile.yml))

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







