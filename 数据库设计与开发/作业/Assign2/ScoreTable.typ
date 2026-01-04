为进行学生成绩的储存与查询，设计学生成绩表如下：

```sql
DROP TABLE IF EXISTS score;
CREATE TABLE score (
  id VARCHAR(20) NOT NULL,  -- 学生ID，外键引用学生表的ID字段
  subject_name VARCHAR(20) NOT NULL,  -- 科目名称
  score NUMERIC(5,2) NOT NULL,  -- 成绩，数值类型，最多5位数字和2位小数
  PRIMARY KEY (id, subject_name),  -- 主键由学生ID和科目名称组成，确保唯一性
  FOREIGN KEY (id) REFERENCES student(id)  -- 外键约束，引用学生表的ID字段
);
```

该表格使用外键约束来确保学生ID的有效性；使用由学生ID和科目名称组成复合主键，以确保每个学生在每个科目上只能有一条成绩记录。

插入以下测试用例数据：

```sql
INSERT INTO score (id, subject_name, score) VALUES
-- 2009年的学生
('1120090001', '数据库设计与开发', 85.0),
('1120090001', '软件工程导论', 90.0),
('1120090001', '科学发展观', 88.0),
('1120090002', '数据库设计与开发', 78.0),
('1120090002', '软件工程导论', 88.0),
('1120090002', '科学发展观', 88.0),
('1120090003', '数据库设计与开发', 92.0),
('1120090003', '软件工程导论', 95.0),
('1120090003', '科学发展观', 90.0),
('1120090004', '数据库设计与开发', 80.0),
('1120090004', '软件工程导论', 85.0),
('1120090004', '科学发展观', 82.0),
-- 2000年的学生
('1120000001', '数据库设计与开发', 75.0),
('1120000001', '软件工程导论', 80.0),
('1120000001', '三个代表重要思想', 85.0),
('1120000002', '数据库设计与开发', 82.0),
('1120000002', '软件工程导论', 78.0),
('1120000002', '三个代表重要思想', 80.0),
('1120000003', '数据库设计与开发', 88.0),
('1120000003', '软件工程导论', 90.0),
('1120000003', '三个代表重要思想', 92.0),
('1120000004', '数据库设计与开发', 70.0),
('1120000004', '软件工程导论', 72.0),
('1120000004', '三个代表重要思想', 75.0),
-- 2015年的学生
('1120150001', '数据库设计与开发', 95.0),
('1120150001', '软件工程导论', 98.0),
('1120150001', '习近平新时代中国特色社会主义思想概论', 90.0),
('1120150002', '数据库设计与开发', 85.0),
('1120150002', '软件工程导论', 87.0),
('1120150002', '习近平新时代中国特色社会主义思想概论', 88.0),
('1120150003', '数据库设计与开发', 90.0),
('1120150003', '软件工程导论', 92.0),
('1120150003', '习近平新时代中国特色社会主义思想概论', 91.0),
('1120150004', '数据库设计与开发', 88.0),
('1120150004', '软件工程导论', 91.0),
('1120150004', '习近平新时代中国特色社会主义思想概论', 75.0),
-- 在校生
('1120240001', '数据库设计与开发', 80.0),
('1120240001', '软件工程导论', 85.0),
('1120240001', '习近平新时代中国特色社会主义思想概论', 82.0);
```

== 查询成绩表

使用连接语句进行成绩表的查询：

```sql
SELECT s.id, s.name, sc.subject_name, sc.score
  FROM get_all_students() AS s
  JOIN score AS sc ON s.id = sc.id;
```

== 实现交叉表查询

为了使成绩查询更加直观，可以使用交叉表的思想，将成绩表转换为以下形式：

#table(
  columns: (auto, auto, auto, auto, auto, auto),
  align: horizon,
  
  [姓名], "三个代表重要思想", "习近平新时代中国特色社会主义思想概论", "数据库设计与开发", "科学发展观", "软件工程导论",
  [李四], [NULL], [NULL], [78.00], [88.00], [88.00],
  [...], [...], [...], [...], [...], [...]
)

这可以通过以下 SQL 语句实现：

```sql
CREATE OR REPLACE FUNCTION get_student_scores()
RETURNS SETOF record AS $$
DECLARE
  cols TEXT;          -- 动态生成的列定义
  sql TEXT;           -- 动态生成的完整 SQL 语句
BEGIN
  -- 获取所有科目名称，并生成 CASE 表达式
  SELECT string_agg(
    format(
        'MAX(CASE WHEN subject_name = %L THEN score END) AS %I',
        subject_name, subject_name
    ),
    ', '
  ) INTO cols
  FROM (
    SELECT DISTINCT subject_name
    FROM score
    ORDER BY subject_name
  ) AS subjects;

  -- 如果没有科目，仅返回学生姓名
  IF cols IS NULL THEN
    sql := 'SELECT name FROM student';
  ELSE
    -- 构造完整的 SQL 查询
    sql := format(
      'SELECT s.name, %s 
        FROM student s 
        LEFT JOIN score sc ON s.id = sc.id 
        GROUP BY s.name, s.id',
      cols
    );
  END IF;

  -- 执行动态查询
  RETURN QUERY EXECUTE sql;
END;
$$ LANGUAGE plpgsql;
```

要进行查询，需要先对动态的列名称进行查询，可使用这个 `DO` 块来动态生成最终的 SQL 查询语句：

```sql
-- 进行查询
DO $$
DECLARE
  cols TEXT;          -- 动态列定义
  final_sql TEXT;     -- 最终 SQL 查询
BEGIN
  -- 获取所有科目列定义（如 "数学 NUMERIC, 物理 NUMERIC"）
  SELECT string_agg(format('%I NUMERIC', subject_name), ', ')
  INTO cols
  FROM (
    SELECT DISTINCT subject_name
    FROM score
    ORDER BY subject_name
  ) AS subjects;

  -- 构造完整的查询语句
  final_sql := format(
    'SELECT * FROM get_student_scores() AS (name VARCHAR(20), %s);',
    cols
  );

  RAISE NOTICE '%', final_sql;
  -- 执行并输出结果
  EXECUTE final_sql;
END $$;
```

执行这个 `DO` 块后，将会输出动态生成的 SQL 查询语句，在本次作业的示例数据中，结果为：

```sql
SELECT * FROM get_student_scores() AS (name VARCHAR(20), "三个代表重要思想" NUMERIC, "习近 平新时代中国特色社会主义思想概论" NUMERIC, "数据库设计与开发" NUMERIC, "科学发展观" NUMERIC, "软件工程导论" NUMERIC);
```

查询结果如下：

#figure(
  image("assets/select_scores_crosstable.png"),
  caption: "成绩表的交叉表形式查询结果"
)