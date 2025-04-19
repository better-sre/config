# Podman

## 说明

- 替代 Docker

## 配置

```ruby

sudo ln -s /run/podman/podman.sock /var/run/docker.sock

# or install your system podman-docker if available
sudo k3d cluster create


```

## Reference

- [k3d - 使用 Podman 代替 Docker](https://k3d.io/stable/usage/advanced/podman/)
