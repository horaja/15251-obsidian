---
publish: true
---
---
### Karp Reductions
##### Trigger
To show a Karp Reduction from language $A$ to $B$, i.e. $A \leq_{m}^p B$
##### Goal shape

##### Recipe
1. Present a computable function $f : \Sigma^* \rightarrow \Sigma^*$. **Three types**:
	1. Trivial - underlying structure is the same
	2. Local Change - repeated transformation to every part of input of same type (e.g. circuit's variables to graph vertices, etc.) - cna be parallelized.
	3. Global Change - 'asymmetric' transformation involving the input as a whole (e.g. adding a clique, fully connecting a new vertex to everything, adding a gadget, etc.)
2. Show that $x \in A \implies f(x) \in B$
3. Show that $x \notin A \implies f(x) \notin B$
	1. Easier to show $f(x) \in B \implies x \in A$
4. Show that $f$ can be computed in polynomial time.
##### Common Mistakes
1. How do you *decide on the language to reduce from* for NP-Hard proofs?
	1. Name the Problem $\rightarrow$ pattern match
	2. Identify all relevant quantifiers $\rightarrow$ pattern match
	3. Identify structure of certificate for verifier $\rightarrow$ pattern match

##### Example/Reminder
