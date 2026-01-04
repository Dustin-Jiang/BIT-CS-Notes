登录到华为云官网，使用课上注册的学生教育账号登录。进入"云数据库RDS"页面，选择"创建云数据库RDS"。

选择"按需计费"的方式，选择"性能规格"，类型选择为 "PostgreSQL", 选择"2核4G"的配置, 选择 "单机实例"。

#figure(
  image("assets/buy-rds.png"),
  caption: "购买ECS数据库服务器",
)

创建成功后, 使用华为云提供的 DAS 连接工具, 输入用户名与设置的密码, 连接到数据库服务器.

#figure(
  image("assets/connect-rds.png"),
  caption: "连接到ECS数据库服务器",
)