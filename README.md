# config

- config files
- 各种常用脚本配置
- local: 本地开发机 配置初始化, 定制脚本
- deploy: server 部署的常用脚本


## Related:

- https://github.com/service-mesh/devops

## Attention:


- 重度使用 [go-task(Taskfile)](https://github.com/go-task/task) 替代 GNU Make(Makefile).
- 平台兼容性说明:
    - Mac: Mac First. 😄 因为我日常主要使用 Mac 开发, so 所有的配置脚本, 都保证在 Mac 下正常工作.
    - Linux: 理论上,  这些脚本都能在 Linux 上运行良好.
    - Windows: 可以参考脚本细节, 自行改写, 同时欢迎 PR 进来. 我会 merge 的.
- 部分脚本写了跨平台, 比较少, 如果有兴趣, 欢迎 PR 支持.
- Taskfile 原生支持跨平台, 改写起来也简单, 只是我没有太多精力, 照顾不到.😄


## QuickStart:

> requirements:

- https://taskfile.dev/#/installation

```ruby
# instasll:
brew install go-task/tap/go-task

# check: go-task version
task --version

```



### Taskfile:

- https://github.com/go-task/task
- 常用配置:
    - [Taskfile.yml](./Taskfile.yml)
    - [taskfile](./taskfile)


### Dockerfile:

- 待合并


### docker-compose:

- 待合并


### k8s:

- 待合并


### homebrew:

- 一些 install + config 脚本





