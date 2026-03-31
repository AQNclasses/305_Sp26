# Master Theorem

Imagine we have a recurrence of form:

$$
T(n) = a T(\frac{n}{b}) + f(n)
$$

with a base case $T(n) \in \Theta(1)$.

What are some examples?

- Merge sort: $T(n) = 2T(n/2) + n$
- Binary search: $T(n) = T(n/2)$
- Max sub-array: $T(n) = 2T(n/2) + \Theta(n)$

If we have a recurrence in this form, a theorem exists to automatically give us
bounds on the solution. This theorem was introduced in the paper "A General
Method for Solving Divide-and-Conquer Recurrences" by Bentley, Haken, and Saxe
in 1980. The textbook "Introduction to Algorithms" by Cormen, Leiserson, Rivest,
and Stein introduced the term "master theorem" because it is a universal method
for solving divide-and-conquer recurrences.

## Step 1

Write down your recurrence relation in the form $T(n) = a T(\frac{n}{b}) + f(n)$
and identify $a$, $b$, and $f(n)$ for your problem.

## Step 2

Compute the **critical exponent**, defined as $c_{crit} = \log_b(a)$.

## Step 3

Use $c_{crit}$ and $f(n)$ to determine which of the following three cases
applies. Plug in the values to the given bound; you're done!

Three cases:

1. Work is dominated by subproblems.

   a. **Condition:** $f(n) = O(n^c)$ where $c < c_{crit}$.

   b. **Bound:** $T(n) = \Theta(n^{c_{crit}})$

2a.

   a. **Condition:** $f(n) = \Theta(n^{c_{crit}} \log^k(n)$ for $k > -1$.

   b. **Bound:** $T(n) = \Theta(n^{c_{crit}} \log^{k+1}(n))$

2b.

   a. **Condition:** $f(n) = \Theta(n^{c_{crit}} \log^k(n)$ for $k = -1$.

   b. **Bound:** $T(n) = \Theta(n^{c_{crit}} \log(\log(n)))$

2c.

   a. **Condition:** $f(n) = \Theta(n^{c_{crit}} \log^k(n)$ for $k < -1$.

   b. **Bound:** $T(n) = \Theta(n^{c_{crit}})$

3. Work to split/recombine dominates the subproblems.

   a. **Condition:** $f(n) = \Omega(n^{c})$ where $c > c_{crit}$
   **and** $a f(\frac{n}{b}) \leq k f(n)$ for $k < 1$ and sufficiently large $n$. Second
   condition is called the *regularity condition*.

   b. **Bound:** $T(n) = \Theta(f(n))$

## Examples

1. $T(n) = 8T(\frac{n}{2}) + 1000n^2$

Solution: Case 1

$f(n) = O(n^2)$

$\log_b(a) = \log_2(8) = 3 > 2$.

Thus,

$$
T(n) = \Theta(n^{\log_b(a)}) = \Theta(n^3)
$$

2. $T(n) = 2T(n/2) + 10n$

$a=2, b-2, c=1, f(n) = 10n$

$f(n) = \Theta(n^c \log^k n)$, where $c=1, k=0$

$\log_b a = \log_2 2 = 1$, therefore, $c = \log_b a$

$T(n) = \Theta(n^{\log_b a} \log^{k+1} n) = \Theta(n \log n)$

3. $T(n) = 2T(n/2) + n^2$

$a=2, b=2, f(n) = n^2$

$f(n) = \Omega(n^c)$, where $c=2$.

Filling case 3 condition:

$\log_b a = \log_2 1$, so $c > \log_b a$.

Regularity condition:

$2 n^2 / 4 \leq kn^2$, choosing $k = 1/2$.

So:

$T(n) = \Theta(n^2)$.
