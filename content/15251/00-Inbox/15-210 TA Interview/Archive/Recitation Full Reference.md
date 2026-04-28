## Topic

**High-Probability Termination for Randomized Algorithms**

Core message:

> We prove a randomized algorithm finishes quickly by tracking a progress variable at a fixed round `r`, showing it is unlikely to still be above the termination threshold.

---

# Board Setup

Use the board in **four regions**.

```text
+--------------------------------------------------------------+
| TOP: Problem statement + today’s goal                         |
+-------------------+--------------------+---------------------+
| LEFT: Goal /      | MIDDLE: Expected   | RIGHT: Failure       |
| random variable   | shrink             | probability + solve r |
+-------------------+--------------------+---------------------+
| SMALL CORNER: definitions / prior knowledge                   |
+--------------------------------------------------------------+
```

The corner definitions are useful, but keep them small.
Do **not** start by dumping definitions.
Add them as they become relevant.

---

# Corner Definitions Box

Write this small box in a corner before or during the first two minutes.

```text
Definitions / Tools

T(n) = stopping time
     = # rounds until termination

X_r = problem size after exactly r rounds

w.h.p.:
For every constant k > 0,
Pr[T(n) <= Ck f(n)] >= 1 - 1/n^k

Markov:
If X >= 0, then Pr[X >= a] <= E[X]/a

Union bound:
Pr[A_1 ∪ ... ∪ A_m] <= Σ Pr[A_i]
```

Optional note below the box:

```text
Usually: prove bad event is tiny.
```

---

# 0. Opening Script

Say:

> Today I want to focus less on memorizing this exact dice game and more on the reusable pattern behind high-probability termination proofs.

Write at the top:

```text
Goal: show the process terminates in O(log n) rounds with high probability.
```

Then write:

```math
\Pr[T(n) \le O(k\log n)] \ge 1 - \frac{1}{n^k}
```

Say:

> This is the actual mathematical sentence we are trying to prove.
> The phrase “with high probability” means we can make the failure probability polynomially small.

---

# 1. Explain the Meaning of the Goal Statement

Write:

```math
\Pr[T(n) \le r] \ge 1 - \frac{1}{n^k}
```

Equivalent bad-event form:

```math
\Pr[T(n) > r] \le \frac{1}{n^k}
```

Say:

> I usually think about high-probability bounds by bounding the bad event.
> Here, the bad event is: the process has not terminated by round `r`.

Write:

```text
Bad event = still not done after r rounds
```

---

# 2. Explain the Role of k

Write:

```text
k = confidence knob
```

Then:

```math
k = 1 \Rightarrow \Pr[\text{fail}] \le \frac{1}{n}
```

```math
k = 3 \Rightarrow \Pr[\text{fail}] \le \frac{1}{n^3}
```

```math
k = 10 \Rightarrow \Pr[\text{fail}] \le \frac{1}{n^{10}}
```

Then write:

```math
k \uparrow \quad \Longrightarrow \quad \text{more rounds allowed} \quad \Longrightarrow \quad \text{smaller failure probability}
```

Say:

> For any fixed constant `k`, `O(k log n)` is still logarithmic in `n`, but we keep the `k` visible because it controls the strength of the probability guarantee.

---

# 3. Tiny Intuition Example

Before the dice game, write:

```math
16 \to 8 \to 4 \to 2 \to 1
```

Say:

> If the problem size definitely halves each round, then we need `log n` rounds.

Write:

```math
\text{constant-factor shrink each round} \Rightarrow O(\log n) \text{ rounds}
```

Then say:

> In a randomized algorithm, every round may not shrink.
> Some rounds may be unlucky.
> So instead of saying “every round shrinks,” we show the remaining size shrinks in expectation, and then convert that into a high-probability statement.

---

# 4. The Big Bridge: T(n) vs X_r

This is important. Put it clearly on the board.

Write:

```math
T(n) = \min\{r : X_r \le \tau\}
```

For this dice game:

```math
\tau = 1
```

So:

```math
T(n) = \min\{r : X_r \le 1\}
```

Then write the equivalences:

```math
T(n) \le r \iff X_r \le 1
```

```math
T(n) > r \iff X_r > 1
```

