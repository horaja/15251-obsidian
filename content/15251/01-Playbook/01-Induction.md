---
publish: true
---
### Weak Induction   #induction
##### Trigger
- need to prove over a large range
- only previous 'statement's' assumption needed

##### Goal shape
$$\text{For all } n \in \mathbb{N,} \ S_n \text{ is true}$$
where $S_n$ is some mathematical statement.
##### Recipe
Let $F_k$ correspond to '$S_k$ is true'.
1. Establish $F_0$
2. Establish *for all $k$, $F_k \implies F_{k+1}$* ^e9af3b

##### Common Mistakes

##### Example/Reminder
- BC can start at any '$n$'.
- Implication can be established not just for an index jump of 1 (from $k$ to $k+1$), but for any arbitrary jump as needed.

### Strong Induction (known as just *induction*)   #induction
##### Trigger
- need to assume $\geq 1$ previous statements

##### Goal shape
$$\text{For all } n \in \mathbb{N,} \ S_n \text{ is true}$$
where $S_n$ is some mathematical statement.

##### Recipe
Let $F_k$ correspond to '$S_k$ is true'.
1. Establish $F_0$
2. Establish *for all $k$, $F_0, F_1, \dots, F_k \implies F_{k+1}$

##### Common Mistakes

##### Example/Reminder
- better to default to strong induction

### Method of Minimum Counter-Example   #contradiction #induction
##### Trigger
- induction-like
- unsure of exactly WHICH previous statements to use to prove current statement

##### Goal shape
$$\text{For all } n \in \mathbb{N,} \ S_n \text{ is true}$$
where $S_n$ is some mathematical statement.

##### Recipe
1. Set up a proof by contradiction
2. Let $m$ be the minimum number such that $S_m$ is not true
3. Show that $S_k$ is not true for $k < m$, reaching the desired contradiction of the minimality of $m$.

##### Common Mistakes

##### Example/Reminder
- Domino Principle
- Basically, you assume that $S_0, \dots S_m$ does not imply $S_{m+1}$. However from this assumption, you can show that one of $S_0, \dots S_{m-1}$ is not true to reach the desired contradiction.

### Invariant Induction   #induction
##### Trigger
- Recognize a *world state*, that varies with an 'inductable' parameter

##### Goal shape: 'prove $S$ true for all world states'

##### Recipe
1. Prove $S$ true for world state $W_0$
2. If S is true for $W_k$, prove it remains true for $W_{k+1}$

##### Common Mistakes

##### Example/Reminder
- Normal Induction variants apply to recipe above (strong, BC, etc.)
- Recitation: Chips in a Circle

### Structural Induction   #induction
##### Trigger
- recursively defined objects
- induct on [[00-Theorems and Important Definitions#^b9d9d2|derivation complexity]]

##### Goal shape
$$\text{For all } n \in \mathbb{N,} \ S_n \text{ is true}$$
where $S_n$ is the statement "every object in $\mathcal{O}_n$ has property $P$", where $\mathcal{O}_n$ is defined to be the set of all objects in a set of recursively defined objects $\mathcal{O}$ with [[00-Theorems and Important Definitions#^b9d9d2|derivation complexity]] $n$.

##### Recipe
Let $F_k$ correspond to '$S_k$ is true'.
1. Establish $F_0$ - Base Case of the recursive definition of objects.
2. Establish *for all $k$, $F_0, F_1, \dots, F_{k-1} \implies F_k$
	1. "Consider an arbitrary object ..., not corresponding to the base case."
	2. Since object $\mathcal{o} \in \mathcal{O}_k$ has recursive structure, assume the "smaller" objects that make it up satisfy property.
	3. **Repeating Pattern**: Case on the recursive rules applied to an arbitrary $\mathcal{o} \in \mathcal{O}_{k-1}$.
##### Common Mistakes
- Ensure for [[01-Induction#^e9af3b|(2)]], you explicitly state:
	- the arbitrary object of derivation complexity $k$ does NOT correspond to the base case
	- IH can be applied since the derivation complexity of "smaller" objects is lower.
##### Example/Reminder
- Recitation - ParenMatching