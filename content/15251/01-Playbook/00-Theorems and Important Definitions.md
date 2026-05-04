---
publish: true
---
### 1. Induction

1.1 - **Derivation Complexity**: The derivation complexity of a recursively defined object is the *minimum number of applications of the recursive rule* needed to create the object.

---
### 2. Strings and Encodings

2.1 - **$\Sigma^*$ is Countably Infinite**

2.2 - **Statements of Basic Operations on Strings not needing justification**:
- For any string $w$ and any $n,m \in \mathbb{N}$, $w^nw^m = w^{n+m}$ and $(w^n)^m = w^{nm}$.
- For any strings $u,v$ and any symbol $a$, $|uv|_a = |u|_a + |v|_a$.
- For any strings $u$, $v$, $w$, if $uw = vw$, then $u = v$.
- For any string $w$, $(w^R)^R = w$.
- For any strings $u$, $v$, $(uv)^R = v^Ru^R$

2.3 - **Encoding**: Let $A$ be a set and let $\Sigma$ be an alphabet. An ***encoding scheme*** for $A$ using $\Sigma$ is an **injective** function(**uniqueness** + **totality**) $\text{Enc : }A\rightarrow \Sigma^*$. ^77ac50

---
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

3.6 - The **state-complexity** of a language $L$, denoted $\text{SC}_{\text{DFA}} (L)$, is the minimum number of states in any DFA solving $L$. ^effb92
- If no DFA solves $L$, we say $\text{SC}_{\text{DFA}} (L) = \infty$.

3.7 - **Closure Properties** Regular Languages are **closed under**...
1. *complementation*
2. *union*
3. *intersection*
4. *difference*
5. *finite union*

3.8 - Define the **Generalized Transition Function** $\delta_{\mathcal{P}} : \mathcal{P}(Q) \times \Sigma \rightarrow \mathcal{P}(Q)$ as follows. For $S \subseteq Q$ and $\sigma \in \Sigma$, $$\delta_{\mathcal{P}}(S, \sigma) =\{\delta(q,\sigma) : q \in S\}$$

---
### 4. Turing Machines

4.1 - If a TM $M$ is a **decider**, then $M$ must **halt** on *all* inputs. Furthermore, $L(M)$ is the *unique* language that $M$ solves.
- 4.1.1: $M$ solves/decides a language $L$ if:
	- if $w \in L$, then $M$ accepts $w$
	- if $w \notin L$, then M rejects $w$
- 4.1.2: $M$ **semi-decides** $L$ if for all $w \in \Sigma^*$, if $w \in L$, then $M$ accepts $w$.

4.2 - If a language is **undecidable**, then for all Turing Machines $M$, there exists some input $w$ such that $f(w) \neq M(w)$.

4.3 - A Turing Machine $M$ solves (or *computes*) **a function problem** $f : \Sigma^* \rightarrow \Sigma^*$ if for all $x \in \Sigma^*$, $M(x) = f(x)$.

4.4 - **The Church-Turing Thesis**: Any computation that can be conducted in this universe can be carried out by a TM.

4.5 - Input of any Turing Machine $M$, including the Universal Turing Machine $U$, must be a **finite-length string** (possibly encoding another object).

4.6 - Some Languages on the **encodings of DFAs**
- $\text{ACCEPTS}_{\text{DFA}} = \{\langle D,x \rangle : D \text{ is a DFA that accepts } x\}$
- $\text{SA}_{\text{DFA}} = \{\langle D \rangle : D \text{ is a DFA that self-accepts}\}$
	- Use a decider $M_{\text{SAT}}$ to 'test' for non-emptiness.
- $\text{SAT}_{\text{DFA}} = \{\langle D \rangle : D \text{ is a satisfiable DFA}\}$
- $\text{NEQ}_{\text{DFA}} = \{\langle D_1, D_2 \rangle : D_1 \text{ and } D_2 \text{ are DFAs such that } L(D_1) \neq L(D_2)\}$

---
### 5. Uncountability and Uncomputability

5.1 - If $\mathcal{S}$ is an infinite set and $|\mathcal{S}| \leq |\mathbb{N}|$, then $|\mathcal{S}| = |\mathbb{N}|$.

