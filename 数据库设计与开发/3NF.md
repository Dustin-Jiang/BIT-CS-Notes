一个关系模式 R 属于 **第三范式（3NF）**，当且仅当对于每一个 [[非平凡函数依赖]] X → A，满足以下两个条件之一：

 - X 是一个 [[超键]]（即能唯一确定元组），或
 - A 是一个 [[主属性]]（是某个 [[候选键]] 的子集）

## [[传递函数依赖]]

如果存在如下依赖链：
```
A → B，B → C，但 A ↛ C，
```
那么 C 对 A 是**传递依赖**。

### 示例

```
Employee(emp_id, name, dept_id, dept_name)
```

其中：
- emp_id → name, dept_id
- dept_id → dept_name

所以 emp_id → dept_name 是一个**传递依赖**，违反 3NF。

解决方法是将其拆分为：
- Employee(emp_id, name, dept_id)
- Department(dept_id, dept_name)

现在两个表都符合 3NF。
