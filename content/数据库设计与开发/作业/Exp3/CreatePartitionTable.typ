分区表是指将一个大表按照某种规则分解成多个更小的、更容易管理的部分。每个部分称为一个分区，从逻辑上看是一个完整的表，但物理上这些数据分布在不同的表空间中。

分区表的优势包括：

- *提升查询性能*：通过分区消除，可以只扫描必要的分区，减少数据扫描量
- *更易维护*：可以独立管理各个分区，便于数据的备份和恢复
- *改善可用性*：分区故障只影响单个分区，不影响整个表的使用
- *均衡I/O*：数据分散存储，可以降低I/O争用

常见分区方式有：

1. *范围分区*：根据分区键的值范围将数据分配到不同分区
2. *列表分区*：根据分区键的离散值列表进行分区
3. *哈希分区*：使用哈希函数将数据均匀分布到各个分区
4. *复合分区*：组合使用多种分区方式

本次实验中, 我们将按和之前一样的格式创建 `xs` 表, 但按学生的入学年份进行范围分区。例如学生的学号为 `20230101`，则其入学年份为 `2023`。

#figure(
  table(
    columns: (auto, auto, auto, auto, auto, auto),
    align: center,
    [字段名], [字段含义], [字段类型], [字段长度], [NULL], [备注],
    [xm], [姓名], [字符], [8], [], [],
    [xh], [学号], [字符], [10], [], [PK],
    [ydh], [所属学院代号], [字符], [2], [#sym.checkmark], [FK],
    [bj], [班级], [字符], [8], [#sym.checkmark], [],
    [chrq], [出生日期], [日期], [], [#sym.checkmark], [],
    [xb], [性别], [字符], [2], [#sym.checkmark], [],
  ),
  caption: "学生表设计",
)

为防止与之前的学生管理系统冲突, 我们将创建一个新的 Schema `partition_test`，并在其中创建分区表。

```sql
CREATE SCHEMA IF NOT EXISTS partition_test;
CREATE TABLE IF NOT EXISTS partition_test.xs (
  xm VARCHAR(8) NOT NULL,
  xh VARCHAR(10) NOT NULL PRIMARY KEY,
  ydh CHAR(2) NOT NULL,
  bj VARCHAR(8) NULL,
  chrq DATE NULL,
  xb CHAR(2) NULL
) PARTITION BY RANGE (xh) (
  PARTITION p_old VALUES LESS THAN ('20200000'),
  PARTITION p_2020 VALUES LESS THAN ('20210000'),
  PARTITION p_2021 VALUES LESS THAN ('20220000'),
  PARTITION p_2022 VALUES LESS THAN ('20230000'),
  PARTITION p_2023 VALUES LESS THAN ('20240000'),
  PARTITION p_2024 VALUES LESS THAN ('20250000')
);
```

#figure(
  image("assets/create-partition-table.png"),
  caption: "在Cloudbeaver中连接数据库并创建Schema与分区表",
)

创建成功之后, 向 `xs` 表中插入数据。

```sql
INSERT INTO partition_test.xs (xm, xh, ydh, bj, chrq, xb) VALUES
('张三', '20230101', '01', '软件工程', '2003-01-01', '男'),
('李四', '20220102', '02', '计算机科学', '2002-02-02', '女'),
('王五', '20210103', '03', '网络工程', '2001-03-03', '男'),
('赵六', '20200104', '04', '信息管理', '2000-04-04', '女');
```

在 Data Studio 左侧的树形结构中, 可以看到 `partition_test` Schema 下的 `xs` 表已经有了六个分区。查看分区中的数据, 可以看到数据的储存符合我们的设计预期, 入学年份为 2023 年的学生 *张三* 被储存在了 `p_2023` 分区中. 

#figure(
  image("assets/select-partition.png"),
  caption: "在Data Studio中查看分区表",
)