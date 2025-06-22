#import "../undergraduate-thesis-template/template.typ" as template

#show: template.paper.with(
  subject: "本科生实验报告",
  title: "数据库设计与开发实验三 数据库物理设计",
  header: "数据库设计与开发实验三 数据库物理设计",
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

== 创建数据分区表

#include "CreatePartitionTable.typ"

== 体会主键、外键约束

#include "KeyConstraint.typ"

== 体会索引

#include "UseIndex.typ"

== 权限管理

#include "Permission.typ"

#include "Conclusion.typ"