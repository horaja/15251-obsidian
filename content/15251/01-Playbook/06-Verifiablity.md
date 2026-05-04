---
publish: true
---
### Proof of Verifiability
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
### Proof of Impossibility via Mapping Reductions
##### Trigger
Want to show $L$ is *NOT* in some 'computability' class (i.e. semi-decidability, decidability).
##### Goal shape
Show $L_\text{HARD} \le_\text{m} L$, i.e. produce a *total computable function* $f : \Sigma^* \rightarrow \Sigma^*$ such that $x \in L_{\text{HARD}} \iff f(x) \in L$.
##### Recipe
1. Pick $L_{\text{HARD}}$
	1. $\text{HALTS}_{\text{TM}}$ for proving undecidability
	2. $\text{NSA}_{\text{TM}}$ for proving semi-undecidability
2. Define $f$ by constructing a helper TM $M'$ to shape the output (should be input/instance of $L$)
	1. Bake in inputs of $\text{HARD}$ language, and case on accept/reject.
##### Common Mistakes
##### Example/Reminder
- Exercise 23
