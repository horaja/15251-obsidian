---
publish: true
---
### [TODO] Listing Heuristic
##### Trigger
Show a set is countable.
##### Goal shape
To show a set $S$ is countable, define a:
1. surjection $f : \mathbb{N} \rightarrow S$, or
2. injection $f : S \rightarrow \mathbb{N}$
Concretely, list every element of $S$ with the guarantee that every element appears somewhere in the list (eventually, finite distance after the start).
##### Recipe
*Key Idea*: A countable union of finite sets is countable.
Partition sets into an infinite sequence of finite buckets,
e.g. partition $S$ into $S_1, S_2, \dots$, i.e. partition by length/sum of elems/total size/etc., then you can *list* these finite partitions.
##### Common Mistakes
##### Example/Reminder

---
### Encoding Heuristic
##### Trigger
Show a set is countable.
##### Goal shape

##### Recipe
1. Encode each object in set as a string in $\Sigma^*$.
2. Prove injectivity
##### Common Mistakes

##### Example/Reminder
- HW4 - 1.2
	- Lowk js memorize the proof structure.

---
### Diagonalization (Constructive)
##### Trigger
Construct an explicit object $X$ **NOT** in [Countable Set].
##### Goal shape
Construct a function $f_D : X \rightarrow {0,1}$ that is not in $\mathcal{F}$.
##### Recipe
1. Enumerate the countable set $\mathcal{F} = f_1, f_2, \dots$, and the input space $x_1, x_2, \dots$
2. For each $f_i \in F$ and input $x_i$, define $f_D(x_i) \neq f_i(x_i)$.
3. Since $f_D$ differs from every $f_i$, it's not in the set.
##### Common Mistakes
- For each $f$, we need to pick a different $x$, so we need $|X| \ge |F|$.
##### Example/Reminder

---
### Diagonalization (Non-constructive)
##### Trigger
Show an object not in a countable set exists.
##### Goal shape
==TODO==
##### Recipe
1. Specify the objects we are interested in as functions, with some domain $X$.
	1. i.e. identify $\mathcal{U}$ and $\mathcal{F}$.
2. Argue $|X| \ge |F|$, and use the Diagonalization Lemma as a black box.
##### Common Mistakes

##### Example/Reminder
- HW2

---
### [TODO] Proof of Uncountability via $\{0,1\}^{\infty}$.
##### Trigger

##### Goal shape

##### Recipe
**HINT**: Find a binary choice at each step.
"At each position n, given what I've built so far, do I have 2 valid options."
If yes, map $b_n$=0 to one and $b_n$=1 to the other.

All thats left to do is verify that:
1. the output always satisfies the constraints
2. injectivity
	1. i.e. different binary strings produce different elements

##### Common Mistakes

##### Example/Reminder
- HW4 - 1.3

---
### Proof of Undecidability via Reduction
##### Trigger
Show $L$ is **undecidable**.
##### Goal shape
$\text{HALTS}_{\text{TM}} \le L$ via defining a decider $M_{\text{HALTS}}(\langle M, x \rangle)$, towards a contradiction.
##### Recipe
1. AFSOC $M_L$ decides $L$.
2. Inside $M_{\text{HALTS}}$, construct a helper TM $M'$ whose language depends on whether $M(x)$ halts.
	1. Then $L(M') = K$ if $M(x)$ accepts, $\varnothing$ if not. *See below for more info*
	2. Return $M_L(M')$ or it's negation.
3. Prove both sides of correctness.
```
def M'(w):
    run M(x)
    if w ∈ <target language>: accept
    else: reject
```
##### Common Mistakes

##### Example/Reminder
- HW4 - 3
