## 定义
- 远程过程调用（Remote Procedure Call）
- 使远程调用像本地调用一样方便（透明性）
- 分布式系统中，多台机器协作完成同一任务时，RPC 是跨节点通信的基石

## 为什么使用 RPC
- 解决分布式系统中服务之间的调用问题
- 让调用者感知不到远程调用的逻辑（透明性）
- 隐藏网络通信、参数编解码、错误处理等底层细节

## 核心组件

### Client Stub（客户端存根）
- 位于客户端，将函数调用参数打包为网络消息（编组 / Marshalling）
- 发送消息到服务器，接收返回结果并解包

### Server Stub（服务器存根）
- 位于服务器端，接收客户端请求消息
- 解包（Unmarshalling），调用实际的服务函数
- 将结果打包后返回客户端

### IDL（接口定义语言）
- Interface Definition Language，跨语言 / 跨平台描述 RPC 接口
- 语言无关，只定义函数名、参数类型、返回值类型

### IDL Compiler
- 编译 IDL 文件，自动生成三个文件：
  1. `client_stub.c` — 客户端代理代码
  2. `server_stub.c` — 服务器代理代码
  3. `header.h` — 接口声明头文件（供双方 include）

### UUID（通用唯一标识符）
- 每个 RPC 接口分配唯一的 UUID
- 用于区分不同服务，确保 Client 能精确找到目标 Server

### Binding（绑定）机制
- **Binder** 类似于工商注册中心，维护服务注册表
- Server 启动时向 Binder 注册（UUID + 服务地址）
- Client 通过 Binder 查询所需服务的 UUID → 获取 Server 地址 → 直接调用
- 实现 Client 与 Server 的动态绑定

## RPC 通信过程
```
Client  →  调用 Client Stub
         →  Stub 封送参数（Marshalling）
         →  网络传输
         →  Server Stub 解包（Unmarshalling）
         →  调用实际服务函数
         →  结果打包（Marshalling）
         →  网络传输回 Client Stub
         →  Client Stub 解包 → 返回给调用者
```

## 调用示例（阶乘计算）
1. **IDL 定义接口**：`rpc_fact`（包含 UUID、函数名、参数 n、返回值 result）
2. **IDL Compiler** 生成 `client_stub.c`、`server_stub.c`、`fact.h`
3. **Server 端**：include `fact.h`，实现阶乘函数，通过 Binder 注册服务
4. **Client 端**：include `fact.h`，直接调用 `rpc_fact(n)`，语法与本地调用完全相同
5. **底层**：Client Stub 打包参数 → 网络发送 → Server Stub 解包 → 执行阶乘 → 打包结果返回

## 关键问题
- 参数封送 / 解封（数据序列化与反序列化）
- 网络传输协议（TCP/UDP）
- 服务寻址（通过 Binder + UUID）
- 错误处理（网络故障、服务器故障）
- 幂等性（重复请求的处理策略）

## 与现代技术的关系
- RPC 是分布式系统通信的基础
- 现代演变：gRPC（Google）、Thrift（Facebook）、Dubbo（Alibaba）等框架
