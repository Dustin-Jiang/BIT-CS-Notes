登录到华为云官网，使用课上注册的学生教育账号登录。进入"弹性云服务器"页面，选择"创建弹性云服务器"。

选择"按需计费"和"按量付费"的方式，选择"云服务器规格"，选择"通用型"，选择"2核4G"的配置, 网络类型选择按流量计费。
系统选择 Huawei EulerOS 2 操作系统。

#figure(
  image("assets/buy-server.png"),
  caption: "选购ECS服务器",
)

购买之后修改密码, 查看服务器公网IP, 使用SSH登录到服务器。

#figure(
  image("assets/login-to-server.png"),
  caption: "SSH登录到服务器",
)

登录之后, 建立OpenGauss数据库的安装目录 `/opt/software/openGauss`, 设置权限为 `755` 之后, 使用 `wget` 工具下载OpenGauss数据库安装包。

#figure(
  image("assets/download-gauss.png"),
  caption: "下载OpenGauss数据库",
)

根据ECS的名称和内网IP, 修改 `cluster-config.xml` 文件中的相关配置项. 

#figure(
  image("assets/cluster-config.png"),
  caption: "编辑集群配置",
)

使用 `tar` 命令解压安装包. 

#figure(
  image("assets/uncompress.png"),
  caption: "解压OpenGauss安装包",
)

使用 `gs_preinstall` 脚本进行预安装检查. 

#figure(
  image("assets/preinstall.png"),
  caption: "准备OpenGauss数据库安装环境",
)

使用 `gs_install` 命令进行安装.

#figure(
  image("assets/install-gauss.png"),
  caption: "安装OpenGauss数据库",
)

使用 `gs_om -t start` 命令启动OpenGauss数据库.

#figure(
  image("assets/start-gauss.png"),
  caption: "启动OpenGauss数据库",
)

提示 `Successfully started.` 说明数据库启动成功.