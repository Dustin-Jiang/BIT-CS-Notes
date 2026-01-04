容器化是一种轻量级的虚拟化技术，它将应用及其依赖项打包到一个独立的单元中，这个单元被称为容器。容器与主机操作系统共享内核，因此比传统的虚拟机更轻量级、更快速。

Docker 是一个开源的应用容器引擎，它基于 Linux 的容器技术，可以将应用及其依赖打包到一个可移植的镜像中，然后发布到任何支持 Docker 的环境中。

  - 提高资源利用率：容器与主机操作系统共享内核，因此比传统的虚拟机更轻量级，可以更有效地利用系统资源。
  - 简化部署：容器将应用及其依赖项打包到一个独立的单元中，可以轻松地在不同的环境中部署。
  - 提高可移植性：容器可以在任何支持 Docker 的环境中运行，从而提高了应用的可移植性。
  - 提高开发效率：容器可以隔离不同的应用，从而避免了应用之间的冲突，提高了开发效率。
#show link: underline


云和恩墨公司制作了一个基于 Docker 的 OpenGauss 数据库镜像 (#link("https://hub.docker.com/r/enmotech/opengauss"))，用户可以通过 Docker 快速部署 OpenGauss 数据库。

使用 Docker Compose 工具, 从镜像 `enmotech/opengauss` 部署 OpenGauss 数据库。`docker-compose` 配置文件如下:

```yaml
version: "3"
services:
  gauss:
    image: enmotech/opengauss:5.0.0
    privileged: true
    restart: always
    user: root
    ports:
      - "5432:5432"
    environment:
      GS_PASSWORD: <DATABASE_PASSWORD>
    volumes:
      - ./data:/var/lib/opengauss
```

使用命令 `docker-compose up -d` 启动 OpenGauss 数据库容器。使用命令 `docker exec -it <container_name> bash` 进入容器。

进入容器后, 切换到 `omm` 用户, 使用命令 `gsql -d postgres` 连接到数据库。

#figure(
  image("assets/docker-compose.png", height: 35%),
  caption: "连接到Docker容器中的OpenGauss数据库",
)