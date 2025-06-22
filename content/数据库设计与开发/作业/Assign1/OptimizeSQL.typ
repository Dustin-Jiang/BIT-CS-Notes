使用 `EXPLAIN` 命令分析 SQL 语句的执行计划, 进而对数据库和 SQL 语句进行优化. `EXPLAIN` 命令会显示 SQL 语句的执行计划, 包括访问路径、连接方式、索引使用情况等。

本次沿用实验中使用的 "学籍与成绩管理系统" 作为实验对象. 由于需要通过创建索引来实现对数据库性能的优化, 因此先删除原有的带索引表格, 重新创建无索引的表格.

```sql
CREATE TABLE IF NOT EXISTS xyb ( 
    ydh CHAR(2) NOT NULL, 
    ymc CHAR(30) NOT NULL 
); 

CREATE TABLE IF NOT EXISTS xs ( 
    xm CHAR(8) NOT NULL, 
    xh CHAR(10) NOT NULL, 
    ydh CHAR(2), 
    bj CHAR(8), 
    chrq DATE, 
    xb CHAR(2) 
); 

CREATE TABLE IF NOT EXISTS js ( 
    xm CHAR(8) NOT NULL, 
    jsbh CHAR(10) NOT NULL, 
    zc CHAR(6), 
    ydh CHAR(2) 
); 

CREATE TABLE IF NOT EXISTS kc ( 
    kcbh CHAR(3) NOT NULL, 
    kc CHAR(20) NOT NULL, 
    lx CHAR(10), 
    xf NUMERIC(5, 1) 
); 

CREATE TABLE IF NOT EXISTS sk ( 
    kcbh CHAR(3), 
    bh CHAR(10) 
); 

CREATE TABLE IF NOT EXISTS xk ( 
    xh CHAR(10), 
    kcbh CHAR(3), 
    jsbh CHAR(10), 
    cj NUMERIC(5, 1) 
); 

-- 插入学院数据
INSERT INTO xyb (ydh, ymc) VALUES ('01', '计算机学院'); 
INSERT INTO xyb (ydh, ymc) VALUES ('02', '电子信息学院');
INSERT INTO xyb (ydh, ymc) VALUES ('03', '自动化学院');
INSERT INTO xyb (ydh, ymc) VALUES ('04', '机械工程学院');
INSERT INTO xyb (ydh, ymc) VALUES ('05', '土木工程学院');

-- 插入学生数据
INSERT INTO xs (xm, xh, ydh, bj, chrq, xb) VALUES ('张三', '20230101', '01', '软件工程', '2003-01-01', '男');
INSERT INTO xs (xm, xh, ydh, bj, chrq, xb) VALUES ('李四', '20230102', '01', '软件工程', '2003-02-01', '女');
INSERT INTO xs (xm, xh, ydh, bj, chrq, xb) VALUES ('王五', '20230103', '02', '电子信息', '2003-03-01', '男');
INSERT INTO xs (xm, xh, ydh, bj, chrq, xb) VALUES ('赵六', '20230104', '03', '自动化', '2003-04-01', '女');
INSERT INTO xs (xm, xh, ydh, bj, chrq, xb) VALUES ('钱七', '20230105', '04', '机械工程', '2003-05-01', '男');
INSERT INTO xs (xm, xh, ydh, bj, chrq, xb) VALUES ('孙八', '20230106', '05', '土木工程', '2003-06-01', '女');
INSERT INTO xs (xm, xh, ydh, bj, chrq, xb) VALUES ('周九', '20230107', '01', '软件工程', '2003-07-01', '男');
INSERT INTO xs (xm, xh, ydh, bj, chrq, xb) VALUES ('吴十', '20230108', '02', '电子信息', '2003-08-01', '女');
INSERT INTO xs (xm, xh, ydh, bj, chrq, xb) VALUES ('郑十一', '20230109', '03', '自动化', '2003-09-01', '男');
INSERT INTO xs (xm, xh, ydh, bj, chrq, xb) VALUES ('冯十二', '20230110', '04', '机械工程', '2003-10-01', '女');

-- 插入教师数据
INSERT INTO js (xm, jsbh, zc, ydh) VALUES ('爱城华恋', 'T001', '副教授', '01');
INSERT INTO js (xm, jsbh, zc, ydh) VALUES ('神乐光', 'T002', '副教授', '02');
INSERT INTO js (xm, jsbh, zc, ydh) VALUES ('大场奈奈', 'T003', '教授', '03');
INSERT INTO js (xm, jsbh, zc, ydh) VALUES ('天堂真矢', 'T004', '教授', '04');
INSERT INTO js (xm, jsbh, zc, ydh) VALUES ('西条克洛迪娜', 'T005', '副教授', '05');
INSERT INTO js (xm, jsbh, zc, ydh) VALUES ('花柳香子', 'T006', '副教授', '01');
INSERT INTO js (xm, jsbh, zc, ydh) VALUES ('石动双叶', 'T007', '副教授', '02');
INSERT INTO js (xm, jsbh, zc, ydh) VALUES ('露崎真昼', 'T008', '副教授', '03');
INSERT INTO js (xm, jsbh, zc, ydh) VALUES ('星见纯那', 'T009', '教授', '04');

-- 插入课程数据
INSERT INTO kc (kcbh, kc, lx, xf) VALUES ('001', '数据结构', '必修', 3.0);
INSERT INTO kc (kcbh, kc, lx, xf) VALUES ('002', '操作系统', '必修', 3.0);
INSERT INTO kc (kcbh, kc, lx, xf) VALUES ('003', '计算机网络', '必修', 3.0);
INSERT INTO kc (kcbh, kc, lx, xf) VALUES ('004', '数据库原理', '必修', 3.0);
INSERT INTO kc (kcbh, kc, lx, xf) VALUES ('005', '软件工程', '选修', 2.0);
INSERT INTO kc (kcbh, kc, lx, xf) VALUES ('006', '人工智能', '选修', 2.0);
INSERT INTO kc (kcbh, kc, lx, xf) VALUES ('007', '机器学习', '选修', 2.0);
INSERT INTO kc (kcbh, kc, lx, xf) VALUES ('008', '深度学习', '选修', 2.0);
INSERT INTO kc (kcbh, kc, lx, xf) VALUES ('009', '数据挖掘', '选修', 2.0);
INSERT INTO kc (kcbh, kc, lx, xf) VALUES ('010', '计算机视觉', '选修', 2.0);

-- 插入授课数据
INSERT INTO sk (kcbh, bh) VALUES ('001', 'T001');
INSERT INTO sk (kcbh, bh) VALUES ('001', 'T006');
INSERT INTO sk (kcbh, bh) VALUES ('002', 'T002');
INSERT INTO sk (kcbh, bh) VALUES ('002', 'T007');
INSERT INTO sk (kcbh, bh) VALUES ('003', 'T003');
INSERT INTO sk (kcbh, bh) VALUES ('003', 'T008');
INSERT INTO sk (kcbh, bh) VALUES ('004', 'T004');
INSERT INTO sk (kcbh, bh) VALUES ('004', 'T009');
INSERT INTO sk (kcbh, bh) VALUES ('005', 'T005');
INSERT INTO sk (kcbh, bh) VALUES ('006', 'T001');
INSERT INTO sk (kcbh, bh) VALUES ('007', 'T002');
INSERT INTO sk (kcbh, bh) VALUES ('008', 'T003');
INSERT INTO sk (kcbh, bh) VALUES ('009', 'T004');
INSERT INTO sk (kcbh, bh) VALUES ('010', 'T005');

-- 插入选课数据
INSERT INTO xk (xh, kcbh, jsbh, cj) VALUES ('20230101', '001', 'T001', 85.0);
INSERT INTO xk (xh, kcbh, jsbh, cj) VALUES ('20230101', '002', 'T002', 90.0);
INSERT INTO xk (xh, kcbh, jsbh, cj) VALUES ('20230102', '001', 'T006', 88.0);
INSERT INTO xk (xh, kcbh, jsbh, cj) VALUES ('20230102', '002', 'T002', 92.0);
INSERT INTO xk (xh, kcbh, jsbh, cj) VALUES ('20230103', '003', 'T003', 80.0);
INSERT INTO xk (xh, kcbh, jsbh, cj) VALUES ('20230103', '004', 'T004', 85.0);
INSERT INTO xk (xh, kcbh, jsbh, cj) VALUES ('20230104', '005', 'T005', 78.0);
INSERT INTO xk (xh, kcbh, jsbh, cj) VALUES ('20230104', '006', 'T001', 82.0);
INSERT INTO xk (xh, kcbh, jsbh, cj) VALUES ('20230105', '007', 'T002', 75.0);
INSERT INTO xk (xh, kcbh, jsbh, cj) VALUES ('20230105', '008', 'T003', 80.0);
INSERT INTO xk (xh, kcbh, jsbh, cj) VALUES ('20230106', '009', 'T004', 95.0);
INSERT INTO xk (xh, kcbh, jsbh, cj) VALUES ('20230106', '010', 'T005', 98.0);
INSERT INTO xk (xh, kcbh, jsbh, cj) VALUES ('20230107', '001', 'T006', 85.0);
INSERT INTO xk (xh, kcbh, jsbh, cj) VALUES ('20230107', '002', 'T007', 90.0);
INSERT INTO xk (xh, kcbh, jsbh, cj) VALUES ('20230108', '003', 'T008', 88.0);
INSERT INTO xk (xh, kcbh, jsbh, cj) VALUES ('20230108', '004', 'T009', 92.0);
INSERT INTO xk (xh, kcbh, jsbh, cj) VALUES ('20230109', '005', 'T005', 80.0);
INSERT INTO xk (xh, kcbh, jsbh, cj) VALUES ('20230109', '006', 'T001', 85.0);
INSERT INTO xk (xh, kcbh, jsbh, cj) VALUES ('20230110', '007', 'T002', 78.0);
INSERT INTO xk (xh, kcbh, jsbh, cj) VALUES ('20230110', '008', 'T003', 82.0);
```

