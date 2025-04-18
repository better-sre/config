
# k3s 集群搭建

## k3d

- <https://www.xingdp.com/post/41.html>

## web ui

### k8m

- <https://github.com/weibaohui/k8m>
- 兼容 k3s

> web ui:

- <http://localhost:3618/#/user/cluster/cluster_user>

### kubernetes dashboard

- <https://github.com/kubernetes/dashboard>

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
