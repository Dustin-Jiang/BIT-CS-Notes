#import "../undergraduate-thesis-template/template.typ" as template

#show: template.paper.with(
  subject: "本科生实验报告",
  title: "数据库设计与开发实验二 数据库查询",
  header: "数据库设计与开发实验二 数据库查询",
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

== 连接到数据库

=== 使用 PuTTY 连接到 OpenGauss 数据库

#include "PuttyConnect.typ"

=== 使用 Data Studio 连接到 OpenGauss 数据库

#include "DataStudioConnect.typ"

=== 使用 Cloudbeaver 连接到 OpenGauss 数据库

#include "CloudbeaverConnect.typ"

== 建立数据库

#include "CreateDatabase.typ"

== 查询数据库

#include "QueryDatabase.typ"

== 修改数据库数据

#include "EditData.typ"

#include "Conclusion.typ"