创建完成后, 使用 `\d xs` 命令查看 `xs` 表的信息. 

#figure(
  image("assets/table_xs_info.png", height: 40%),
  caption: "查看xs表信息",
)

使用 `ANALYZE` 命令收集性能统计信息.

```sql
ANALYZE VERBOSE xs;
```

使用 `EXPLAIN` 命令分析 SQL 语句的执行计划.

```sql
EXPLAIN SELECT * FROM xs WHERE xh = '20230102';
```

#figure(
  image("assets/explain-query.png", height: 40%),
  caption: "SQL语句执行计划",
)

可以看见, 由于表格没有索引, 因此使用的是 _Seq Scan_ 顺序扫描的方式来进行查询. 在大数据量的情况下, 这种方式会导致性能表现较差.

使用下面的命令为 `xs` 表创建主键. 

```sql
ALTER TABLE xs ADD PRIMARY KEY (xh);
```

创建完成后, 使用 `\d xs` 命令查看 `xs` 表的信息. 可以看见, `xh` 列已经被添加了主键约束, 并且已经被自动创建了索引 `xs_pkey`.

#figure(
  image("assets/add-pkey.png", height: 40%),
  caption: "为表添加主键",
)

此时, 通过添加 Hint 来优化 SQL 语句的执行计划.

```sql
EXPLAIN SELECT /*+indexscan(xs xs_pkey)*/ * FROM xs WHERE xh = '20230102';
```

#figure(
  image("assets/explain-query-with-pkey.png", height: 40%),
  caption: "添加Hint之后SQL语句的执行计划",
)

可以看到, SQL 语句的执行计划已经发生了变化, 变成了 _Index Scan_ 索引扫描的方式来进行查询. 这种方式在大数据量的情况下, 性能表现会更好.