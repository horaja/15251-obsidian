---
publish: false
---
---
### Proof of Intrinsic Complexity of Language $L$
##### Trigger

##### Goal shape

##### Recipe
1. To prove Intrinsic Complexity in $O(f(n))$, present an algorithm $A$ that decides $L$ in $O(f(n))$ time.
2. To prove Intrinsic Complexity in $\Omega(f(n))$:
	1. AFSOC there exists a decider $A$ that always finishes in $< f(n)$ steps on length-$n$ inputs.
	2. Define the notion of a *step*.
	3. Pick a **hard pair** of inputs $x$ and $x'$ of the same length $n$ so that:
		1. $x$ is a YES-instance, $x'$ is a NO-instance (or vice versa)
		2. They differ on only a *small* part of the input
	4. Argue that $A$, however, accepts or rejects **both**
		1. Thus, any algorithm must take $f(n)$ steps/positions inspected, forcing a lower bound.

##### Common Mistakes

##### Example/Reminder
- Similar to DFA-fooling set proof
