# 安装虚拟机

使用 VirtualBox 虚拟机软件安装虚拟机. 选择安装无 GUI 的 Debian 12 系统以最小化磁盘占用, 同时尽可能保持 apt 层面与 Ubuntu 的兼容性. 

![[Pasted image 20250505002354.png]]

设置主机名为 Spark1, 便于后续创建和管理集群.
![[Pasted image 20250505002301.png]]

安装完成后, 为便于后续配置, 使用 SSH 连接到虚拟机中. 

![[Pasted image 20250512100513.png]]

# 安装 Spark

使用 SCP 工具, 将 Java 运行时和 Spark 安装包复制到虚拟机中. 

![[Pasted image 20250512100948.png]]

使用 `tar` 工具解压两个安装包

![[Pasted image 20250512101054.png]]

将 `jdk` 文件夹移动到 `~/.local/share/jdk` 后, 修改环境变量. 

![[Pasted image 20250512101421.png]]

通过 `source ~/.bashrc` 应用更改后, 启动 Spark Shell. 为了便于从实体机访问, 使用 `SPARK_LOCAL_IP` 环境变量来设计 Web UI 绑定的 IP 地址. 

![[Pasted image 20250512102556.png]]

在浏览器中打开 Web UI 地址. 

![[Pasted image 20250512102709.png]]

# 单节点运行 Spark

新建 `~/test.txt`, 输入一些内容. 

![[Pasted image 20250512103348.png]]

在 Spark Shell 中执行 Scala 语句. 

```scala
sc.textFile("/home/dustin/test.txt")
	.flatMap(_.split(" "))
	.map((_,1))
	.reduceByKey(_+_)
	.collect
```

![[Pasted image 20250512103542.png]]

使用 Spark Submit 工具提交计算工作. 

![[Pasted image 20250512103801.png]]

![[Pasted image 20250512103747.png]]

# 多节点运行 Spark

复制虚拟机 Spark1, 登录后修改 Hostname 为 Spark2. 

修改 `spark/conf` 下的 `slaves` 配置文件. 

![[Pasted image 20250512105130.png]]

修改 `spark-env.sh` 配置文件. 

![[Pasted image 20250512111423.png]]

在 Spark2 上重复这些操作. 

使用 Standalone 模式运行 Spark, 在主节点 Spark1 上执行 `$SPARK_HOME/sbin/start-all.sh`. 

![[Pasted image 20250512105658.png]]

成功启动后, 访问 `http://MASTER_IP:8080` 查看运行情况. 

![[Pasted image 20250512111752.png]]

用 Spark Submit 工具提交计算任务.

![[Pasted image 20250512111946.png]]

在 Web UI 中查看任务运行情况. 

![[Pasted image 20250512112018.png]]