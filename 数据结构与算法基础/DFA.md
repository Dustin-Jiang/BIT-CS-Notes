确定性有限自动机 (DFA) 是一个 5 元组 $(Q,\Sigma,\delta,s,F)$, 
- $Q$ 是有限集, 称为状态集;
- $\Sigma$ 是有限集, 称为字母表;
- $\delta:Q\times\Sigma\to Q$ 是转移函数;
- $s\in Q$ 是起始状态;
- $F\subseteq Q$ 是接受状态集. 

读写头不能改写, 只能右移. 