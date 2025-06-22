由于 OpenGauss 的部分维护功能只在 *企业版* 中可用，因此在轻量版中无法完成本次作业的部分内容: 

- 物理备份
- 数据库恢复

因此, 为完成本次作业, 需要将 OpenGauss 切换到企业版. 

由于本人在先前的实验中使用了 Docker 和 Docker Compose 工具进行了容器化的 OpenGauss 的部署, 而两个版本的 OpenGauss 数据文件相互兼容, 因此只需要将 `docker-compose.yml` 中的 `image` 字段修改为企业版的镜像, 即可完成版本的切换.

```yaml
version: "3"
services:
  gauss:
    # 轻量版: enmotech/opengauss-lite:5.0.0
    # 将镜像替换为企业版的镜像
    image: enmotech/opengauss:5.1.0
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

修改完成后, 使用 `docker-compose up -d` 命令重新启动容器, 即可完成版本的切换. 由于相同版本间, 轻量版与企业版的数据基本兼容, 因此原有数据不会丢失. 