#import "@preview/cetz:0.3.2"
#import "@preview/fletcher:0.5.5"
#import "@preview/fletcher:0.5.5": node, edge
#import "./slides-template/touying-bit.typ": *

// cetz and fletcher bindings for touying
#let cetz-canvas = touying-reducer.with(reduce: cetz.canvas, cover: cetz.draw.hide.with(bounds: true))
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

#show: bit-theme.with(
  // Lang and font configuration
  lang: "zh",
  font: ("IBM Plex Sans", "Source Han Sans"),
  // Basic information
  config-info(
    title: [数据库设计与开发 作业三],
    subtitle: [电脑诊所管理系统],
    author: [蒋浩天],
    date: datetime.today(),
    institution: [北京理工大学],
  ),

  // Pdfpc configuration
  // typst query --root . ./examples/main.typ --field value --one "<pdfpc-file>" > ./examples/main.pdfpc
  config-common(
    preamble: pdfpc.config(
      duration-minutes: 30,
      start-time: datetime(hour: 14, minute: 10, second: 0),
      end-time: datetime(hour: 14, minute: 40, second: 0),
      last-minutes: 5,
      note-font-size: 12,
      disable-markdown: false,
      default-transition: (
        type: "push",
        duration-seconds: 2,
        angle: ltr,
        alignment: "vertical",
        direction: "inward",
      ),
    ),
  ),
)

#show raw: set text(
  font: ("Cascadia Code PL", "Microsoft YaHei UI"),
  size: 16pt,
  ligatures: true
)

#title-slide()

= 功能介绍

== 功能介绍

#tblock(
  title: "背景介绍",
  [
    网络开拓者协会电脑诊所部长期在校内 *多个场地* 开展电脑义诊服务, 为同学们进行免费的电脑维修. 为了资源利用最大化, 设计了维修预约管理系统. 
  ]
)

在这一系统中: 

1. 普通用户 (同学) 可在登录后查看, 添加, 修改预约, 阅读公告. 

2. 工作人员在登录后可查看所有场地的预约, 在维修中进行预约信息状态的修改. 

3. 管理员可在工作人员的基础上, 修改用户信息和权限, 更改场地信息, 设置诊所场地的预约时间段. 

= 登录与注册功能

== 使用说明

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

#tblock(
  title: "密码储存",
  [
    "密码在数据库中以 MD5 值的形式存储. 这使得即使数据库被泄露, 用户的密码也不会被直接暴露.",
    "在登录时, 系统会将用户输入的密码进行 MD5 处理, 并与数据库中存储的值进行比较. 如果两者相同, 则验证通过.",
  ],
)

#figure(
  grid(
    columns: 2,
    gutter: 10pt,
    image("assets/LoginFormUserNotExists.png", width: 100%),
    image("assets/LoginFormWrongPassword.png", width: 100%),
  ),
  caption: "登录界面错误提示：(左) 用户不存在；(右) 密码错误"
)

= 以普通用户身份登录

== 使用说明

#grid(
  columns: 2,
  column-gutter: 20pt,
  [以普通用户身份登录后, 用户可以查看自己的预约信息, 查看公告, 也可以修改预约信息, 修改个人信息和取消预约.],
  figure(
    image("assets/UserMainForm.png", width: 100%),
    caption: "普通用户主界面",
  )
)

#grid(
  columns: 2,
  column-gutter: 20pt,
  [修改预约信息时, 预约时间选框中的选项会根据用户选择的预约地点自动更新, 且只显示尚未预约满的时间点. 这使得用户在选择预约地点时, 可以根据选择的地点预约合适的时间段, 提高了用户体验.],
  figure(
    image("assets/UserMainFormDatePicker.png", width: 100%),
    caption: "修改预约信息",
  )
)

点击 "新建预约" 按钮后, 系统会弹出预约表单, 用户可以在表单中填写预约信息.

#figure(
  image("assets/UserNewAppointment.png", width: 40%),
  caption: "新建预约",
)

#grid(
  columns: 2,
  column-gutter: 20pt,
  [
    同样, 在新建预约的表单中, 预约时间选框中的选项会根据用户选择的预约地点自动更新, 且只显示尚未预约满的时间点. 此外, 在提交时, 系统会检查用户输入的信息是否完整, 预约时间是否冲突, 预约地点是否存在. 如果用户输入的信息存在上述问题, 系统会提示问题所在, 并要求用户重新输入.
  ],
  figure(
    image("assets/UserNewAppointmentError.png", width: 100%),
    caption: "新建预约错误提示",
  )
)

= 以工作人员身份登录

== 使用说明

以工作人员身份登录后, 工作人员可以查看所有预约信息, 修改预约状态与信息.

#figure(
  image("assets/WorkerMainForm.png", width: 60%),
  caption: "工作人员主界面",
)

其中, 左上角的预约时间选框中的选项会根据工作人员选择的诊所地点自动更新, 实现了级联操作. 

#figure(
  image("assets/WorkerMainFormDatePicker.png", width: 40%),
  caption: "工作人员主界面 - 预约时间级联选择",
)

工作人员可以根据实际工作情况, 选择对应的预约记录, 修改其状态与信息. 

