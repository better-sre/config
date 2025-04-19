# Grafana + Loki

## 方案

- ✅ ALG = [Alloy](https://github.com/grafana/alloy) + [Grafana](https://github.com/grafana/grafana) + [Loki](https://github.com/grafana/loki)

- `Promtail` 现已弃用，并将于 2025 年 2 月 13 日进入长期支持 (LTS) 阶段。
- 所有未来功能的开发都将在 Grafana Alloy 中进行。
- 如果您目前正在使用 Promtail，则应该计划迁移到 Alloy。
- Alloy 迁移文档中包含一个迁移工具，可使用单个命令将 Promtail 配置转换为 Alloy 配置。

## Alloy

- ✅ [alloy](https://github.com/grafana/alloy)
- alloy + loki + grafana

## Fluentbit

- fluentbit + loki + grafana
- ✅ [fluentbit](https://github.com/fluent/fluent-bit)
- <https://grafana.com/docs/loki/latest/send-data/fluentbit/>

## Reference

- ✅ [loki](https://github.com/grafana/loki)
- ✅ [grafana](https://grafana.com/)
- ✅ [alloy](https://github.com/grafana/alloy)
- ✅  [Promtail](https://grafana.com/docs/loki/latest/send-data/promtail/)
  - 官方已经弃用, 请迁移到 alloy.

> 教程:

- ✅ [Promtail+Loki+Grafana搭建轻量级日志管理平台](https://www.cnblogs.com/cao-lei/p/16848665.html)
