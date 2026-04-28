---
publish: false
---
### Prove a Language is Decidable
##### Trigger
Show $L$ is **decidable**, with no obvious helper language to reduce to.

##### Goal shape
Construct a decider TM, where, for any $w \in L$, $M(w)$ accepts, and for any $w \notin L$, $M(w)$ rejects.
##### Recipe
1. Write high-level **pseudocode**
2. Use Known **Building Blocks**:
	1. Closure Properties of Decidable Languages
	2. Universal TM
	3. Decidable helpers like $\text{SAT}_{\text{DFA}}$
		1. intersect/complement Languages of DFAs, check emptiness.
3. Justify $M$ **halts on all inputs**.
4. Prove both directions of **correctness**.
##### Common Mistakes
- If you have a `for` loop, argue **that your TM halts** with an explicit bound.
##### Example/Reminder

---
### Prove a Language is Decidable through Reductions. 

##### Trigger
Show $L$ is **decidable**, with a natural decidable language $K$ to reduce to.
##### Goal shape
Want to show $L \le K$.
Define a TM $M_L(x)$ that constructs a $K$-instance and calls $M_K$.
##### Recipe
1. Let $M_K$ be the decider for $K$
2. Build $M_L$ constructing transformed object inside, then returns $M_K(\dots)$ or $\texttt{not} \ M_K(\dots)$
3. Prove correctness: $x \in L \iff M_K$ accepts transformed instance
##### Common Mistakes
- Direction Confusion
	- Think of $\le$ as an $\impliedby$; 
	- $K$ decidable $\implies$ $L$ decidable.
##### Example/Reminder

