---
publish: false
---
### Cook Reductions
#tag1 #tag2
##### Trigger

##### Goal shape

##### Recipe

##### Common Mistakes

##### Example/Reminder

### Karp Reductions
#tag1 #tag2
##### Trigger
To show a Karp Reduction from language $A$ to $B$, i.e. $A \leq_{m}^p B$
##### Goal shape

##### Recipe
1. Present a computable function $f : \Sigma^* \rightarrow \Sigma^*$.
2. Show that $x \in A \implies f(x) \in B$
3. Show that $x \notin A \implies f(x) \notin B$
	1. Easier to show $f(x) \in B \implies x \in A$
4. Show that $f$ can be computed in polynomial time.
##### Common Mistakes

##### Example/Reminder
