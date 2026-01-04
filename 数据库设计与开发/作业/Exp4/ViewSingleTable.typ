联接逻辑： 
`xs`（学生表） 左联接 `xk`（选课表） → 包含未选课的学生; 
`xk` 左联接 `kc`（课程表） → 确保查询到对应课程学分。

总成绩的计算： 
分子 ```sql SUM(xk.cj * kc.xf)```为所有选课成绩 × 课程学分之和。
分母 ```sql SUM(kc.xf)```为所有选课的总学分。
若总学分为0，直接返回 0 （避免除以零错误）。

分组与聚合： 
按 学号 (`xs.xh`) 和 姓名 (`xs.xm`) 分组，确保结果按学生聚合。

```sql
DROP VIEW IF EXISTS zcj_view;  -- 删除视图（如果存在）
CREATE VIEW zcj_view AS
SELECT
    xs.xh AS xh,    -- 学号
    xs.xm AS xm,    -- 姓名
    COALESCE(SUM(kc.xf), 0) AS zxf,   -- 总学分
    CASE
        WHEN COALESCE(SUM(kc.xf), 0) = 0 THEN 0   -- 总学分0则返回0（避免除0）
        ELSE (SUM(xk.cj * kc.xf) / SUM(kc.xf))    -- 加权平均分
    END AS zcj    -- 加权平均成绩
FROM xs
LEFT JOIN xk ON xs.xh = xk.xh   -- 左联接选课表（包含未选课的学生）
LEFT JOIN kc ON xk.kcbh = kc.kcbh   -- 左联接课程表（获取学分信息）
GROUP BY xs.xh, xs.xm;
```

成功创建视图之后, 可以看到视图中的所有数据. 视图中包含了所有学生的学号、姓名、总学分和加权平均成绩. 其中, 学号和姓名来自 `xs` 表格, 总学分和加权平均成绩是通过联接 `xk` 和 `kc` 表格计算得出的. 视图中的数据是动态的, 当基础表格中的数据发生变化时, 视图中的数据也会随之更新.

#figure(
  image("assets/create-single-view-success.png"),
  caption: "查看视图中的数据"
)