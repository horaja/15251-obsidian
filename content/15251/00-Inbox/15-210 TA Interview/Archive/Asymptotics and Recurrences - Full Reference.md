
> If stuck, unfold the recurrence, draw the tree, identify what each term means, and reason from first principles.

---

## 0. What This Topic Is Really About

Asymptotic analysis is a way of describing how an algorithm's cost grows as input size grows.

The point is to ignore details that do not matter asymptotically:
- constant factors,
- lower-order terms,
- machine-specific details,
- small input behavior.

But the point is **not** to be vague.

A good TA answer should still be precise:
- What function are we bounding?
- Is it work or span?
- Is it worst-case, expected, or high-probability?
- What are the recursive calls?
- What is the local work outside recursion?
- Are recursive calls sequential or parallel?

---

## 1. Asymptotic Domination Framework

### Big-O

$g(n) \in O(f(n))$ means:

$$
\exists c > 0, \exists n_0 \ge 0 \text{ such that for all } n \ge n_0,
\quad g(n) \le c f(n)
$$

Intuition:

> Past some point, $f(n)$ upper-bounds $g(n)$ up to a constant factor.

Big-O is an **upper bound**.
It does not automatically mean worst-case.

Correct:

$$
T_{\text{worst}}(n) \in O(n^2)
$$

This means the **worst-case cost function** is upper-bounded by $n^2$.

---

### Big-Omega

$g(n) \in \Omega(f(n))$ means:

$$
\exists c > 0, \exists n_0 \ge 0 \text{ such that for all } n \ge n_0,
\quad g(n) \ge c f(n)
$$

Intuition:

> Past some point, $g(n)$ is at least a constant fraction of $f(n)$.

Big-$\Omega$ is a **lower bound**.

---

### Big-Theta

$g(n) \in \Theta(f(n))$ means:

$$
g(n) \in O(f(n)) \quad \text{and} \quad g(n) \in \Omega(f(n))
$$

Intuition:

> Same asymptotic growth rate.

To prove $\Theta(f(n))$, prove both:
- an upper bound, and
- a lower bound.

---

### Little-o and Little-omega

$g(n) \in o(f(n))$ means $g$ grows strictly slower than $f$.

Equivalently:

$$
\lim_{n \to \infty} \frac{g(n)}{f(n)} = 0
$$

$g(n) \in \omega(f(n))$ means $g$ grows strictly faster than $f$.

Equivalently:

$$
\lim_{n \to \infty} \frac{g(n)}{f(n)} = \infty
$$

---

## 2. Common Growth Hierarchy

For constants $a > 1$, $b > 1$, $k > 0$, and $\epsilon > 0$:

$$
1 \ll \log n \ll n^\epsilon \ll n \ll n \log n \ll n^2 \ll n^k \ll a^n \ll n!
$$

Important instincts:
- logarithms grow very slowly,
- any positive polynomial beats any polylogarithm,
- exponentials beat polynomials,
- factorials beat exponentials.

Examples:

$$
\log^5 n \in o(n^{0.01})
$$

$$
n^{100} \in o(2^n)
$$

$$
2^n \in o(n!)
$$

---

## 3. Work, Span, and Parallelism

### Work

Work $W(n)$ is the total number of primitive operations.

Think:

> How much total computation happens if one processor did everything?

---

### Span

Span $S(n)$ is the length of the longest dependency chain.

Think:

> How long would the computation take with infinitely many processors?

Span is also called the **critical path length**.

---

### Parallelism

Parallelism is:

$$
\frac{W(n)}{S(n)}
$$

Intuition:

> Roughly how many processors can be usefully kept busy.

---

## 4. Sequential vs Parallel Composition

This is one of the most important 15-210 ideas.

### Sequential composition

If we do $A$ and then $B$:

$$
W = W_A + W_B
$$

$$
S = S_A + S_B
$$

Both work and span add.

---

### Parallel composition

If we do $A$ and $B$ in parallel:

$$
W = W_A + W_B
$$

$$
S = \max(S_A, S_B)
$$

Work still adds because all operations still happen.

Span takes the max because the branches run at the same time.

---

### Common TA trap

If a divide-and-conquer algorithm makes two recursive calls in parallel:

$$
W(n) = 2W(n/2) + \text{local work}
$$

but

$$
S(n) = S(n/2) + \text{local span}
$$

not

$$
S(n) = 2S(n/2) + \text{local span}
$$

