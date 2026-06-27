## 自上而下 vs 自下而上

- **自上而下**：从开始符号 $S$ 出发，推导出输入串。（LL 分析、递归下降）
- **自下而上**：从输入串出发，规约到开始符号 $S$。（LR 分析）

## 回溯问题

自上而下分析中，若某非终结符有多个候选式，选择错误则需回退——**回溯**。

产生回溯的原因：

- 左递归导致死循环
- 候选式 FIRST 集重叠
- 候选式含 $\varepsilon$ 且与 FOLLOW 集冲突

## 左递归消除

### 消除直接左递归

$$P \to P\alpha_1 \mid P\alpha_2 \mid \ldots \mid P\alpha_n \mid \beta_1 \mid \beta_2 \mid \ldots \mid \beta_m$$

转换为：

$$P \to \beta_1 P' \mid \beta_2 P' \mid \ldots \mid \beta_m P'$$
$$P' \to \alpha_1 P' \mid \alpha_2 P' \mid \ldots \mid \alpha_n P' \mid \varepsilon$$

### 消除间接左递归

算法（代入后消除直接左递归）：

1. 对非终结符排序 $A_1, A_2, \ldots, A_n$
2. 对于 $i$ 从 1 到 $n$：
   - 对于 $j$ 从 1 到 $i-1$：将 $A_j \to \alpha$ 代入 $A_i \to A_j \beta$ 中
   - 消除 $A_i$ 的直接左递归
3. 删除多余产生式

#重点 消除直接左递归公式必须掌握。

## 提取左公因子

若 $A \to \alpha\beta_1 \mid \alpha\beta_2$，提取 $\alpha$：

$$A \to \alpha A'$$
$$A' \to \beta_1 \mid \beta_2$$

## FIRST 集

**定义**：$FIRST(\alpha)$ 是从 $\alpha$ 推导出的所有串的首终结符集合。

**计算规则**：

1. 若 $\alpha = a\beta$（$a \in V_T$），则 $a \in FIRST(\alpha)$
2. 若 $A \to \alpha \in P$，则 $FIRST(\alpha) \subseteq FIRST(A)$
3. 若 $X \to Y_1Y_2\ldots Y_n$：
   - 将 $FIRST(Y_1)$ 中非 $\varepsilon$ 元素加入 $FIRST(X)$
   - 若 $Y_1 \stackrel{*}{\Rightarrow} \varepsilon$，则将 $FIRST(Y_2)$ 中非 $\varepsilon$ 加入
   - 依次类推
   - 若 $Y_1\ldots Y_n \stackrel{*}{\Rightarrow} \varepsilon$，则 $\varepsilon \in FIRST(X)$

#重点 FIRST 集计算规则必须掌握。

## FOLLOW 集

**定义**：$FOLLOW(A)$ 是在所有句型中紧跟在 $A$ 之后的终结符集合。

**计算规则**（反复迭代直到不动点）：

1. 将 `$` 加入 $FOLLOW(S)$（$S$ 为开始符号）
2. 若 $A \to \alpha B\beta$，则 $FIRST(\beta) \setminus \{\varepsilon\} \subseteq FOLLOW(B)$
3. 若 $A \to \alpha B$ 或 $A \to \alpha B\beta$ 且 $\beta \stackrel{*}{\Rightarrow} \varepsilon$，则 $FOLLOW(A) \subseteq FOLLOW(B)$

#重点 FOLLOW 集计算错误导致分析表全错。

### 关系图法求 FOLLOW 集（辅助方法）

关系图法为 FOLLOW 集计算提供直观的图形化方法：

1. 为每个非终结符建立结点
2. 若 $A \to \alpha B\beta$，则从 $B$ 到 $FIRST(\beta)$ 中的每个终结符 $a$ 画边 $B \to a$
3. 若 $A \to \alpha B$ 或 $A \to \alpha B\beta$ 且 $\beta \stackrel{*}{\Rightarrow} \varepsilon$，则从 $B$ 到 $A$ 画边 $B \to A$
4. 从每个结点出发，沿有向边可达的所有终结符和 `$` 即为该非终结符的 FOLLOW 集

#重点 关系图法可辅助 FOLLOW 集计算，但考试推荐用迭代法确保完整。

## LL(1) 分析表构造

对每条产生式 $A \to \gamma$：

1. 对每个 $a \in FIRST(\gamma)$，将 $A \to \gamma$ 填入 $M[A, a]$
2. 若 $\varepsilon \in FIRST(\gamma)$，则对每个 $b \in FOLLOW(A)$，将 $A \to \gamma$ 填入 $M[A, b]$

## LL(1) 分析算法

栈 + 分析表 + 控制程序：

1. 初始状态：栈 `$S`，输入指针指向第一个符号
2. 若栈顶 $X$ 与当前输入 $a$：
   - $X = a = \$$：接受
   - $X = a \neq \$$：匹配，弹出栈顶，输入指针前移
   - $X \in V_N$：查表 $M[X, a] = X \to Y_1\ldots Y_n$，弹出 $X$，压入 $Y_n\ldots Y_1$
   - 表中为空或出错则报错

#重点 LL(1) 分析表构造是核心内容，必须掌握考试重点。

## 递归下降分析法

为每个非终结符编写一个递归函数，函数体根据产生式候选式分支。

- 遇到终结符：匹配输入
- 遇到非终结符：调用对应函数
- 要求：无左递归、FIRST 集两两不相交

### 悬挂 else 问题

```c
if a then if b then c else d
```

二义性——else 与哪个 if 匹配？

解决：**最近匹配原则**——else 匹配最近的未匹配 if。

$$S \to iSeS \mid iS \mid a$$

## LL(1) 文法判定

#重点 分析表无多重定义即为 LL(1) 文法。

LL(1) 文法判定条件（等价）：

1. 无左递归
2. 无回溯条件：对任意 $A \to \alpha \mid \beta$，$FIRST(\alpha) \cap FIRST(\beta) = \varnothing$
3. 若 $\varepsilon \in FIRST(\alpha)$，则 $FIRST(\alpha) \cap FOLLOW(A) = \varnothing$

**无回溯条件**是充分非必要条件。
