== 数据表设计

根据需求分析和功能设计, 设计如下数据表:

#figure(
  image("Tables.png"),
  caption: "数据表设计",
)

实体属性说明:

- *clinic_user*: 所有用户的基本信息, 包括普通用户和工作人员
- *worker*: 工作人员信息, 继承自用户
- *admin*: 管理员信息, 继承自工作人员
- *campus*: 校区/场地信息
- *schedule*: 诊所开放时间安排
- *appointment*: 预约工单信息
- *announcement*: 公告信息

== ER 图

针对上述需求分析和功能设计, 根据数据表的设计, 绘制出如下的ER图:

#figure(
  image("ER.png", height: 90%),
  caption: "ER图",
)

在这个ER图中, 各实体间的关系如下:

1. *campus* 与 *schedule* 是一对多关系: 一个校区可以有多个日程安排
2. *campus* 与 *worker* 是一对多关系: 一个校区可以有多个工作人员
3. *worker* 继承自 *clinic_user*: 工作人员是用户的特例
4. *admin* 继承自 *worker*: 管理员是工作人员的特例
5. *clinic_user* 与 *appointment* 是一对多关系: 一个用户可以有多个预约
6. *worker* 与 *appointment* 是一对多关系: 一个工作人员可以处理多个预约
7. *schedule* 与 *appointment* 是一对多关系: 一个日程可以有多个预约
8. *worker* 与 *announcement* 是一对多关系: 一个工作人员可以发布多个公告

关键业务约束:
1. 预约状态 (status) 定义了工单的生命周期
2. 日程安排 (schedule) 的开始时间必须早于结束时间
3. 日程安排的容量 (capacity) 必须为正数
4. 当预约状态达到正在处理时, 系统自动记录到达时间(arrive_time)

== 范式证明

在本节中，将针对数据库设计进行范式证明，分析每个表是否满足第一范式(1NF)、第二范式(2NF)和第三范式(3NF)。

=== 第一范式(1NF)

第一范式要求关系模式中的每个属性都是不可再分的原子值。形式化定义为：

对于关系模式 $R(U)$，其中 $U$ 是属性集，若 $∀A in U$，$A$ 的域中的所有值都是原子的，则称 $R$ 满足第一范式（1NF）。

令 $D$ 表示数据库模式，$R_i in D$ 表示数据库中的每个关系模式。对于我们的设计：

- *campus表* $R_1("id", "name", "address")$: 
  $forall A in \{"id", "name", "address"\}$，$A$ 的值域中的所有值均为原子值，因此 $R_1$ 满足1NF。

- *clinic_user表* $R_2("id", "name", "school_id", ..., "password_hash")$: 
  用户表中所有属性均为原子值，因此 $R_2$ 满足1NF。

- *worker表* $R_3("id", "campus")$: 
  $forall A in \{"id", "campus"\}$，$A$ 的值域中的所有值均为原子值，因此 $R_3$ 满足1NF。

- *admin表* $R_4("id")$: 
  $forall A in \{"id"\}$，$A$ 的值域中的所有值均为原子值，因此 $R_4$ 满足1NF。

- *announcement表* $R_5("id", "title", "content", ..., "last_editor")$: 
  公告表中所有属性均为原子值，因此 $R_5$ 满足1NF。

- *schedule表* $R_6("id", "campus_id", "date", "start_time", "end_time", "capacity")$: 
  $forall A in \{"id", "campus_id", "date", "start_time", "end_time", "capacity"\}$，$A$ 的值域中的所有值均为原子值，因此 $R_6$ 满足1NF。

- *appointment表* $R_7("id", "user_id", "worker_id", ..., "status")$: 
  预约表中所有属性均为原子值，因此 $R_7$ 满足1NF。

因此，$forall R_i in D$，$R_i$ 满足1NF，即整个数据库模式 $D$ 满足第一范式。

=== 第二范式(2NF)

第二范式在第一范式的基础上，要求非主属性完全依赖于主键，而不是部分依赖。形式化定义为：

设 $R(U)$ 是满足1NF的关系模式，$K$ 为 $R$ 的候选键，$A in U$，$A in.not K$ 是非主属性。若对于 $R$ 中的任意非主属性 $A$，$A$ 完全函数依赖于 $R$ 的每个候选键，则称 $R$ 满足第二范式（2NF）。

用函数依赖表示：不存在 $X subset K$ 和非主属性 $A$ 使得 $X arrow A$。

对于我们的数据库模式 $D$：

- *campus表* $R_1("id", "name", "address")$: 
  主键 $K = \{"id"\}$，非主属性集合 $U - K = \{"name", "address"\}$。
  $forall A in \{"name", "address"\}$，不存在 $X subset \{"id"\}$ 使得 $X arrow A$（因为 $id$ 是单属性，不可再分），所以非主属性完全依赖于主键，满足2NF。