Say:

> `T(n)` is the first time we cross the finish line.
> `X_r` is the snapshot at a fixed time `r`.
> So saying “not done by round `r`” is exactly saying “the snapshot at round `r` is still above the threshold.”

Then write the key proof bridge:

```math
\Pr[T(n) > r] = \Pr[X_r > 1]
```

---

# 5. Mental Template Box

Write this as a reusable template.

```text
High-Probability Termination Machine

1. Define X_r = remaining size after r rounds.
2. Show E[X_r] <= n alpha^r, for alpha < 1.
3. Bad event: X_r > 1.
4. Markov: Pr[X_r > 1] <= E[X_r].
5. Pick r so n alpha^r <= 1/n^k.
6. Conclude Pr[T(n) <= r] >= 1 - 1/n^k.
```

Then say:

> The dice game is just one instance of this machine.

---

# 6. Dice Game Problem Statement

At the top or upper-left, write:

```text
Dice Game

Start with board value n.
Each round:
  roll D in {1,2,3,4,5,6}
  new value = floor(old value * D/4)
Stop when value <= 1.

Show: terminates in O(log n) rounds w.h.p.
```

Say:

> The board value may go down or up depending on the roll.
> But what matters is the average multiplier.

---

# 7. Left Column: Random Variable and Goal

Write:

```math
X_r = \text{board value after r rounds}
```

Goal:

```math
\Pr[T(n) \le r] \ge 1 - \frac{1}{n^k}
```

Equivalent:

```math
\Pr[T(n) > r] \le \frac{1}{n^k}
```

Using the bridge:

```math
\Pr[T(n) > r] = \Pr[X_r > 1]
```

So enough to show:

```math
\Pr[X_r > 1] \le \frac{1}{n^k}
```

Say:

> This is the key transition: instead of analyzing the stopping time directly, we analyze the size after a fixed number of rounds.

---

# 8. Middle Column: Expected Shrink

Let `D_i` be the die roll on round `i`.

Write:

```math
D_i \in \{1,2,3,4,5,6\}
```

Ignoring floor only makes the value larger, so it is safe for an upper bound.

Write:

```math
X_r \le n \prod_{i=1}^{r} \frac{D_i}{4}
```

Then:

```math
\mathbb{E}[X_r]
\le
n \cdot \mathbb{E}\left[\prod_{i=1}^{r} \frac{D_i}{4}\right]
```

Because rolls are independent:

```math
\mathbb{E}[X_r]
\le
n \prod_{i=1}^{r} \mathbb{E}\left[\frac{D_i}{4}\right]
```

Compute one round:

```math
\mathbb{E}[D_i] = \frac{1+2+3+4+5+6}{6} = \frac{7}{2}
```

```math
\mathbb{E}\left[\frac{D_i}{4}\right]
=
\frac{7}{8}
```

Therefore:

```math
\mathbb{E}[X_r] \le n\left(\frac{7}{8}\right)^r
```

Say:

> The process can increase in a particular round, but the expected multiplier per round is `7/8`, which is less than 1.
> That is the geometric shrink.

---

# 9. Right Column: Failure Probability

Write Markov:

```math
\Pr[X_r > 1] \le \frac{\mathbb{E}[X_r]}{1}
```

Therefore:

```math
\Pr[X_r > 1]
\le
n\left(\frac{7}{8}\right)^r
```

We want:

```math
n\left(\frac{7}{8}\right)^r
\le
\frac{1}{n^k}
```

Solve:

```math
\left(\frac{7}{8}\right)^r
\le
\frac{1}{n^{k+1}}
```

Equivalent:

```math
\left(\frac{8}{7}\right)^r
\ge
n^{k+1}
```

Take logs:

```math
r \ge (k+1)\log_{8/7} n
```

So choose:

```math
r = (k+1)\log_{8/7} n
```

Then:

```math
\Pr[X_r > 1] \le \frac{1}{n^k}
```

Therefore:

```math
\Pr[T(n) > r] \le \frac{1}{n^k}
```

So:

```math
\Pr[T(n) \le r] \ge 1 - \frac{1}{n^k}
```

Conclusion:

```math
T(n) = O(\log n) \text{ with high probability}
```

