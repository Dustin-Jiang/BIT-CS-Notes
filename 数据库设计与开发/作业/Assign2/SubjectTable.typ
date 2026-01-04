== 数据结构设计

中华人民共和国学科分类指以国家标准为形式发布的学科分类方式及名称提法。学科分类采用树形结构, 一级学科下设二级学科，二级学科下设三级学科，如此类推。每一级均有其编码与名称:
- 一级学科: 2 位数字编码, 如 "01" 表示 "哲学"
- 二级学科: 4 位数字编码, 前 2 位为对应一级学科编码, 后 2 位为本学科编号
- 如此类推, 三级学科编码为 6 位数字, 四级学科编码为 8 位数字

此编码方式便于管理与扩展, 也方便检索上下级关系. 例如, "010102" 编码可直观地看出属于 "01" 哲学一级学科下的 "01" 哲学类二级学科下的 "02" 逻辑学。

但随着学科分类的不断发展，学科编码也在不断变化。例如，新设立的学科可能会使用已经消失的旧学科的编号，三级学科可能会变更为二级学科等。

由于学科编号与所有大学毕业生的学位证书、学籍档案等密切相关，在某次变更前毕业的学生，其学位证书上可能会使用旧的学科编码，而在变更后毕业的学生则使用新的学科编码。因此学科编码的变更需要有明确的可追溯性，以便于在查询时能够准确地找到对应的学科信息。

考虑到学科编码结构的特殊性、对可追溯性的特殊要求，将数据表设计如下：

```sql
CREATE TABLE subject (
  id SERIAL NOT NULL PRIMARY KEY,
  name VARCHAR(50),
  parent_id VARCHAR(10),        -- 递归层级关系
  self_id VARCHAR(10) NOT NULL, -- 代码唯一标识
  start_date DATE NOT NULL,     -- 代码生效时间
  end_date DATE                 -- 代码失效时间 (NULL表示当前有效)
);
```

下面对表中各处设计进行详细说明：

=== 数据嵌套

在作业要求中，学科表要能处理学科代码的变更，如一级学科的编码长度变为 3 位。

由于学科分类的结构设计，在这种情况下，需要将该一级学科下的各级学科的编码都进行相应的调整，以确保数据的一致性和完整性。

因此，将学科信息的储存设计为嵌套结构，每个数据行都有 `parent_id` 列，指向上级学科的 `id`。

这样使得一级学科下的二级学科、三级学科等都可以在同一表中进行存储。更新时，只需更新一级学科的编码，其下的各级学科编码可通过触发器进行自动更新，确保了数据的完整性和一致性。查询时，只需将 `parent_id` 列与 `self_id` 列进行连接，即可得到完整且准确的学科编码。

=== 可追溯的数据变更

由于上述原因，学科编码的变更需要有明确的可追溯性，以便于在查询时能够准确地找到对应的学科信息。

因此，在数据表中设计了每条记录的生效时间和失效时间，失效时间设为 `NULL` 时表示截止当前有效；同时，所有的数据更改都以 `INSERT` 的方式记录，所有历史数据都以数据行的形式保存在表中，避免数据丢失。

在这样的设计下，需要进行查询时，可通过学生的毕业时间对数据行的生效时间和失效时间进行筛选，从而来确定使用的学科编码，以确保数据准确无误。

== 示例数据说明

在本次作业中，为方便实验与说明，设计以下测试数据：

```sql
INSERT INTO subject (name, parent_id, self_id, start_date, end_date) VALUES
  ('理学', NULL, '07', '1970-01-01', NULL),
  ('工学', NULL, '08', '1970-01-01', NULL),
  ('农学', NULL, '09', '1970-01-01', NULL),
  ('控制科学与工程', '08', '11', '1970-01-01', NULL),
  ('计算机科学与技术', '08', '12', '1970-01-01', NULL),
  ('建筑学', '08', '13', '1970-01-01', NULL),
  ('计算机系统结构', '0812', '01', '1970-01-01', NULL),
  ('计算机软件与理论', '0812', '02', '1970-01-01', NULL),
  ('计算机应用技术', '0812', '03', '1970-01-01', NULL),
  ('嵌入式软件', '081202', '01', '1970-01-01', NULL);

-- 假设2009年发生学科编号变更
INSERT INTO subject (name, parent_id, self_id, start_date, end_date) VALUES
  ('软件工程', '0812', '02', '2009-08-31', NULL),
  ('计算机软件与理论', '0812', '04', '2009-08-31', NULL);

-- 假设2014年发生大类编号变更
INSERT INTO subject (name, parent_id, self_id, start_date, end_date) VALUES
  ('理学', NULL, '007', '2014-01-01', NULL),
  ('工学', NULL, '008', '2014-01-01', NULL),
  ('农学', NULL, '009', '2014-01-01', NULL);

-- 假设2018年加入四级学科，停用某些学科
INSERT INTO subject (name, parent_id, self_id, start_date, end_date) VALUES
  -- 停用这个学科
  ('计算机软件与理论', '00812', '04', '2018-01-01', '2018-01-01'),
  -- 加入这个四级学科
  ('嵌入式软件系统架构', '008120201', '01', '2018-01-01', NULL);
```

