将课程提供的OpenEuler虚拟机镜像导入VirtualBox软件中. 

#figure(
  image("assets/vm-euler.png", height: 30%),
  caption: "导入OpenEuler虚拟机镜像",
)

虚拟机启动后, 切换到 `omm` 用户, 使用 `gs_ctl status` 命令查看OpenGauss数据库状态. 

#figure(
  image("assets/vm-show-gauss-status.png", height: 40%),
  caption: "查看OpenGauss数据库状态",
)

使用命令 `gsql postgres` 连接到其中的OpenGauss数据库，输入用户名与设置的密码，连接到数据库服务器。