5.2 - Let $\mathbb{F}(X)$ denote the **set of all functions** of the form $\mathcal{f} : X \rightarrow \{0,1\}$ and let $\mathcal{P}(X)$ denote the **set of all subsets** of $X$. Then, $|\mathbb{F}(X)| = |\mathcal{P}(X)|$.
- applicable to sets, infinite sequences (set of all infinite-length binary strings), real numbers, etc.

5.3 - **Cantor's Theorem**: For any set $X$, $|X| < |\mathbf{F}(X)|$.

5.5 - When setting up the **Diagonalization Proof**, note that $\mathcal{F}$ need not be a set of functions, only that the elements must be **"function-like"**.
- e.g. Turing machines

5.6 - Undecidable Languages are **closed under complement**.

5.7 - **Reduction Order**: $\mathcal{A} \leq \{0^n1^n : n \in \mathbb{N}\} < \text{HALTS}_{\text{TM}} \leq \mathcal{B}$
- Proves $\mathcal{A}$ is decidable and $\mathcal{B}$ is undecidable.

5.8 - **Mapping Reduction**: To show $L \leq_m K$ (L reduces to K), construct the TM $M_L$ using $M_K$ as such: $M_L(x) = M_K(f(X))$

5.9 - For **reductions** from $\text{HALTS}_{\text{TM}}$, simulate $M(x)$ within $M'$.
- If $M(x)$ halts, then $L(M) = \Sigma^*$
- If $M(x)$ loops, then $L(M) = \varnothing$.

---
### 6. Verifiability

6.1 - Many **verifiable** languages/problems have the similar form: *Given as input $X$, does there exist $Y$*.
- For many problems, the proof is obvious.
- Non-obvious proof example:
	- **$\text{HALTS}_{\text{TM}}$** - proof string $u$ is the 'number of steps $k$' to run the TM for until it halts (or does not halt).

6.2 - For verifiability problems, it is important to note that what we are checking for has a **finite length string representation**.

6.3 - $L$ decidable $\implies$ $L$ verifiable.

6.4 - If there exists $L$ such that both $L$ and $\bar{L}$ verifiable $\implies$ L is decidable.
- Corollary: If $L$ is verifiable but undecidable, then $\bar{L}$ is unverifiable.

6.5 - Verifiability is **closed** under **union** and **intersection**.

6.6 - **RE $\cap$ coRE = R**

6.7 - For all $L \in \text{RE}$, $L \leq_m \text{SAT}_{\text{TM}}$.
- $\text{SAT}_{\text{TM}}$ is **one of the** hardest verifiable languages.

---
### 7. Time Complexity

7.1 - To show $f(n) = \Theta(g(n))$, must show there exists constants $c, C, n_0$ such that for all $n \geq n_0$, $c \leq \frac{f(n)}{g(n)} \leq C$.
- For $O$ and $\Omega$, only need to bound *one side* respectively.

7.2 - A number is considered **small** if its length $> O(\log n)$ where $n$ is the *input length for your overall algorithm*.

7.3 - $\log (n!) = \Theta(n\log n)$

---
### 8. Introduction to Graph Theory

8.1 - A graph $G$ is called **d-regular** if every vertex $v \in V$ satisfies $\text{deg}(v) = d$.

8.2 - **The Handshake Lemma** - Let $G = (V, E)$ be a graph. Then $$\sum_{v \in V}^{}\text{deg}(v) = 2m$$

8.3 - Let $G = (V,E)$ be a **connected graph** with $n$ vertices and $m$ edges. Then $m \geq n-1$.
- If G is **acyclic (i.e. is a tree)**, then $m = n-1$.

8.4 - A graph satisfying two of the following three properties is a **tree**:
1. connected
2. $m = n-1$
3. acyclic

8.5 - In an undirected DFS, cross and forward edges are not possible.

---
### 9. Matchings in Graphs

9.1 - Any graph with an odd number of vertices cannot have a perfect matching.

9.2 - Let $G = (V, E)$ be a graph. Then **a matching $M \subseteq E$ is maximum** if and only if there is no augmenting path in $G$ with respect to $M$.

9.3 - Let $G = (V, E)$ be a graph such that all vertices have degree at most 2. Then every connected component is either a cycle or a disjoint path.

