图灵机 (TM) 是一个 7 元组 $(Q,\Sigma,\Gamma,\delta,q_0,q_a,q_r)$, 
- $Q$ 是状态集;
- $\Sigma$ 是输入字母表, 不包括空白符;
- $\Gamma$ 是带字母表, 其中 $\text{空白符}\in\Gamma,\Sigma\in\Gamma$. 
- $\delta:Q\times\Gamma\to Q\times\Gamma\times\{L,R\}$ 是转移函数;
- $q_0\in Q$ 是起始状态;
- $q_a\in Q$ 是接受状态;
- $q_r\in Q$ 是拒绝状态, $q_a\neq q_r$. 

图灵机根据转移函数运行. 

- 若 TM 进入接受状态, 则停机且接受输入;
- 若 TM 进入拒绝状态, 则停机且拒绝输入;
- 否则 TM 一直运行不停机.

![[判定器]]

![[图灵可判定语言]]

![[图灵可识别语言]]

![[NTM]]