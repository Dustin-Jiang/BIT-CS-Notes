#let show-mainbody(body) = {
  set text(font: ("IBM Plex Sans", "Source Han Sans"), hyphenate: false)

  set par(
    leading: 1.15em,
    first-line-indent: (
      amount: 2em,
      all: true,
    ),
    justify: true,
  )

  show heading.where(level: 2): it => {
    set block(
      above: 1.5em,
      below: 1em,
    )
    it
  }

  body
}

#show: show-mainbody;

= 数据库设计与开发 作业一加分申请

#block(
  table(
    columns: (1fr, 1fr, 1fr),
    stroke: none,
    [08012301], [蒋浩天], [1120231337],
  ),
  width: 60%,
)

== 容器化安装和版本更换

由于 OpenGauss 的部分维护功能只在 *企业版* 中可用，因此在轻量版中无法完成本次作业的部分内容. 因此, 为完成本次作业, 需要将 OpenGauss 切换到企业版. 

由于先前使用 Docker 和 Docker Compose 进行安装, 相比于传统的物理机安装方式具有以下创新点:

=== 环境隔离与版本切换便利性
- Docker 容器提供了独立的运行环境, 避免了不同版本 OpenGauss 之间的冲突
- 通过修改 `docker-compose.yml` 即可快速切换企业版和轻量版
- 容器的启动和停止更加便捷, 无需考虑复杂的服务管理

=== 配置标准化与可复用性
- 将数据库配置编写为 Docker Compose 文件, 实现了配置的版本控制
- 可以快速在不同环境中复现相同的数据库配置
- 降低了环境依赖和版本管理的复杂度

=== 资源利用效率
- 容器化部署占用系统资源更少
- 可以在同一台机器上并行运行多个 OpenGauss 实例
- 快速环境清理, 避免残留配置文件

#linebreak()

== 日常数据库维护

良好的数据库维护对于数据库的正常运行至关重要. 虽然本次作业并未要求此部分内容, 但通过主动研究和实践, 从以下几个方面体现了创新性:

- 通过 `pg_stat_activity` 视图监控数据库活动连接状况
- 使用 `ANALYZE` 命令及时更新统计信息以优化查询性能
- 定期使用 `VACUUM` 命令回收无用空间, 减少表膨胀
- 通过 `REINDEX` 命令维护索引以提升查询效率
