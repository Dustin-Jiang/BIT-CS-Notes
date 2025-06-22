DROP TABLE IF EXISTS subject;

CREATE TABLE subject (
  id SERIAL NOT NULL PRIMARY KEY,
  name VARCHAR(50),
  parent_id VARCHAR(10), -- 递归层级关系
  self_id VARCHAR(10) NOT NULL, -- 代码唯一标识
  start_date DATE NOT NULL, -- 代码生效时间
  end_date DATE -- 代码失效时间 (NULL表示当前有效)
);

-- 创建函数方便查询
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
    COALESCE(subject.parent_id, '') || subject.self_id AS full_id,
    subject.parent_id AS parent_id,
    subject.self_id AS self_id,
    subject.start_date AS start_date,
    subject.end_date AS end_date
  FROM subject
  WHERE
    subject.start_date <= target_date AND
    (subject.end_date IS NULL OR subject.end_date > target_date);
END;
$$ LANGUAGE plpgsql;

-- 使用触发器更新
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

DROP TRIGGER IF EXISTS subject_before_insert ON subject;
CREATE TRIGGER subject_before_insert BEFORE INSERT ON subject
  FOR EACH ROW EXECUTE PROCEDURE subject_insert_trigger_func();

-- 插入测试数据
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