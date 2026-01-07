#import "../undergraduate-thesis-template/template.typ" as template

#figure(
  template.three-line-table(
    header: ("类别", "要求", "完成情况"),
    ([*前台开发*], "表的增删改查", [$checkmark$]),
    ("", "有界面表级联操作", [$checkmark$]),
    ("", "有应用程序用户权限管理", [$checkmark$]),
    ("", "采用Delphi至少5种组件", [$checkmark$]),
    ([*数据设计*], "视图", [$checkmark$]),
    ("", "动态 SQL", [$checkmark$]),
    ("", "存储过程/函数", [$checkmark$]),
    ("", "触发器", [$checkmark$]),
    ([*文档*], "功能需求、设计说明", [$checkmark$]),
    ("", "含ER图，范式证明", [$checkmark$]),
    ("", "使用说明书", [$checkmark$]),
    ("", "源代码、可执行文件", [$checkmark$]),
    ("", "数据库SQL语句", [$checkmark$]),
    ("", "数据库备份", [$checkmark$]),
  ),
  caption: "得分情况",
)