More precise:

```math
T(n) \le O(k\log n) \text{ with probability at least } 1 - \frac{1}{n^k}
```

---

# 10. Pause and Summarize the Dice Game

Say:

> The important thing was not the die itself.
> The important thing was that after `r` rounds, the expected remaining size was at most `n alpha^r` for some `alpha < 1`.
> Once we had that, Markov converted “small expected remaining size” into “small probability of still not being done.”

Write:

```math
\mathbb{E}[X_r] \le n\alpha^r
\quad \Longrightarrow \quad
\Pr[T(n) > r] \le n\alpha^r
```

Then:

```math
n\alpha^r \le \frac{1}{n^k}
\quad \Longrightarrow \quad
r = O(k\log n)
```

---

# 11. Extension: Many Parallel Random Processes

Write:

```text
Parallel extension

One task finishes in O(log n) rounds w.h.p.
Now run n^210 tasks in parallel.
Question: do all finish in O(log n) rounds w.h.p.?
```

Say:

> The whole computation is only as fast as the slowest subtask.
> So the bad event is: at least one subtask is bad.

Write:

```math
B_i = \text{subtask i is bad}
```

```math
B = B_1 \cup B_2 \cup \cdots \cup B_{n^{210}}
```

By union bound:

```math
\Pr[B]
\le
\sum_{i=1}^{n^{210}} \Pr[B_i]
```

If each task has failure probability:

```math
\Pr[B_i] \le \frac{1}{n^{k'}}
```

then:

```math
\Pr[B]
\le
n^{210} \cdot \frac{1}{n^{k'}}
```

We want:

