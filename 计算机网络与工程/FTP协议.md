FTP (File Transfer Protocol) 用于在客户机和服务器之间传输文件。

## 工作原理

- **客户机/服务器模型 (C/S)**。
- 使用 [[TCP协议]] 保证可靠传输。
- **双重连接**：FTP 是一个带外 (Out-of-band) 协议。 #重点
	1. **控制连接**：用于发送用户名、密码、改变目录、获取文件列表等指令。端口号为 **21**。
	2. **数据连接**：用于实际传送文件数据。端口号为 **20**（主动模式下）。
- **状态维护**：FTP 服务器维护关于用户的“状态”（如当前目录、较早的鉴别等）。 #重点

## 控制连接与数据连接

- **控制连接**在整个会话期间一直保持打开。
- **数据连接**是瞬时的，每传输一个文件都会打开一个新的数据连接，传输完成后关闭。

## FTP 命令与响应

- 命令以 ASCII 文本形式发送。
	- `USER`, `PASS`
	- `LIST`：返回文件列表。
	- `RETR filename`：获取文件 (get)。
	- `STOR filename`：存储文件 (put)。
- 响应码示例：
	- `331`: Username OK, password required.
	- `125`: Data connection already open; transfer starting.
	- `425`: Can't open data connection.
