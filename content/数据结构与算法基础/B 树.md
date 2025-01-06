$m$ 阶 B 树是一棵高度平衡的 $m$ 岔查找树. 

B 树的高度 $\log_m(N+1) \le h \le log_{\lceil m/2\rceil}((N+1)/2) + 1$, 其中 $N$ 为关键码数量. 

B 树上进行插入时要进行分裂操作. ![[Pasted image 20250106154949.png]]

![[B+ 树]]