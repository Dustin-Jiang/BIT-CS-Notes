#import "../undergraduate-thesis-template/template.typ" as template

#show: template.paper.with(
  subject: "本科生实验报告",
  title: "数据库设计与开发实验一 建立数据库",
  header: "数据库设计与开发实验一 建立数据库",
  college: "计算机学院",
  major: "软件工程",
  class: "08012301班",
  author: "蒋浩天",
  student-id: "1120231337",
  date: datetime.today(),
  declare: false,
)

= 实验任务

#include "ExpTask.typ"

= 实验过程

== 购买ECS服务器，安装OpenGauss数据库

#include "ECSDeploy.typ"

== 购买ECS数据库服务器

#include "RDSBuy.typ"

== 使用虚拟机安装OpenGauss数据库

#include "VMDeploy.typ"

== 使用Docker容器化部署OpenGauss数据库

#include "ContainerDeploy.typ"

== 建立数据表及索引

#include "CreateTable.typ"

= 实验结论

通过本次实验，我成功完成了数据库环境的搭建和基础数据表的设计与创建，获得了以下实验结论：

+ 多种数据库部署方式对比

  - ECS自建数据库：通过华为云ECS服务器自行安装配置OpenGauss数据库，具有较高的灵活性和可控性，但需要自行管理数据库运行环境和后续维护。
  - 云数据库RDS服务：华为云提供的托管PostgreSQL数据库服务，具有易用性高、运维简单的特点，适合快速部署且无需关注底层运维的场景。
  - 虚拟机本地部署：通过VirtualBox安装OpenEuler并使用其中的OpenGauss数据库，适合学习和开发环境，不依赖网络和云服务，便于本地调试和学习。

+ 数据库设计与实现

  - 成功设计并实现了学籍与成绩管理系统的六张数据表：学生表(xs)、教师表(js)、课程表(kc)、学院表(xyb)、授课表(sk)和学生选课表(xk)。
  - 建立了合理的表间关系，通过主外键约束保证了数据的完整性和一致性。
  - 采用了规范化的数据库设计方法，避免了数据冗余，使数据结构清晰合理。

+ 索引设计

  - 针对查询频率高的字段创建了适当的索引，如学号、课程编号、教师编号等。
  - 为外键字段如ydh(学院代号)建立索引，提高关联查询效率。
  - 为成绩字段cj创建索引，便于成绩统计和排序操作。
  - 索引设计兼顾了查询效率和写入开销的平衡。

+ 数据安全与完整性

  - 通过主键、唯一约束、非空约束等方式确保了数据的唯一性和完整性。
  - 通过外键约束维护了表之间的引用完整性，防止了数据不一致的情况出现。

= 实验体会

本次实验通过多种方式成功搭建了数据库环境，并完成了学籍与成绩管理系统的数据库设计与创建，为后续的数据操作和应用开发奠定了基础。

  - 掌握了OpenGauss数据库的安装、配置和基本管理方法。
  - 熟悉了SQL语言在数据定义(DDL)方面的应用，包括表的创建和索引的建立。
  - 了解了数据库外键约束的设置和作用。
  - 学会了使用华为云服务部署数据库环境。

实验中使用的多种部署方式各有优缺点，可以根据不同的应用场景灵活选择。数据库设计遵循了规范化原则，合理建立了索引，为系统的高效运行提供了保障。