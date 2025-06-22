#let show-mainbody(body) = {
  set text(font: ("IBM Plex Sans", "Source Han Sans"), hyphenate: false)

  set par(
    leading: 1.15em,
    first-line-indent: (
      amount: 2em,
      all: true,
    ),
    justify: true,
  )

  show heading.where(level: 2): it => {
    set block(
      above: 1.5em,
      below: 1em,
    )
    it
  }

  body
}

#show: show-mainbody;

= 数据库设计与开发 作业二加分申请

#block(
  table(
    columns: (1fr, 1fr, 1fr),
    stroke: none,
    [08012301], [蒋浩天], [1120231337],
  ),
  width: 60%,
)

== 触发器逻辑设计

在设计嵌套的学科结构时，使用触发器来处理下级编码的更新。

触发器会在插入或更新学科表时自动计算下级编码，并将其存储在相应的字段中。而在触发器处理函数中，又对更改学科的子学科记录进行了插入或更新，这样触发器就会被嵌套触发，从而确保学科编码的一致性和正确性。

== 逻辑封装

在设计学科表和学生表时，将复杂的逻辑封装在了函数中，以便于后续的查询和维护。

== 动态列的交叉表查询

在设计成绩表查询时，在不使用 DBMS 提供的 `CROSS` 方法的情况下，使用了动态生成列的交叉表查询。在使用时，只需要调用 `DO` 块，即可获得动态生成的 SQL 查询语句。