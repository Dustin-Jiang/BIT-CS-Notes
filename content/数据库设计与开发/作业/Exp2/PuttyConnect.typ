PuTTY 是一个免费的 SSH、Telnet 和 Rlogin 客户端，适用于 Windows 和 Unix 平台，提供多种功能，包括：

- 远程连接：通过 SSH 协议安全地连接到远程服务器。
- 终端仿真：模拟各种终端类型，如 _xterm_、_vt102_ 等。

由于微软在 Windows 内置了 Windows Terminal 这一工具, 其功能与 PuTTY 类型,因此本次实验使用 Windows Terminal 和 OpenSSL 提供的 SSH 客户端连接到 OpenGauss 数据库。

使用 SSH 连接到服务器时，通常需要提供用户名和密码。由于先前设置了 SSH 密钥对，因此可以使用 SSH 密钥进行身份验证，而无需输入密码。

#figure(
  image("assets/ssh-connect.png", height: 38%),
  caption: "使用 SSH 连接到服务器",
)

登录之后, 切换到 `omm` 用户, 使用命令 `gs_ctl status` 查看数据库状态, 如果数据库未启动, 使用命令 `gs_ctl start` 启动数据库.

数据库启动后, 使用 `psql -d postgres` 命令连接到 OpenGauss 数据库中的 postgres 数据库. 

#figure(
  image("assets/ssh-connect-db.png", height: 38%),
  caption: "连接到数据库",
)