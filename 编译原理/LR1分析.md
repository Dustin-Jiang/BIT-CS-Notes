## LR(1) 项目

LR(1) 项目是带搜索符的二元组：

$$[A \to \alpha·\beta, a]$$

- $A \to \alpha·\beta$：LR(0) 项
- $a$：搜索符（展望符），$a \in V_T \cup \{\#\}$

**含义**：在 $\beta$ 归约为 $A$ 后，期望下一个输入符号是 $a$。

## 搜索符传播

LR(1) 中 B 包计算需要处理搜索符：

### LR(1) 闭包计算

对于项目集 $I$：

1. $I \subseteq closure(I)$
2. 若 $[A \to \alpha·B\beta, a] \in closure(I)$，则对每个 $B \to \gamma \in P$ 和每个 $b \in FIRST(\beta a)$，将 $[B \to ·\gamma, b]$ 加入 $closure(I)$

**搜索符传播规则**：$b = FIRST(\beta a)$——从 $\beta$ 的后继符号中取第一个终结符。

### LR(1) GO 函数

$$GO(I, X) = closure(\{ [A \to \alpha X·\beta, a] \mid [A \to \alpha·X\beta, a] \in I \})$$

搜索符在 GO 函数中**保留不变**。

#重点 B 包中搜索符计算：$FIRST(\beta a)$。

## LR(1) 项目集规范族构造

同 LR(0) 流程，但使用 LR(1) 的 B 包和 GO 函数：

1. $C = \{ closure(\{ [S' \to ·S, \$] \}) \}$
2. 对 $C$ 中每个 $I$ 和每个文法符号 $X$，若 $GO(I, X) \notin C$，则加入
3. 重复直到不动点

## LR(1) 分析表构造

**规则 1**（移进）：若 $[A \to \alpha·a\beta, b] \in I_k$ 且 $GO(I_k, a) = I_j$，则 $ACTION[k, a] = S_j$

**规则 2**（规约）：若 $[A \to \alpha·, a] \in I_k$（$A \neq S'$），则 $ACTION[k, a] = R_m$

**规则 3**（接受）：若 $[S' \to S·, \$] \in I_k$，则 $ACTION[k, \$] = ACC$

**规则 4**（GOTO）：若 $GO(I_k, A) = I_j$（$A \in V_N$），则 $GOTO[k, A] = j$

LR(1) 的关键优势：规约仅对搜索符进行，而非 FOLLOW 集中的所有符号。

#重点 LR(1) 项目二元组结构，搜索符精确控制规约时机。
