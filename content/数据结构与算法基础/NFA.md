非确定型有限自动机 (NFA), 
- 每步能以 0 到多种方式进入下一步
- 转移箭头上的符号可以为空串 $\varepsilon$, 可以没有输入就转移. 

NFA 是一个 5 元组 $(Q,\Sigma, \delta, s, F)$, 
- $Q$ 是状态集;
- $\Sigma$ 是字母表;
- $\delta: Q\times \Sigma_\varepsilon\to P(Q)$ 是转移函数. 
- $s\in Q$ 是起始状态;
- $F\subseteq Q$ 是接受状态集;
其中 $\Sigma_\varepsilon=\Sigma\cup\{\varepsilon\}$.

> 每个 NFA 都有等价的 [[DFA]]. 

