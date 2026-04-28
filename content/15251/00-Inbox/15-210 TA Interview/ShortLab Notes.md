## Task 1: Unweighted All Shortest Paths

### Goal

Given a directed, unweighted graph and source $s$, build a DS so that later, for any target $t$, we can report **all shortest paths from $s$ to $t$**.

Not just:
- one shortest path
- the distance

Need: compact info that can reconstruct every shortest path.

---
### Core motivation

#### 1. One parent is not enough

Directed graph:

```text
        a
      ↗   ↘
s           t
      ↘   ↗
        b
```

Edges:

```text
s -> a
s -> b
a -> t
b -> t
```

Shortest paths:

```text
s -> a -> t
s -> b -> t
```

If `parent[t] = a`, we lose the path through `b`.

**Conclusion:** each vertex may need **multiple parents**.

---
#### 2. But not every incoming edge is useful

Extra edges:

```text
a -> b
b -> a
```

These create longer paths like:

```text
s -> a -> b -> t
```

length 3, while shortest length is 2.

**Conclusion:** store only edges that can appear on a shortest path.

---
#### 3. BFS gives the filter

In an unweighted graph, BFS from $s$ gives shortest distances / layers.

```text
Layer 0: s
Layer 1: a, b
Layer 2: t
```

Draw:

```text
dist 0        dist 1        dist 2

  s   --->     a     --->     t
   \           b     ---/
```

A shortest path must move:

```text
dist 0 -> dist 1 -> dist 2 -> ...
```

It cannot waste a step.

---
### Parent-edge rule

For a directed edge:

```text
u -> v
```

store `u` as a parent of `v` iff:

```text
dist[v] = dist[u] + 1
```

Reason:
- shortest path to `u` has length `dist[u]`
- then edge `u -> v` gives length `dist[u] + 1`
- this is shortest for `v` exactly when `dist[v] = dist[u] + 1`

---
### Edge cases

#### Store: forward by one layer

```text
u(1) -> v(2)
```

because $2 = 1 + 1$.

#### Do not store: same layer

```text
u(1) -> v(1)
```

Would give a path of length 2 to `v`, but `v` is already reachable in 1.

#### Do not store: backward edge

```text
u(2) -> v(1)
```

Would give a path of length 3 to `v`, but `v` is already reachable in 1.

#### Sanity check: forward by more than one layer

```text
u(1) -> v(3)
```

Should not happen after BFS on the same unweighted graph, because edge `u -> v` would imply `dist[v] <= 2`.

---
### Reporting paths

To report paths to `t`, recursively walk backward through parents.

If:

```text
parents[t] = {c, d}
```

then every shortest path to `t` is:

```text
path to c, then t
path to d, then t
```

Recursion tree:

```text
t
|- c
|  \- a
|     \- s
\- d
   |- a
   |  \- s
   \- b
      \- s
```

Read bottom-up:

```text
s -> a -> c -> t
s -> a -> d -> t
s -> b -> d -> t
```

Base case:

```text
if v has no parents, v is the source
```

---

### TA guiding questions

**Q:** What does BFS give us in an unweighted graph?  
**A:** Shortest distances / layers from the source.

**Q:** Why not store one parent?  
**A:** Multiple shortest paths may enter the same vertex.

**Q:** When do we store edge `u -> v`?  
**A:** Exactly when `dist[v] = dist[u] + 1`.

**Q:** Why not store same-layer or backward edges?  
**A:** They create longer paths, not shortest paths.

**Q:** How do we recover all paths?  
**A:** Recursively report all paths to every parent, then append current vertex.

---

### Implementation checklist

#### Representation

```sml
type graph = Set.t Table.t
```

Meaning:

```text
graph[u] = set of out-neighbors of u
```

```sml
type asp = vertex Seq.t Table.t
```

Meaning:

```text
asp[v] = sequence of all shortest-path parents of v
```

---

#### `makeGraph`

Group directed edges by source.

```text
[(s,a), (s,b), (a,t)]
```

