---
publish: true
---
### Proof by Construction of an Injective Encoding Scheme 
#encodingscheme #injectivity
##### Trigger
- To prove a **set is encodable**.

##### Goal shape
1. Define an alphabet $\Sigma$
2. Define an encoding scheme $\text{Enc : }A \rightarrow \Sigma$, for any set A.
3. Prove $\text{Enc}$ is an injective function.

##### Recipe
1. Define an alphabet $\Sigma$
	1. Usually binary, with modifications (e.g. boundary delimiter '#')
2. Define an [[00-Theorems and Important Definitions#^77ac50|encoding scheme]] $\text{Enc : }A \rightarrow \Sigma$ by, for every *(or an arbitrary)* element of $A$, define an encoding.

---
### Proof a Recursively Defined Language satisfies a property.
#induction #languages
##### Trigger
- Let there be a recursively/inductively defined language.
- Need to prove that all elements in the language satisfy some property.

##### Goal shape
Given a recursively defined language $L$, show that L consists of all strings that satisfy some property $P$.

##### Recipe
- Proof by **Double Containment**. Let $L$, $K$.
	- First, define some mathematical abstraction of the property that all elements in set $K$ satisfy.
		- e.g. *open/close/difference metrics* from Recitation 1.
	- To show $L \subseteq K$, use structural induction.
		- Case on **the last applied rule**. 
		- Show that, by assuming the string was in $K$ before applying the last rule, it is still in $K$ after application.
	- To show $K \subseteq L$, use strong induction on some property of the string.
		- e.g. *the length of the string* - Recitation 1
		- Then, case on some scenario where recursive rule $i$ applies, otherwise recursive rule $j$ applies. 

##### Common Mistakes
- Ensuring casing covers all possibilities.
- Follow rules of structural induction.

##### Example/Reminder
- Recitation 1