#grid(
  columns: 2,
  column-gutter: 20pt,
  figure(
    image("assets/WorkerMainFormChangeStatus.png", width: 100%),
    caption: "工作人员主界面 - 修改预约状态",
  ),
  [
    系统会根据预约记录的状态改变, 自动修改预约记录中的一些字段. 例如, 当工作人员将预约记录的状态修改为 "正在处理" 时, 系统会自动修改预约记录中的 "到达时间" 字段; 当有工作人员修改记录时, 会自动修改该记录的关联工作人员. 

    这使得工作人员在修改预约记录时, 不需要手动输入一些字段, 提高了工作效率, 也便于管理员进行数据统计.
  ],
)



= 以管理员身份登录

== 使用说明

以管理员身份登录后, 管理员可以查看所有预约信息, 修改预约状态与信息, 也可以添加新的工作人员, 删除工作人员, 修改工作人员信息, 管理公告, 管理诊所场地, 设置诊所场地的预约时间段. 

#figure(
  image("assets/AdminMainForm.png", width: 90%),
  caption: "管理员主界面",
)

可以看到, 管理员的主界面与工作人员的主界面类似, 但由于管理员具有管理权限, 因此界面中显示了管理功能的相关按钮.

由于管理员同时也是工作人员, 因此在管理员的主界面中, 也可以查看所有预约信息, 修改预约状态与信息. 使用方法同工作人员.

== 用户管理功能

#grid(
  columns: 2,
  column-gutter: 20pt,
  [点击 "用户管理" 按钮后, 系统会弹出用户管理界面, 管理员可以在界面中查看所有用户的信息, 修改用户的信息和权限, 为用户设置新密码, 删除用户.],
  figure(
    image("assets/AdminUserManagement.png", width: 100%),
    caption: "管理员主界面 - 用户管理",
  )
)

#grid(
  columns: 2,
  column-gutter: 20pt,
  [
    在修改用户信息时, 系统会检查用户输入的信息是否完整, 用户名是否已存在. 如果用户输入的信息存在上述问题, 系统会提示问题并要求用户重新输入.
  ],
  figure(
    image("assets/AdminUserManagementError.png", width: 100%),
    caption: "管理员主界面 - 用户管理错误提示",
  )
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

== 诊所地点管理功能

#grid(
  columns: 2,
  column-gutter: 20pt,
  [
    点击 "诊所地点管理" 按钮后, 系统会弹出诊所地点管理界面, 管理员可以在界面中查看所有诊所地点的信息, 修改诊所地点的信息, 添加新的诊所地点, 删除诊所地点.
  ],
  figure(
    image("assets/AdminCampusManagement.png", width: 80%),
    caption: "管理员主界面 - 诊所地点管理",
  )
)

#grid(
  columns: 2,
  column-gutter: 20pt,
  [
    在提交时, 系统会检查用户输入的信息是否完整, 诊所地点是否已存在. 如果用户输入的信息存在上述问题, 系统会提示问题所在, 并要求用户重新输入.
  ],
  figure(
    image("assets/AdminCampusManagementError.png", width: 80%),
    caption: "管理员主界面 - 诊所地点管理错误提示",
  )
)

== 公告管理功能

#grid(
  columns: 2,
  column-gutter: 20pt,
  [
    点击 "公告管理" 按钮后, 系统会弹出公告管理界面, 管理员可以在界面中查看所有公告的信息, 修改公告的信息, 添加新的公告, 删除公告.
  ],
  figure(
    image("assets/AdminAnnouncementManagement.png", width: 100%),
    caption: "管理员主界面 - 公告管理",
  )
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

= 代码说明

== 动态SQL

#tblock(
  title: "动态SQL",
  [
    "使用动态SQL来处理查询条件的变化. 动态SQL允许我们根据用户输入的参数构建不同的查询语句, 从而实现灵活的查询功能."
  ],
)

#raw(
  lang: "sql",
  "CREATE OR REPLACE FUNCTION search_appointments(
    p_status INTEGER DEFAULT NULL,
    p_campus_name VARCHAR DEFAULT NULL,
    p_start_date DATE DEFAULT NULL,
    p_end_date DATE DEFAULT NULL,
    p_user_school_id VARCHAR DEFAULT NULL
) 
RETURNS TABLE(
    id INTEGER,
    description VARCHAR,
    ... -- 其他字段
) AS $$
DECLARE
    v_sql TEXT;
    v_where_clause TEXT := ' WHERE 1=1';
    v_params_count INTEGER := 0;
BEGIN
    -- 构建基础查询
    v_sql := 'SELECT id, description, worker_caption, reject_reason, arrive_time, computer_model, 
              status, date AS appointment_date, campus, user_name, user_school_id, user_phone_number, 
              worker_name, user_id, worker_id, schedule_id 
              FROM appointment_view';
    
    IF p_status IS NOT NULL THEN
        v_where_clause := v_where_clause || ' AND status = ' || p_status;
        v_params_count := v_params_count + 1;
    END IF;
    
    -- ...其他参数处理
    -- 如果有参数，添加WHERE子句
    IF v_params_count > 0 THEN
        v_sql := v_sql || v_where_clause;
    END IF;

    v_sql := v_sql || ' ORDER BY appointment_date DESC, status ASC';
    
    RETURN QUERY EXECUTE v_sql;
END;
$$ LANGUAGE plpgsql;"
)

== 储存过程

#tblock(
  title: "使用储存过程",
  [
    在项目中, 使用储存过程来自动化删除数据库中过期的公告数据, 简化了操作.
  ]
)

#raw(
  lang: "sql",
  "CREATE OR REPLACE PROCEDURE delete_expired_announcements() AS
BEGIN
  DELETE FROM announcements
    WHERE expire_time IS NOT NULL
    AND expire_time < CURRENT_TIMESTAMP;
END;"
)