becomes:

```text
s -> {a,b}
a -> {t}
```

Implementation idea:

```sml
Table.collect E
Table.map Set.fromSeq
```

---

#### `makeASP`

1. Run BFS from `s`.
2. Build distance table `D[v]`.
3. For every edge `u -> v`, keep it iff `D[v] = D[u] + 1`.
4. Store it reversed as parent relation: `v -> u`.
5. Collect by child to get `parents[v]`.

Output is the parent table.

---

#### `report`

Recursive idea:

```text
report(v):
  if v has no parents:
    return [[v]]
  else:
    for each parent p of v:
      get report(p)
      append v to each path
```

Reverse paths at end if implementation builds them backward.

---
### Full Solution
```sml
functor MkUnweightedASP
  (structure Table : ORDTABLE)
  :> UNWEIGHTED_ASP where type vertex = Table.Key.t and Seq = Table.Seq =
struct
  structure Seq = Table.Seq
  structure Set = Table.Set

  exception NotYetImplemented

  type vertex = Table.Key.t
  type edge = vertex * vertex

  (* You must define the following two types *)
  type graph = Set.t Table.t
  type asp = vertex Seq.t Table.t

  fun makeGraph (E : edge Seq.t) : graph = Table.map Set.fromSeq (Table.collect E)

  fun makeASP (G : graph) (v : vertex) : asp =
    let
      (* Canonical BFS with Distance Tracking *)
      fun bfs (G : graph) (v : vertex) : (int Table.t * int) = let
        fun explore X F i =
          if Set.size F = 0 then (X, i-1)
          else let
            val F' = Table.tabulate (fn k => i) F
            val X' = Table.union (fn (x, _) => x) (X, F')
            (* Review Cost Bounds for below *)
            val F'' = Table.reduce Set.union (Set.empty ())
                     (Table.difference ((Table.restrict (G, F)), X))
          in explore X' F'' (i+1) end
        in explore (Table.empty ()) (Set.$ v) 0 end
      val (D, i) = bfs G v
      (* Parents Tracking *)
      val T = let
        val seqG = Table.toSeq G
        val P = let
          fun f (v, N) = let
            val N' = Set.toSeq N
          in Seq.map (fn n => (n, v)) N' end
        in Seq.map f seqG end
        fun p (u, v) =
          (case (Table.find D u, Table.find D v) of
                (SOME d1, SOME d2) => d2 < d1
              | _ => false)
      in Seq.filter p (Seq.flatten P) end
    in Table.collect T end

  fun report (A : asp) (v : vertex) : vertex Seq.t Seq.t = let
    fun report' (v : vertex) : vertex list list =
    (case Table.find A v of
          NONE => [[v]]
        | SOME N => let
            val Ps = Seq.map report' N
            val Ps' = List.concat (Seq.toList Ps)
            val Ps'' = List.map (fn P => v :: P) Ps'
          in Ps'' end)
    val pathList = report' v
  in Seq.map (Seq.fromList o List.rev) (Seq.fromList pathList) end
end
```
---
## Task 2: Mongolian Puzzle

### Core idea

Do **not** solve the puzzle directly.

Model it as an **unweighted shortest-path problem**.

- Vertex = one full puzzle state
- Edge = one legal move
- Answer = BFS distance from start state to goal state

---

### What state must remember?

A state must include everything needed to determine legal next moves:

`(red position, blue position, turn)`

Why include `turn`?

Because red and blue must alternate, and red moves first.

So two states with the same token positions but different turns are **different states**.

---

### Drawable example state

Grid positions can be represented as coordinates.

```text
R = (0,0)
B = (n-1,n-1)
turn = red
```

State:

```text
((0,0), (n-1,n-1), red)
```

Start state:

```text
(top-left, bottom-right, red)
```

Goal condition:

```text
red = bottom-right
blue = top-left
```

Turn does not matter once the tokens are swapped.

---

### What is an edge?