9.4 - $G$ is $k$-colorable if it has a legal $k$-coloring.

9.5 - A graph is bipartite if and only if it contains no odd-length cycles.

9.6 - **Hall's Theorem** - Let $G = (X, Y, E)$ be a bipartite graph. For a subset $S$ of vertices, let $N(S) = \bigcup_{v \in S}^{}N(v)$. Then G has a matching covering all vertices in $X$ if and only if for all $S \subseteq X$, we have $|S| \leq |N(S)|$.

9.7 - **Hall's Theorem (Corollary)** - Let $G = (X, Y, E)$ be a bipartite graph. Then $G$ has a **perfect matching** if and only if $|X| = |Y|$ and for all $S \subseteq X$, we have $|S| \leq |N(S)|$.

---
### 10. Stable Matchings

---
### 11. Boolean Circuits and Formulas

11.1 - **Useful Patterns for Boolean Formulas**, given a set of variables $X$:
- At Least One: $\text{ALO}(X) = x_1 \vee x_2 \vee \cdots \vee x_3$
- At Most One: $\text{AMO}(X) = \bigwedge_{1 \leq i < j \leq n}(\neg x_i \vee \neg x_j)$
- Exactly One: $\text{EO}(X) = \text{ALO}(X) \wedge \text{AMO}(X)$
- Implication: $x \implies y$ can be written as $\neg x \vee y$
- Equality: $x \iff y$ can be written as $(x \implies y) \wedge (y \implies x)$
- Not Equal: $x \neq y$ can be written as $(x \vee y) \wedge (\neg x \vee \neg y)$

11.2 - **Conjunctive Normal Form (CNF Formula)** is a tuple $F = (X, C_1, C_2, \dots, C_m)$, where:
1. $X$ is a non-empty sequence where each element is an *input variable*.
2. Each $C_i$ is a *clause*, i.e. a non-empty string of *literals*, where a literal is either a variable in $X$ or its negation.
$F$ typically written as an $\text{AND}$ of clauses, where each clause is an $\text{OR}$ of literals.

11.3 - **Satisfying Truth Assignment** over $F = (X, C_1, C_2, \dots, C_m)$ - A Truth Assignment (an assignment of values 0 or 1 to each variable in $X$) such that each clause $C_i$ contains at least 1 literal with value 1.

11.4 - **CIRCUIT-SAT** - $\{<C> | C \text{ is a satisfiable circuit} \}$

11.5 - **CIRCUIT-SAT** efficiently reduces to **SAT**.

---
### 12. Polynomial-Time Reductions

12.1 - L is $\mathcal{C}$-complete $\iff$ $L \in \mathcal{C} \wedge L$ is $\mathcal{C}$-Hard
12.2 - If L is $\mathcal{C}$-complete, then $L \in \mathbf{P} \iff \mathcal{C} = \mathbf{P}$.

[TODO] - REVIEW ALL REDUCTIONS AND NOTE KEY TECHNIQUES

---
### 13. Non-Deterministic Polynomial Time

13.1 - Many languages in **NP** have the template: "Given an input X does there exist Y"?
- The "there exists" quantifier usually aligns with the proof string in Verifiers.

13.2 - A poly-time transformation $f$ for a Karp Reduction $A \le_m^p B$ does *not need* to cover all of $B$, only all of $A$.

13.3 - For a complex reduction involving Boolean Circuits, always check to ensure you mention the **tautological case**!

---
### 14. Probability Theory Basics

14.1 - $\mathbf{Pr}[E] = \Sigma_{l \in E}\mathbf{Pr}[E]$

14.2 - If a probability distribution $\mathbf{Pr}$ is such that $\mathbf{Pr}[l] = 1/|\Omega|, \ \forall l \in \Omega$, then we call it a **uniform distribution**.

14.3 - **Let $A$ and $B$ be two events. Then**
- If $A \subseteq B$, then $\mathbf{Pr}[A] \leq \mathbf{Pr}[B]$.
- $\mathbf{Pr}[\bar{A}] = 1 - \mathbf{Pr}[A]$.
- $\mathbf{Pr}[A \cup B] = \mathbf{Pr}[A] + \mathbf{Pr}[B] - \mathbf{Pr}[A \cap B]$.

