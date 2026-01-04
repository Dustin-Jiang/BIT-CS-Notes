=== 输入不符合系统要求的数据

首先删除原有的表, 重建没有索引和主键外键约束的表. 根据系统设计要求, 向表中插入一些不符合要求的数据, 例如学生表中有重复的学号. 

```sql
INSERT INTO xs (xm, xh, ydh, bj, chrq, xb) VALUES ('吕十三', '20230111', '04', '机械工程', '2003-10-01', '女');
INSERT INTO xs (xm, xh, ydh, bj, chrq, xb) VALUES ('艾十四', '20230111', '04', '机械工程', '2003-10-08', '男');
```

执行SQL语句后, 由于我们的数据表中没有唯一约束等, 因此可以成功插入重复的学号. 

=== 建立存储过程查找和删除不合法的数据

为了删除不合法的数据, 我们可以创建一个存储过程, 该存储过程会删除所有重复的学号. 该存储过程的代码如下:

```sql
CREATE OR REPLACE PROCEDURE delete_duplicate() AS
BEGIN
  DELETE FROM xs WHERE xh IN (
    SELECT xh FROM xs GROUP BY xh HAVING COUNT(*) > 1
  );
END;
```

成功创建存储过程之后, 我们可以使用 ```sql CALL delete_duplicate();``` 来调用该存储过程, 删除所有重复的学号.

但是需要注意, 这一存储过程会删除所有重复的学号, 而不是只删除其中一个. 如果需要只保留一个, 最好在创建表时就添加唯一约束 `UNIQUE`. 

#figure(
  image("assets/procedure-delete-duplicate.png"),
  caption: "成功删除重复的学号"
)

=== 建立存储过程计算学生总学分总成绩，保存在另一张表中

通过关联以下三张表，获取计算所需的字段：

- `xk`（选课表）：核心表，包含学生的选课记录和成绩。
- `kc`（课程表）：提供课程对应的学分信息。
- `xs`（学生表）：提供学生的姓名信息。

通过 `INNER JOIN` 操作，按以下条件关联表：

- `xk.kcbh` = `kc.kcbh`：通过课程编号关联选课表和课程表，获取课程学分。
- `xk.xh` = `xs.xh`：通过学号关联选课表和学生表，确保每个成绩对应的学生姓名。

#linebreak()

- 总学分（`zxf`）：通过 SUM(kc.xf) 汇总学生所有课程的学分总和。
- 加权平均成绩（`zcj`）：

  1. 计算 加权总分：各课程成绩（`xk.cj`）× 对应学分（`kc.xf`）的总和。
  2. 除以总学分（`SUM(kc.xf)`）得到加权平均值。
  3. 通过 `NULLIF` 避免除以零错误（当总学分为0时返回 `NULL`）。
  4. 使用 `ROUND(..., 1)` 格式化结果，保留一位小数。


- 由于同一学号 xh 对应唯一姓名，但需满足数据库的聚合规则，使用 MAX(xs.xm) 从多个相同记录中选择姓名。



```sql
CREATE TABLE IF NOT EXISTS student_score(
    xh CHAR(10) NOT NULL PRIMARY KEY,
    xm CHAR(8) NOT NULL,
    zxf DECIMAL(5,1),
    zcj DECIMAL(5,1)
);

CREATE OR REPLACE PROCEDURE calc_total_score() AS
BEGIN
    -- 清空表格
    TRUNCATE TABLE student_score;

    INSERT INTO student_score (xm, xh, zxf, zcj)
    SELECT
        MAX(xs.xm) AS xm,
        xk.xh,
        SUM(kc.xf) AS zxf,
        ROUND(
            (SUM(xk.cj * kc.xf) / 
             NULLIF(SUM(kc.xf), 0::NUMERIC))
            , 1
        ) AS zcj
    FROM 
        xk
    INNER JOIN kc ON xk.kcbh = kc.kcbh
    INNER JOIN xs ON xk.xh = xs.xh
    WHERE
        xk.cj IS NOT NULL
    GROUP BY 
        xk.xh;
END;

-- 执行存储过程
CALL calc_total_score();
```

#figure(
  image("assets/procedure-run-success.png"),
  caption: "成功计算学生总学分和总成绩"
)

从结果中可以看到, 通过存储过程成功计算了学生的总学分和加权平均成绩, 并将结果存储在了 `student_score` 表中.

=== 查询总成绩表并进行排序

由于我们已经将学生的总学分和加权平均成绩 `student_score` 表, 因此可以直接使用 `SELECT` 语句查询该表. 通过 `ORDER BY` 子句对总学分和总成绩进行排序.

```sql
SELECT * FROM student_score ORDER BY zcj DESC;
```

#figure(
  image("assets/query-procedure-table.png"),
  caption: "查询总学分和总成绩表"
)

可以看到, 通过 `ORDER BY` 子句, 我们可以对总学分和总成绩进行排序. 通过 `DESC` 可以实现降序排列, 通过 `ASC` 可以实现升序排列.