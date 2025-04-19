# k3d

- 快速创建 k3s 集群

## 使用教程

### 环境变量配置

- [K3d 命令补全](https://k3d.io/stable/usage/commands/k3d_completion/)

### 集群配置管理

- [K3d 获取 kubeconfig](https://k3d.io/stable/usage/commands/k3d_kubeconfig_get/)

### 启动集群

- [K3d 集群启动](https://k3d.io/stable/usage/commands/k3d_cluster_start/)

```ruby

# list
k3d cluster list


# run
k3d cluster start 
```

### 集群节点管理

- [K3d 节点](https://k3d.io/stable/usage/commands/k3d_node/)

```ruby
k3d node list

k3d node create

k3d node delete 

k3d node start 

k3d node stop

```

## Reference

- <https://k3d.io/stable/>
