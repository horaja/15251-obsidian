
When stuck, say:
> Let's unfold the recurrence and see what each level costs.

---

## 1. Core Definitions

### Asymptotic Domination
`f(n)` dominates `g(n)` if there exist constants `c > 0` and `n0` such that:

$$
g(n) \le c f(n) \quad \text{for all } n \ge n_0
$$

Meaning:
- `c` ignores constant factors.
- `n0` ignores small inputs.
- We care about eventual growth.

### Big-O / Omega / Theta
- `g(n) in O(f(n))`: `g` grows no faster than `f`.
- `g(n) in Omega(f(n))`: `g` grows at least as fast as `f`.
- `g(n) in Theta(f(n))`: both upper and lower bound.

**Important:** Big-O is not “worst case.”
Big-O is an upper bound.
Worst-case is the cost function you are bounding.

Example:

$$
T_{worst}(n) \in O(n^2)
$$

---

## 3. Work, Span, Parallelism

### Work
Total number of operations.

### Span
Longest dependency chain.
Minimum possible time with infinite processors.

### Parallelism

$$
\text{parallelism} = \frac{W}{S}
$$

Amount of useful parallel slack.

---

## 4. How to Derive a Recurrence

Ask:
1. What is the input size?
2. How many recursive calls?
3. What size are the recursive calls?
4. Are recursive calls sequential or parallel?
5. What work/span happens outside recursion?

Example:

```sml
val (L, R) = f(left) || f(right)
combine(L, R)
```

Work:

$$
W(n)=2W(n/2)+W_{combine}(n)
$$

Span:

$$
S(n)=S(n/2)+S_{combine}(n)
$$

---

## 5. Tree Method

Use when solving from first principles.

Steps:
1. Draw/unroll recursion tree.
2. Find cost per level.
3. Find number of levels.
4. Sum across levels.

Good explanation:
> Each level costs `n`, and there are `log n` levels.

---

## 6. Brick Method

Compare total child local cost to parent local cost.
Let `C(v)` be local cost at node `v`.
### Root-Dominated
Children cost less than parent by constant factor.

$$
\sum_{u \in children(v)} C(u) \le \alpha C(v), \quad \alpha < 1
$$

Then root dominates $\implies$ $O(\text{cost(root)})$
### Balanced
Each level costs about the same.
- `cost per level` $\times$ `# levels`
### Leaf-Dominated
Children cost more than parent by constant factor.

$$
\sum_{u \in children(v)} C(u) \ge \alpha C(v), \quad \alpha > 1
$$
- For some $W(n) = aW(\frac{n}{b}) + f(n)$, the `number of leaves` is $a^{\log_b n} = n^{\log_b a}$.
	- *Why? What if not of this form*?
- $\Theta(\text{\# leaves} \times \text{cost per leaf})$
	- `cost per leaf` usually $O(1)$.

---

## 8. Substitution Method

Use to prove a guessed bound.

Template:
1. Guess bound.
2. Assume it for smaller inputs.
3. Plug into recurrence.
4. Choose constants so the inequality works.

Example:

$$
T(n)=T(n/2)+1
$$

Guess:

$$
T(n) \le c\log n
$$

Inductive step:

$$
T(n) \le c\log(n/2)+1
$$

$$
= c\log n - c + 1
$$

If `c >= 1`, then:

$$
T(n) \le c\log n
$$

So:

$$
T(n)=O(\log n)
$$

Important phrase:
> Substitution is usually for verifying a guess, not discovering it.

---

## 10. Edge Cases / Tricky Notes

### Floors and Ceilings
Usually do not change asymptotic bounds.
Explicitly state on exams:
> Floors and ceilings matter for exact values, but not for asymptotic growth. We can handle them by adjusting constants.

### Base Cases
Base cases usually contribute leaf cost.
If each leaf costs `O(1)`, total leaf cost = number of leaves.

### Uneven Recurrences
Example: $T(n)=T(n/2)+T(n/3)+\sqrt n$

Compare parent local cost to child local cost: $\sqrt{n/2}+\sqrt{n/3}$

If child cost is bigger, likely leaf-dominated.
Counting children more complex:
- $L(n) = L(n/2) + L(n/3)$ - Solve via substitution

### Work vs Span Trap
Parallel recursive calls add work but not span.
Span follows the longest branch.

---

## 11. OH Response Script

When a student asks a hard recurrence question:

1. **Restate the recurrence in words.**
   > This says we make __ recursive calls of size __ and pay __ local work.

2. **Unroll 2-3 levels.**
   > Let's compute the first few level costs before guessing.

3. **Classify.**
   > The level costs are shrinking / equal / growing.

4. **Solve.**
   > So root / all levels / leaves dominate.

5. **Check intuition.**
   > Does the answer make sense relative to the amount of work at the root and the number of leaves?

When stuck:
> This does not fit the clean Master Theorem form, so I would avoid applying it blindly. Let's use the recursion tree or substitution instead.
