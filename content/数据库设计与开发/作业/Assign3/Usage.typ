#let show-mainbody(body) = {
  set text(font: ("IBM Plex Sans", "Source Han Sans"), hyphenate: false, size: 10pt)

  set par(
    leading: 1.15em,
    first-line-indent: (
      amount: 2em,
      all: true,
    ),
    justify: true,
  )

  show heading.where(level: 2): it => {
    set block(
      above: 1.5em,
      below: 1em,
    )
    it
  }

  body
}

#show: show-mainbody;

= 电脑诊所管理系统 使用说明书

#outline(title: [])

== 登录与注册

在使用电脑诊所管理系统之前, 用户需要先进行注册, 注册后才能登录系统. 

#figure(
  image("assets/RegisterForm.png", width: 35%),
  caption: "注册界面",
)

注册表单会检查用户输入的信息是否完整, 注册所用的学号是否已存在. 若用户输入的信息存在上述问题, 系统会提示问题所在, 并要求用户重新输入.

#figure(
  image("assets/RegisterFormUserExists.png", width: 35%),
  caption: "注册界面错误提示 - 用户已存在",
)

登录时, 用户需要输入用户名和密码, 系统会验证用户的身份信息. 

如果用户输入的学号不存在, 系统会提示用户重新输入; 如果用户输入的密码错误, 系统会提示用户重新输入密码.

#figure(
  grid(
    columns: 2,
    gutter: 10pt,
    image("assets/LoginFormUserNotExists.png", width: 100%),
    image("assets/LoginFormWrongPassword.png", width: 100%),
  ),
  caption: "登录界面错误提示：(左) 用户不存在；(右) 密码错误"
)

== 以普通用户身份登录

以普通用户身份登录后, 用户可以查看自己的预约信息, 查看公告, 也可以修改预约信息, 修改个人信息和取消预约.

#figure(
  image("assets/UserMainForm.png", width: 75%),
  caption: "普通用户主界面",
)

修改预约信息时, 预约时间选框中的选项会根据用户选择的预约地点自动更新, 且只显示尚未预约满的时间点. 这使得用户在选择预约地点时, 可以根据选择的地点预约合适的时间段, 提高了用户体验.

#figure(
  image("assets/UserMainFormDatePicker.png", width: 75%),
  caption: "修改预约信息",
)

点击 "新建预约" 按钮后, 系统会弹出预约表单, 用户可以在表单中填写预约信息.

#figure(
  image("assets/UserNewAppointment.png", width: 50%),
  caption: "新建预约",
)

同样, 在新建预约的表单中, 预约时间选框中的选项会根据用户选择的预约地点自动更新, 且只显示尚未预约满的时间点. 此外, 在提交时, 系统会检查用户输入的信息是否完整, 预约时间是否冲突, 预约地点是否存在. 如果用户输入的信息存在上述问题, 系统会提示问题所在, 并要求用户重新输入.

#figure(
  image("assets/UserNewAppointmentError.png", width: 50%),
  caption: "新建预约错误提示",
)

== 以工作人员身份登录

以工作人员身份登录后, 工作人员可以查看所有预约信息, 修改预约状态与信息.

#figure(
  image("assets/WorkerMainForm.png", width: 100%),
  caption: "工作人员主界面",
)

其中, 左上角的预约时间选框中的选项会根据工作人员选择的诊所地点自动更新, 实现了级联操作. 

#figure(
  image("assets/WorkerMainFormDatePicker.png", width: 40%),
  caption: "工作人员主界面 - 预约时间级联选择",
)

工作人员可以根据实际工作情况, 选择对应的预约记录, 修改其状态与信息. 

#figure(
  image("assets/WorkerMainFormChangeStatus.png", width: 50%),
  caption: "工作人员主界面 - 修改预约状态",
)

系统会根据预约记录的状态改变, 自动修改预约记录中的一些字段. 例如, 当工作人员将预约记录的状态修改为 "正在处理" 时, 系统会自动修改预约记录中的 "到达时间" 字段; 当有工作人员修改记录时, 会自动修改该记录的关联工作人员. 

这使得工作人员在修改预约记录时, 不需要手动输入一些字段, 提高了工作效率, 也便于管理员进行数据统计.

== 以管理员身份登录

以管理员身份登录后, 管理员可以查看所有预约信息, 修改预约状态与信息, 也可以添加新的工作人员, 删除工作人员, 修改工作人员信息, 管理公告, 管理诊所场地, 设置诊所场地的预约时间段. 

#figure(
  image("assets/AdminMainForm.png", width: 90%),
  caption: "管理员主界面",
)

可以看到, 管理员的主界面与工作人员的主界面类似, 但由于管理员具有管理权限, 因此界面中显示了管理功能的相关按钮.

由于管理员同时也是工作人员, 因此在管理员的主界面中, 也可以查看所有预约信息, 修改预约状态与信息. 使用方法同工作人员.

=== 用户管理功能

点击 "用户管理" 按钮后, 系统会弹出用户管理界面, 管理员可以在界面中查看所有用户的信息, 修改用户的信息和权限, 为用户设置新密码, 删除用户.

#figure(
  image("assets/AdminUserManagement.png", width: 50%),
  caption: "管理员主界面 - 用户管理",
)

在修改用户信息时, 系统会检查用户输入的信息是否完整, 用户名是否已存在. 如果用户输入的信息存在上述问题, 系统会提示问题并要求用户重新输入.

#figure(
  image("assets/AdminUserManagementError.png", width: 50%),
  caption: "管理员主界面 - 用户管理错误提示",
)

