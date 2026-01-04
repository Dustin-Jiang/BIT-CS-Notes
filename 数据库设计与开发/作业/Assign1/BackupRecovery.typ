== 物理备份

要进行物理备份, 需要先创建一个备份文件夹, 假设为 `~/physicalBackup`。然后, 使用 `gs_basebackup` 命令进行备份。

```bash
gs_basebackup -D /home/omm/physicalBackup -p 5432
```

运行命令之后, 等待执行完毕. 备份完成后, 可以在 `~/physicalBackup` 目录下找到备份文件. 

#figure(
  image("assets/physical-backup.png", height: 40%),
  caption: "对数据库成功进行物理备份"
)

== 物理恢复

当数据库发生故障时, 可以从备份文件进行恢复. 由于 `gs_basebackup` 命令是对数据库按二进制进行备份，因此恢复时可以直接拷贝替换原有的文件，或者直接在备份的库上启动数据库. 

为防止数据库运行时对文件加锁, 需要先停止数据库, 再进行备份数据的替换. 

```bash
# 停止数据库
gs_ctl stop

# 删除损坏数据
rm -rf /var/lib/opengauss/data/*

# 备份数据替换
cp -r ~/physicalBackup/* /var/lib/opengauss/data

# 启动数据库
gs_ctl start
```

这样进行物理恢复后, 数据应会恢复到备份时的状态.

== 逻辑备份

=== 使用 `gs_dump` 对指定数据库进行逻辑备份

逻辑备份是通过导出数据库对象定义和内容的方式进行数据备份。与物理备份相比，逻辑备份具有以下特点：

1. *时间点一致性*：逻辑备份只能保存备份时刻的数据状态，无法记录故障点和备份点之间的变更。

2. *适用场景*：最适合备份相对静态的数据。当数据因误操作被破坏时，可以通过逻辑备份快速恢复特定对象。

3. *恢复限制*：进行全库恢复时，通常需要重建数据库实例并导入备份数据。对于高可用性要求的生产环境，由于恢复时间较长，不建议作为主要恢复方案。

4. *平台兼容性*：由于逻辑备份是以 SQL 或特定格式文本形式存储，具有良好的平台兼容性，常用于数据库迁移和跨平台部署。

#linebreak()

在 OpenGauss 中, 可以使用 `gs_dump` 工具进行逻辑备份. `gs_dump` 工具支持多种格式的备份, 具体格式如下:

#table(
  columns: (1fr, 0.5fr, 2fr, 1fr, 1.5fr),
  align: horizon,

  [*格式名称*], [*-F 的参数数值*], [*说明*], [*建议*], [*对应导入工具*],
  [*纯文本格式*], [p], [纯文本脚本文件包含 SQL 语句和命令。命令可以由 `gsql` 命令行终端程序执行，用于重新创建数据库对象并加载表数据。], [小型数据库，一般推荐纯文本格式。], [使用 `gsql` 工具恢复数据库对象前，可根据需要使用文本编辑器编辑纯文本导出文件。],
  [*自定义归档格式*], [c], [一种二进制文件。支持从导出文件中恢复所有或所选数据库对象。], [中型或大型数据库，推荐自定义归档格式。], [],
  [*目录归档格式*], [d], [该格式会创建一个目录，该目录包含两类文件，一类是目录文件，另一类是每个表和 `blob` 对象对应的数据文件。], [无], [使用 `gs_restore` 可以选择要从自定义归档导出文件中导入相应的数据库对象。],
  [*`tar` 归档格式*], [t], [`tar` 归档文件支持从导出文件中恢复所有或所选数据库对象。`tar` 归档格式不支持压缩且对于单独表大小应小于 8GB。], [无], [],
)

要对数据库进行逻辑备份, 需要先创建一个备份文件夹, 假设为 `~/logicalBackup`。然后, 使用 `gs_dump` 命令进行备份. 由于数据库较小, 这里我们使用纯文本格式进行备份.

```bash
gs_dump -f /home/omm/logicalBackup/backup.sql -p 5432 postgres -F p
```

#figure(
  image("assets/logical-backup.png", height: 40%),
  caption: "对数据库成功进行逻辑备份"
)

可以看到, 由于我们在进行逻辑备份时指定了备份格式为 `p`, 即纯文本格式进行逻辑备份, 因此备份文件的后缀名为 `.sql`, 其中储存着用于重建数据库的全部 SQL 语句.

=== 使用 `gs_dumpall` 对所有数据库进行逻辑备份

`gs_dumpall` 可以导出 Open Gauss 数据库的所有数据，包括默认数据库 `postgres` 的数据、自定义数据库的数据、以及 Open Gauss 所有数据库公共的全局对象。

在导出时分为两部分：
-	对所有数据库公共的全局对象进行导出，包括有关数据库用户和组，表空间以及属性（例如，适用于数据库整体的访问权限）信息。
-	调用 `gs_dump` 来完成各数据库的SQL脚本文件导出，该脚本文件包含将数据库恢复为其保存时的状态所需要的全部SQL语句。

```bash
gs_dumpall -f /home/omm/logicalBackup/backupAll.sql -p 5432
```

#figure(
  image("assets/logical-backup-all.png", height: 40%),
  caption: "对所有数据库成功进行逻辑备份"
)

== 逻辑恢复

在通过 `gs_dump` 进行逻辑备份后, 可以使用 `gs_restore` 命令进行逻辑恢复. `gs_restore` 命令可以从 `gs_dump` 生成的转储文件中恢复数据库对象和数据. 

需要注意的是, 恢复数据时为防止数据的覆盖或是对象冲突, 需要先创建一个新的数据库, 然后再进行数据的恢复.

例如, 将 `backup.sql` 文件中的数据恢复到 `recovery` 数据库中, 先需要创建一个新的数据库 `recovery`:

```sql
DROP DATABASE IF EXISTS recovery;
CREATE DATABASE recovery;
```

创建完成后, 连接到 `recovery` 数据库, 然后使用 `\i` 命令读取 SQL 文件进行数据恢复:

```
gsql -d recovery
\i /home/omm/logicalBackup/backup.sql
```

#figure(
  image("assets/logical-recovery.png", height: 40%),
  caption: "对数据库成功进行逻辑恢复"
)

需要注意的是, 由 `gs_dump` 生成的转储文件不包含优化程序用来做执行计划决定的统计数据. 因此, 最好从某转储文件恢复之后运行 `ANALYZE` 以确保最佳效果. 转储文件不包含任何 `ALTER DATABASE ... SET` 命令, 这些设置由 `gs_dumpall` 转储. 