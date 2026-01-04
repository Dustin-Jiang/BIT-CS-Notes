#import "./undergraduate-thesis-template/template.typ" as template

#show: template.paper.with(
  subject: "网络开拓者协会",
  title: "电脑诊所管理系统 设计需求",
  header: "电脑诊所管理系统 设计需求",
  college: "计算机学院",
  major: "软件工程",
  class: "08012301班",
  author: "蒋浩天 叶子宁 时佳",
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

#include "./Assign3/AssignTask.typ"