The span only follows the slower recursive branch.

---

## 5. What a Recurrence Means

A recurrence is a cost function defined in terms of itself.

Example:

$$
T(n) = 2T(n/2) + O(n)
$$

Translation:
- there are 2 recursive calls,
- each call has input size $n/2$,
- the non-recursive work at this call is $O(n)$.

Do not solve a recurrence before translating it.

A good OH response starts with:

> Let's first understand what the recurrence says about the algorithm.

---

## 6. How to Derive a Recurrence From Code

Use this checklist.

### Step 1: Define input size

Examples:
- $n = |S|$ for a sequence,
- $n = |V|$ for vertices,
- $m = |E|$ for edges,
- sometimes both $n$ and $m$ matter.

### Step 2: Identify recursive calls

Ask:
- How many recursive calls are made?
- What size is each recursive call?
- Are they sequential or parallel?

### Step 3: Identify local cost

Local cost means everything outside recursive calls.

Examples:
- splitting a sequence,
- filtering,
- merging,
- reducing,
- sorting sub-results,
- building tables.

### Step 4: Write separate work and span recurrences

For parallel recursive calls:

$$
W(n) = \text{sum of recursive work} + \text{local work}
$$

$$
S(n) = \text{max of recursive spans} + \text{local span}
$$

---

## 7. Tree Method

The tree method means unfolding a recurrence level by level.

Use it when explaining to a confused student.

### Template

1. Draw the recursion tree.
2. Find the cost per node.
3. Find the number of nodes at level $i$.
4. Find the total cost at level $i$.
5. Find the number of levels.
6. Sum across levels.

---

### Example: Merge-sort-shaped recurrence

$$
T(n) = 2T(n/2) + n
$$

Level 0:

$$
n
$$

Level 1:

$$
2 \cdot \frac{n}{2} = n
$$

Level 2:

$$
4 \cdot \frac{n}{4} = n
$$

Level $i$:

$$
2^i \cdot \frac{n}{2^i} = n
$$

Number of levels:

$$
\log_2 n
$$

Total:

$$
\sum_{i=0}^{\log n} n = n \log n
$$

So:

$$
T(n) \in \Theta(n \log n)
$$

Key explanation:

> Each level costs $n$, and there are $\log n$ levels.

---

## 8. Brick Method

The brick method is a shortcut after you understand the tree.

At each node, compare:

$$
\text{cost of parent}
$$

against

$$
\text{sum of costs of children}
$$

This tells you whether the recurrence is:
- root-dominated,
- balanced,
- leaf-dominated.

---

## 9. Root-Dominated Recurrences

A recurrence is root-dominated when each level costs geometrically less than the previous level.

Usually:

$$
\text{children total cost} \le \alpha \cdot \text{parent cost}
$$

for some constant $0 < \alpha < 1$.

Then the root dominates the total cost.

---

### Example

$$
T(n) = 2T(n/2) + n^2
$$

Root cost:

$$
n^2
$$

Level 1 cost:

$$
2 \left(\frac{n}{2}\right)^2 = \frac{n^2}{2}
$$

Level 2 cost:

$$
4 \left(\frac{n}{4}\right)^2 = \frac{n^2}{4}
$$

Total:

$$
n^2 + \frac{n^2}{2} + \frac{n^2}{4} + \cdots = O(n^2)
$$

So:

$$
T(n) \in \Theta(n^2)
$$

TA explanation:

> The root already pays $n^2$, and all lower levels form a decreasing geometric tail.

---

## 10. Balanced Recurrences

A recurrence is balanced when each level costs about the same.

Then:

$$
\text{total cost} = \text{cost per level} \times \text{number of levels}
$$

---

### Example

$$
T(n) = 3T(n/3) + n
$$

Root cost:

$$
n
$$

Level 1 cost:

$$
3 \cdot \frac{n}{3} = n
$$

Level 2 cost:

$$
9 \cdot \frac{n}{9} = n
$$

Number of levels:

$$
\log_3 n
$$

Total:

$$
O(n \log n)
$$

TA explanation:

> No level dominates. Every level contributes $n$, so we multiply by the number of levels.

---

## 11. Leaf-Dominated Recurrences

A recurrence is leaf-dominated when each level costs geometrically more than the previous level.

Usually:

$$
\text{children total cost} \ge \alpha \cdot \text{parent cost}
$$

for some constant $\alpha > 1$.

Then the leaves dominate the total cost.

---

### Example

