=== 查询计划 ```sql EXPLAIN```

重置数据库之后, 利用查询计划 (```sql EXPLAIN```) 对查询语句进行分析。

```sql
EXPLAIN SELECT * FROM xs WHERE xh IN (
  SELECT xh FROM xs WHERE xh IN (
    SELECT xh FROM xk WHERE cj < 75
  )
);
```

在图中，我们可以看到每一步运行的时间，从而可以判断哪一步是最需要优化的步骤。

#figure(
  image("assets/query-explain.png", height: 40%),
  caption: "查询计划分析",
)

接下来，我们观察去掉所有约束和主键索引后查询效率发生的变化. 

```sql
ALTER TABLE js DROP CONSTRAINT IF EXISTS js_pkey CASCADE;
ALTER TABLE js DROP CONSTRAINT IF EXISTS idx_js_ydh CASCADE;
ALTER TABLE kc DROP CONSTRAINT IF EXISTS kc_pkey CASCADE;
ALTER TABLE kc DROP CONSTRAINT IF EXISTS idx_kc_kc CASCADE;
ALTER TABLE kc DROP CONSTRAINT IF EXISTS idx_kc_xf CASCADE;
ALTER TABLE sk DROP CONSTRAINT IF EXISTS sk_pkey CASCADE;
ALTER TABLE xk DROP CONSTRAINT IF EXISTS xk_pkey CASCADE;
ALTER TABLE xk DROP CONSTRAINT IF EXISTS idx_xk_cj CASCADE;
ALTER TABLE xk DROP CONSTRAINT IF EXISTS idx_xk_jsbh CASCADE;
ALTER TABLE xk DROP CONSTRAINT IF EXISTS idx_xk_kcbh CASCADE;
ALTER TABLE xs DROP CONSTRAINT IF EXISTS xs_pkey CASCADE;
ALTER TABLE xs DROP CONSTRAINT IF EXISTS idx_xs_ydh CASCADE;
ALTER TABLE xyb DROP CONSTRAINT IF EXISTS xyb_pkey CASCADE;
```

#figure(
  image("assets/query-explain-noidx.png", height: 40%),
  caption: "查询计划分析 (没有索引)",
)

可知建立索引与不建立索引，查询效率确实会发生一定差异。索引提高数据查找的效率，当数据量非常大时将会变得非常显著。如果建立适当的索引，数据库查询效率将会大幅度提高。

我们建立两张测试表, 一张有索引, 而一张无索引, 向两张表中插入大量数据, 用于测试大量数据下的性能差异. 

```sql
DROP TABLE IF EXISTS test_table_with_idx;
DROP TABLE IF EXISTS test_table_without_idx;
CREATE TABLE test_table_with_idx(
  id INTEGER PRIMARY KEY,
  x DECIMAL(5,4)
);
CREATE TABLE test_table_without_idx(
  id INTEGER,
  x DECIMAL(5,4)
);
DROP INDEX IF EXISTS t_index;
CREATE INDEX t_index ON test_table_with_idx(x);
DO $$
  BEGIN
    FOR cnt IN 1..100000 LOOP
      INSERT INTO test_table_with_idx(id,x) VALUES (cnt,RANDOM());
      INSERT INTO test_table_without_idx(id,x) VALUES (cnt,RANDOM());
    END LOOP;
  END
$$;
```

然后对两张表分别进行大量查询, 观察查询效率的差异.

```sql
DO $$
  BEGIN
    FOR cnt IN 1..100000 LOOP
      PERFORM * FROM test_table_with_idx WHERE x = 0.5;
    END LOOP;
  END
$$;

DO $$
  BEGIN
    FOR cnt IN 1..100000 LOOP
      PERFORM * FROM test_table_without_idx WHERE x = 0.5;
    END LOOP;
  END
$$;
```

实验表明, 有索引的情况下100000次查询用时仅需2秒, 而没有索引的情况下用时超过了30分钟. 可以看出, 有索引的查询效率明显高于没有索引的查询效率. 这说明了索引在数据库查询中的重要性, 在数据量较大的情况下, 索引可以显著提高查询效率.

#figure(
  image("assets/lookup-with-idx.png", height: 40%),
  caption: "有索引的查询",
)

#figure(
  image("assets/lookup-without-idx.png", height: 40%),
  caption: "没有索引的查询",
)

使用 ```sql EXPLAIN``` 语句可以查看查询计划. 

```sql
EXPLAIN SELECT * FROM test_table_with_idx WHERE x = 0.5;
EXPLAIN SELECT * FROM test_table_without_idx WHERE x = 0.5;
```

#figure(
  grid(columns: 2, gutter: 1em,
    image("assets/explain-with-idx.png"),
    image("assets/explain-without-idx.png"),
  ),
  caption: "查询计划分析 (有索引, 没有索引)",
)

可以看到, 有索引时, 查询采用 Bitmap Heap Scan, 而没有索引时, 查询采用 Seq Scan. Bitmap Heap Scan 是一种高效的查询方式, 它会先在索引中查找符合条件的记录, 然后再在数据表中查找对应的记录. 而 Seq Scan 则是顺序扫描整个数据表, 效率较低. 这也进一步证明了索引在查询中的重要性.