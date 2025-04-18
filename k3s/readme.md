
# k3s 集群搭建

## k3d

- <https://www.xingdp.com/post/41.html>

## 公开暴露内部服务

- <https://k3d.io/stable/usage/exposing_services/>
- ✅ 基于 Ingress 公开暴露服务
- ✅ 示例是nginx服务, <http://localhost:8081>

## web ui

### kubesphere

- ✅ <https://github.com/kubesphere/kubesphere>
- ✅ 完成度最高

> web ui:

- <http://localhost:6002/clusters/host/overview>

### k8m

- <https://github.com/weibaohui/k8m>
- ✅ 兼容 k3s, 完成度比较高

> web ui:

- <http://localhost:3618/#/user/cluster/cluster_user>

### kubernetes dashboard

- <https://github.com/kubernetes/dashboard>
- ❎ 和 k3s 配合使用, 有 bug, 无法创建 token, 始终报错!!!

```ruby

# Add kubernetes-dashboard repository
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/


# Deploy a Helm Release named "kubernetes-dashboard" using the kubernetes-dashboard chart
helm upgrade --install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard


```

- 端口映射:

```ruby

kubectl -n kubernetes-dashboard port-forward svc/kubernetes-dashboard-kong-proxy 8443:443


# 访问
https://localhost:8443


kubectl proxy --port=8001


```

## References

- <https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md>
- <https://docs.rancher.cn/docs/k3s/installation/kube-dashboard/_index/>
- <https://github.com/opsre/awesome-ops#K8S-Cluster-Manage>

> 负载均衡器

- <https://openelb.io/docs/getting-started/>
