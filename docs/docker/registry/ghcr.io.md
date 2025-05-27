# Github Container Registry

- ghcr.io

## 官方文档

- <https://docs.github.com/zh/actions/use-cases-and-examples/publishing-packages/publishing-docker-images>
- [github - 自动令牌身份验证](https://docs.github.com/zh/actions/security-for-github-actions/security-guides/automatic-token-authentication)

## Mirrors

- [南京大学 镜像站](https://sci.nju.edu.cn/9e/05/c30384a564741/page.htm)

```ruby


docker pull ghcr.io/github/super-linter:latest

# use mirror
docker pull ghcr.nju.edu.cn/github/super-linter:latest


docker pull quay.io/prometheus/prometheus:latest

docker pull quay.nju.edu.cn/prometheus/prometheus:latest


# 重命名镜像为原镜像
docker tag ghcr.nju.edu.cn/github/super-linter:latest ghcr.io/github/super-linter:latest

# 删除镜像
docker rmi ghcr.nju.edu.cn/github/super-linter:latest

```

## 使用教程

- <https://www.chenshaowen.com/blog/github-container-registry.html>

> 镜像加速

- <https://blog.csdn.net/asdfaa/article/details/137845694>
