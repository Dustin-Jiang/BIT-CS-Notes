DROP VIEW IF EXISTS student_view;
DROP TABLE IF EXISTS student;

CREATE TABLE student (
  id VARCHAR(20) NOT NULL PRIMARY KEY,
  name VARCHAR(20) NOT NULL,
  graduate_date DATE,
  subject_id VARCHAR(20),
  UNIQUE(id),
  region VARCHAR(6),
  FOREIGN KEY (region) REFERENCES region(id)
);

DROP FUNCTION IF EXISTS get_all_students;
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

INSERT INTO student (id, name, graduate_date, subject_id, region) VALUES
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