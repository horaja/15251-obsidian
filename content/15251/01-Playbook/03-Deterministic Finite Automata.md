---
publish: false
---
### Designing a DFA
#construction #DFA #regular
##### Trigger
- "Prove a Language is Regular" - by definition of a **regular language**.
- Mostly, any statement covering a **lower bound** is regular.
	- See *homework 2* for exceptions.

##### Goal shape
Define a DFA as $M = (Q, \Sigma, \delta, q_0, F)$.

##### Recipe
**Key Idea**: Put *yourself* in the place of the DFA
- you iterate through the string **once**, **symbol-by-symbol**, **left-to-right**.
- You have a constant/**fixed** memory
1. Determine all **necessary information** needed to output an accept/reject decision after every symbol in the string.
2. $Q$: Present this information as a finite combination of *possibilities*/**states**. Some common patterns:
	1. Some **counter mod $k$
	2. The most recent **few symbols**
3. Assign $\delta$ over $\Sigma$.
4. Assign $q_0$ based on the possibility corresponding to seeing 0 symbols ($\epsilon$).
5. Assign $F$.

##### Common Mistakes
- use template as a guide *if stuck*, try to reason about structural properties of the language.

##### Example/Reminder
- To prove a language is regular, prove *complement* of language regular.
- Recitation 2, Section 3.
---
### Proof of Non-Regular Language
#non-regular #DFA #contradiction
##### Trigger
- Given some language, show that it is **non-regular**, i.e. unsolvable by a DFA
- When is it non-regular?
	- Usually, any constraint on the language that *must be continuously checked by the DFA forever.*
		- e.g. 'at most'

##### Goal shape
Show that an arbitrary (any) DFA cannot solve this language.

A DFA with $k$ states defines $k$ separability class on $\Sigma^*$.
Providing $k+1$ pairwise-separable strings, two of them must collapse to the same state, but separability says they shouldn't—contradiction.

##### Recipe
This will be a proof by contradiction.
1. Assuming there exists a DFA $M$, observe it has $k$ states.
	1. An observation of the **structure** of the DFA (i.e. $M$ splits $\Sigma^*$ into $k$ equivalence classes.)
2. Define a **[[00-Theorems and Important Definitions#3. Deterministic Finite Automata|DFA-Fooling Set]]** $P$ of size $k+1$ over $L$.
	1. Identify the *information the language forces the DFA to remember forever*, and build $P$ as a family of strings parametrized by that information.
		1. If you have a *candidate DFA*, for each state, pick one canonical representation of a string that lands in that state.
		2. Don't forget sink state.
	2. Prove it is a **DFA-Fooling Set** by showing for any two non-equal elements of $P$, they force *different* outcomes on $M$.
		1. Note that the $z$ you select can **depend** on $x$ and $y$.

##### Common Mistakes

##### Example/Reminder
- Text Exercise on proving *Powers of 2 is not DFA-solvable*.
---
### Proof for Closure of Language
#DFA #closure #regular
##### Trigger
- Show a **regular** language is closed over some **operation**.

##### Goal shape
1. Construct a DFA $M = (Q, \Sigma, \delta, q_0, F)$ from assumptions.
2. Prove correctness via **double containment** (if needed).

##### Recipe
1. State assumptions & proof strategy.
2. Explain intuition of construction
	1. Idea: *Store a **minimal summary of the current prefix** you have seen so far* inside your state space $Q$.
	2. Practically: Think of *what an **ideal** algorithm would do*.
		1. Then, acting as a **DFA**, what information do you need to **track** to simulate this algorithm.
		2. Encode this information as your **state space** $Q$—common patterns:
			1. **Tuple Threading**
				1. Utilizing a **mode bit** (for parity, etc.)
			2. **Powerset Threading**
			3. **Main + Ghost Threading**
			4. **Decomposition by Intermediate State + finite union**
3. Formally construct the **DFA**.

Alternatively, consider using previously proved closure properties:
- Concatenation
- Union/Intersection
	- **Finite Union**
- Concatenation
- Star

##### Common Mistakes
- Ensure it **type-checks**.
- Keep the intuition explanation **short**.

##### Example/Reminder
- Proof of closure of regular languages over Union/Concatenation/Star from text.

---
### Proof of [[00-Theorems and Important Definitions#^effb92|State Complexity]]
#pigeonfooling #DFA
##### Trigger
- "**minimum number of states** in any DFA solving some language L"

##### Goal shape
To show the state complexity of a language is some $k$:
1. Define a DFA with $k$ states that solves the language.
2. Define a **DFA-Fooling Set** of size $k$.

##### Recipe
1. Upper bound the state complexity by [[03-Deterministic Finite Automata#^ef13e1|Defining a DFA]].
	1. Prove correctness as needed.
2. Lower bound the state complexity by defining a DFA-fooling set, and then proving it is one.

##### Common Mistakes
- Ensure you work through examples to understand exactly how to define $k$.

##### Example/Reminder

