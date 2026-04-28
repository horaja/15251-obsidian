---
publish: false
---
### Show $L$ in $\mathbf{NP}$
#tag1 #tag2
##### Trigger
Given a language $L$, show that it is in $\mathbf{NP}$.

##### Goal shape

##### Recipe
1. Present a TM $V$, that takes two inputs $x$ and $u$.
2. Argue that $V$ works correctly, which involves arguing for some constant $k > 0$,
	1. for all $x \in L$, there exists $u \in \Sigma^*$ with $|u| \leq |x|^k$ such that $V (x, u)$ accepts.
	2. for all $x \notin L$, for all $u \in \Sigma^*$, $V(x,u)$ rejects.
3. Argue that $V$ has polynomial running time.
##### Common Mistakes
- In your $V$, include a line checking the 'type' of $u$.
- When assuming $x \in L$, you can just state the desired proof string exists, and $u$ is it, so accept.
- In proof, assuming $x \notin L$:
	- $x$ not a valid encoding
	- $u$ does not correspond to a valid type of answer
	- $u$ is wrong

##### Example/Reminder
