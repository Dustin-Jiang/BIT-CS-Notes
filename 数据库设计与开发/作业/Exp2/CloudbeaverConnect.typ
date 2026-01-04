Cloudbeaver 是一个基于 Web 的数据库管理工具，它提供了一个图形化的用户界面，用于访问、管理和分析各种类型的数据库。

- 跨平台: Cloudbeaver 可以在任何支持 Web 浏览器的操作系统上运行。
- 多数据库支持: Cloudbeaver 支持 JDBC 连接, 因此支持包括 MySQL, PostgreSQL, MariaDB, SQL Server, Oracle, DB2, _OpenGauss_ 等多种数据库。
- Web界面: 通过 Web 界面进行数据库管理，无需安装客户端。
- 数据浏览与编辑: 允许用户浏览数据库中的表、视图、存储过程等对象，并进行数据的编辑。
- SQL编辑器: 提供 SQL 编辑器，支持语法高亮、自动补全等功能。
- 数据导出: 支持将数据导出为多种格式，如 CSV, Excel, JSON 等。

Cloudbeaver 适用于需要通过 Web 界面管理数据库的场景，例如：

- 远程数据库管理
- 团队协作开发
- 云环境下的数据库管理

由于 Cloudbeaver 支持使用 JDBC 插件连接到数据库，因此可以使用华为官方提供的 JDBC 插件连接到 OpenGauss 数据库。

将 OpenGauss 的 JDBC 驱动程序放入 Cloudbeaver 的 Docker 镜像中, 以便在 Docker 中容器化部署服务。

使用 Docker Compose 部署 Cloudbeaver, `docker-compose.yml` 文件如下: 

```yaml
version: '3'
services:
  cloudbeaver:
    image: ghcr.io/dustin-jiang/cloudbeaver-opengauss:latest
    restart: unless-stopped
    ports:
      - "8978:8978"
    environment:
      - CB_SERVER_URL=http://localhost:8978
    volumes:
      - ./cloudbeaver/workspace:/opt/cloudbeaver/workspace
```

使用 `docker-compose up -d` 命令启动 Cloudbeaver 服务, 在浏览器中打开页面, 配置 OpenGauss 数据库的登录账号和密码, 连接到数据库。

#figure(
  image("assets/cloudb-connect.png", height: 40%),
  caption: "使用 Cloudbeaver 连接到 OpenGauss 数据库"
)