为了储存学生信息，学生表格设计如下：

```sql
CREATE TABLE student (
  id VARCHAR(20) NOT NULL PRIMARY KEY,
  name VARCHAR(20) NOT NULL,
  graduate_date DATE,
  subject_id VARCHAR(20),
  UNIQUE(id),
  region VARCHAR(6),
  FOREIGN KEY (region) REFERENCES region(id)
);
```

插入以下测试用例数据：

```sql
INSERT INTO student (id, name, graduate_date, subject_id, region) VALUES
-- 2009年的学生
('1120090001', '张三', '2013-06-30', '081203', '110100'),
('1120090002', '李四', '2013-06-30', '081202', '510200'), -- 原四川省重庆市
('1120090003', '王五', '2013-06-30', '081201', '420400'), -- 原湖北省沙市市
('1120090004', '赵六', '2013-06-30', '081202', '542300'), -- 原西藏自治区日喀则地区
-- 2000年的学生
-- 毕业时软件工程尚不是二级专业
('1120000001', '刘七', '2004-06-30', '081203', '110100'),
('1120000002', '朱八', '2004-06-30', '081202', '510200'),
('1120000003', '徐九', '2004-06-30', '081201', '420400'),
('1120000004', '吴十', '2004-06-30', '081202', '542300'),
-- 2015年的学生
-- 毕业时大类编号已变更
('1120150001', '钱十一', '2019-06-30', '0081203', '110100'),
('1120150002', '孙十二', '2019-06-30', '0081201', '500100'),
('1120150003', '周十三', '2019-06-30', '0081201', '421000'),
('1120150004', '郑十四', '2019-06-30', '0081203', '540200'),
-- 在校生
('1120240001', '林十五', NULL, '0081201', '310100');
```

== 查询学生信息

为方便查询全部学生的信息，设计了查询函数如下：

```sql
CREATE FUNCTION get_all_students()
RETURNS TABLE (
  id VARCHAR(20),
  name VARCHAR(20),
  graduate_date DATE,
  region_name VARCHAR(40),
  region_id VARCHAR(6),
  subject_name VARCHAR(50),
  subject_id VARCHAR(20)  -- 修改 subject_id 的数据类型为 VARCHAR(20)
) AS $$
DECLARE
  student_row RECORD;     -- 保存正在处理的 student 行记录
  rname TEXT;             -- 存储查询到的区域名称
  rid VARCHAR(6);         -- 存储查询到的区域ID
  subj_name VARCHAR(50);  -- 存储查询到的科目名称
BEGIN
  -- 遍历 student 表的每一行数据
  FOR student_row IN
    SELECT s.id, s.name, s.graduate_date, s.region, s.subject_id
    FROM student s
  LOOP
    -- 计算 region_name 和 region_id（使用更清晰的变量命名避免歧义）
    SELECT r.name, r.id
    INTO rname, rid
    FROM region_view r
    WHERE r.id = student_row.region;
    
    -- 计算 subject_name（模拟 LATERAL 子查询）
    SELECT sub.name
    INTO subj_name
    FROM subject_full_id(COALESCE(student_row.graduate_date, CURRENT_DATE)) sub
    WHERE sub.full_id = student_row.subject_id;

    -- 将数据赋值给 OUT 参数
    id := student_row.id;               -- 学生ID
    name := student_row.name;           -- 学生姓名
    graduate_date := student_row.graduate_date; -- 毕业日期
    region_name := rname;               -- 区域名称
    region_id := rid;                   -- 区域ID
    subject_name := subj_name;          -- 科目名称
    subject_id := student_row.subject_id; -- 科目ID

    -- 返回当前处理行结果
    RETURN NEXT;
  END LOOP;
END;
$$ LANGUAGE plpgsql;
```

执行查询函数时，使用如下语句：

```sql
SELECT * FROM get_all_students();
```

查询结果如下：

#{
  set text(9pt)
  figure(
    caption: "查询所有学生的结果",
    table(
      columns: (1fr, 0.8fr, 1fr, 2fr, 0.8fr, 1.7fr, 0.8fr),
      align: horizon,
      [*id*], [*name*], [*graduate date*], [*region name*], [*region id*], [*subject name*], [*subject id*],
      "1120090001", "张三", "2013-06-30", "北京市市辖区", "110100", "计算机应用技术", "081203",
      "1120090002", "李四", "2013-06-30", "重庆市", "510200", "软件工程", "081202",
      "1120090003", "王五", "2013-06-30", "湖北省荆州市", "420400", "计算机系统结构", "081201",
      "1120090004", "赵六", "2013-06-30", "西藏自治区日喀则市", "542300", "软件工程", "081202",
      "1120000001", "刘七", "2004-06-30", "北京市市辖区", "110100", "计算机应用技术", "081203",
      "1120000002", "朱八", "2004-06-30", "重庆市", "510200", "计算机软件与理论", "081202",
      "1120000003", "徐九", "2004-06-30", "湖北省荆州市", "420400", "计算机系统结构", "081201",
      "1120000004", "吴十", "2004-06-30", "西藏自治区日喀则市", "542300", "计算机软件与理论", "081202",
      "1120150001", "钱十一", "2019-06-30", "北京市市辖区", "110100", "计算机应用技术", "0081203",
      "1120150002", "孙十二", "2019-06-30", "重庆市市辖区", "500100", "计算机系统结构", "0081201",
      "1120150003", "周十三", "2019-06-30", "湖北省荆州市", "421000", "计算机系统结构", "0081201",
      "1120150004", "郑十四", "2019-06-30", "西藏自治区日喀则市", "540200", "计算机应用技术", "0081203",
      "1120240001", "林十五", "NULL", "上海市市辖区", "310100", "计算机系统结构", "0081201"
    )
  )
}

可以看见，查询结果中根据学生的毕业日期，查询到了毕业时学科编号所对应的学科名称；而学生的籍贯信息显示的是当前的区域名称。

例如，学生 *朱八* 于 2004 年毕业时，其学科编号 _081202_ 所对应的学科为 *计算机软件与理论* 而不是软件工程；虽然其籍贯信息为旧 *四川省重庆市* 的编号，显示其籍贯仍为 *重庆市*。

== 修改学生专业信息

由于只有在校生有可能修改其专业信息，因此设计了如下函数：

```sql
DROP FUNCTION IF EXISTS update_student_subject;
CREATE FUNCTION update_student_subject(
  target_id VARCHAR(20),
  new_subject_id VARCHAR(20)
) RETURNS TABLE (
  学号 VARCHAR(20),
  姓名 VARCHAR(20),
  毕业时间 DATE,
  地区编号 VARCHAR(6),
  专业编号 VARCHAR(20)
) AS $$
BEGIN
  UPDATE student
  SET subject_id = new_subject_id
  WHERE id = target_id AND graduate_date IS NULL;

  RETURN QUERY SELECT * FROM student WHERE id = target_id;
END;
$$ LANGUAGE plpgsql;
```

添加函数之后，可以使用如下语句修改学生 *林十五* 的专业信息为嵌入式软件系统架构：

```sql
SELECT update_student_subject('1120240001', '008120201');
```

#figure(
  image("assets/update_student_subject.png"),
  caption: "成功修改学生专业信息",
)