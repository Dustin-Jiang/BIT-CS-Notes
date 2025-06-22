#import "../undergraduate-thesis-template/template.typ" as template

#show: template.paper.with(
  subject: "本科生实验报告",
  title: "数据库设计与开发实验四 数据库开发",
  header: "数据库设计与开发实验四 数据库开发",
  college: "计算机学院",
  major: "软件工程",
  class: "08012301班",
  author: "蒋浩天",
  student-id: "1120231337",
  date: datetime.today(),
  declare: false,
)

#show raw: set text(
  font: ("Cascadia Code PL", "Microsoft YaHei UI"),
  size: 9pt,
  ligatures: true
)

= 实验任务

#include "ExpTask.typ"

= 实验过程

== 建立没有表之间参照关系的表格

#include "CreateDatabase.typ"

== 建立视图

=== 建立适当的视图, 使可直接单表查询学生的总学分与总成绩

#include "ViewSingleTable.typ"

=== 建立适当的视图，将所有的表连接起来

#include "ViewAllTables.typ"

=== 建立单表的视图，通过视图来更新、删除数据

#include "ViewSingleTableUpdate.typ"

=== 建立多表的视图，通过视图来更新、删除数据

#include "ViewMultiTablesUpdate.typ"

== 存储过程

#include "StoredProcedure.typ"

== 触发器

#include "Trigger.typ"

== 讨论视图、存储过程、触发器的使用范围及优缺点

#include "Differences.typ"

#include "Conclusion.typ"