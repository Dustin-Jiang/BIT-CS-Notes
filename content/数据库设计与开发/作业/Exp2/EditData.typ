=== 更新部分学生的学籍情况或成绩

使用 SQL 语句中的 `UPDATE` 语句更新学生的学籍情况或成绩。可以使用 `SET` 语句设置要更新的字段和新值。可以使用 `WHERE` 子句指定要更新的记录。

例如, 将学号为 `20230102` 的学生的专业更新为 `计算机科学与技术`，将学号为 `20230104` 的学生 `006` 课程的成绩更新为 `90.0`。

```sql
UPDATE xs SET zy = '计算机科学与技术' WHERE xh = '20230102'; -- 更新学号为 20230102 的学生的专业
UPDATE xk SET cj = 90.0 WHERE xh = '20230104' AND kcbh = '006'; -- 更新学号为 20230104 的学生的 006 课程的成绩
```

#figure(
  image("assets/update-data.png"),
  caption: "更新部分学生的学籍情况或成绩",
)

=== 删除部分同学的学籍信息

使用 SQL 语句中的 `DELETE` 语句删除学生的学籍信息。可以使用 `WHERE` 子句指定要删除的记录。

例如, 删除学号为 `20230103` 的学生的学籍信息, 需要分两步操作，以避免违反数据库的外键约束（例如 `xk` 表中的外键引用 `xs.xh`）。

```sql
-- 删除选课记录
DELETE FROM xk
WHERE xh = '20230105';

-- 删除学生基本信息
DELETE FROM xs
WHERE xh = '20230105';
```

#figure(
  image("assets/delete-data.png"),
  caption: "删除部分同学的学籍信息",
)