There is an edge from state $X$ to state $Y$ if one legal move transforms $X$ into $Y$.

From state:

```text
(red = r, blue = b, turn = red)
```

Red must move.

The distance red moves is the number written under blue.

```text
step = grid[b]
```

Try 4 directions:

```text
up, down, left, right
```

Each produces a candidate new red position.

Reject if:

- off the grid
- red lands on blue

Then flip turn:

```text
(newRed, blue, blue)
```

Same logic when turn is blue.

---

### Whiteboard diagram

```text
State X
(R at r, B at b, red turn)

        move up
          |
move left - X - move right
          |
       move down
```

Each legal move becomes an outgoing edge in the state graph.

At most 4 outgoing edges per state.

---

### Why BFS?

Every move costs exactly 1.

So the minimum number of puzzle moves is exactly the shortest path length in this state graph.

Use BFS from the start state.

If BFS reaches a goal state, return its distance.

If BFS finishes without reaching goal, report no solution.

---

### Cost bound

Choices:

- red position: $n^2$
- blue position: $n^2$
- turn: 2

Total states:

```text
2 * n^2 * n^2 = O(n^4)
```

Each state has at most 4 legal moves.

Total edges:

```text
O(n^4)
```

BFS work:

```text
O(n^4)
```

---

### TA guiding questions

**Q:** What does one vertex in our graph represent?

**A:** A complete puzzle state: red position, blue position, and whose turn it is.

**Q:** Why do we need the turn in the state?

**A:** The same token positions can have different legal next moves depending on whose turn it is.

**Q:** What does an edge represent?

**A:** One legal move of the token whose turn it is.

**Q:** Why BFS?

**A:** All moves have equal cost, so shortest path in this state graph gives minimum number of moves.

**Q:** How do we know the cost is $O(n^4)$?

**A:** There are $O(n^4)$ states and constant outgoing moves per state.

---

### Implementation guide

1. Encode a state as:

```text
(redRow, redCol, blueRow, blueCol, turn)
```

2. Start:

```text
(0, 0, n-1, n-1, red)
```

3. Goal test:

```text
red = (n-1,n-1) and blue = (0,0)
```

4. Neighbor generation:

```text
if turn = red:
    step = grid[blue]
    move red by step in 4 dirs
    keep legal states
    next turn = blue

if turn = blue:
    step = grid[red]
    move blue by step in 4 dirs
    keep legal states
    next turn = red
```

5. Run BFS over implicit state graph.

6. Return first goal distance, or no solution.

---
## Task 3: Building Roads
### Core idea

We need count currently non-adjacent building pairs `{u,v}` such that adding road `{u,v}` does **not** shorten the shortest path from `s` to `t`.
Ask: `After adding {u,v}, is the shortest s-to-t distance still the same?`

**Naiively**: Run BFS on addition of every possible additional road, from $s$ to $t$

We only need to find if one new road can create a shortcut from $s$ to $t$.

---

### What changes when adding one road?

Current shortest distance:

```text
D = dist(s,t)
```

If we add new road `{u,v}`, any new shorter `s -> t` path using that road must look like one of these:

```text
s ... u -- v ... t
```

or

```text
s ... v -- u ... t
```

Because the new road is undirected.
Then the best possible path using `u -> v` has length:

```text
best s-to-u path + new road + best v-to-t path
```

So we only need distances:

```text
ds[{u,v}] = distance from s to {u,v}
dt[{u,v}] = distance from {u,v} to t
```

In an undirected graph, `dt[{u,v}]` is found by BFS from `t`.

---

### Drawable diagram

```text
s ---- ... ---- u == v ---- ... ---- t
```

New path length:

```text
ds[u] + 1 + dt[v]
```

Reverse direction:

```text
s ---- ... ---- v == u ---- ... ---- t
```

New path length:

```text
ds[v] + 1 + dt[u]
```

The road `{u,v}` is safe iff both possible new paths are **not shorter** than current `D`.

---

### Safe-road condition

For candidate non-edge `{u,v}`:

```text
new1 = ds[u] + 1 + dt[v]
new2 = ds[v] + 1 + dt[u]
```

Safe iff:

```text
min(new1, new2) >= D
```

Equivalent:

```text
ds[u] + 1 + dt[v] >= D
and
ds[v] + 1 + dt[u] >= D
```

If either value is `< D`, adding the road shortens Umut's commute.

---

### Why this is enough

Any path that does not use the new road already existed, so it cannot be shorter than `D`.

Any path that uses the new road can be simplified to using it once:

```text
s path -> one endpoint -> new road -> other endpoint -> t path
```

So the only two relevant forms are:

```text
s ... u -- v ... t
s ... v -- u ... t
```

Thus the two inequalities fully decide whether the road is safe.

---

### Cost bound

Run BFS from `s`:

```text
O(n + m)
```

Run BFS from `t`:

```text
O(n + m)
```

Check all unordered pairs `{u,v}`:

```text
O(n^2)
```

Skip pairs that already have a road.

Since simple graph has `m <= O(n^2)`, total:

```text
O(n^2)
```

---

### TA guiding questions

**Q:** What is the current commute length?

**A:** `D = ds[t]`.

**Q:** If we add road `{u,v}`, what can a newly shorter path look like?

**A:** It must use the new road either as `u -> v` or `v -> u`.

**Q:** What distances do we need?

**A:** Distances from `s` and from `t`.

**Q:** Why not rerun BFS for every candidate road?

**A:** There are `O(n^2)` candidate roads, so that would be too expensive. The two BFS arrays let us test each pair in `O(1)`.

**Q:** What pairs do we count?

**A:** Non-edges `{u,v}` where both new possible path lengths are at least the old distance.

---

### Implementation guide

1. Build graph adjacency / edge lookup.

2. BFS from `s`:

```text
ds[x] = dist(s,x)
```

3. BFS from `t`:

```text
dt[x] = dist(t,x)
```

4. Let:

```text
D = ds[t]
```

5. For every unordered pair `{u,v}`:

```text
if {u,v} already edge:
    skip
else:
    new1 = ds[u] + 1 + dt[v]
    new2 = ds[v] + 1 + dt[u]
    if min(new1,new2) >= D:
        count += 1
```

6. Return `count`.

---
## Task 4: Budget Cuts
### Problem Statement

We have:

- bus edges between arbitrary cities
- helicopter edges only between capital `c` and another city
- all edge weights positive
- may be parallel edges

Goal:

Cancel the **maximum number of helicopter routes** while preserving every city's shortest distance to the capital.

---

### Core instinct

This is a **weighted shortest paths** problem.

Use Dijkstra, not BFS, because route durations are weights.

First compute the true shortest distances with **all routes available**.

```text
d[v] = shortest distance from c to v using buses + helicopters
```

After cuts, every city must still have distance exactly `d[v]`.

---

### Motivation Step 1: Which helicopters are obviously useless?

For a helicopter `(c, v)` with weight `w`:

```text
w > d[v]
```

Then this helicopter is not on any shortest path to `v`.

It is strictly worse than the best known way to reach `v`.

So it can be canceled.

Keep considering only **optimal helicopters**:

```text
w = d[v]
```

---

### Motivation Step 2: But even optimal helicopters may be unnecessary

Suppose:

```text
d[a] = 5
d[b] = 8
bus a--b has weight 3
```

Then:

```text
d[a] + 3 = d[b]
```

So city `b` can be reached optimally by:

```text
c ... a --bus-- b
```

Even if there is an optimal helicopter directly to `b`, we do not need it.

Whiteboard:

```text
c ---- ... ---- a ==bus== b
               5   +3   8
```

Since `5 + 3 = 8`, bus edge can be the last edge of a shortest path to `b`

---

### Motivation Step 3: Shortest-path predecessor idea

After Dijkstra, think of preserving at least one shortest-path way to reach each city.

A city `v` is safe without a direct helicopter if it has a bus predecessor `u`:

