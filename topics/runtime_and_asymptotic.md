# Runtime and Asymptotics

## Computational model

- RAM model:
  - single processor, sequential execution
  - constant-time elementary instructions (arithmetic, data movement, control)
  - runtime cost is uniform (1 time unit) for all simple instructions (arithmetic, calling subroutine, initializing variables, etc)
  - memory is unlimited and "flat" : no hierarchy, accessing a variable in memory takes 1 time unit.
- Running time of an algorithm is always given in terms of input size (usually N).
  - Input can have other structure, eg: sorted or unsorted, cyclic or acyclic graphs

## Complexity

The number of steps the algorithm takes determines its **computational
complexity**. However, the number of steps an algorithm takes may depend on
structure of the input (consider sorting an already-sorted list).

There are three cases we usually consider:

- Worst Case complexity: maximum number of steps
- Best Case complexity: minimum number of steps
- Average case complexity: average over all possible inputs
    - will discuss further later in the quarter

Usually we focus on worst-case complexity. Why?

## Computing runtime: Counting!

Assumptions:

1. "Simple" operations take constant time (doesn't depend on size of input)
2. The line defining a loop runs one more time than the statements inside the loop (has to check for ending condition)


### Example 1

Consider a straightforward implementation of insertion sort.

Let `ti` be a variable representing the number of times the inner while loop
executes for a given value of `i`.


```python
def insertionSort(A, n):
  for j=2 to n:                         # c1*n (assume loop is inclusive of n)
    key = A[j]                          # c2*(n-1)
    i = j-1                             # c3*(n-1)
    while i > 0 and A[i] > key:         # c4*(sum ti from 2 to n)
      A[i+1] = A[i]                     # c5*(sum ti-1 from 2 to n)
      i = i-1                           # c6*(sum ti-1 from 2 to n)
    A[i+1] = key                        # c7*(n-1)
```

Best case: already sorted list. How many times will the inner loop run for each `i`?
In the best case, only twice (check that elements i and `i+1` are sorted, then
check loop termination condition).

Worst case: reverse sorted list. Same question.

How would we try to prove correctness? (loop invariants)


### Example 2

```python
def example(n):
    j = 0                   # 1 initialize, 1 assignment
    for i in range(1,n):    # 1 assignment to initialize, one for each increment = n+1
      j = 1                 # 1*n (cost one, inside for loop)
      while j <= n:         # 1*n*(iterations of inner loop)
         j += 2             # 1*n*(iterations of inner loop)
    return j                # 1: count return
```

- How many times will inner while loop evaluate for arbitrary `i`?
- Can estimate `n/2` by inspection
- Algebra solution:
  - after $k$ iterations, value of `j` is `2k+1`
  - Termination condition: `j <= n`
  - Solve for value of k when loop terminates: `2k+1 <= n` -> `k = (n-1)/2`
- So inner loop will run $(n-1)/2$ times during *each* iteration of outer loop
- Total count -> $nc(n-1)/2$
- What if inner loop instead terminates when $j <= i$??
  - Can multiply max runtime by $n$ (over-estimation)
  - To get tighter bound, manually compute sum over i

$$
\sum_{i=1}^n (i-1)/2
$$

$$
\to \frac{1}{2} \sum_{i=1}^n (i-1)
$$

$$
\to \frac{1}{2} \big((\sum_{i=1}^n i) - n \big)
$$

### Tips and Tricks

`https://discrete.openmathbooks.org` is a great resource in general.

- Arithmetic series finite sum
  - Example: $1 + 2 + \ldots + n$
  - Example: $2 + 5 + 8 + 11 + 14 = 40$
  - Formula: $\frac{n(a_1 + a_n)}{2}$
- Geometric series sum
  - $\sum_{i=0}^n a r^i$
  - Case of $r=1$
  - Otherwise, sum = $a\frac{1-r^{n+1}}{1-r}$
- Logarithm rules (+ exponent rules)
- Don't stress about floor / ceilings
- Exponents vs. polynomials: $c^N$ will always be asymptotically larger than
  $N^d$, where $c$ and $d$ are arbitrary positive integers.


# Asymptotics

We care most about how runtime (or space, etc) scales with the size of the
input.

As $N$ gets bigger, different parts of the runtime function will contribute more
to others. Example: compare $f(x) = x^2$ and $g(x) = x^4$. When $x$ is small, for example
$x=1/2$ or $x=1$, we may have $f(x) > g(x)$ or $f(x) = g(x)$. But as $x$ gets
larger, we can clearly see that $x^2 < x^4$ and this property will not change
as $x$ increases further.

We will formalize this idea. This allows us to say that two algorithms are
**asymptotically** equally efficient, or that one is asymptotically more
efficient than the other.

## O-notation

O-notation characterizes an **upper bound** on the asymptotic behavior of a function.
We usually say this out loud as "big-Oh notation". This is shorthand for a
formal definition of classes of functions with bounded growth rates.

Formally, for a function $g(n)$, we define $O(g(n))$ as the set of functions
asymptotically bounded by $g(n)$. We can write this set as

$$
\O(g(n)) = \{ f(n) : 0 \leq f(n) \leq c g(n), n \geq n_0 \}
$$

for some positive constants $c$ and $n_0$.

This means that there is some input size $n_0$ beyond which $g(n)$ is a strict
upper bound for $f(n)$.

O-notation implies that a function grows *no faster* than a certain rate. The rate is determined by
the highest order term.

For example, $f(n) = 7n^3 + 100n^2 - 20n + 6$ is $O(n^3)$.

Faster growing functions are also valid upper bounds, for example the function $f(n)$ is also
$O(n^5)$. However, we say that $O(n^5)$ is not a *tight* upper bound while
$O(n^3)$ is a *tight* upper bound, as you can prove there is no polynomial
smaller than $n^3$ that can serve as an upper bound for $f(n)$.

## Ω-notation

Ω-notation (big omega) characterizes a **lower bound** on the asymptotic behavior of a function, implying that a function grows
*at least as fast* as a certain rate. Again, this rate is based on the highest-order term.

Formally, for a function $g(n)$, we define $\Omega(g(n))$ as the set of
functions lower-bounded by $g(n)$. We write this as

$$
\Omega(g(n)) = \{ f(n) : 0 \leq c g(n) \leq f(n), n \geq n_0 \}
$$

for some positive constants $c$ and $n_0$.

Using the same function $f(n) = 7n^3 + 100n^2 - 20n + 6$, $f(n)$ is $\Omega(n^3)$.

The function $f(n)$ is also $\Omega(n^2)$, $\Omega(n)$, and $\Omega(n^c)$ for any $c \leq 3$.

## Θ-notation

$\Theta$-notation (big theta) characterizes a *tight upper and lower bound* on the asymptotic behavior of the function: it states
that a function grows at precisely a certain rate, based on the highest-order term (in the limit of large $n$).

Formally, we write $\Theta(g(n))$ as the set of functions bounded above and
below by $g(n)$:

$$
\Theta(g(n)) = {f(n): 0 \leq c_1 g(n) \leq f(n) \leq c_2 g(n), \forall n \geq n_0}
$$

for positive constants $c_1$, $c_2$, and $n_0$.

Our example function $f(n) = 7n^3 + 100n^2 - 20n + 6$ is $\Theta(n^3)$, and is $\Theta(n^c)$ only for $c=3$.

The logical relationship between the notations is:

$$
O(f(n)) \wedge \Omega(f(n)) \iff \Theta(f(n))
$$

## lowercase asymptotics

The lowercase greek letter is used to indicate a "loose" bound, while upper case
indicates a "tight" bound.

| Variable | Name | Corresponding Operator |
| -------- | ---- | ---------------------- |
| O | big O | $\leq$ |
| o | little O | $<$ |
| $\Omega$ | big omega | $\geq$ |
| $\omega$ | little omega | $>$ |
| $\Theta$ | big theta | $\approx |

Does "little theta" make sense? Why or why not?
