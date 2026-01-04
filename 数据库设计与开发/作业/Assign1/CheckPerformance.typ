登录到服务器之后, 使用 `gs_checkperf` 命令检查性能, 该命令会检查数据库的性能, 包括内存使用情况、IO使用情况、CPU使用情况等。

#figure(
  image("assets/checkperf.png", height: 35%),
  caption: "性能检查",
)

`gs_checkperf` 工具的监控信息依赖于 PMK 模式下的表的数据，如果 PMK 模式下的表未执行 `ANALYZE` 操作，则可能导致gs_checkperf工具执行失败。

连接到数据库之后, 使用 `ANALYZE` 命令收集性能统计信息. 

```sql
ANALYZE pmk.pmk_configuration; 
ANALYZE pmk.pmk_meta_data;
ANALYZE pmk.pmk_snapshot;
ANALYZE pmk.pmk_snapshot_datanode_stat;
```

执行完成后, 断开数据库连接, 使用 `gs_checkperf` 命令检查性能. 如果需要详细性能信息, 使用 `gs_checkperf --detail` 命令.

#figure(
  image("assets/analyze-checkperf.png", height: 35%),
  caption: "性能检查详细信息",
)

得到的具体性能信息如下:

#raw(
  read("assets/checkperf-detail.log"),
  block: true,
)