在测试数据中，假设发生了以下变更事件：

1. 2009 年 8 月 31 日，学科编号发生变更，*计算机软件与理论* 的编码由 _081202_ 变更为 _081204_，其原编号 _081202_ 分配给了新增的学科 *软件工程* 。
2. 2014 年 1 月 1 日，学科大类编号发生变更，*理学* 的编码由 _07_ 变更为 _007_，*工学* 的编码由 _08_ 变更为 _008_，*农学* 的编码由 _09_ 变更为 _009_ 。
3. 2018 年 1 月 1 日，*计算机软件与理论* 这个学科停用。新增了四级学科 *嵌入式软件系统架构* ，其编码为 _008120201_ 。

在下面的设计与测试中，将以此数据为基础进行学科编码的查询与验证。

== 触发器更新逻辑设计

为了实现学科编码和过期信息的自动更新，设计了一个触发器 `update_subject_id`，用于在插入新数据时自动更新下级学科的编码和过期信息。

该触发器会在插入新数据后，检查下级学科的编码，并根据需要进行更新；同时在插入新数据时，将原先可能有的旧数据标记为过期。

```sql
DROP FUNCTION IF EXISTS subject_insert_trigger_func;
CREATE FUNCTION subject_insert_trigger_func()
RETURNS TRIGGER AS $$
BEGIN
  -- 更新parent_id
  INSERT INTO subject (name, parent_id, self_id, start_date, end_date)
  SELECT 
    name, 
    COALESCE(CAST(NEW.parent_id AS TEXT), '') || NEW.self_id, 
    self_id, 
    NEW.start_date, 
    NULL
  FROM subject_full_id(NEW.start_date)
  WHERE parent_id IN (
    SELECT full_id
    FROM subject_full_id(NEW.start_date)
    WHERE name = NEW.name
  );

  -- 更新end_date
  UPDATE subject
  SET end_date = NEW.start_date
  WHERE id IN (
    SELECT id
    FROM subject_full_id(NEW.start_date)
    WHERE (
        (self_id = NEW.self_id AND parent_id = NEW.parent_id) OR
        name = NEW.name
      ) AND
      end_date IS NULL
  );

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
```

在这个触发器对学科编码更改的处理逻辑中，由于对数据表进行了下一级学科的插入操作，于是触发器会被递归触发，以确保所有下级学科的编码都能得到更新。

== 查询逻辑设计

为了方便针对特定时间节点进行学科编码的查询，设计了一个函数 `subject_full_id`，用于根据时间节点查询拼接后的完整学科编码。该函数将根据输入的时间参数，结合 `start_date` 和 `end_date` 字段，返回对应的学科编码。

```sql
DROP FUNCTION IF EXISTS subject_full_id;
CREATE FUNCTION subject_full_id(target_date DATE)
RETURNS TABLE(
  id INTEGER,
  name VARCHAR(50),
  full_id TEXT,
  parent_id VARCHAR(10),
  self_id VARCHAR(10),
  start_date DATE,
  end_date DATE
) AS $$
BEGIN
  RETURN QUERY SELECT
    subject.id AS id,
    subject.name AS name,
    -- 拼接完整的学科编码
    COALESCE(subject.parent_id, '') || subject.self_id AS full_id,
    subject.parent_id AS parent_id,
    subject.self_id AS self_id,
    subject.start_date AS start_date,
    subject.end_date AS end_date
  FROM subject
  WHERE
    -- 根据时间节点筛选数据
    subject.start_date <= target_date AND
    (subject.end_date IS NULL OR subject.end_date > target_date);
END;
$$ LANGUAGE plpgsql;
```

创建这个函数后，可以通过调用 `subject_full_id` 函数来查询特定时间节点的学科编码。

例如，查询 2010 年 8 月 31 日的学科编码，可以使用以下 SQL 语句：

```sql
SELECT * FROM subject_full_id('2010-08-31');
```

查询结果如下：

#figure(
  image("assets/subject_full_id_1.png", height: 40%),
  caption: "2010 年 8 月 31 日的学科编码查询结果",
)

再进行 2016 年 8 月 31 日的学科编码查询，结果如下：

#figure(
  image("assets/subject_full_id_2.png", height: 40%),
  caption: "2016 年 8 月 31 日的学科编码查询结果",
)

可以看见，在我们的学科编号数据中，由于 2014 年学科大类编号从 2 位变为了 3 位，导致了在后续的时间点进行查询时，各个学科的编号和生效时间、失效时间都发生了相对应的变化。

再对 2018 年 6 月 1 日的学科编码进行查询，结果如下：

#figure(
  image("assets/subject_full_id_3.png", height: 40%),
  caption: "2018 年 6 月 1 日的学科编码查询结果",
)

可以看见，由于 2018 年 1 月 1 日发生的变化，在后续的时间点进行查询时，各个学科的数据行也都发生了相对应的变化。