```text
d[u] + w(u,v) = d[v]
```

Because then `v` can inherit a preserved shortest path to `u`, then take the bus to `v`.

This is the weighted version of the Task 1 parent-edge idea.

Task 1 unweighted rule:

```text
dist[v] = dist[u] + 1
```

Task 4 weighted bus rule:

```text
d[v] = d[u] + weight(u,v)
```

---

### Motivation Step 4: Which helicopters are actually necessary?

A helicopter to `v` is necessary only if:

1. `v` has **no bus predecessor** on any shortest path
2. there exists an optimal helicopter `(c,v)` with weight `d[v]`

Then we must keep **one** such helicopter.

Why only one?

If there are multiple equal optimal helicopters to the same city:

```text
(c,v, d[v])
(c,v, d[v])
(c,v, d[v])
```

keeping one preserves the distance; the duplicates can be canceled.

---

### Big picture

For each city `v != c`:

```text
if v has a bus shortest-path predecessor:
    keep 0 helicopters to v
else if v has one or more optimal helicopters:
    keep 1 helicopter to v
```

Cancel everything else.

Answer:

```text
k - number_of_helicopters_kept
```

---

### Important subtlety

Do **not** just compare against bus-only distances.

Wrong instinct:

```text
run Dijkstra on bus-only graph
remove helicopter to v if bus-only distance to v equals d[v]
```

This is too strict.

A city might be optimally reachable using:

```text
one kept helicopter to a different city
then buses
```

Example:

```text
c --heli--> a --bus--> b
```

`b` may need no helicopter even if bus-only distance from `c` to `b` is bad.

So check **bus predecessor under full distances**, not bus-only distances.

---

### Drawable mini-example

```text
     heli 5
c  -------->  a
              |
              | bus 3
              v
              b

also heli c -> b has weight 8
```

Dijkstra gives:

```text
d[a] = 5
d[b] = 8
```

For `b`:

```text
d[a] + 3 = d[b]
```

So `b` has a bus predecessor.

We can cancel the helicopter to `b`.

Need only keep the helicopter to `a`.

---

### TA guiding questions

**Q:** Why Dijkstra?

**A:** Edges have positive weights, so weighted shortest paths.

**Q:** What distance must be preserved?

**A:** `d[v]`, the original shortest distance from capital to every city using all routes.

**Q:** When is a helicopter obviously removable?

**A:** If its weight is greater than `d[v]`.

**Q:** When does city `v` not need a direct helicopter?

**A:** If some bus edge `u--v` satisfies `d[u] + w(u,v) = d[v]`.

**Q:** What if there are many optimal helicopters to the same city?

**A:** Keep at most one; cancel the rest.

**Q:** Why not bus-only Dijkstra?

**A:** Because cities can be preserved using a kept helicopter to another city plus buses.

---

### Implementation guide

1. Build full graph:

```text
all bus edges + all helicopter edges
```

2. Run Dijkstra from capital `c`:

```text
d[v] = shortest distance from c to v
```

3. Mark cities with bus shortest-path predecessor:

For every bus edge `{u,v}` with weight `w`:

```text
if d[u] + w = d[v]:
    busPred[v] = true

if d[v] + w = d[u]:
    busPred[u] = true
```

Because buses are undirected.

4. Group/count optimal helicopters.

For each helicopter `(c,v,w)`:

```text
if w = d[v]:
    optHeli[v] += 1
```

Helicopters with `w > d[v]` are automatically removable.

5. Decide how many helicopters to keep:

For each city `v != c`:

```text
if busPred[v]:
    keep 0
else if optHeli[v] > 0:
    keep 1
```

6. Return:

```text
k - keep
```

---

### Cost

Dijkstra on `m + k` edges:

```text
O((m+k) log n)
```

Scan bus edges:

```text
O(m)
```

Scan/group helicopters:

```text
O(k log n)` or `O(k)` depending structure
```

Total fits required:

```text
O(m log n + k log n)
```

---
