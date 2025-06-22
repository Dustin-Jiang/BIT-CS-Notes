由于部署在 Docker 容器中的 OpenGauss *无需考虑* 服务器的物理资源限制, 在成熟可靠的镜像中也不会遇到系统配置对数据库的影响, 因此这一部分内容在华为云的 ECS 上进行测试. 系统为 Huawei OpenEuler 20.09, 安装的 OpenGauss 版本同样为 *企业版* 5.1.0. 

```bash
gs_checkos -i A
```

使用 OpenGauss 提供的 `gs_checkos` 脚本, 检查操作系统的兼容性. 该脚本会检查操作系统版本、内核版本、文件系统类型等信息, 确保系统满足 OpenGauss 的运行要求. 

返回结果中, Normal 表示正常, Warning 表示警告, Abnormal 表示错误. Abnormal 为必须处理项, Warning 可以不处理. 

#figure(
  image("assets/checkos.png", height: 40%),
  caption: "使用 gs_checkos 检查操作系统兼容性",
)

在参数配置文件 (`/etc/sysctl.conf`) 中将参数 `vm.min_free_kbytes` (表示内核内存分配保留的内存量, 以保证物理内存有足够空闲空间，防止突发性换页) 的值调整为3488. 

再次执行 `gs_checkos`, 此时 `A6. [ System control parameters status ] ` 的状态是 Warning 为告警项; 
`vm.min_free_kbytes = 3488` 修改后的信息会暴露在告警项中, 通过详细信息可以查看到. 

```bash
# 查看详细信息
gs_checkos -i A --detail
```

#figure(
  image("assets/checkos-detail.png", height: 40%),
  caption: "使用 gs_checkos 深入检查操作系统兼容性",
)

可以看见, 详细信息中显示了 `vm.min_free_kbytes` 的值过小的警报, 同时也给出了建议的最小数值为 `201763`.

根据给出的建议, 我们可以将所有警报项的值都设置为建议值或以上, 以免影响数据库的正常运行.