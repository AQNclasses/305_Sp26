# Recurrences

**Definition:** a recurrence relation is a mathematical formula for computing
sequences of numbers, where the $n$th term in the sequence is equal to some
combination of previous terms.

In this course, we will use recurrences mostly for computing the runtime of
recursive algorithms. For example, merge sort can be thought of as two recursive
calls to merge sort (one call for each half of the input), along with $O(n)$
work to merge the halves back together. The runtime of merge sort can be
expressed as

```math
T(n) = 2T(n/2) + O(n)
```

with base case $T(1) = 1$, and the solution can be found by drawing recursion trees, among other methods.

Probably the most famous recurrence relation is the recurrence defining the
Fibonacci numbers,

```math
F_n = F_{n-1} + F_{n-2},
```

with the base cases $F(0) = 0$ and $F(1) = 1$.

This is the recurrence for computing the numbers themselves; the runtime
recurrence for computing the numbers looks quite similar:

```
T(n) = T(n-1) + T(n-2) + 1
```

(draw recursion tree)

Each level $i$ of the recursion tree will have $2^i$ nodes, each with constant
time work. There are roughly $n$ levels.

```math
\sum_{i=0}^n 2^i = \frac{1-2^{n+1}}{1-2} = O(2^n)
```

Is this the best we can do? **No!** (Thankfully)

How to improve? Best case?

Takeaway: Recurrence method will give upper bound, but dynamic programming
(changing order of evaluation to avoid re-computing values) can save us a lot of
time.

## Root method


- We can solve "second-order" recurrence relations by finding roots of characteristic equation
- Method for generating solutions to recurrence relations of form $f_n + \alpha f_{n-1} + \beta f_{n-2} = 0$
- We guess that $f_n = r^n$, then factor and solve for $r$
- Example:

$$
\begin{align*}
& G_n = G_{n-1} + 6 G_{n-2} \\
\to & r^n - r^{n-1} - 6r^{n-2} = 0 \\
\to & r^{n-2} ( r^2 - r - 6 ) = r^{n-2} (r-3) (r+2)
\end{align*}
$$

Solutions $r=3$ and $r=-2$ are both valid, depending on initial conditions (check using original recurrence).

Solutions of $f_n + \alpha f_{n-1} + \beta f_{n-2} = 0$ can be found using roots
$r_1$, $r_2$ of the characteristic equation $x^2 + \alpha x + \beta = 0$, and in general solutions
take the form $f_n = a r_1^n + b r_2^n$.

Further reading [here](https://discrete.openmathbooks.org/dmoi2/sec_recurrence.html) and [here](https://math.stackexchange.com/a/167197).
