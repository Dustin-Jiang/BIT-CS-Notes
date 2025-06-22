#import "../undergraduate-thesis-template/template.typ" as template

假设以同学的选课表为主体，所有的表连接起来的结果为：
（学生姓名，学生学号，学生学院名称，学生学院代号，班级，出生日期，性别，课程，课程编号，授课教师姓名，教师编号，教师学院名称，教师学院代号，教师职称，课程类型，课程学分，学生成绩）.

#figure(
	template.three-line-table(
		("连接表", "连接条件", "作用"),
		("xs → xyb_1", [`xs.ydh = xyb_1.ydh`], "获取学生所属院系名称（ymc）"),
		("xs → xk", [`xs.xh = xk.xh`], "通过学生学号关联其选课记录"),
		("xk → kc", [`xk.kcbh = kc.kcbh`], "获取课程的基本信息（名称、类型、学分等）"),
		("xk → js", [`xk.jsbh = js.jsbh`], "获取授课教师的信息（姓名、职称等）"),
		("js → xyb_2", [`js.ydh = xyb_2.ydh`], "获取教师所属的院系名称"),
	),
	caption: "关键连接逻辑"
)


创建视图的SQL语句如下：

```sql
DROP VIEW IF EXISTS all_info_view;
CREATE VIEW all_info_view AS (
  SELECT 
	xs.xm AS xs_xm,
	xs.xh AS xs_xh,
	xyb_1.ymc AS xs_ymc,
	xs.ydh AS xs_ydh,
	xs.bj,
	xs.chrq,
	xs.xb,
	kc.kc,
	kc.kcbh,
	js.xm AS js_xm,
	js.jsbh,
	xyb_2.ymc AS js_ymc,
	js.ydh AS js_ydh,
	js.zc,
	kc.lx,
	kc.xf,
	xk.cj
  FROM (
    xs JOIN xyb AS xyb_1 ON (xs.ydh = xyb_1.ydh)
    JOIN xk ON (xs.xh = xk.xh)
    JOIN kc ON (xk.kcbh = kc.kcbh)
    JOIN js ON (js.jsbh = xk.jsbh)
    JOIN xyb AS xyb_2 ON (js.ydh = xyb_2.ydh) 
  )
	
  ORDER BY (xs_xm,js_xm)
);
```

#figure(
	image("assets/create-all-view-success.png"),
	caption: "成功创建连接全部表的视图"
)