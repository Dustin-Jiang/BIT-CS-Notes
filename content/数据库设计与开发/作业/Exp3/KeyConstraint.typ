在每次练习之前, 都先将数据库中的所有数据恢复到实验二中插入数据之后的状态, 以免影响实验结果.

=== 练习更新、删除主表数据（针对主键属性且子表中可能有参照外键数据）

==== 更新数据

将学生表中学号为 `20230108` 的学生的学号改为 `20230111`，并更新所有表中与这个学生相关的记录.

如果我们直接使用下面的 SQL 语句进行更新的话, 会导致外键约束错误, 因为在成绩表中有一条记录通过外键约束引用了学生表中的学号 `20230108`.
```sql
UPDATE xs SET xh='20230111' WHERE xh='20230108';
```

#figure(
  image("assets/update-pk-error.png"),
  caption: "更新主键属性时的外键约束错误",
)

在这种情况下, 如果要修改主表的主键属性, 我们需要先删除子表中引用了这个主键的记录, 然后再进行更新操作. 在更新之后, 我们需要重新插入之前删除的记录. 这种操作显然是比较繁琐, 且容易出错的, 因为我们需要手动删除和插入记录; 一旦我们在删除记录后忘记将记录添加回数据表, 就会导致数据的丢失.

为了避免这种情况, 我们可以使用 `ON UPDATE CASCADE` 选项来定义外键约束, 这样在更新主表的主键属性时, 子表中引用了这个主键的记录会自动更新.

用下面的 SQL 语句, 为数据表创建所需的外键约束.

```sql
ALTER TABLE xs DROP CONSTRAINT IF EXISTS xs_ydh_fkey;
ALTER TABLE xs ADD CONSTRAINT xs_ydh_fkey
  FOREIGN KEY (ydh) REFERENCES xyb(ydh)
  ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE js DROP CONSTRAINT IF EXISTS js_ydh_fkey;
ALTER TABLE js ADD CONSTRAINT js_ydh_fkey
  FOREIGN KEY (ydh) REFERENCES xyb(ydh)
  ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE xk DROP CONSTRAINT IF EXISTS xk_xh_fkey;
ALTER TABLE xk ADD CONSTRAINT xk_xh_fkey
  FOREIGN KEY (xh) REFERENCES xs(xh)
  ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE xk DROP CONSTRAINT IF EXISTS xk_kcbh_fkey_1;
ALTER TABLE xk ADD CONSTRAINT xk_kcbh_fkey_1
  FOREIGN KEY (kcbh,jsbh) REFERENCES sk(kcbh,bh)
  ON UPDATE CASCADE ON DELETE CASCADE;
```

成功创建外键约束后, 我们可以直接使用下面的 SQL 语句进行更新操作.

```sql
UPDATE xs SET xh='20230111' WHERE xh='20230108';
```

此时, 子表中引用了这个主键的记录会自动更新, 不需要手动删除和插入记录.

#figure(
  image("assets/update-pk-success.png"),
  caption: "更新主键属性时的外键约束成功",
)

==== 删除数据

现在将学生表中学号为 `20230111` 的学生删除. 由于我们已经为外键约束定义了 `ON DELETE CASCADE` 选项, 所以在删除主表的主键属性时, 子表中引用了这个主键的记录会自动删除. 

所以我们可以直接使用下面的 SQL 语句进行删除操作.

```sql
DELETE FROM xs WHERE xh='20230111';
```

#figure(
  image("assets/delete-pk-success.png"),
  caption: "删除带有外键约束的主键属性成功",
)

我们可以通过下面的 SQL 语句确定学号为 `20230111` 的学生以及其选课记录已经被删除.

```sql
SELECT * FROM xs WHERE xh='20230111';
SELECT * FROM xk WHERE xh='20230111';
```

可以看见, 查询的结果为空, 说明学号为 `20230111` 的学生已经被删除, 其选课记录也因为外键约束而被删除. 

#figure(
  image("assets/delete-pk-check.png"),
  caption: "外键层联删除成功",
)

=== 练习更新、删除主表数据（针对非主键属性）

==== 更新数据

重置数据表后, 将学生表中学号为 `20230108` 的学生的姓名改为 `长崎素世`.

```sql
UPDATE xs SET xm='长崎素世' WHERE xh='20230108';
SELECT * FROM xs WHERE xh='20230108';
```

可以看见, 在更新数据之后, 查询的结果显示, 学号为 `20230108` 的学生的姓名已经被修改为 `长崎素世`.

