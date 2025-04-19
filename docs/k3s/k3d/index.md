# k3d

## 集群管理

### 创建集群

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
