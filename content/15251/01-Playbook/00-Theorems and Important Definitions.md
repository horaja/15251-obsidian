---
publish: true
---
*The purpose of this document is to compile all necessary theorems and complex definitions relevant for proof-writing.*
### 1. Induction

1.1 - **Derivation Complexity**: The derivation complexity of a recursively defined object is the *minimum number of applications of the recursive rule* needed to create the object.

### 2. Strings and Encodings

2.1 - **$\Sigma^*$ is Countably Infinite**

2.2 - **Statements of Basic Operations on Strings not needing justification**:
- For any string $w$ and any $n,m \in \mathbb{N}$, $w^nw^m = w^{n+m}$ and $(w^n)^m = w^{nm}$.
- For any strings $u,v$ and any symbol $a$, $|uv|_a = |u|_a + |v|_a$.
- For any strings $u$, $v$, $w$, if $uw = vw$, then $u = v$.
- For any string $w$, $(w^R)^R = w$.
- For any strings $u$, $v$, $(uv)^R = v^Ru^R$

2.3 - **Encoding**: Let $A$ be a set and let $\Sigma$ be an alphabet. An ***encoding scheme*** for $A$ using $\Sigma$ is an **injective** function(**uniqueness** + **totality**) $\text{Enc : }A\rightarrow \Sigma^*$. ^77ac50

### 3. Deterministic Finite Automata

3.1 - A **Deterministic Finite Automaton (DFA)** $M$ is a 5-tuple $$M = (Q, \Sigma, \delta, q_0, F)$$
where,
- $Q$ is the non-empty finite set of states
- $\Sigma$ is the non-empty finite set representing the alphabet
- $\delta : Q \times \Sigma \rightarrow Q$ is the transition function
- $q_0 \in Q$ is the start state
- $F \subseteq Q$ is the set of accepting states.

3.2 - Given two DFAs, **Isomorphism** implies **Equivalence**.

3.3 - Let $L$ be a **finite language**. Then there exists a DFA **solving** $L$.

3.4 - Although there exists a **unique** regular language that a DFA $M$ solves, there may exist **many** DFAs that solve a particular regular language.

3.5 - A **DFA-fooling Set** $P$ is such that **for all** $x,y \in P, x \neq y$, there exists a (*chosen*) $z \in \Sigma^*$ such that exactly one of $xz$ and $yz$ is in $L$, and the other is not.
- If the set is **infinite** $\implies$ non-regular language.

3.6 - The **state-complexity** of a language $L$, denoted $\text{SC}_{\text{DFA}} (L)$, is the minimum number of states in any DFA solving $L$.
- If no DFA solves $L$, we say $\text{SC}_{\text{DFA}} (L) = \infty$.

3.7 - **Closure Properties** Regular Languages are **closed under**...
1. *complementation*
2. *union*
3. *intersection*
4. *difference*
5. *finite union*

3.8 - Define the **Generalized Transition Function** $\delta_{\mathcal{P}} : \mathcal{P}(Q) \times \Sigma \rightarrow \mathcal{P}(Q)$ as follows. For $S \subseteq Q$ and $\sigma \in \Sigma$, $$\delta_{\mathcal{P}}(S, \sigma) =\{\delta(q,\sigma) : q \in S\}$$

