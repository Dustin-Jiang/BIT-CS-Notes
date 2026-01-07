== 概述

本后端基于 Django + Django REST Framework 实现。主要对外 API 均被注册在 `/api/` 路径下。

- *认证方式：*
  - *Web/Staff*: 使用 Django session（DRF 的 `SessionAuthentication`）。登录后 staff 权限用于管理类操作。
  - *微信/手机客户端*: 使用自定义 apikey 验证 (`X-API-KEY` header + `Date` header + `username` query 参数)。验证算法见 `clinic/utils.py`。
- *路由注册：* 见 `clinic/urls.py`，主要资源：`users`, `records`, `wechat`, `date`, `announcement`, `campus`。
- *默认 pagination*: DRF 在 `settings.py` 中配置 page size 为 10（除非 ViewSet 指定 `pagination_class = None`）。

== 公共认证/访问点

=== GET /api-auth/login/ (DRF 浏览器登录)

*说明：* DRF 提供的登录入口，登录可用于 admin/staff 权限操作。

=== GET /api/user/

- *说明：* 返回当前登录用户（如果已登录），等价于 `/api/users/me/`。
- *权限：* 需要登录（返回当前用户）；若未登录返回匿名信息。
- *返回字段：* `ClinicUserSerializer` 中列出的字段（`url`, `username`, `id`, `is_staff`, `school`, `campus`, `realname`, `phone_num`, `work_mon` 等）。

== 用户管理 - `/api/users/` (Router: `ClinicUserViewSet`)

=== 基本动作

- *GET* `/api/users/` 列表（仅 staff 可列出）。
  - *参数：* `is_staff` (string), `today` (string), `campus` (string)
  - *用法：* 带 `is_staff=True` 可以过滤出值班人员。`today=True` 结合当前 weekday 过滤今天值班人员；`campus` 可按校区名称过滤。
- *POST* `/api/users/` 创建用户
- *GET* `/api/users/{id}/` 详情
- *PUT/PATCH / DELETE* `/api/users/{id}/` 修改/删除（例如 staff 或对象拥有者）。
- *自定义：* GET `/api/users/me/` 返回当前登录用户。

=== 权限行为

`ClinicUserPermission`：staff 可以列出（list）；普通用户不可 list，但可以查询/更改自身信息；非 staff 不能列出全部。

=== 请求/响应示例

返回示例（GET `/api/users/` 或 `/api/users/me/`）：

```json
{
  "url": "http://.../api/users/1/",
  "username": "student123",
  "id": 1,
  "is_staff": false,
  "school": "计算机学院",
  "campus": "主校区",
  "realname": "张三",
  "phone_num": "12345678",
  "work_mon": false,
  ...
}
```

== 工单（Record） - `/api/records/` (Router: `RecordViewSet`)

*默认权限：* `IsAdminUser`（管理人员）。若不是 staff，`get_queryset` 对于非 staff 将只返回当前用户的工单。

*资源字段：* 见 `RecordSerializer`（`fields='__all__'`），包括：`id`, `user` (URL), `worker`, `realname`, `phone_num`, `status`, `campus`, `appointment_time`, `arrive_time`, `description`, `worker_description`, `deal_time`, `model`, `method`, `reject_reason`, `password`, `is_taken` 等。

=== 常用操作

- *GET* `/api/records/` 列表（staff 可查看全部或按 `campus` 查询；普通用户只看自己）
- *GET* `/api/records/{pk}/` 详情
- *POST* `/api/records/` 创建工单（管理员）
- *PUT/PATCH/DELETE* `/api/records/{pk}/`

=== 自定义动作

- *GET* `/api/records/{pk}/call_user_back/`：管理员调用，返回 `{'detail':'already taken'}` 或 `{'detail':'send success'}`。用途：呼叫用户。
- *POST* `/api/records/insert/`：从管理员端快速插入一个工单
  - *请求体：* `user`（用户名），其他字段以 `RecordSerializer` 可接受的形式（例如 `campus` 用校区 name）。内部逻辑：如果找不到 `user` 会自动创建；`status` 为 `2`；`appointment_time` 会被设置为 `YYYY-MM-DD`（当天）。若当日诊所停业，返回验证错误。

=== 示例（POST 插入）

```json
{
  "user": "student_username",
  "campus": "主校区",
  "realname": "张三",
  "phone_num": "1234556",
  "description": "电脑无法开机"
}
```

=== 错误/校验

如果当日没有 `Date` 配置(诊所停业)，返回 400 带有 `{'msg':'今日诊所停业'}`。

== 微信端/客户端工单 - `/api/wechat/` (Router: `RecordViewSetWechat`)

*简介：* 为微信（或其他移动客户端）设计，使用 `ApikeyPermission` + `ApikeyAuthentication`。必须在 HTTP Headers 中提供：`X-API-KEY` 与 `Date`，并通过 `username`（query 参数）指定用户名。`X-API-KEY` 的校验方式：md5(server_api_key + username + Date_header)（见 `clinic/utils.py`）。

=== 查询/行为