14.4 - **Union Bound** - Let $A_1, A_2, \dots, A_n$ be events. Then $\mathbf{Pr}[A_1 \cup A_2 \cup \cdots \cup A_n] \leq \mathbf{Pr}[A_1] + \mathbf{Pr}[A_2] + \cdots + \mathbf{Pr}[A_n]$, where we get **equality iff the $A_i$'s are pairwise independent**.

14.5 - **Conditional Probability**
- $(\Omega, \mathbf{Pr}) \rightarrow (\Omega, \mathbf{Pr}_E)$, where $\mathbf{Pr}[l] = 0$ if $l \notin E$ and $\mathbf{Pr}[l] = \mathbf{Pr}[l]/\mathbf{Pr}[E]$ if $l \in E$.
- Alternatively, think of it as redefining the sample space $\Omega$ to be $E$, and then renormalizing probabilities so that $\mathbf{Pr}[\Omega] = \mathbf{Pr}[E] = 1$.

14.6 - **Some Other Topics**:
- Chain Rule
- Independence
- Law of Total Probability

---
### 15. Randomized Algorithms

15.1 - **Definition of a deterministic algorithm solving a function problem**
- An algorithm $A$ solves $f : \Sigma^* \rightarrow \Sigma^*$ in time $T(n)$ if:
	- **Correctness**: for all $x \in \Sigma^*$, $A(x) = f(x)$
	- **Running Time**: for all $x \in \Sigma^*$, $A(x)$ takes at most $T(|x|)$ steps.

15.2 - **Monte Carlo Algorithm**
- An algorithm $A$ is a $T(n)$-time *Monte Carlo Algorithm* that computes $f: \Sigma^* \rightarrow \Sigma^*$ with $0 \leq \epsilon \leq 1$ probability of error if:
	- **Correctness**: for all $x \in \Sigma^*$, Pr$[A(x) \neq f(x)] \leq \epsilon$
	- **Running Time**: for all $x \in \Sigma^*$, Pr$[A(x) \ \text{takes at most} \ T(|x|) \ \text{steps}] = 1$

15.3 - **Las Vegas Algorithm**
- An algorithm $A$ is a $T(n)$-time Las Vegas Algorithm that computes $f: \Sigma^* \rightarrow \Sigma^*$ if:
	- **Correctness**: for all $x \in \Sigma^*$, Pr$[A(x) = f(x)] = 1$
	- **Running Time**: for all $x \in \Sigma^*$, $\mathbb{E}[\text{number of steps} \ A(x) \ \text{takes}] \leq T(|x|)$
		- Define a ==geometric random variable== for number of steps/iterations.

---
### 16. Modular Arithmetic

16.1 - $A$ **divides** $B$, denoted $A|B$, if $\exists C \in \mathbb{Z}$ ST $B = AC$.

16.2 - $A$ mod $N$ - remainder when divide $A$ by $N$.

16.3 - **$A$ and $B$ are congruent module $N$**, denoted by $A \equiv_N B$ or $A \equiv B$ mod $N$, if $A$ mod $N = B$ mod $N$. (i.e. the two remainders are equal)

16.4 - $A \equiv_N B$ **if and only if** $N | (B - A)$
- *state* vs *distance*

16.5 - $A$ and $B$ are **relatively prime** if $gcd(A,B) = 1$.

16.6 - $\mathbb{Z}_N$ denotes the set $\{0, 1, \dots, N-1\}$.

16.8 - If $A \equiv_N B$ and $A' \equiv_N B'$, then $A + A' \equiv_N B + B'$.
- can also split apart

16.9 - The **additive inverse** of $A$, denoted $-A$, is defined to be an element in $\mathbb{Z}_N$ such that $A +_N -A = 0$.
- finding the element to return to the identity state (0)

16.10 - In the addition table of $\mathbb{Z}_N$, every row and column is a permutation of the elements $\mathbb{Z}_N$.

16.11 - If $A \equiv_N B$ and $A' \equiv_N B'$, then $AA' \equiv_N BB'$.
- can also split apart

