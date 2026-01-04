- 在华为云上购买ECS服务器，安装OpenGauss数据库
- 在华为云上购买ECS数据库服务器
- 使用VirtualBox安装 OpenEuler 虚拟机并连接到其中的OpenGauss数据库
- 在OpenGauss数据库中创建数据库、数据表
- 建立“学籍与成绩管理系统”表格；
  - 包含以下信息
    - 课程名称
    - 课程代号
    - 课程类型（必修、选修、任选）
    - 学分
    - 任课教师姓名
    - 教师编号
    - 教师职称
    - 教师所属学院名称
    - 教师所属学院代号
    - 教师所授课程
    - 学生姓名
    - 学生学号
    - 学生所属学院名称
    - 学生所属学院代号
    - 学生所选课程
    - 学生成绩
  - 建立表之间的参照关系
  - 建立适当的索引
  - 在实验三说明建立索引的原因

#linebreak()

学籍与成绩管理系统表格设计如下
#figure(
  table(
    columns: (auto, auto, auto, auto, auto, auto),
    align: center,
    [字段名], [字段含义], [字段类型], [字段长度], [NULL], [备注],
    [xm], [姓名], [字符], [8], [], [],
    [xh], [学号], [字符], [10], [], [PK],
    [ydh], [所属学院代号], [字符], [2], [#sym.checkmark], [FK],
    [bj], [班级], [字符], [8], [#sym.checkmark], [],
    [chrq], [出生日期], [日期], [], [#sym.checkmark], [],
    [xb], [性别], [字符], [2], [#sym.checkmark], [],
  ),
  caption: "学生表设计",
)

#figure(
  table(
    columns: (auto, auto, auto, auto, auto, auto),
    align: center,
    [字段名], [字段含义], [字段类型], [字段长度], [NULL], [备注],
    [kcbh], [课程编号], [字符], [3], [], [PK],
    [kcmc], [课程名称], [字符], [20], [], [],
    [kclx], [课程类型], [字符], [2], [#sym.checkmark], [],
    [xf], [学分], [数字], [5.1], [#sym.checkmark], [],
  ),
  caption: "课程表设计",
)

#figure(
  table(
    columns: (auto,auto,auto,auto,auto,auto),
    [字段名], [字段含义], [字段类型], [字段长度], [NULL], [备注],
    [xm], [姓名], [字符], [8], [], [],
    [jsbh], [教师编号], [字符], [10], [], [PK],
    [zc], [职称], [字符], [6], [#sym.checkmark], [],
    [ydh], [所属学院代号], [字符], [2], [#sym.checkmark], [FK],
  ),
  caption: "教师表设计",
)

#figure(
  table(
    columns: (auto,auto,auto,auto,auto,auto),
    align: center,
    [字段名], [字段含义], [字段类型], [字段长度], [NULL], [备注],
    [ydh], [学院代号], [字符], [2], [], [PK],
    [ymc], [学院名称], [字符], [30], [], []
  ),
  caption: "学院表设计",
)

#figure(
  table(
    columns: (auto,auto,auto,auto,auto,auto),
    align: center,
    [字段名], [字段含义], [字段类型], [字段长度], [NULL], [备注],
    [kcbh], [课程编号], [字符], [3], [], [PK,FK1],
    [bh], [教师编号], [字符], [10], [], [PK,FK2]
  ),
  caption: "授课表设计",
)

#figure(
  table(
    columns: (auto,auto,auto,auto,auto,auto),
    align: center,
    [字段名], [字段含义], [字段类型], [字段长度], [NULL], [备注],
    [xh], [学号], [字符], [10], [], [PK],
    [kcbh], [课程编号], [字符], [3], [], [PK,FK1],
    [jsbh], [教师编号], [字符], [10], [], [PK,FK1],
    [ch], [成绩], [数字], [5.1], [#sym.checkmark], [],
  ),
  caption: "课程表设计",
)