- *GET* `/api/wechat/?username=<username>`：列出该用户的当前/未来工单（会过滤掉工作中状态和早于当前时间的工单）。
- *POST* `/api/wechat/`：创建工单（如微信端预约），校验流程：
  + 检查对应 `Date` 是否在营业且容量剩余；
  + 检查用户是否含有 >=1 个 `WORKING_STATUS` 的未完成工单；
  + 检查 `appointment_time` 是否为未来日期（不能选择过去）。

=== 自定义动作

- *GET* `/api/wechat/finish/?username=<username>`：返回已完成状态的工单（`FINISHED_STATUS` 列表）。
- *GET* `/api/wechat/working/?username=<username>`：返回当前 `WORKING` 状态的单条工单（若存在）。

=== Authentication 示例

生成 `X-API-KEY`（python）：

```python
from hashlib import md5
server_apikey = "oh-my-tlb"  # clinic_django.settings.apikey
username = "student123"
date_header = "Wed, 20 Aug 2025 08:00:00 GMT"  # 必须与请求头 Date 一致
key = md5((server_apikey + username + date_header).encode()).hexdigest()
# 把 `key` 放到 `X-API-KEY` header
```

curl GET example：

```bash
curl -H "X-API-KEY: <computed-md5>" -H "Date: <date-string>" \
  "http://<host>/api/wechat/?username=student123"
```

*注意：* `username` 是 query 参数而非 JSON body；若用户名不存在会在 `ApikeyAuthentication` 中被自动创建。

== 服务日期（Date） - `/api/date/` (Router: `DateViewSet`)

- *字段：* `title`, `date`, `capacity`, `campus` (校区名), `startTime`, `endTime`, `count`, `finish`, `working`（3 个只读字段用于统计）
- *权限：* `IsAuthenticatedOrReadOnly`，匿名用户可查看列表，带登录可做管理操作。
- *筛选：* 默认只返回 `date >= today`。若匿名用户，已结束时间（同日但 endTime < now）不显示。

=== 自定义动作

*GET* `/api/date/{pk}/cancel_all/`（仅管理员）：将该服务时间的所有未完成工单标记为 `未到诊所`（status=9）并返回 `{'count': <number cancelled>}`。

=== 校验

- *创建/更新：* `date` 不能早于今天；若该 Date 有已存在工单，则无法修改该 `date` 字段（避免出现逻辑冲突）；删除也要求 `count()==0`。

=== 示例

新增 Date POST body：

```json
{
  "title": "正常服务",
  "date": "2025-12-01",
  "capacity": 50,
  "campus": "主校区",
  "startTime": "09:00:00",
  "endTime": "17:00:00"
}
```

== 公告（Announcement） - `/api/announcement/` (Router: `AnnouncementViewSet`)

- *字段：* `title`, `content`, `brief`, `tag`（`TOS`/`AN`/`TA` 等), `expireDate`, `priority` 等。
- *权限：* `IsAuthenticatedOrReadOnly`。
- *自定义：* GET `/api/announcement/toc/` 返回 tag 为 `TOS` 的第一条公告内容 `{content: ...}`。

== 校区（Campus） - `/api/campus/` (Router: `CampusViewSet`)

- *字段：* `name`, `address`
- *权限：* `IsAuthenticatedOrReadOnly`，`pagination_class=None`（无分页）。

== 常见错误与返回值

- *401 未认证：* 当 DRF 默认权限要求登录但未提供 valid session/token。
- *403 权限被拒绝：* 例如非 staff 查询 `users` 列表；或 `X-API-KEY` 校验失败。
- *ValidationError (HTTP 400)：* 通常返回 `{'msg': '...详细原因...'}`，例如：当日期已满或选的日期停业时。

== 快速示例（curl + python）

=== 获取微信用户的预约（需要 X-API-KEY）

```bash
curl -H "X-API-KEY: <md5>" -H "Date: Tue, 20 Aug 2025 08:00:00 GMT" \
  "http://localhost:8000/api/wechat/?username=student123"
```

=== 创建一个 Date（需要管理员 session）

```bash
curl -X POST -u adminuser:password \
  -H "Content-Type: application/json" \
  -d '{"title":"...","date":"2025-12-18","capacity":20,"campus":"主校区","startTime":"09:00:00","endTime":"17:00:00"}' \
  "http://localhost:8000/api/date/"
```

=== 插入一个管理员工单

```bash
curl -X POST -u admin:password \
  -H "Content-Type: application/json" \
  -d '{"user":"student123","campus":"主校区","description":"问题描述"}' \
  "http://localhost:8000/api/records/insert/"
```

== 补充说明（技术细节）

- *Apikey 生成与验证逻辑：* `verify_apikey` 在 `clinic/utils.py` 中，算法为 `MD5(server_apikey + username + Date_header)`。
- *序列化器说明：* `ClinicUserSerializer` 使用 `SlugRelatedField` 对 `Campus` 以 `name` 标识，`RecordSerializer` 同样对 `Campus` 做同样处理。因此在 POST/PUT 时，`campus` 字段应传 `Campus.name`。
- *查询参数依赖：* `RecordViewSetWechat` 的 `get_queryset` 依赖 `username` query 参数；对于 RESTful clients 使用 apikey 验证时请始终带上此参数。