#figure(
  image("assets/update-nonpk-success.png", height: 40%),
  caption: "更新非主键属性成功",
)

==== 删除数据

要删除学号为 `20230108` 的学生, 由于我们没有为外键约束定义 `ON DELETE CASCADE` 选项, 所以仍需要先按上面的方法创建外键约束, 这样在删除主表的记录时, 子表中的相关记录会自动删除.

```sql
ALTER TABLE xs DROP CONSTRAINT IF EXISTS xs_ydh_fkey;
ALTER TABLE xs ADD CONSTRAINT xs_ydh_fkey
  FOREIGN KEY (ydh) REFERENCES xyb(ydh)
  ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE js DROP CONSTRAINT IF EXISTS js_ydh_fkey;
ALTER TABLE js ADD CONSTRAINT js_ydh_fkey
  FOREIGN KEY (ydh) REFERENCES xyb(ydh)
  ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE xk DROP CONSTRAINT IF EXISTS xk_xh_fkey;
ALTER TABLE xk ADD CONSTRAINT xk_xh_fkey
  FOREIGN KEY (xh) REFERENCES xs(xh)
  ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE xk DROP CONSTRAINT IF EXISTS xk_kcbh_fkey_1;
ALTER TABLE xk ADD CONSTRAINT xk_kcbh_fkey_1
  FOREIGN KEY (kcbh,jsbh) REFERENCES sk(kcbh,bh)
  ON UPDATE CASCADE ON DELETE CASCADE;
```

创建外键约束后, 我们可以直接使用下面的 SQL 语句进行删除操作.

```sql
DELETE FROM xs WHERE xh='20230108';
```

#figure(
  image("assets/delete-nonpk-success.png", height: 40%),
  caption: "删除非主键属性成功",
)

=== 练习先删除子表数据，再删除主表数据

重置数据库之后, 删除土木工程学院 (代号为05) 的相关信息，并把属于土木工程学院的同学，老师，授课信息以及同学的选课信息删除。

这个操作无法直接使用 `ON DELETE CASCADE` 选项来实现, 我们必须按照 *依赖关系的逆序* 删除数据，即从 *最底层的引用表* 开始删除，逐步向上删除高层表。

```sql
DELETE xk WHERE xk.jsbh IN (SELECT jsbh FROM js WHERE ydh = '05');
DELETE xk WHERE xk.xh IN (SELECT xh FROM xs WHERE ydh = '05');
DELETE sk WHERE sk.bh IN (SELECT jsbh FROM js WHERE ydh = '05');
DELETE js WHERE ydh = '05';
DELETE xs WHERE ydh = '05';
DELETE xyb WHERE ydh = '05';
```

#figure(
  image("assets/delete-tables-in-order.png", height: 40%),
  caption: "成功按顺序删除子表格后删除主表格",
)

=== 使用子查询方式更新、删除数据

==== 更新数据

重置数据表后, 找出没有任何一门成绩小于80的同学，将他们的班级信息更新为“全优良”。

我们可以使用子查询的方式完成这个操作, SQL语句如下: 

```sql
UPDATE xs SET bj='全优良' WHERE xh IN (
  SELECT xh FROM xs WHERE xh NOT IN (
    SELECT xh FROM xk WHERE cj < 80
  )
);
SELECT * FROM xs WHERE bj='全优良';
```

可以看见, 在更新数据之后查询的结果显示, 没有任何一门成绩小于80的同学的班级都为 `全优良`.

#figure(
  image("assets/update-subquery-success.png", height: 40%),
  caption: "使用子查询更新数据成功",
)

==== 删除数据

找出任意一门选课成绩小于75的同学，将他们的信息删除。

同样这需要为外键约束定义 `ON DELETE CASCADE` 选项, 这样在删除主表的记录时, 子表中的相关记录会自动删除.

添加外键约束后, 我们可以直接使用下面的 SQL 语句进行删除操作.

```sql
DELETE FROM xs WHERE xh IN (
  SELECT xh FROM xs WHERE xh IN (
    SELECT xh FROM xk WHERE cj < 75
  )
);
-- 删除后检查
SELECT * FROM xs WHERE xh IN (
  SELECT xh FROM xs WHERE xh IN (
    SELECT xh FROM xk WHERE cj < 75
  )
);
```

可以看见, 在删除数据之后查询的结果显示, 任意一门选课成绩小于75的同学的信息已经被删除.

#figure(
  image("assets/delete-subquery-success.png", height: 40%),
  caption: "使用子查询删除数据成功",
)