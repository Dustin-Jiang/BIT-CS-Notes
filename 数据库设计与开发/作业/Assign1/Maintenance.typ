=== 通过 `pg_stat_activity` 检查活动连接

在 OpenGauss 中，可以使用 `pg_stat_activity` 视图来检查当前活动的连接。以下命令查看当前所有活动连接的信息：

```sql
SELECT * FROM pg_stat_activity;
```

#figure(
  image("assets/check-activity.png"),
  caption: "通过 pg_stat_activity 查看活动连接"
)

=== 通过 `ANALYZE` 维护统计信息

在 OpenGauss 中，可以使用 `ANALYZE` 命令来更新表的统计信息，以帮助查询优化器选择最佳的执行计划。以下命令对 `xs` 表进行统计信息更新：

```sql
VACUUM ANALYZE verbose xs;
```

由于优化器依赖统计信息生成最佳执行计划, 因此在数据发生大量变化时, 需要更新统计信息, 以确保查询性能。

=== 通过 `VACUUM` 进行表维护

数据库中, 默认情况下已被删除或已被覆盖的行仍然会占用储存空间以备事务回滚或数据库闪回. 但在长期大量的删改操作后, 数据库中会存有大量无用过时数据. 这时可以使用 `VACUUM` 命令来回收已删除或更新的行占用的空间，减少表膨胀。

例如, 假设 `xs` 表中有大量的删除和更新操作，可以使用以下命令来回收空间：

```sql
VACUUM xs;
```

=== 使用 `REINDEX` 维护更新索引

在数据表发生大量的增改后, 可能会导致索引失效或性能下降。可以使用 `REINDEX` 命令来重建索引，以提高查询性能。
例如, 假设 `xs` 表的索引 `idx_xs_pkey` 需要重建，可以使用以下命令：

```sql
REINDEX INDEX idx_xs_pkey;
-- 或者重建整个表的索引：
REINDEX TABLE xs;
```

在大量数据删除或索引膨胀后执行 `REINDEX`, 可以有效地减少索引的大小和提高查询性能。