=== 在表上建立触发器实现主外键功能

由于OpenGauss的限制, 触发器的主体只能是对函数或者存储过程的调用, 因此我们将触发器的主体剥离为函数, 包含对主键和外键的检查逻辑。

#raw(
  read("./create-trigger.sql"),
  lang: "sql",
  block: true
)

将上述 SQL 语句保存为 `Create-Trigger.sql` 文件, 然后使用 `gsql`工具连接到数据库, 执行该 SQL 文件. 可以通过尝试添加不合法数据来验证触发器的创建成功与否. 例如:

```sql
-- 插入不合法数据
INSERT INTO xyb (ydh, ymc) VALUES ('06', '车辆工程学院'); -- 合法数据
INSERT INTO xyb (ydh, ymc) VALUES ('06', '对外关系学院'); -- 重复的 ydh
```

#figure(
  image("assets/trigger-functioning.png"),
  caption: "触发器功能验证",
)

可以看见, 我们创建的触发器成功地阻止了有相同主键的不合法数据的插入, 这表明触发器的创建成功。

=== 讨论触发器与主外键的异同

触发器和主外键约束都是用于维护数据完整性和一致性的机制，但它们在实现方式和应用场景上都有较大区别。

#strong[触发器的优点:] 
1. 灵活性: 触发器可以执行任意复杂的逻辑，不仅限于简单的约束检查。
2. 可定制性: 可以根据具体业务需求自定义错误信息和处理逻辑。
3. 功能扩展: 除了约束检查，还可以实现审计日志、数据同步等功能。

#strong[主外键的优点:] 
1. 性能优势: 数据库系统对主外键约束进行了优化，执行效率更高。
2. 维护简单: 无需编写和维护额外的代码。
3. 标准化: 是数据库标准的一部分，可移植性好。

#linebreak()

- 如果只需要简单的引用完整性约束，优先使用主外键约束。
- 当需要复杂的业务逻辑或特殊的错误处理时，选择触发器实现。
- 在某些情况下，可以同时使用两者来获得最佳效果。

=== 在表上建立触发器实现对数据录入修改的限制

假设需要限制学生表中学号的长度为 8 位, 学生出生日期不得晚于当前日期, 这些数据限制可以通过触发器来实现. 

```sql
CREATE OR REPLACE FUNCTION check_student_data()
RETURNS TRIGGER AS $$
BEGIN
  -- 检查学号长度
  IF LENGTH(NEW.xh) != 8 THEN
    RAISE EXCEPTION '学号长度必须为 8 位';
  END IF;

  -- 检查出生日期
  IF NEW.chrq > CURRENT_DATE THEN
    RAISE EXCEPTION '出生日期不能晚于当前日期';
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 删除旧的触发器
DROP TRIGGER check_student_data_trigger ON xs;

-- 创建触发器
CREATE TRIGGER check_student_data_trigger
BEFORE INSERT OR UPDATE ON xs
FOR EACH ROW
EXECUTE PROCEDURE check_student_data();
```

将上述 SQL 语句保存为 `Create-Student-Trigger.sql` 文件, 然后使用 `gsql`工具连接到数据库, 执行该 SQL 文件. 

可以通过尝试添加不合法数据来验证触发器的创建成功与否. 例如:

```sql
-- 插入不合法数据
INSERT INTO xs (xh, xm, chrq) VALUES ('12345678', '张三', '2025-08-01'); -- 出生日期晚于当前日期
INSERT INTO xs (xh, xm, chrq) VALUES ('1234567', '李四', '2000-01-01'); -- 学号长度不合法
```

#figure(
  image("assets/trigger-functioning-2.png"),
  caption: "触发器功能验证",
)