$$
T(n) = 4T(n/2) + n
$$

Root cost:

$$
n
$$

Level 1 cost:

$$
4 \cdot \frac{n}{2} = 2n
$$

Level 2 cost:

$$
16 \cdot \frac{n}{4} = 4n
$$

Costs grow by a factor of 2 each level.

Number of leaves:

$$
4^{\log_2 n} = n^{\log_2 4} = n^2
$$

If each leaf costs $O(1)$, then:

$$
T(n) \in \Theta(n^2)
$$

TA explanation:

> The lower levels contain so many subproblems that the leaf layer dominates.

---

## 12. General Divide-and-Conquer Form

For recurrences of the form:

$$
T(n) = aT(n/b) + f(n)
$$

where:
- $a$ = number of recursive calls,
- $b$ = shrink factor,
- $f(n)$ = local work,

compare $f(n)$ with the leaf mass:

$$
n^{\log_b a}
$$

Why?

The recursion tree has about:

$$
\log_b n
$$

levels, and the number of leaves is:

$$
a^{\log_b n} = n^{\log_b a}
$$

---

### Cases

| Comparison | Type | Result |
|---|---|---|
| $f(n)$ grows faster than $n^{\log_b a}$ | root-dominated | $T(n) = \Theta(f(n))$ |
| $f(n)$ grows like $n^{\log_b a}$ | balanced | $T(n) = \Theta(f(n)\log n)$ |
| $f(n)$ grows slower than $n^{\log_b a}$ | leaf-dominated | $T(n) = \Theta(n^{\log_b a})$ |

Do not present this as magic.

Say:

> $n^{\log_b a}$ is the leaf mass. Compare the root/local cost to the leaf mass.

---

## 13. Master-Theorem-Shaped Examples

### Example 1

$$
T(n) = 2T(n/2) + n
$$

Leaf mass:

$$
n^{\log_2 2} = n
$$

Local work:

$$
n
$$

Balanced.

$$
T(n) = \Theta(n \log n)
$$

---

### Example 2

$$
T(n) = 2T(n/2) + n^2
$$

Leaf mass:

$$
n^{\log_2 2} = n
$$

Local work:

$$
n^2
$$

Root-dominated.

$$
T(n) = \Theta(n^2)
$$

---

### Example 3

$$
T(n) = 4T(n/2) + n
$$

Leaf mass:

$$
n^{\log_2 4} = n^2
$$

Local work:

$$
n
$$

Leaf-dominated.

$$
T(n) = \Theta(n^2)
$$

---

### Example 4

$$
T(n) = 3T(n/2) + n
$$

Leaf mass:

$$
n^{\log_2 3}
$$

Local work:

$$
n
$$

Since $n^{\log_2 3} \approx n^{1.585}$ grows faster than $n$, this is leaf-dominated.

$$
T(n) = \Theta(n^{\log_2 3})
$$

---

## 14. Substitution Method

The substitution method is guess-and-check using induction.

Use it when:
- the recurrence does not fit a simple tree/Master pattern,
- the tree is uneven,
- you need to prove a bound rigorously,
- you already have a guess from intuition.

---

### Template

1. Guess a bound.
2. State induction hypothesis.
3. Substitute the hypothesis into the recurrence.
4. Choose constants so the inequality works.
5. Check base case.

---

### Example

$$
T(n) = T(n/2) + 1
$$

Guess:

$$
T(n) \le c \log n
$$

Inductive step:

$$
T(n) = T(n/2) + 1
$$

By IH:

$$
T(n/2) \le c \log(n/2)
$$

So:

$$
T(n) \le c\log(n/2) + 1
$$

$$
= c(\log n - 1) + 1
$$

$$
= c\log n - c + 1
$$

If $c \ge 1$, then:

$$
T(n) \le c\log n
$$

So:

$$
T(n) \in O(\log n)
$$

TA explanation:

> Substitution is not always how we discover the answer. It is how we certify that a guessed answer is valid.

---

## 15. Important Trick: Strengthening the Hypothesis

Sometimes the obvious induction fails because of lower-order terms.

Example:

$$
T(n) = 2T(n/2) + n
$$

If we guess:

$$
T(n) \le cn\log n
$$

then substitution works cleanly.

But for some recurrences, you may need to guess something stronger like:

$$
T(n) \le cn\log n - dn
$$

or:

$$
T(n) \le cn - d
$$

Why?

Because the recurrence may produce extra constants that need to be absorbed.

