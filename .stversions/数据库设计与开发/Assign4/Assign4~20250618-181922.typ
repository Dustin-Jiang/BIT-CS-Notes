#import "../undergraduate-thesis-template/template.typ" as template

#show: template.paper.with(
  subject: "数据库设计与开发",
  title: "作业四 内存型数据库前沿研究",
  header: "作业四 内存型数据库前沿研究",
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

#include "Declaration.typ"

= 作业要求

#include "AssignTask.typ"

= 内存数据库的定义

#include "MemoryDatabase.typ"

= 内存数据库的特点

#include "Features.typ"

= 内存数据库的应用

#include "Applications.typ"

= 前沿领先的内存数据库

#include "LeadingMemoryDatabase.typ"

= 总结与思考

#include "Conclusion.typ"

#template.references("./ref.bib")