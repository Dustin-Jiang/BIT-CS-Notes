根据实验要求，设计了“学籍与成绩管理系统”中的一系列表格. 创建表格的SQL语句如下：

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
  image("assets/create-table.png", height: 45%),
  caption: "创建表格",
)

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
  image("assets/create-index.png", height: 45%),
  caption: "创建索引",
)