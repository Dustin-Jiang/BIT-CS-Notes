#import "./undergraduate-thesis-template/template.typ" as template

#show: template.paper.with(
  subject: "网络开拓者协会",
  title: "电脑诊所管理系统 数据库设计与开发文档",
  header: "电脑诊所管理系统 数据库设计与开发文档",
  college: "计算机学院",
  major: "软件工程",
  class: "08012301班",
  author: "蒋浩天 叶子宁 时佳",
  student-id: "",
  date: datetime(
    year: 2025,
    month: 4,
    day: 30,
  ),
  declare: false,
)

#show raw: set text(
  font: ("Cascadia Code PL", "Microsoft YaHei UI"),
  size: 9pt,
  ligatures: true,
)

= 数据库设计

#include "./Assign3/DatabaseDesign.typ"

= API文档

#include "./API.typ"
