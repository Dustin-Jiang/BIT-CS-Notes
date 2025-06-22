数据库运行时，某些操作在执行过程中可能会出现错误，数据库依然能够运行。但是此时数据库中的数据可能已经发生不一致的情况。建议检查 OpenGauss 运行日志，及时发现隐患。
当 OpenGauss 发生故障时，使用 `gs_collector` 此工具收集OS信息、日志信息以及配置文件等信息，来定位问题。

本次先手工设置收集配置信息，然后通过 `gs_collector` 工具调整用配置来收集相关日志信息。

登录到服务器后, 创建 `collector.json` 配置文件, 内容如下: 

```json
{
  "Collect": [
    { "TypeName": "System", "Content": "RunTimeInfo, HardWareInfo", "Interval": "0", "Count": "1" },
    { "TypeName": "Log", "Content": "Coordinator,DataNode,Gtm,ClusterManager", "Interval": "0", "Count": "1" },
    { "TypeName": "Database", "Content": "pg_locks,pg_stat_activity,pg_thread_wait_status", "Interval": "0", "Count": "1" },
    { "TypeName": "Config", "Content": "Coordinator,DataNode,Gtm", "Interval": "0", "Count": "1" }
  ]
}
```

然后执行 `gs_collector` 命令, 进行收集:
```bash
gs_collector --begin-time="20250407 23:00" --end-time="20250408 12:00"  -C /home/omm/collector.json
```

#figure(
  image("assets/collect-journal.png", height: 40%),
  caption: "收集日志信息",
)

可以看见日志被导出到了 `/opt/huawei/wisequery/omm_mppdb/` 目录下的压缩文件中. 为方便查看, 可通过 `scp` 命令将其复制到本地. 

```bash
scp root@116.205.110.253:/opt/huawei/wisequery/omm_mppdb/collector_20250408_121118.tar.gz ~/Downloads
```

解压日志文件后, 目录结构如下: 

```
COLLECTOR_20250408_121118
│   Detail.log
│   Summary.log
│
└───ecs-6e39
    ├───catalogfiles
    │       dn_6001_pg_locks_20250408_121120632991.csv
    │       dn_6001_pg_stat_activity_20250408_121120831763.csv
    │       dn_6001_pg_thread_wait_status_20250408_121121030174.csv
    │       gs_clean_20250408_121121235082.txt
    │
    ├───configfiles
    │   └───config_20250408_121122396664
    │       └───dn_6001
    │           │   gaussdb.state
    │           │   pg_control
    │           │   pg_hba.conf
    │           │   pg_ident.conf
    │           │   postgresql.conf
    │           │
    │           └───pg_replslot
    ├───coreDumpfiles
    ├───gstackfiles
    ├───logfiles
    │       log_20250408_121121810369.tar.gz
    │
    ├───planSimulatorfiles
    ├───systemfiles
    │       database_system_info_20250408_121118913879.txt
    │       OS_information_20250408_121118891142.txt
    │
    └───xlogfiles
```

根据需要, 可以查看 `catalogfiles` 目录下的各个 `csv` 文件, 其中包含了锁信息、活动会话信息、线程等待状态等信息. 也可以查看 `logfiles` 目录下的日志文件, 其中包含了数据库的运行日志.
