储存学生个人信息时，籍贯信息是经常设计的一部分。但由于我国在过去数十年间，对行政区划进行了大量的调整，导致了籍贯信息的设计需要不断更新和调整，以确保其准确性和有效性。

为确保籍贯信息的准确性，设计了籍贯信息表，以便及时反映行政区划的变化。该表将包含各个地区的名称、编码、以及地区的变更信息，以支持对籍贯信息的动态管理和查询。

数据表的设计如下：

```sql
CREATE TABLE region (
  id VARCHAR(6) NOT NULL PRIMARY KEY,
  name VARCHAR(40) NOT NULL,
  -- 变更后的编号
  replaced_by VARCHAR(6),
  UNIQUE(id)
);
```

其中，`id` 列储存的是符合我国居民身份证号中地区信息编码规则的六位编码，如：`110101` 表示北京市东城区。`replaced_by` 列储存的是变更后的编号，例如，在重庆市从四川省脱离，成为直辖市时，原编码 `510200` 的 `replaced_by` 列将被更新为新的编码 `500100`。此时进行查询，不论是使用 `510200` 还是 `500100` ，查询到的地区名称都将是 *重庆市* 而非过时的 *四川省重庆市*。

插入的数据如下：

```sql
INSERT INTO region (id, name, replaced_by) VALUES
('110000', '北京市', NULL),
('110100', '北京市市辖区', NULL),
('110200', '北京市县','110100'),   -- 已撤销，改为市辖区
('120000', '天津市', NULL),
('120100', '天津市市辖区', NULL),
('120200', '天津市县','120100'),   -- 已撤销，改为市辖区
......
('654200', '新疆维吾尔族自治区塔城地区', NULL),
('654300', '新疆维吾尔族自治区阿勒泰地区', NULL),
('659000', '新疆维吾尔族自治区直辖县级行政单位', NULL);
```

为方便查询，可以创建视图以简化查询过程。创建视图的 SQL 语句如下：

```sql
CREATE VIEW region_view AS
SELECT 
  l.id,
  COALESCE(r.name, l.name) AS name,
  l.replaced_by
FROM region l
LEFT JOIN region r ON l.replaced_by = r.id;
```

可以看到，视图 `region_view` 通过 `JOIN` 进行列的连接，显示所有地区的现行名称和编号。通过使用 `COALESCE` 函数，可以确保即使在没有变更的情况下，查询结果也能正确显示地区名称。

对视图进行查询，结果如下：

#figure(
  image("assets/query_region_view.png", height: 40%),
  caption: "籍贯视图查询结果",
)