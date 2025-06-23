一个关系模式 R 属于 **第二范式（2NF）**，当且仅当它满足以下两个条件：

1. 已经属于 **第一范式（1NF）**（即每个属性都是原子的，不可再分）。
2. 所有非 [[主属性]] 都 **[[完全函数依赖]]** 于 **[[候选键]]**（即不存在部分依赖）。

## 完全依赖 vs 部分依赖

- **部分依赖（Partial Dependency）**：某个非主属性只依赖于候选键的一部分。
- **完全依赖（Full Dependency）**：非主属性必须依赖于整个候选键。

## 示例

假设有一个关系模式：
```
StudentEnroll(student_id, course_id, student_name, grade)
```

候选键是 `(student_id, course_id)`，其中 `student_name` 只依赖于 `student_id`，不依赖于 `course_id` → 存在**部分依赖**。

因此这个关系不是 2NF。需要将其拆分为：
- Student(student_id, student_name)
- Enroll(student_id, course_id, grade)

这样就符合 2NF 了。