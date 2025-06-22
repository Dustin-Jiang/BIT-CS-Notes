=== 建立数据表

在实验一中, 根据实验要求，设计了“学籍与成绩管理系统”中的一系列表格. 创建表格的SQL语句如下：

#show raw: set text(
  font: ("Cascadia Code PL", "Microsoft YaHei UI"),
  size: 9pt,
  ligatures: true
)
```sql
CREATE TABLE IF NOT EXISTS xyb ( -- 创建学院表，存储学院基础信息
    ydh CHAR(2) PRIMARY KEY NOT NULL,  -- 学院代号，主键（不允许空，固定长度2字符）
    ymc CHAR(30) NOT NULL             -- 学院名称（不允许空，固定长度30字符）
);

CREATE TABLE IF NOT EXISTS xs ( -- 创建学生表，存储学生基本信息
    xm CHAR(8) NOT NULL,        -- 姓名（不允许空，固定长度8字符）
    xh CHAR(10) PRIMARY KEY NOT NULL,  -- 学号，主键（不允许空，固定长度10字符）
    ydh CHAR(2),                -- 所属学院代号（允许空，外键，引用xyb.ydh）
    bj CHAR(8),                -- 班级（固定长度8）
    chrq DATE,                  -- 出生日期（允许空）
    xb CHAR(2),                -- 性别（允许空，固定长度2字符）
    FOREIGN KEY (ydh)          -- 外键约束：所属学院代号必须是xyb表中存在的ydh值
        REFERENCES xyb(ydh),
    UNIQUE (xh)                -- 唯一约束：确保学号
);

CREATE TABLE IF NOT EXISTS js ( -- 创建教师表，存储教师信息
    xm CHAR(8) NOT NULL,        -- 姓名（不允许空）
    jsbh CHAR(10) PRIMARY KEY NOT NULL, -- 教师编号，主键（不允许空）
    zc CHAR(6),                -- 职称（允许空，固定长度6字符）
    ydh CHAR(2),                -- 所属学院代号（允许空，外键，引用xyb.ydh）
    FOREIGN KEY (ydh)          -- 外键约束：所属学院代号必须是xyb表中存在的ydh值
        REFERENCES xyb(ydh),
    UNIQUE(jsbh)               -- 唯一约束：确保教师编号值唯一
);

CREATE TABLE IF NOT EXISTS kc ( -- 创建课程表，存储课程信息
    kcbh CHAR(3) PRIMARY KEY NOT NULL, -- 课程编号，主键（不允许空）
    kc CHAR(20) NOT NULL,          -- 课程名称（不允许空）
    lx CHAR(10),                   -- 课程类型（允许空）
    xf NUMERIC(5, 1),               -- 学分（数值类型，总长度5位，小数点后1位）
    UNIQUE(kcbh)
);

CREATE TABLE IF NOT EXISTS sk ( -- 创建授课表，存储课程与班级的关联关系
    kcbh CHAR(3),               -- 课程编号（非主键字段，参与复合主键）
    bh CHAR(10),                -- 教师编号（非主键字段，参与复合主键）
    PRIMARY KEY (kcbh, bh),     -- 复合主键：课程编号 + 教师编号必须唯一组合
    FOREIGN KEY (kcbh)          -- 外键约束：课程编号必须是kc表中存在的kcbh值
        REFERENCES kc(kcbh),
    FOREIGN KEY (bh)            -- 外键约束：班级编号必须是js表中存在的jsbh值
        REFERENCES js(jsbh)       -- js的jsbj字段添加UNIQUE约束以允许外键引用
);

CREATE TABLE IF NOT EXISTS xk ( -- 创建学生选课表，记录选课及成绩
    xh CHAR(10),               -- 学号（主键字段之一）
    kcbh CHAR(3),              -- 课程编号（主键字段之一）
    jsbh CHAR(10),             -- 教师编号（主键字段之一）
    cj NUMERIC(5, 1),          -- 成绩（允许空）
    PRIMARY KEY (xh, kcbh, jsbh), -- 联合主键：学号 + 课程编号 + 教师编号的组合唯一
    FOREIGN KEY (xh)           -- 外键约束：学号必须是xs表中存在的xh值
        REFERENCES xs(xh),
    FOREIGN KEY (kcbh)         -- 外键约束：课程编号必须是kc表中存在的kcbh值
        REFERENCES kc(kcbh),
    FOREIGN KEY (jsbh)         -- 外键约束：教师编号必须是js表中存在的jsbh值
        REFERENCES js(jsbh),
    -- 确保 (kcbh, jsbh) 组合存在于 sk 表中
    FOREIGN KEY (kcbh, jsbh)   -- sk 表的主键字段是 (kcbh, bh)，而 jsbh 对应 sk 表的 bh 字段
        REFERENCES sk(kcbh, bh)  -- 因此需要将 jsbh 映射到 sk 的 bh
);
```

