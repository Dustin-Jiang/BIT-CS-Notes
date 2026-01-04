TCP 连接的生命周期包括连接建立、数据传送和连接释放三个阶段。

## 三次握手 (Connection Establishment)

#重点 连接建立解决同步序号、协商参数（如 MSS、窗口扩大因子）和分配资源。

1. 客户机发送连接请求：`SYN=1, seq=x`。进入 `SYN-SENT` 状态。
2. 服务器确认并同意：`SYN=1, ACK=1, seq=y, ack=x+1`。进入 `SYN-RCVD` 状态。
3. 客户机确认：`ACK=1, seq=x+1, ack=y+1`。进入 `ESTABLISHED` 状态。

## 四次挥手 (Connection Release)

#重点 释放连接需要双方分别关闭，进入半关闭状态。

1. 客户机发起释放：`FIN=1, seq=u`。进入 `FIN-WAIT-1`。
2. 服务器确认：`ACK=1, seq=v, ack=u+1`。进入 `CLOSE-WAIT`。此时从 A 到 B 的连接释放，但服务器仍可发送数据。
3. 服务器发起释放：`FIN=1, ACK=1, seq=w, ack=u+1`。进入 `LAST-ACK`。
4. 客户机确认：`ACK=1, seq=u+1, ack=w+1`。进入 `TIME-WAIT`。

## 2MSL 等待

#重点 客户机在 `TIME-WAIT` 状态必须等待 2 倍的最长报文寿命 (MSL) 后才能进入 `CLOSED`：

- 目的：
    1. 确保最后一个 ACK 报文能到达服务器，若丢失则服务器会重传 FIN+ACK。
    2. 防止 “已失效的连接请求报文段” 出现在新连接中，让本连接产生的所有报文都从网络中消失。

## TCP 有限状态机

见课件 P64 状态转换图。主要的正常变迁包括：
- 客户：`CLOSED -> SYN_SENT -> ESTABLISHED -> FIN_WAIT_1 -> FIN_WAIT_2 -> TIME_WAIT -> CLOSED`
- 服务器：`CLOSED -> LISTEN -> SYN_RCVD -> ESTABLISHED -> CLOSE_WAIT -> LAST_ACK -> CLOSED`