TA-safe explanation:

> If the induction is almost working but leaves an extra lower-order term, strengthen the hypothesis by subtracting or adding a lower-order term.

---

## 16. Additive-Shrink Recurrences

Not all recurrences divide the input.

### Example 1

$$
T(n) = T(n-1) + 1
$$

This is a chain of length $n$.

$$
T(n) = \Theta(n)
$$

---

### Example 2

$$
T(n) = T(n-1) + n
$$

Expand:

$$
n + (n-1) + (n-2) + \cdots + 1
$$

So:

$$
T(n) = \Theta(n^2)
$$

---

### Example 3

$$
T(n) = 2T(n-1) + 1
$$

Depth is $n$, and branching factor is 2.

So:

$$
T(n) = \Theta(2^n)
$$

TA explanation:

> If the input shrinks by 1 instead of by a constant factor, the depth is $n$, not $\log n$.

---

## 17. Logarithmic Summation Patterns

### Pattern 1

$$
T(n) = T(n/2) + 1
$$

Costs:

$$
1 + 1 + \cdots + 1
$$

Number of levels:

$$
\log n
$$

Result:

$$
T(n) = O(\log n)
$$

---

### Pattern 2

$$
T(n) = T(n/2) + \log n
$$

Expand:

$$
\log n + \log(n/2) + \log(n/4) + \cdots
$$

Assume base 2:

$$
\log n + (\log n - 1) + (\log n - 2) + \cdots + 1
$$

This is a triangle:

$$
1 + 2 + \cdots + \log n = O(\log^2 n)
$$

So:

$$
T(n) = O(\log^2 n)
$$

TA explanation:

> The costs decrease by 1 each level in log-space, not by a constant factor. So the sum is quadratic in $\log n$.

---

## 18. Uneven Recurrences

Some recurrences do not have equal subproblem sizes.

Example:

$$
T(n) = T(n/2) + T(n/3) + \sqrt n
$$

Do not force Master Theorem.

Use first principles.

Parent local cost:

$$
\sqrt n
$$

Children local cost:

$$
\sqrt{n/2} + \sqrt{n/3}
$$

Factor out $\sqrt n$:

$$
\sqrt n \left(\frac{1}{\sqrt 2} + \frac{1}{\sqrt 3}\right)
$$

Since:

$$
\frac{1}{\sqrt 2} + \frac{1}{\sqrt 3} > 1
$$

the local cost grows as we move downward.

So the recurrence is leaf-dominated.

But counting leaves is harder because the branches have different depths.

Possible next step:
- define a leaf-count recurrence, or
- use substitution to prove a guessed bound.

TA explanation:

> The classification still comes from comparing parent cost to total child cost. But the exact leaf count is harder because not all root-to-leaf paths have the same length.

---

## 19. Floors, Ceilings, and Base Cases

In asymptotic recurrence solving, floors and ceilings usually do not change the final asymptotic bound.

Examples:

$$
T(n) = 2T(\lfloor n/2 \rfloor) + n
$$

and

$$
T(n) = 2T(n/2) + n
$$

usually have the same asymptotic solution.

But in a proof, you should be careful.

Safe OH phrasing:

> For intuition, I will ignore floors and ceilings. If we needed a formal proof, we would handle them with inequalities or restrict to powers of two first, then extend.

Base cases are usually constant:

$$
T(n) = O(1) \quad \text{for } n \le 1
$$

Base cases rarely affect asymptotic growth unless there are many leaves and the recurrence is leaf-dominated.

---

## 20. Common Edge Cases and Tricky Notes

### 1. Big-O is not equality

Bad:

$$
n = O(n^2)
$$

Better:

$$
n \in O(n^2)
$$

Big-O describes a set of functions.

---

### 2. Big-O does not mean tight

$$
n \in O(n^2)
$$

is true, but not tight.

A tight bound is:

$$
n \in \Theta(n)
$$

---

### 3. Worst-case and Big-O are different concepts

Big-O is a type of bound.
Worst-case is a type of cost function.

You can have:
- worst-case $O(n^2)$,
- expected $O(n)$,
- span $O(\log n)$,
- high-probability $O(\log n)$.

Always ask: **what cost function are we bounding?**

---

### 4. Work and span recurrences can be different

For parallel divide-and-conquer:

$$
W(n) = 2W(n/2) + O(n)
$$

but possibly:

$$
S(n) = S(n/2) + O(\log n)
$$

