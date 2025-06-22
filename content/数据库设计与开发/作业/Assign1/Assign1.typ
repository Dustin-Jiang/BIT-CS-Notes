#import "../undergraduate-thesis-template/template.typ" as template

#show: template.paper.with(
  subject: "数据库设计与开发",
  title: "作业一 数据库进阶管理",
  header: "作业一 数据库进阶管理",
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

= 准备工作

#include "Preparation.typ"

= 操作系统参数检查

#include "CheckOS.typ"

= 数据库维护

#include "DatabaseMaintenance.typ"

= 备份与恢复

#include "BackupRecovery.typ"

= 总结与体会

#include "Conclusion.typ"