== 值班时间管理功能

点击 "值班时间管理" 按钮后, 系统会弹出值班时间管理界面, 管理员可以在界面中查看所有诊所地点的值班时间, 修改值班时间, 添加新的值班时间, 删除值班时间.

#figure(
  image("assets/AdminScheduleManagement.png", width: 50%),
  caption: "管理员主界面 - 值班时间管理",
)

在提交时, 系统会检查用户输入的信息是否完整, 值班时间是否冲突. 如果提交的日期和地点已存在, 系统会提示用户重新输入.

#figure(
  image("assets/AdminScheduleManagementError.png", width: 50%),
  caption: "管理员主界面 - 值班时间管理错误提示",
)

点击 "新建" 按钮后, 系统会弹出新建值班时间表单, 用户可以在表单中填写值班时间信息.

#figure(
  image("assets/AdminScheduleManagementNew.png", width: 50%),
  caption: "管理员主界面 - 新建值班时间",
)

在新建值班时间时, 系统会检查用户输入的信息是否完整, 值班时间是否冲突. 如果用户输入的信息存在上述问题, 系统会提示问题所在, 并要求用户重新输入.

=== 诊所地点管理功能

点击 "诊所地点管理" 按钮后, 系统会弹出诊所地点管理界面, 管理员可以在界面中查看所有诊所地点的信息, 修改诊所地点的信息, 添加新的诊所地点, 删除诊所地点.

#figure(
  image("assets/AdminCampusManagement.png", width: 40%),
  caption: "管理员主界面 - 诊所地点管理",
)

在提交时, 系统会检查用户输入的信息是否完整, 诊所地点是否已存在. 如果用户输入的信息存在上述问题, 系统会提示问题所在, 并要求用户重新输入.

#figure(
  image("assets/AdminCampusManagementError.png", width: 40%),
  caption: "管理员主界面 - 诊所地点管理错误提示",
)

=== 公告管理功能

点击 "公告管理" 按钮后, 系统会弹出公告管理界面, 管理员可以在界面中查看所有公告的信息, 修改公告的信息, 添加新的公告, 删除公告.

#figure(
  image("assets/AdminAnnouncementManagement.png", width: 50%),
  caption: "管理员主界面 - 公告管理",
)

在提交时, 系统会检查用户输入的信息是否完整, 公告标题是否已存在. 如果用户输入的信息存在上述问题, 系统会提示问题所在, 并要求用户重新输入.

#figure(
  image("assets/AdminAnnouncementManagementError.png", width: 50%),
  caption: "管理员主界面 - 公告管理错误提示",
)

点击 "新建" 按钮后, 左侧列表中会出现 "新公告" 项, 用户可在编辑后提交. 

#figure(
  image("assets/AdminAnnouncementManagementNew.png", width: 50%),
  caption: "管理员主界面 - 新建公告",
)

== 服务端使用

=== 建立数据库

在导入数据库之前, 先在 OpenGauss 数据库中创建一个新的数据库, 命名为 `clinic_manage`.

```sql
CREATE DATABASE clinic_manage;
```

源代码中, `CreateTable.sql` 文件中包含了创建数据库的 SQL 语句, 该文件中包含了创建数据库所需的所有表格和字段; `CreateView.sql` 文件中包含了创建视图的 SQL 语句, 该文件中包含了创建数据库所需的所有视图; `CreateTrigger.sql` 文件中包含了创建触发器的 SQL 语句; `CreateProcedure.sql` 文件中包含了创建储存过程的 SQL 语句; `CreateFunction.sql` 文件中包含了创建函数的 SQL 语句.

源代码中 `InsertData.sql` 文件包含了测试数据. 测试数据中包含的用户登录信息如下:

#figure(
  table(
    columns: 3,
    [*用户类型*], [*学号*], [*密码*],
    "普通用户", "1120230001 - 1120230048", "password",
    "工作人员", "1120200001 - 1120200007", "password",
    "管理员", "1120200008", "password",
  ),
  caption: "测试用户信息",
)

需要确保在创建数据库时, 数据库的编码格式为 `UTF8` , 否则可能会导致中文字符无法正常显示.

=== 连接数据库

数据库创建完成后, 运行 `CreateUser.sql` 文件中的 SQL 语句, 创建数据库用户用于连接. 用户名为 `cloudb`, 密码为 `Test-0penGaussServer-DustinNas`.

数据库创建成功后, 使用 ODBC 连接数据库. 安装 OpenGauss 官网提供的 ODBC 驱动, 并配置 ODBC 数据源. 具体配置方法请参考 OpenGauss 官网提供的文档. 配置时使用刚刚创建的数据库用户 `cloudb` 连接数据库.

安装完成后, 数据源应该为下图所示. 测试数据库连接是否成功.

#figure(
  image("assets/ODBC.png", width: 60%),
  caption: "ODBC 数据源配置",
)

由于 Delphi 中使用 Connection String 来连接数据库, 因此为了顺利连接到数据库, 上述配置应严格遵守. Delphi 中使用的连接字符串如下:

```
Provider=MSDASQL.1;Password=Test-0penGaussServer-DustinNas;Persist Security Info=True;User ID=cloudb;Data Source=PostgreSQL35W;Initial Catalog=clinic_manage
```

如果 Delphi 提示无法连接到数据库, 请检查 ODBC 数据源配置是否正确, 并确保数据库服务已启动. 如果无法使数据库配置符合上述连接字符串, 请修改项目中所有 ADOConnection 组件的连接字符串, 使其能顺利连接到数据库. 