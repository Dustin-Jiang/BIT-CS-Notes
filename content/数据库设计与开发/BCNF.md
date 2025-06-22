一个关系模式 R 属于 **BCNF**（Boyce-Codd Normal Form），当且仅当对于每一个非平凡的函数依赖 X → A：

> X 必须是一个 [[超键]]（Superkey）

换句话说，只有当决定因素（X）是 [[候选键]] 时，才能有函数依赖。

## 特点

- BCNF 比 [[3NF]] 更严格。
- 在实际应用中，BCNF 能消除更多的更新异常。
- 不是所有关系都能分解为 BCNF 同时保持依赖（即可能无法做到既 BCNF 又保持所有函数依赖）。

## 示例

考虑关系：
```
CourseTeacher(course_id, teacher_id, office)
```

假设：
- course_id → teacher_id
- teacher_id → office

此时候选键是 `course_id`，因为通过 course_id 可以唯一确定 teacher_id。

但是 `teacher_id → office`，而 teacher_id 并不是候选键，因此不符合 BCNF。

解决方法是将其分解为：
- CourseTeacher(course_id, teacher_id)
- TeacherOffice(teacher_id, office)

这两个关系都满足 BCNF。

![[分解为 BCNF]]