Do not blindly reuse the work recurrence for span.

---

### 5. Balanced does not mean subproblems are equal

Balanced in the brick-method sense means level costs are about equal.

It does not necessarily mean every subproblem is the same size.

---

### 6. Leaf-dominated does not always mean easy leaf counting

For:

$$
T(n) = aT(n/b) + f(n)
$$

leaf counting is easy.

For:

$$
T(n) = T(n/2) + T(n/3) + f(n)
$$

leaf counting can require another recurrence or substitution.

---

### 7. If recursive calls are sequential, span adds

If code does:

```sml
val x = f(left)
val y = f(right)
```

then span behaves like:

$$
S(n) = S(n/2) + S(n/2) + \text{local span}
$$

If code does:

```sml
val (x, y) = f(left) || f(right)
```

then span behaves like:

$$
S(n) = \max(S(n/2), S(n/2)) + \text{local span}
$$

which simplifies to:

$$
S(n) = S(n/2) + \text{local span}
$$

---

## 21. OH Strategy for Solving an Unknown Recurrence

Use this exact script.

### Step 1: Translate

> This recurrence says we make ___ recursive calls of size ___ and do ___ local work.

### Step 2: Decide if this is work or span

> Are the recursive calls sequential or parallel?

### Step 3: Draw 2–3 levels

Do not start with the theorem.

Write:

Level 0: cost = ___

Level 1: cost = ___

Level 2: cost = ___

### Step 4: Look for pattern

Ask:

> Are levels shrinking, growing, or staying the same?

Then classify:
- shrinking: root-dominated,
- same: balanced,
- growing: leaf-dominated.

### Step 5: Count levels

If size divides by $b$ each time:

$$
\text{levels} = \log_b n
$$

If size decreases by 1 each time:

$$
\text{levels} = n
$$

### Step 6: Sum

Use:
- geometric series for root/leaf dominated,
- cost per level times levels for balanced,
- arithmetic sum for additive decreases,
- substitution if the tree is irregular.

---

## 22. Common Interview Questions and Good Answers

### Q: Why do we ignore constants?

Constants matter in real implementation, but asymptotics are about growth as input size gets large.

The constants $c$ and $n_0$ in the definition let us ignore constant factors and small input behavior.

---

### Q: Why is $n \in O(n^2)$ but not $\Theta(n^2)$?

Because for $n \ge 1$:

$$
n \le n^2
$$

so $n \in O(n^2)$.

But $n$ is not in $\Omega(n^2)$ because there is no constant $c > 0$ such that:

$$
n \ge c n^2
$$

for all sufficiently large $n$.

Dividing by $n$ gives:

$$
1 \ge cn
$$

which eventually fails.

---

### Q: Why is merge sort $O(n \log n)$?

Each level of the recursion tree does $O(n)$ total merge work.

The input halves each level, so there are $O(\log n)$ levels.

Therefore:

$$
O(n) \cdot O(\log n) = O(n \log n)
$$

---

### Q: Why is binary search $O(\log n)$?

After $r$ rounds, the remaining input size is:

$$
\frac{n}{2^r}
$$

We stop when:

$$
\frac{n}{2^r} \le 1
$$

So:

$$
n \le 2^r
$$

Taking logs:

$$
r \ge \log n
$$

Thus binary search takes $O(\log n)$ rounds.

---

### Q: What is the span of a parallel divide-and-conquer algorithm?

Work follows all recursive calls.

Span follows only the longest dependency chain.

So if two equal recursive calls run in parallel:

$$
S(n) = S(n/2) + \text{local span}
$$

not:

$$
2S(n/2) + \text{local span}
$$

---

### Q: What do I do if I do not recognize the recurrence?

Say:

> I do not want to force a theorem here. Let's unfold the recurrence and look at the recursion tree.

Then draw levels and compare parent cost to children cost.

---

## 24. Final Interview Mental Checklist

When they ask a hard question, slow down and do this:

1. Define the cost function.
2. Decide work vs span.
3. Translate each recurrence term.
4. Draw/unfold 2–3 levels.
5. Compare parent cost to children cost.
6. Classify root/balanced/leaf.
7. Count levels or leaves.
8. Sum.
9. Mention edge cases: floors, ceilings, base cases, parallel vs sequential.
10. Give the final bound and explain why it makes intuitive sense.

Best possible TA vibe:

> “Let’s not pattern-match yet. Let’s understand what the recurrence is saying.”