$n^{210} \cdot \frac{1}{n^{k'}} \le \frac{1}{n^k}$

Choose:

```math
k' = k + 210
```

Then:

```math
n^{210} \cdot \frac{1}{n^{k+210}}
=
\frac{1}{n^k}
```

Therefore:

```math
\Pr[\text{some task is bad}] \le \frac{1}{n^k}
```

So:

```math
\Pr[\text{all tasks finish in time}] \ge 1 - \frac{1}{n^k}
```

Time bound:

```math
O(k'\log n) = O((k+210)\log n) = O(k\log n)
```

For fixed constants:

```math
O((k+210)\log n) = O(\log n)
```

Key line:

> If we have many chances to fail, we make each individual failure probability smaller, then union bound over all possible failures.

---

# 12. Important Student Questions and Board Responses

## Q1. Why use `X_r > 1` instead of `X_r <= 1`?

Write:

```math
X_r \le 1 = \text{success}
```

```math
X_r > 1 = \text{failure}
```

Markov bounds the probability that a nonnegative random variable is large:

```math
\Pr[X_r > 1] \le \mathbb{E}[X_r]
```

Then flip:

```math
\Pr[X_r \le 1] = 1 - \Pr[X_r > 1]
```

Say:

> We bound failure because Markov gives an upper bound on the large tail.

---

## Q2. Why is `k` there?

Write:

```math
\Pr[\text{fail}] \le \frac{1}{n^k}
```

Say:

> `k` controls the strength of the guarantee.
> Bigger `k` means smaller failure probability.
> We pay by allowing a larger constant times `log n` rounds.

---

## Q3. Why not just use expected time?

Draw:

```text
Most runs: fast
Rare runs: extremely slow
```

Example:

```text
10 rounds       with probability 0.999
1,000,000 rounds with probability 0.001
```

Say:

> Expected time only describes the average.
> High probability controls the chance of a bad tail.
> For span, tails are especially important because the slowest parallel branch determines the time.

Write:

```math
\text{parallel time} \approx \max(T_1,T_2,\dots,T_m)
```

---

## Q4. Where did independence matter?

Write:

```math
\mathbb{E}\left[\prod_i Y_i\right]
=
\prod_i \mathbb{E}[Y_i]
```

Say:

> This multiplication step uses independence of the die rolls.
> Markov itself does not require independence.

---

## Q5. Does union bound need independence?

Write:

```math
\Pr[A_1 \cup \cdots \cup A_m] \le \sum_i \Pr[A_i]
```

Say:

> No independence needed.
> That is why union bound is so useful.

---

## Q6. Why does the `k+1` appear?

Start from:

```math
n\alpha^r \le \frac{1}{n^k}
```

Divide by `n`:

```math
\alpha^r \le \frac{1}{n^{k+1}}
```

Say:

> The extra `+1` comes from the leading `n` in the expectation bound.

---

## Q7. What if the process sometimes increases?

Say:

> That is fine.
> We are not claiming every round shrinks.
> We are claiming the expected multiplier is below 1.

Write:

```math
\mathbb{E}[\text{multiplier}] = \frac{7}{8} < 1
```

---

## Q8. How exactly do `T(n)` and `X_r` connect?

Write:

```math
T(n) = \min\{r : X_r \le 1\}
```

Therefore:

```math
T(n) > r \iff X_r > 1
```

Say:

> `T(n)` is the first time we cross the threshold.
> `X_r` is the value at a fixed time.
> So being unfinished after `r` rounds is exactly the same as still being above the threshold at round `r`.

---

# 13. Recitation Timing Plan

## 0:00–2:00 — Frame the lesson

Board:

```math
\Pr[T(n) \le O(k\log n)] \ge 1 - \frac{1}{n^k}
```

Explain w.h.p., bad event, and `k`.

## 2:00–4:00 — Tiny deterministic shrink example

Board:

```math
16 \to 8 \to 4 \to 2 \to 1
```

Explain why constant-factor shrink suggests `log n`.

## 4:00–5:30 — Bridge from T(n) to X_r

Board:

```math
T(n) = \min\{r : X_r \le 1\}
```

```math
T(n) > r \iff X_r > 1
```

## 5:30–11:00 — Dice game proof

Board:

```math
X_r \le n\prod_{i=1}^{r}\frac{D_i}{4}
```

```math
\mathbb{E}[X_r] \le n\left(\frac{7}{8}\right)^r
```

```math
\Pr[X_r > 1] \le n\left(\frac{7}{8}\right)^r
```

```math
r \ge (k+1)\log_{8/7} n
```

## 11:00–13:00 — General template

Board:

```math
\mathbb{E}[X_r] \le n\alpha^r
\Rightarrow
\Pr[T(n) > r] \le n\alpha^r
```

```math
n\alpha^r \le \frac{1}{n^k}
\Rightarrow
r = O(k\log n)
```

## 13:00–15:00 — Parallel extension

Board:

```math
\Pr[\exists \text{ bad task}]
\le
n^{210}\cdot \frac{1}{n^{k'}}
```

```math
k' = k+210
```

```math
\Pr[\exists \text{ bad task}] \le \frac{1}{n^k}
```

---

# 14. Final Closing Statement

Say:

> The dice game is not special.
> The reusable idea is: define a remaining-size variable, show it shrinks geometrically in expectation, use Markov to say it is unlikely to still be above the termination threshold, and choose enough rounds to make that failure probability at most `1/n^k`.
> If there are many parallel randomized tasks, we strengthen the individual guarantee and union bound over all tasks.

Then write the final one-line summary:

```math
\boxed{
\Pr[T(n) > r]
= \Pr[X_r > 1]
\le \mathbb{E}[X_r]
\le n\alpha^r
}
```

and:

```math
\boxed{r = O(k\log n)}
```

---

# 15. What NOT to Overdo

Do not over-focus on:

- the exact base of the logarithm,
- the floor operation,
- memorizing the dice game arithmetic,
- saying “this is obvious,”
- rushing Markov without explaining why it applies.

Do focus on:

- what the bad event is,
- why `X_r` captures being unfinished,
- why expected shrink is useful,
- why Markov turns expectation into probability,
- why `k` controls confidence,
- why union bound handles many parallel failures.

---

# 16. One-Sentence Memory Hooks

Use these if you freeze.

```text
T(n) is when we finish; X_r is where we are after r rounds.
```

```text
Not finished by round r means X_r is still above the threshold.
```

```text
Expected shrink is not the conclusion; it is the thing Markov uses.
```

```text
k is a confidence knob.
```

```text
Union bound says many chances to fail means we need each chance to be smaller.
```

```text
For span, one unlucky branch can determine the whole runtime.
```
