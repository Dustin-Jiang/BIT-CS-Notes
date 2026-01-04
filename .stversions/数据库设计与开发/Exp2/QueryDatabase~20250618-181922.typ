=== 使用 ```sql SELECT * FROM ...``` 语句查询数据

使用Data Studio连接到数据库后, 编写SQL语句查询数据. 例如, 查询所有学生信息, 查询所有教师信息, 查询所有课程信息, 查询所有选课信息等. 具体的SQL语句如下

```sql
-- 查询所有学生信息
SELECT * FROM xs;
-- 查询所有教师信息
SELECT * FROM js;
-- 查询所有课程信息
SELECT * FROM kc;
-- 查询所有选课信息
SELECT * FROM xk;
```

#figure(
    image("assets/datastudio-query.png", height: 40%),
    caption: "使用 Data Studio 查询数据",
)


此外, 还可以使用 Data Studio 界面化查询数据. 在左侧的数据库树中, 右键点击表格, 选择“查看数据”, 即可查询表中数据.

#figure(
    image("assets/datastudio-select-gui.png", height: 40%),
    caption: "使用 Data Studio 图形界面查询数据",
)

=== 自拟题目对表格进行查询

==== 查询所有学生的学分

通过学生表与选课表关联，再通过选课表与课程表关联。使用 ```sql SUM(kc.xf)``` 对每个学生的课程学分求和。使用 ```sql LEFT JOIN``` 和 ```sql COALESCE()``` 确保即使学生未选课，也能显示总学分为 0。

```sql
SELECT 
    xs.xh AS 学号,
    xs.xm AS 姓名,
    COALESCE(SUM(kc.xf), 0) AS 总学分
FROM 
    xs
LEFT JOIN 
    xk ON xs.xh = xk.xh
LEFT JOIN 
    kc ON xk.kcbh = kc.kcbh
GROUP BY 
    xs.xh, xs.xm
ORDER BY 
    xs.xh;  -- 按学号排序
```

#figure(
  image("assets/student-point-sum.png"),
  caption: "查询每个学生的总学分",
)

==== 查询每个学生的平均分

通过学生表与选课表关联，再通过选课表与课程表关联。使用 ```sql AVG(xk.cj)``` 对每个学生的课程成绩求平均。使用 ```sql LEFT JOIN``` 和 ```sql COALESCE()``` 确保即使学生未选课，也能显示平均分为 0。

```sql
SELECT 
    xs.xh AS 学号,
    xs.xm AS 姓名,
    COALESCE(AVG(xk.cj), 0) AS 平均分
FROM 
    xs
LEFT JOIN 
    xk ON xs.xh = xk.xh
GROUP BY 
    xs.xh, xs.xm
ORDER BY 
    xs.xh;  -- 按学号排序
```

#figure(
  image("assets/student-score-avg.png"),
  caption: "查询每个学生的平均分",
)

==== 将学生按照选课数量降序排序

通过学生表与选课表关联。使用 ```sql COUNT(xk.kcbh)``` 统计每个学生的选课数量。使用 ```sql LEFT JOIN``` 和 ```sql COALESCE()``` 确保即使学生未选课，也能显示选课数量为 0。

```sql
SELECT 
    xs.xh AS 学号,
    xs.xm AS 姓名,
    COALESCE(COUNT(xk.kcbh), 0) AS 选课数量
FROM
    xs
LEFT JOIN
    xk ON xs.xh = xk.xh
LEFT JOIN
    kc ON xk.kcbh = kc.kcbh
GROUP BY
    xs.xh, xs.xm
ORDER BY
    COUNT(xk.kcbh) DESC;
```

#figure(
  image("assets/student-course-count.png"),
  caption: "查询每个学生的选课数量",
)

==== 查询每个教师的授课数量与平均分

通过授课表统计每个教师的授课次数。
子查询 sk_count 统计每个教师在授课表中的记录数（即授课门数）。
使用 ```sql LEFT JOIN``` 确保即使教师未授课，也能显示 0。
通过选课表计算每个教师所教课程的学生平均成绩。
子查询 avg_cj 计算每个教师的平均分。
使用 ```sql ROUND(..., 1)``` 保留一位小数。

```sql
SELECT 
    j.jsbh AS 教师编号,
    j.xm AS 教师姓名,
    COALESCE(sk_count.授课数量, 0) AS 授课数量,
    ROUND(COALESCE(avg_cj.平均分, 0), 1) AS 平均分
FROM 
    js j
LEFT JOIN 
    (SELECT bh AS jsbh, COUNT(*) AS 授课数量 
     FROM sk 
     GROUP BY bh) sk_count
    ON j.jsbh = sk_count.jsbh
LEFT JOIN 
    (SELECT jsbh, AVG(cj) AS 平均分 
     FROM xk 
     GROUP BY jsbh) avg_cj
    ON j.jsbh = avg_cj.jsbh
ORDER BY 
    授课数量 DESC, -- 先按授课数量降序排列
    平均分 DESC;  -- 数量相同则按平均分降序排列
```

#figure(
  image("assets/teacher-course-count-score-avg.png"),
  caption: "查询每个教师的授课数量与平均分",
)