=== 以不同身份用户登录数据库建立表

使用 SSH 连接到服务器，切换到 `omm` 用户, 使用 `gsql` 命令连接到数据库。连接到数据库后，使用 `CREATE USER` 命令创建一个新用户。

```sql
CREATE USER starlight PASSWORD 'PositionZER0@123';
```

#figure(
  image("assets/create-user.png", height: 35%),
  caption: "创建用户"
)

创建成功后, 使用 `\q` 命令退出数据库。使用新创建的用户登录数据库。

```bash
gsql -d postgres -U starlight -W PositionZER0@123
```

#figure(
  image("assets/login-with-new-user.png", height: 35%),
  caption: "登录用户"
)

使用与实验二中一样的语句创建学院表 `xyb`. 

```sql
CREATE TABLE IF NOT EXISTS xyb ( -- 创建学院表，存储学院基础信息
    ydh CHAR(2) PRIMARY KEY NOT NULL,  -- 学院代号，主键（不允许空，固定长度2字符）
    ymc CHAR(30) NOT NULL             -- 学院名称（不允许空，固定长度30字符）
);
```
执行之后, 使用 `\dt` 命令查看表格信息, 可以看到表格创建成功.

从 `\dt` 命令的结果可以发现, 尽管表名相同, 但是表格的 Schema 不同. 用户 _starlight_ 建立的 `xyb` 表格在 `starlight` 这一 Schema 下. 这说明了不同用户创建的表格是相互独立的, 互不影响. 

#figure(
  image("assets/user-create-table.png", height: 35%),
  caption: "创建学院表"
)

向 `xyb` 表格中插入不同数据, 便于后续实验中进行区分.

=== 以不同身份用户查询自己与其他用户建立的表

以用户 _starlight_ 登录数据库, 使用 `\dt` 命令查看表格信息. 可以看到, 该用户只能看到自己创建的表格, 不能看到其他用户创建的表格.

使用 `SELECT` 语句查询用户 _starlight_ 创建的 `xyb` 表格.

```sql
SELECT * FROM xyb;
```

#figure(
  image("assets/query-self-table.png", height: 35%),
  caption: "查询自己创建的表格"
)

若需要查询用户 _cloudb_ 创建的 `xyb` 表格, 如果直接使用 `SELECT` 语句, 会提示权限拒绝. 这是因为用户 _starlight_ 没有权限访问其他用户创建的表格.

```sql
SELECT * FROM cloudb.xyb;
```

#figure(
  image("assets/query-other-table-fail.png", height: 35%),
  caption: "查询其他用户创建的表格提示权限拒绝"
)

若要给予用户 _starlight_ 访问用户 _cloudb_ 创建的 `xyb` 表格的权限, 需要使用 `GRANT` 命令. 以用户 _omm_ 登录数据库, 使用 `GRANT` 命令给予用户 _starlight_ Schema和对应表格的访问权限.

```sql
GRANT USAGE ON SCHEMA cloudb TO starlight;
GRANT SELECT ON TABLE cloudb.xyb TO starlight;
```

执行成功后, 以用户 _starlight_ 登录数据库, 使用 `SELECT` 语句查询用户 _cloudb_ 创建的 `xyb` 表格.

#figure(
  image("assets/query-other-table-success.png", height: 35%),
  caption: "授权后成功查询其他用户创建的表格"
)

=== 定义授权方案并进行验证

例如需要给予用户 _starlight_ 对用户 _cloudb_ 创建的 `xyb` 表格的访问权限, 对 `xs` 表格的访问与修改权限, 对 `xk` 表无访问权限. 这时可以使用 `GRANT` 命令给予用户 _starlight_ 对应的权限.

```sql
GRANT USAGE ON SCHEMA cloudb TO starlight;
GRANT SELECT ON TABLE cloudb.xyb TO starlight;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE cloudb.xs TO starlight;
```

执行成功后, 以用户 _starlight_ 登录数据库, 使用 `SELECT` 语句可顺利查询用户 _cloudb_ 创建的 `xyb` 表格; 
使用 `INSERT`, `UPDATE`, `DELETE` 语句可顺利修改到用户 _cloudb_ 创建的 `xs` 表格; 
使用 `SELECT` 语句查询用户 _cloudb_ 创建的 `xk` 表格时, 提示权限拒绝.

```sql
SELECT * FROM cloudb.xyb;
INSERT INTO cloudb.xs (xm, xh, ydh, bj, chrq, xb) VALUES ('巴珠绪', '20230111', '01', '计算机科学与技术', '2003-01-01', '女');
SELECT * FROM cloudb.xk;
```

#figure(
  image("assets/set-permissions.png", height: 35%),
  caption: "成功设置权限"
)