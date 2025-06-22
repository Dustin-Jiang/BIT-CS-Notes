#import "../undergraduate-thesis-template/template.typ" as template

#show: template.paper.with(
  subject: "数据库设计与开发",
  title: "作业三 数据库设计与实现",
  header: "作业三 数据库设计与实现",
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

= 数据库设计

#include "DatabaseDesign.typ"

= 评分

#include "Grading.typ"

= 总结与体会

#include "Conclusion.typ"