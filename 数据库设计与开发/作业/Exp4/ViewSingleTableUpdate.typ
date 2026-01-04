假设需要查询所有选课记录的成绩, 将低于90分的成绩都加上5分, 之后删除所有小于等于80分的选课记录.

由于我们只关心选课表中的成绩, 因此我们可以创建一个单表视图, 该视图只包含成绩, 学生学号, 课程编号.
创建视图的语句如下:

```sql
CREATE OR REPLACE VIEW xk_cj_view("学生学号","课程编号","课程成绩") AS (
  SELECT xh,kcbh,cj FROM xk
);
```

#figure(
  image("assets/create-single-view-success-2.png"),
  caption: "成功创建单表视图"
)

由于 OpenGauss 中数据库视图默认为只读模式，默认不支持更新和删除操作，因此要想使用视图来更新、删除数据，必须通过 Rule 实现。

因此为 `xk_cj_view` 视图添加 Rule, 使其支持更新和删除操作.

```sql
CREATE OR REPLACE RULE xk_cj_view_update AS ON UPDATE TO xk_cj_view DO INSTEAD
(
  UPDATE xk SET cj = NEW."课程成绩"
    WHERE xh = NEW."学生学号" AND kcbh = NEW."课程编号"
);
CREATE OR REPLACE RULE xk_cj_view_delete AS ON DELETE TO xk_cj_view DO INSTEAD
(
  DELETE FROM xk
    WHERE xh = OLD."学生学号" AND kcbh = OLD."课程编号"
);
```

创建 Rules 成功后, 我们可以直接使用 SQL 语句对视图进行更新和删除操作.

```sql
UPDATE xk_cj_view SET "课程成绩" = "课程成绩" + 5 WHERE "课程成绩" < 90;
DELETE FROM xk_cj_view WHERE "课程成绩" <= 80;
```

#figure(
  image("assets/update-single-view-success.png"),
  caption: "成功更新视图中的数据"
)

可以看到, 数据库返回更新和删除成功的消息. 查询数据库也可以确定, 数据表中的数据已经被更新或删除. 