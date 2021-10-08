# Traefik

> 反向代理负载均衡

官方文档, [https://traefik.io](https://traefik.io/)

## 快速开始

可以参考 [exchange-proxy](https://github.com/btcccorp/exchange-proxy/blob/master/docker-compose-traefik.yml) 的配置

### 核心配置

`network` 需要和本服务中的 network 是同一个, 使用 `docker network ls` 查看当前网络

```yml
  labels:
    - "traefik.backend=exchange-proxy"
    - "traefik.frontend.rule=Host:wstest83.btckk.com"
    - "traefik.port=9393"
```

端口不能 expose 因为 `scale` 时会端口冲突, 应在 `traefik.port` 设置, `traefik.frontend.rule` 为分配的域名, `traefik.backend` 为服务名称. 更多配置请参考官方文档.

### 启动服务

```sh
# scale exchange-proxy 服务为两个实例
$ docker-compose -f docker-compose-traefik.yml up --scale exchange-proxy=2 -d
```
