# Calico

## Features

- 数据平面选择：eBPF、标准 Linux、Windows 和 VPP——网络解决方案的多功能性。
- go 实现

## Reference

- <https://github.com/projectcalico/calico>

> docs

- [k3d - 使用 Calico 代替 Flannel](https://k3d.io/stable/usage/advanced/calico/)

```ruby
k3d cluster create "${clustername}" \
  --k3s-arg '--flannel-backend=none@server:*' \
  --k3s-arg '--disable-network-policy@server:*' \
  --k3s-arg '--cluster-cidr=192.168.0.0/16@server:*'
```
