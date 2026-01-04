参照实验二的数据库设计, 但去除所有的外键约束, 主键和索引, 通过以下 SQL 语句建立表格. 

```sql
CREATE TABLE IF NOT EXISTS xyb ( 
    ydh CHAR(2) NOT NULL, 
    ymc CHAR(30) NOT NULL 
); 

CREATE TABLE IF NOT EXISTS xs ( 
    xm CHAR(8) NOT NULL, 
    xh CHAR(10) NOT NULL, 
    ydh CHAR(2), 
    bj CHAR(8), 
    chrq DATE, 
    xb CHAR(2) 
); 

CREATE TABLE IF NOT EXISTS js ( 
    xm CHAR(8) NOT NULL, 
    jsbh CHAR(10) NOT NULL, 
    zc CHAR(6), 
    ydh CHAR(2) 
); 

CREATE TABLE IF NOT EXISTS kc ( 
    kcbh CHAR(3) NOT NULL, 
    kc CHAR(20) NOT NULL, 
    lx CHAR(10), 
    xf NUMERIC(5, 1) 
); 

CREATE TABLE IF NOT EXISTS sk ( 
    kcbh CHAR(3), 
    bh CHAR(10) 
); 

CREATE TABLE IF NOT EXISTS xk ( 
    xh CHAR(10), 
    kcbh CHAR(3), 
    jsbh CHAR(10), 
    cj NUMERIC(5, 1) 
); 
```

删除原数据表, 创建新数据表后, 重新插入数据. 

#figure(
  image("assets/create-table.png"),
  caption: "创建没有表之间参照关系的表格"
)