使用Data Studio连接到数据库后, 执行上述SQL语句创建表格. SQL语句运行成功后, 可从Data Studio左侧的数据库树中查看到创建的表格.

#figure(
  image("assets/create-table.png", height: 40%),
  caption: "创建表格",
)

=== 建立索引

建立数据表之后, 根据数据特点, 针对部分常用的查询进行索引设计, 以提高查询效率. 例如, 在学生表的学号字段上建立索引, 在课程表的课程编号字段上建立索引, 在教师表的教师编号字段上建立索引, 在选课表的学号和课程编号字段上建立联合索引等. 

```sql
-- 学生表（xs）
CREATE INDEX idx_xs_ydh ON xs(ydh); --用于按学院快速筛选学生信息（如统计某学院的学生数量）

-- 教师表（js）
CREATE INDEX idx_js_ydh ON js(ydh); --用于按学院筛选教师（如查询某学院的教师列表）

-- 课程表（kc）
CREATE INDEX idx_kc_kc ON kc(kc); -- 按课程名称查询
CREATE INDEX idx_kc_xf ON kc(xf); -- 按学分数筛选课程

-- 学生选课表（xk）
CREATE INDEX idx_xk_kcbh ON xk(kcbh); --按课程编号（kcbh）统计选课人数
CREATE INDEX idx_xk_jsbh ON xk(jsbh); --按教师编号（jsbh）筛选授课记录
CREATE INDEX idx_xk_cj ON xk(cj); --按成绩（cj）排序或统计（如按成绩筛选）
```

在Data Studio中运行上述SQL语句, 可在左侧的数据库树中查看到创建的索引. 右键点击表格, 选择“查看索引”即可查看到创建的索引.

#figure(
  image("assets/create-index.png", height: 40%),
  caption: "创建索引",
)

=== 插入数据

根据实验要求, 向主表插入至少5行数据, 向子表插入至少30行数据. 具体的SQL语句如下：
```sql
-- 插入学院数据
INSERT INTO xyb (ydh, ymc) VALUES ('01', '计算机学院'); 
INSERT INTO xyb (ydh, ymc) VALUES ('02', '电子信息学院');
INSERT INTO xyb (ydh, ymc) VALUES ('03', '自动化学院');
INSERT INTO xyb (ydh, ymc) VALUES ('04', '机械工程学院');
INSERT INTO xyb (ydh, ymc) VALUES ('05', '土木工程学院');
```
```sql
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
```

```sql
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
```
```sql
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
```

```sql
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
```

```sql
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

#figure(
    image("assets/datastudio-insert.png", height: 40%),
    caption: "使用 Data Studio 插入数据",
)

=== 输入含有不存在外键值的数据

在选课表中输入含有不存在外键值的数据, 例如, 插入一条学号为“20230111”的学生选课记录, 但该学号在学生表中并不存在. 执行以下SQL语句：

```sql
INSERT INTO xk (xh, kcbh, jsbh, cj) VALUES ('20230111', '001', 'T001', 85.0);
```

执行该SQL语句后, 数据库系统会报错, 提示外键约束失败. 这是因为在选课表中插入的学号“20230111”在学生表中并不存在, 导致外键约束失败.

#figure(
    image("assets/foreign-key-error.png", height: 45%),
    caption: "外键约束失败",
)

但是如果插入的数据中, 有外键约束的列为NULL, 则不会报错. 例如, 插入一条学生记录, 但学院代号为NULL, 即不指定学院. 执行以下SQL语句：

```sql
INSERT INTO xs (xm, xh, ydh, bj, chrq, xb) VALUES ('小明', '20230111', NULL, '软件工程', '2003-01-01', '男');
```

执行该SQL语句后, 数据库会成功插入数据. 这是因为在学生表中, 学院代号ydh是允许为空的, 因此可以插入NULL值. 

这说明了外键约束的作用是确保引用的完整性, 但允许NULL值的存在. 这在实际应用中是很常见的, 因为有些数据在插入时可能并不确定, 可以先插入NULL值, 后续再进行更新.