- *clinic_user表* $R_2("id", "name", "school_id", ..., "password_hash")$: 
  主键 $K = \{"id"\}$，非主属性集合包含所有除id外的属性。
  对所有非主属性，不存在 $X subset \{"id"\}$ 使得 $X arrow A$，满足2NF。

- *worker表* $R_3("id", "campus")$: 
  主键 $K = \{"id"\}$，非主属性集合 $U - K = \{"campus"\}$。
  对于 $"campus"$，不存在 $X subset \{"id"\}$ 使得 $X arrow "campus"$，满足2NF。

- *admin表* $R_4("id")$: 
  主键 $K = \{"id"\}$，无非主属性，所以平凡地满足2NF。

- *announcement表* $R_5("id", "title", "content", "publish_time", "expire_time", "priority", "last_editor")$:
  主键 $K = \{"id"\}$，非主属性集合 $U - K = \{"title", "content", "publish_time", "expire_time", "priority", "last_editor"\}$。
  $forall A in \{"title", "content", "publish_time", "expire_time", "priority", "last_editor"\}$，不存在 $X subset \{"id"\}$ 使得 $X arrow A$，满足2NF。

- *schedule表* $R_6("id", "campus_id", "date", "start_time", "end_time", "capacity")$:
  主键 $K = \{"id"\}$，非主属性集合 $U - K = \{"campus_id", "date", "start_time", "end_time", "capacity"\}$。
  $forall A in \{"campus_id", "date", "start_time", "end_time", "capacity"\}$，不存在 $X subset \{"id"\}$ 使得 $X arrow A$，满足2NF。

- *appointment表* $R_7("id", "user_id", "worker_id", ..., "status")$:
  主键 $K = \{"id"\}$，非主属性集合 $U - K$ 包含所有除id外的属性。
  $forall A in$ 非主属性集合，不存在 $X subset \{"id"\}$ 使得 $X arrow A$，满足2NF。

因此，$forall R_i in D$，$R_i$ 满足2NF，即整个数据库模式 $D$ 满足第二范式。

=== 第三范式(3NF)

第三范式在第二范式的基础上，要求非主属性不传递依赖于主键，即非主属性之间不存在函数依赖关系。形式化定义为：

设 $R(U)$ 是满足2NF的关系模式，若 $R$ 中不存在这样的非主属性 $A$ 和 $B$，使得 $A arrow B$（即 $B$ 传递函数依赖于键 $K$），则称 $R$ 满足第三范式（3NF）。

更精确地说，关系模式 $R(U)$ 满足3NF，当且仅当对于 $R$ 中的每个函数依赖 $X arrow A$，要么：
1. $X$ 是超键，或者
2. $A$ 是主属性（即 $A$ 包含于某个候选键中）

对于我们的数据库模式 $D$：

- *campus表* $R_1("id", "name", "address")$: 
  主键 $K = \{"id"\}$，非主属性集合 $U - K = \{"name", "address"\}$。
  我们需要检查是否存在 $"name" arrow "address"$ 或 $"address" arrow "name"$。
  根据语义，校区名称与地址之间没有函数依赖关系，因此不存在传递依赖，满足3NF。

- *clinic_user表* $R_2("id", "name", "school_id", "phone_number", "password_hash")$: 
  主键 $K = \{"id"\}$，非主属性集合 $U - K = \{"name", "school_id", "phone_number", "password_hash"\}$。
  对于任意 $A, B in \{"name", "school_id", "phone_number", "password_hash"\}$ 且 $A ≠ B$，
  不存在 $A arrow B$ 的函数依赖（例如姓名不能决定学号，学号不能决定密码等），因此满足3NF。

- *worker表* $R_3("id", "campus")$: 
  主键 $K = \{"id"\}$，非主属性集合 $U - K = \{"campus"\}$。
  只有一个非主属性，不可能存在传递依赖，满足3NF。

- *admin表* $R_4("id")$: 
  主键 $K = \{"id"\}$，无非主属性，所以平凡地满足3NF。

- *announcement表* $R_5("id", "title", "content", ..., "last_editor")$:
  主键 $K = \{"id"\}$，非主属性集合 $U - K$ 包含所有除id外的属性。
  对于任意两个非主属性 $A, B$，不存在 $A arrow B$ 的函数依赖（如标题不能决定内容等），满足3NF。

- *schedule表* $R_6("id", "campus_id", "date", "start_time", "end_time", "capacity")$:
  主键 $K = \{"id"\}$，非主属性集合 $U - K = \{"campus_id", "date", "start_time", "end_time", "capacity"\}$。
  对于任意 $A, B in \{"campus_id", "date", "start_time", "end_time", "capacity"\}$ 且 $A ≠ B$，
  不存在 $A arrow B$ 的函数依赖（例如校区不能决定日期，日期不能决定容量等），因此满足3NF。

