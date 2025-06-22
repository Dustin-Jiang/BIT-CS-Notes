使用 ```sql SELECT``` 和 ```sql WHERE``` 语句可以同时在多个表中查询信息，从而建立多表视图，比如每位同学的姓名，学号，选择课程的编号和对应成绩。

例如, 我们可以建立一个视图，包含学生的姓名、学号、课程编号和对应成绩。

```sql
CREATE OR REPLACE VIEW xs_cj_view("姓名", "学号", "课程编号", "对应成绩") AS
  SELECT xs.xm, xs.xh, xk.kcbh, xk.cj
  FROM xs
  JOIN xk ON xs.xh = xk.xh;
```

#figure(
  image("assets/create-multi-view-success.png"),
  caption: "成功创建多表视图"
)

可以看到视图已经创建成功, 通过 ```sql SELECT``` 和 ```sql WHERE``` 语句可以查询视图中的数据. 

假设现在需要查询所有选课记录的成绩, 将低于80分的成绩设置为 `NULL`, 并为所有与这些记录相关的学生姓名添加后缀 `-非全优良`. 

同样因为 OpenGauss 中数据库视图默认为只读模式，默认不支持更新和删除操作，因此必须通过 Rule 实现。

```sql
CREATE OR REPLACE RULE xs_cj_view_update AS ON UPDATE TO xs_cj_view DO INSTEAD
(
  UPDATE xk SET cj = NULL
    WHERE xh = OLD."学号" AND kcbh = OLD."课程编号" AND cj < 80;
  UPDATE xs SET xm = xm || '-非全优良'
    WHERE xh = OLD."学号";
);
```

创建 Rules 成功后, 我们可以直接使用 SQL 语句对视图进行更新和删除操作.

```sql
UPDATE xs_cj_view SET "对应成绩" = NULL WHERE "对应成绩" < 80;
UPDATE xs_cj_view SET "姓名" = "姓名" || '-非全优良' WHERE "对应成绩" IS NULL;
```

#figure(
  image("assets/update-multi-view-success.png"),
  caption: "成功更新视图中的数据"
)

查询数据库可以确定, 数据表中的数据已经被更新, 部分成绩被设置为 `NULL`, 对应的学生姓名也添加了后缀 `-非全优良`. 这说明我们成功地使用视图对数据进行了更新和删除操作.