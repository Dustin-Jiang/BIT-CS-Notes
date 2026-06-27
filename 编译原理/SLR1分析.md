## SLR(1) 分析

**SLR(1)**（Simple LR）通过 FOLLOW 集解决 LR(0) 中的冲突。

### 核心思想

LR(0) 的规则 2 中，对规约项目 $A \to \alpha·$，在所有输入符号上都填规约。SLR(1) 限制：**仅当输入符号 $a \in FOLLOW(A)$ 时才规约**。

**SLR(1) 分析表构造规则**（与 LR(0) 的区别仅在规则 2）：

- 规则 1、3、4 同 LR(0)
- **规则 2（SLR 修改）**：若 $A \to \alpha· \in I_k$（$A \neq S'$），则对每个 $a \in FOLLOW(A)$，$ACTION[k, a] = R_m$

### 冲突判断

若 SLR(1) 表中仍有双重定义条目，则文法不是 SLR(1)。

### 完整示例

文法 $G$：

$$(0)\ S' \to S \qquad (1)\ S \to aS \mid b$$

项目集规范族：

- $I_0 = \{ S' \to ·S, S \to ·aS, S \to ·b \}$
- $I_1 = closure(\{ S' \to S· \})$
- $I_2 = closure(\{ S \to a·S \}) = \{ S \to a·S, S \to ·aS, S \to ·b \}$
- $I_3 = closure(\{ S \to b· \})$
- $I_4 = closure(\{ S \to aS· \})$

求 FOLLOW 集：

- $FOLLOW(S) = \{\$\}$（$S$ 为开始符号）
- $FOLLOW(S') = \{\$\}$

SLR(1) 分析表：

| 状态 | $a$ | $b$ | $\$$ | $S$ |
|------|-----|-----|------|-----|
| 0 | $S_2$ | $S_3$ | | 1 |
| 1 | | | $ACC$ | |
| 2 | $S_2$ | $S_3$ | | 4 |
| 3 | $R_2$ | $R_2$ | $R_2$ | |
| 4 | $R_1$ | $R_1$ | $R_1$ | |

$I_3$ 中 $S \to b·$ 是规约项，$FOLLOW(S) = \{\$\}$，因此 $ACTION[3, \$] = R_2$ 而非所有符号填规约，有效减少了 LR(0) 中多余规约。

## SLR(1) 局限性

FOLLOW 集不区分规范推导的具体上下文。

示例：$S \to aAd \mid bBd \mid aBe \mid bAe$，$A \to c$，$B \to c$

- $FOLLOW(A) = \{d, e\}$，$FOLLOW(B) = \{d, e\}$
- LR(0) 中状态 $[A \to c·, B \to c·]$ 有规约 - 规约冲突
- SLR(1) 仍无法区分（$FOLLOW(A) \cap FOLLOW(B) \neq \varnothing$）
- 需 LR(1) 引入搜索符区分

#重点 SLR(1) 用 FOLLOW 集解决冲突，但 FOLLOW 集不区分规范推导的路径。
