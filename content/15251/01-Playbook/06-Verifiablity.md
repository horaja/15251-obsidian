---
publish: false
---
### Proof of Verifiability
#turingmachine #verifiability
##### Trigger
- Show a language/decision problem is **verifiable**.

##### Goal shape
- Present a **Verifier** $V$ (TM) taking in two inputs $x$ and $v$.
- Argue $V$ is correct.

##### Recipe
1. Define/demand a proof string $u$
2. Define a Verifier TM
	1. Implement type checking if needed
3. Argue Correctness
	1. Completeness: $x \in L \implies \exists u, V (x,u)$ accepts.
		1. "when $u$ is the encoding of (insert desired proof string)"
	2. Soundness: $\exists u, V (x,u) \text{ accepts} \implies x \in L$
	3. $V$ is Decidable
		1. *Usually straightforward*.

##### Common Mistakes

##### Example/Reminder
- See Proposition 6 for verifiability of $\text{SAT}_{\text{TM}}$, many times will require a *hidden proof string*, like **there exists some number $k$ such that $M(x)$ halts.**

---
### [TODO] Proof of Impossibility via Mapping Reductions
#tag1 #tag2
##### Trigger
- 

##### Goal shape

##### Recipe

##### Common Mistakes

##### Example/Reminder
- Exercise 23
