---
publish: true
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
2. $Q$: Present this information as a finite combination of *possibilities*/**states**.
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
- When is it regular?
	- Usually, any constraint on the language that must be continuously checked by the DFA forever.
		- e.g. 'at most'

##### Goal shape
Show that an arbitrary (any) DFA cannot solve this language.

##### Recipe
This will be a proof by contradiction.
1. Assuming there exists a DFA $M$, observe it has $k$ states.
	1. An observation of the **structure** of the DFA (i.e. $M$ splits $\Sigma^*$ into $k$ equivalence classes.)
2. Define a **[[00-Theorems and Important Definitions#3. Deterministic Finite Automata|DFA-Fooling Set]]** $P$ of size $k+1$ over $L$.
	1. Prove it is a **DFA-Fooling Set** by showing for any two non-equal elements of $P$, they force *different* outcomes on $M$.

##### Common Mistakes

##### Example/Reminder
- Text Exercise on proving *Powers of 2 is not DFA-solvable*.
---
### Proving $\text{SC}_{\text{DFA}}(L)$ - TODO
#lower-bound #DFAfoolingSet
##### Trigger

##### Goal shape

##### Recipe

##### Common Mistakes

##### Example/Reminder
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
	1. Idea: *Store a minimal summary of **the current prefix** you are processing*.
	2. Practically: Think of *what an **ideal** algorithm would do*.
		1. Then, acting as a **DFA**, what information do you need to **track** to simulate this algorithm.
		2. Encode this information as your **state space**
			1. Some common examples:
				1. Multiple machines (threads) - small number -> tuple
				2. Small control mode - bit/counter/etc.
				3. Set of possible states for many threads
					1. Will need to represent with power set.
3. Formally construct the **DFA**.

##### Common Mistakes
- Ensure it **type-checks**.
- Keep the intuition explanation **short**.

##### Example/Reminder
- Proof of closure of regular languages over Union/Concatenation/Star from text.
