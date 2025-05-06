# k3s Cluster 管理

## 创建集群

```ruby title="创建集群 Taskfile.yml" linenums="1" hl_lines="7 9"

tasks:
  #
  #负载均衡的正确配置过程:
  #
  create:cluster:
    cmds:
      - k3d cluster create --api-port 6550 -p "8081:80@loadbalancer" --agents 2 k3d-test
      - k3d cluster list
      - kubectl --cluster k3d-k3d-test get nodes,svc,ing,pod

```

- 创建2:

```ruby

sudo k3d cluster create hello-k3d \
    --api-port 6550 \
    -p "9080:80@loadbalancer" -p "9443:443@loadbalancer" \
    --servers-memory 4g \
    --agents-memory 4g \
    --servers 1 \
    --agents 2 


```

## 删除集群

```ruby

sudo k3d cluster delete hello-k3d
```

## Reference

- [k3d - 3分钟创建一个生产级k8s集群](https://coding.gs/2024/04/03/k3d/getting-started-with-k3d/)