- *appointment表* $R_7("id", "user_id", "worker_id", ..., "status")$:
  主键 $K = \{"id"\}$，非主属性集合是所有除id外的属性。
  对于任意两个非主属性 $A$ 和 $B$，不存在 $A arrow B$ 的函数依赖（如用户ID不能决定工作人员ID等），满足3NF。

因此，$forall R_i in D$，$R_i$ 满足3NF，即整个数据库模式 $D$ 满足第三范式。

=== BCNF (Boyce-Codd范式)

BCNF是对3NF的进一步强化，要求关系模式中所有决定因素必须是候选键。形式化定义为：

设 $R(U)$ 是满足3NF的关系模式，若对于 $R$ 中的每个非平凡函数依赖 $X arrow A$（其中 $A in.not X$），$X$ 都包含某个候选键，则称 $R$ 满足BCNF。

换言之，关系模式 $R(U)$ 满足BCNF，当且仅当对于 $R$ 中的每个函数依赖 $X arrow A$，$X$ 必须是 $R$ 的超键。

对于我们的数据库模式 $D$：

- *campus表* $R_1("id", "name", "address")$: 
  主键 $K = \{"id"\}$，唯一候选键是 $\{"id"\}$。
  在该表中，$"id" arrow "name"$，$"id" arrow "address"$ 是唯一的非平凡函数依赖，
  且 $id$ 是候选键，因此满足BCNF。

- *clinic_user表* $R_2("id", "name", "school_id", "phone_number", "password_hash")$: 
  主键 $K = \{"id"\}$，由于 $"school_id"$ 也被设置为UNIQUE，因此候选键有 $\{"id"\}$ 和 $\{"school_id"\}$。
  所有函数依赖中的决定因素（$"id"$ 或 $"school_id"$）都是候选键，满足BCNF。

- *worker表* $R_3("id", "campus")$: 
  主键 $K = \{"id"\}$，唯一候选键是 $\{"id"\}$。
  在该表中，$"id" arrow "campus"$ 是唯一的非平凡函数依赖，
  且 $id$ 是候选键，因此满足BCNF。

- *admin表* $R_4("id")$: 
  主键 $K = \{"id"\}$，只有一个属性，平凡地满足BCNF。

- *announcement表* $R_5("id", "title", "content", ..., "last_editor")$:
  主键 $K = \{"id"\}$，唯一候选键是 $\{"id"\}$。
  所有非平凡函数依赖的决定因素都是 $\{"id"\}$，且 $\{"id"\}$ 是候选键，满足BCNF。

- *schedule表* $R_6("id", "campus_id", "date", "start_time", "end_time", "capacity")$:
  主键 $K = \{"id"\}$，唯一候选键是 $\{"id"\}$。
  所有非平凡函数依赖的决定因素都是 $\{"id"\}$，且 $\{"id"\}$ 是候选键，满足BCNF。

- *appointment表* $R_7("id", "user_id", "worker_id", ..., "status")$:
  主键 $K = \{"id"\}$，唯一候选键是 $\{"id"\}$。
  所有非平凡函数依赖的决定因素都是 $\{"id"\}$，且 $\{"id"\}$ 是候选键，满足BCNF。

因此，$forall R_i in D$，$R_i$ 满足BCNF，即整个数据库模式 $D$ 满足Boyce-Codd范式。

=== 范式设计总结

通过以上严格的数学证明，我们已经验证了本数据库设计完全满足从第一范式到Boyce-Codd范式的所有要求。具体而言：

1. *第一范式(1NF)*: $∀R_i in D$，$∀A in R_i$，$A$ 的值域中的所有值均为原子值，保证了数据的原子性。

2. *第二范式(2NF)*: $∀R_i in D$，不存在 $X subset K$ 和非主属性 $A$ 使得 $X arrow A$，消除了非主属性对主码的部分依赖。

3. *第三范式(3NF)*: $∀R_i in D$，不存在非主属性 $A$ 和 $B$ 使得 $A arrow B$，消除了非主属性之间的传递依赖。

4. *Boyce-Codd范式(BCNF)*: $∀R_i in D$，对于 $R_i$ 中的每个非平凡函数依赖 $X arrow A$（其中 $A in.not X$），$X$ 都是超键，确保了所有决定因素都是候选键。

这种严格遵循高级范式的设计方法具有以下优势：

- 最小化数据冗余，节省存储空间
- 消除更新异常（插入异常、删除异常、修改异常）
- 提高数据一致性和完整性
- 增强数据库结构的稳定性和扩展性
- 简化查询优化和索引设计

因此，本数据库模式设计不仅理论上满足规范化要求，在实际应用中也能有效支持业务需求，保证系统的可靠性和性能。

