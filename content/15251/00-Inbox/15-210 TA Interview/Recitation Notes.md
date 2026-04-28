### Recitation - Reasoning about Randomized Algorithms
Teach a **mental template**, focusing on *intuition/understanding*.

>When a randomized algorithm usually makes progress, but might get unlucky, we prove high-probability termination by defining a “remaining size” random variable, showing it shrinks in expectation, and then turning that expectation into a small failure probability.

Start from the **statement you want to prove**.
- Naturally leads into the *Definition of 'With High Probability Bounds'*
- If time, use *real numbers*, draw out a tiny example.

Next, move to the **Dice Game Example**.
- *Whiteboard Strategy*:
	- Top: Dice Game Problem
	- Left: Goal Statement with R.V. Definition
		- *Draw Distribution*, work through variants of w.h.p definition
	- Middle: Expectation Shrink
	- Right: Failure Probability -> finding an $r$

Variations/Extensions:
- Many parallel random processes -> union bound

*Student Interruptions*
1. Why $X > 1$, not $X \leq 1$?
2. Why can you use Markov's?
3. Why is independence crucial?
4. Why is $k$ there in the statement goal?
	1. *Confidence knob*: more rounds $\iff$ smaller failure probability
5. Why not use expected time?
	1. *Draw distribution*
	2. Useless for span—depends on the maximum, i.e. one unlucky run determines span