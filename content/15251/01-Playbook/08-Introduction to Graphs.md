---
publish: false
---
---
### Proof of Property of Graph via Handshake Lemma and Degree Counting
##### Trigger

##### Goal shape

##### Recipe
1. Write **Handshake Lemma**
2. Split the sum creatively based on your problem
	1. i.e. over a disjoint partition of the vertices, each contributing a specifically written amount to the sum
3. Substitute known facts about your graph
	1. e.g. for any tree, $m=n-1$.
4. Rearrange algebra until you reach your desired result.

For any WTP statement that isn't easily algebraically written, try AFSOC, and then **lower bounding the sum** in the Handshake Lemma, showing it is **greater than $2m$**.

##### Common Mistakes

##### Example/Reminder
- **Trees** always have $m=n-1$, and thus by **The Handshake Lemma**, the sum of the degrees of the vertices is always $2n-2$.
- Let $T$ be a tree with at least $2$ vertices. Then $T$ must have at least $2$ leaves.
- Let $T$ be a tree with $L$ leaves. Let $\Delta$ be the largest degree of any vertex in $T$. Then $\Delta \leq L$.

---
### Proof of Property of Graphs via Induction
##### Trigger

##### Goal shape
Suppose we want to prove that all graphs with property $A$ must also have property $B$.
##### Recipe
1. Prove the base case(s)
2. Assume the statement is true for all graphs with $n$ vertices or less.
	1. Inductive Hypothesis
3. Consider an **arbitrary** graph on $n+1$ vertices that has property A.
4. Remove '*some*' vertices to obtain a smaller graph (or a collection of smaller graphs).
	1. Most likely will need to **case** here.
		1. If smaller graphs have property $A$, by IH, conclude they must have property $B$.
		2. Using this conclusion, establish that the original graph with $n+1$ vertices that you started with must have property $B$.

##### Common Mistakes
- Instead of assuming $n$th object and constructing/proving $n+1$th object:
	- WTS property holds from tree $T$ with $n+1$ vertices.
	- Construct tree $T'$ with $< n+1$ vertices by *deleting/destroying* part of $T$, then use inductive hypothesis on $T'$

##### Example/Reminder
- Every tree with $n \geq 2$ vertices must have a leaf.
- When we remove a leaf from a tree, we end up with a smaller tree - apply IH.
- When we remove an internal node from a tree, we end up with $\text{deg}(v)$ smaller trees - apply IH to collection of trees.
- **When Deciding Case Split**, think *"Will removing $u$ break the hypothesis or not?"*
	- Case Split should usually be **on property of node in arbitrary original $T$.**

---
### Proof of Property of Graph via Removing All Edges and adding them back in one by one.
##### Trigger

##### Goal shape

##### Recipe

##### Common Mistakes

##### Example/Reminder
