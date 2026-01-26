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

2.3 - **Encoding**: Let $A$ be a set and let $\Sigma$ be an alphabet. An ***encoding scheme*** for $A$ using $\Sigma$ is an **injective** function(**uniqueness** + **totality**) $\text{Enc : }A\rightarrow \Sigma^*$.

