### Probability Basics

**Probability Space**: $(\Omega, P)$
**3 Axioms of Probability**:
1. Non-negativity
2. Additivity over disjoint events
3. Normalization - $P[\Omega] = 1$.

**Union Bound**: $P[A_1 \cup A_2 \cup \cdots \cup A_n] \leq \sum_{i=1}^n P[A_i]$.
- note: does not require independence

**Conditional Probability**: $P[A|B] = \frac{P[A \cap B]}{P[B]}$
- intuition: "Constrict your world to $B$, then Probability of A inside B"
- In algorithms... look for "Given..."

**Law of Total Probability**:
If events $B_1, \dots, B_k$ partition $\Omega$, then $P[A] = \sum_i P[A|B]P[B]$.
- In algorithms, condition on pivot

**Independence**: $P[A \cap B] = P[A]P[B]$
- not required for *Linearity of Expectation*

**Random Variables**: $X : \Omega \rightarrow \mathbb{R}$
- In randomized algorithms, *runtime itself is an rv*
- **Probability Mass Function**: $p_X(x) = P[X=x]$.
	- non-negative
	- sum to 1 across all values $x$
- **Indicator RV**
	- 1 if event $A$ happens, 0 otherwise
	- $E[I_A] = P[A]$
	- *Express a complex rv $X$ as a sum of indicators*
		- e.g. $X$ - number of comparisons in quicksort
		- Define indicator of whether rank-$i$ and rank-$j$ elements are compared.

**Expectation**: $E[X] = \sum_x x p_X[x]$.
- **Linearity of Expectation** - does not require independence

**Tail Bounds**:
- **Markov's Inequality**: For a *non-negative* rv $X$, $P[X \geq a] \leq \frac{E[X]}{a}$
	- Use in algorithms: $E[X] \leq \frac{1}{n^k} \implies P[X \geq 1] \leq \frac{1}{n^k}$.
	- If $X_r$ is *'remaining problem size after $r$ rounds'*, then $P[\text{algorithm not done}] = P[X_r \geq 1]$.
- **High Probability Bounds**: A statement holds *with high probability* if for any constant $k > 0$, the failure probability is at most $\frac{1}{n^k}$.
	- If $T(n)$ is the random variable for the algorithm's termination time/number of rounds, and $f(n)$ is your time bound,
		- $\forall k > 0, Pr[T(n) \leq C \cdot k \cdot f(n)] \geq 1 - \frac{1}{n^k}$
		- $\forall k > 0, Pr[T(n) \geq C \cdot k \cdot f(n)] \leq \frac{1}{n^k}$

#### To show an algorithm terminates in f(n) rounds with high probability,
First, note that the **runtime of the algorithm** is a random variable—define this.
The goal is to show the following is 'small': $$Pr[\text{algorithm is still alive after} \ C \cdot k \cdot f(n) \ \text{rounds}]$$i.e. The goal is to find $r = Ckf(n)$ such that $Pr[T(n) > r] < \frac{1}{n^k}$.

Define a **measure** for 'the algorithm is still alive' using rv representing runtime
- e.g. $X_r$ = problem size after r rounds; $X_r > 1$
- Then, want to bound $Pr[X_r > 1]$.

Via **tail bound**, we know that $Pr[X_r > 1] \leq E[X_r]$.
So to bound $Pr[X_r > 1]$, we must bound $E[X_r]$. Well, for many randomized algorithms, each round **shrinks expected size** by a **constant factor**: $$E[X_{r+1} | X_r] \leq \alpha X_r$$where $0 < \alpha < 1$.

After $r$ rounds, $E[X_r] \leq n\alpha^r$. We want to find an $r$ such that $n\alpha^r \leq \frac{1}{n^k}$. Solving for $r$ gives $r \geq (k+1)\log_{1/\alpha}n$.

---
### Order Statistics, Quicksort, Treaps
**Order Statistics Problem**:
- Input: $(S, k)$
- Output: The rank-$k$ element in $S$.

**Quickselect**
$$
\begin{aligned}
&\mathrm{Quickselect}(S,k):\\
&\quad p \leftarrow \text{random pivot from } S\\
&\quad L \leftarrow \{x \in S : x < p\}\\
&\quad R \leftarrow \{x \in S : x > p\}\\
&\quad \textbf{if } |L| = k \textbf{ then return } p\\
&\quad \textbf{else if } k < |L| \textbf{ then return } \mathrm{Quickselect}(L,k)\\
&\quad \textbf{else return } \mathrm{Quickselect}(R, k - |L| - 1)
\end{aligned}
$$
- *Runtime (W)* - $O(n)$
	- Partitioning costs $O(n)$.
	- Size of the recursive subproblem
		- A pivot is *good* if it's rank is between $n/4$ and $3n/4$
			- A uniformly random pivot is *good* w.p. $1/2$.
		- Thus the next call to Quickselect has at most $3n/4$ elements.
	- Recurrence: $W(n) = W(3n/4) + O(n)$ if the pivot is *good*/balanced.
		- Root-dominated
- *Runtime (S)* - $O(\log^2 n)$
	- Partitioning costs $O(\log n)$
	- Number of expected rounds is $O(\log n)$

**Quicksort**
Same idea as Quickselect—but recurse on **both** sides.
- **Pivot Trees**
	- Binary tree of chosen pivots
- *Runtime (W: total number of comparisons)*: $O(n \log n)$
	- Naiively: $O(n)$ per level, $O(\log n)$ levels.
	- With **Indicator Random Variables**:
		- Intuition: For each pair of elements, probability they get compared?
		- Define $$X_{i,j} = \begin{cases} 1 \ \text{if rank-i and rank-j elements are compared} \\ 0 \ \text{otherwise} \end{cases}$$
		- $E[X] = \sum_{i < j}Pr[X_{i,j} = 1] = \sum_{i < j}\frac{2}{j-i+1}$, where $X$ is total comparisons
			- $Pr[X_{i,j} = 1] = \frac{2}{j-i+1}$ because the only way $i, j$ are compared at a 'level' if $i$ or $j$ themselves are chosen over the interval between $i$ and $j$.
		- Using **Harmonic Sums**, this simplifies to $O(\log n)$ for a fixed $i$, and there are $n$ elements.
- *Runtime (S)*: $O(\log^2 n)$
	- The pivot tree height is $O(\log n)$ with high probability, and span per level is $O(\log n)$

==TODO==: Treaps


