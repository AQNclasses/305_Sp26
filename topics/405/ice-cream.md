# Greedy algorithms: the Ice Cream Problem

## Coding problem

- Maximum Ice Cream Flavors: given a fixed budget, and a list of costs for ice cream flavors, how do we maximize the number of flavors we can try?

## How to prove optimality?

**Lemma:** for a permutation p, Expected(cost(p)) is minimized when $c(p[i]) \leq c(p[i+1])$
for all $i$, where $c(p[i])$ is the cost of the $i$th element in the permutation.

**Proof:** Suppose $c(p[i]) > c(p(i+1))$. Let $a = p(i)$ and $b = p(i+1)$. If we
swap the order of purchase of $a$ and $b$, the our remaining coins after purchasing $a$
increases by $c(b) - c(a)$, and our remaining coins after purchasing $b$
will be the same in either case. Thus, the expected return if we run out of
money at some uniformly random $i$ will be maximized if we use the correctly
sorted order.