16.12 - The multiplicative inverse of $A$, denoted $A^{-1}$, is defined to be an element in $\mathbb{Z}_N$ ST $A \cdot_N A^{-1} = 1$.

16.13 - The multiplicative inverse of $A$ in $\mathbb{Z}_N$ exists $\iff$ $gcd(A, B) = 1$.

16.13 - Let $\mathbb{Z}_N^*$ denote the set $\{A \in \mathbb{Z}_N : gcd(A, N) = 1\}$, i.e. the set of all elements of $\mathbb{Z}_N$ that are coprime with $N$, i.e. have a multiplicative inverse.

16.14 - In the multiplication table of $\mathbb{Z}_N^*$, every row and column is a **permutation** of the elements in $\mathbb{Z}_N^*$.

16.15 - **The Euler Totient Function** $\varphi : \mathbb{N} \rightarrow \mathbb{N}$ defined as $\phi(N) = |\mathbb{Z}_N^*|$.

16.16 - If $P$ a prime, then $\varphi(P) = P - 1$, and if $P, Q$ distinct primes, then $\varphi(PQ) = (P - 1)(Q - 1)$.

16.17 - **Euler's Theorem** - For any $A \in \mathbb{Z}_N^*$, $A^{\varphi(N)} = 1$.
 - When $N$ prime, known as *Fermat's Little Theorem*.

16.18 - Let $A \in \mathbb{Z}_N^*$ and $E \in \mathbb{Z}_N^*$. Then $A^E = A^{E \ \text{mod} \ \varphi(N)}$.
- Given $A^E$ mod $N$, think of 2 parallel tracks:
	- $A$ lives in the set $\mathbb{Z}_N$
	- $E$ lives in the set $\mathbb{Z}_{\varphi(N)}$

16.19 - Let $A \in \mathbb{Z}_N^*$. $A$ is a **generator** if $\{A^E : E \in \mathbb{Z}_{\varphi(N)}\} = \mathbb{Z}_N^*$.
- i.e. $A^k \equiv_N 1$ at exactly $k = \varphi(N)$ repeated exponentiations, no more, no less.

16.20 - If $P$ prime, then $\mathbb{Z}_P^*$ **contains a generator**.

---
### 17. Cryptography

17.1 - **Diffie Hellman Assumption** - Given $P, B, B^{E_1}, B^{E_2}$, it is computationally hard to compute $B^{E_1 E_2}$.
- Decisional Diffie-Hellman Assumption - Given $P, B, B^{E_1}, B^{E_2}$, you cannot gain any information about $B^{E_1 E_2}$.

---
### 18. Polynomials and Error Correcting Codes
18.1 - The sequence of $d + 1$ coefficients $\langle c_{d}, c_{d-1}, \dots, c_0 \rangle$ completely describes the corresponding polynomial.

18.2 - If coefficients all drawn from $\mathcal{Z}_p$, then exactly $p^{d+1}$ possible unique polynomials.

18.3- **The Few Roots Theorem** - Any non-zero polynomial of degree at most $d$ has at most $d$ roots.

18.4 - Given $d+1$ points $(a_0, b_0), (a_1, b_1), \dots, (a_d, b_d)$, where $a_i$'s are distinct, there is a **unique polynomial** with degree at most $d$ such that $P(a_i) = b_i$ for all $i = 0, 1, \dots, d$.
- Using $a_i = i$, given just a **sequence of $d+1$ numbers $b_0, b_1, \dots, b_d$**, there is a **unique polynomial** of degree at most $d$ such that $P(i) = b$.

18.5 - **The Few Roots Theorem (Probabilistic)** - Given a non-zero polynomial of degree at most d, fix a finite subset $S$ of values in the field we are working over, and pick a random $X \in S$. Then the probability that $P(X) = 0$ is $\frac{d}{|S|}$.
- $d$ - number of desired values of P(X).
- $|S|$ - total number of values P(X) could be.

18.6 - **Schwartz-Zippel Lemma** - For any non-zero degree-$d$ polynomial $P(\mathbf{x})$ and any subset $S$ of values from the underlying field, if each $X_i$ is chosen independently and uniformly from $S$, then $$Pr[P(X_1, \dots, X_m) = 0] \leq \frac{d}{|S|}$$

---
### 19. Fast Fourier Transform
