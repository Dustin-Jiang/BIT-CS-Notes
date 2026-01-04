#import "../undergraduate-thesis-template/template.typ" as template

#show: template.paper.with(
  subject: "网络开拓者协会",
  title: "电脑诊所管理系统 数据库设计与实现",
  header: "电脑诊所管理系统 数据库设计与实现",
  college: "计算机学院",
  major: "软件工程",
  class: "08012301班",
  author: "蒋浩天",
  student-id: "",
  date: datetime(
    year: 2025,
    month: 5,
    day: 20,
  ),
  declare: false,
)

#show raw: set text(
  font: ("Cascadia Code PL", "Microsoft YaHei UI"),
  size: 9pt,
  ligatures: true,
)

= 设计要求

#include "AssignTask.typ"

= 数据库设计

#include "DatabaseDesign.typ"

= 评分

#include "Grading.typ"

#include "Usage_copy.typ"
