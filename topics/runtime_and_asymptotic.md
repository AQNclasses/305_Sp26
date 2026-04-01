# Runtime and Asymptotics

## Computational model

- RAM model:
  - single processor, sequential execution
  - constant-time elementary instructions (arithmetic, data movement, control)
  - runtime cost is uniform (1 time unit) for all simple instructions
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

### Example 1

Consider a straightforward implementation of insertion sort.

Here is how to write down the number of operations per line:

```python
def insertionSort(arr):
  for i in range(1, len(arr)):          # n+1
    key = arr[i]                        # n
    j = i-1                             # n

    while j >= 0 and key < arr[j]:      # best case: C=2; worst case: C=n
      arr[j+1] = arr[j]                 # n*1*C
      j -= 1                            # n*1*C
    arr[j+1] = key                      # n
```

### Example 2

```python
def example(n):
    j = 0                   # 1 initialize, 1 assignment
    for i in range(1,n):    # 1 assignment to initialize, one for each increment = n+1
      j = 1                 # 1*n (cost one, inside for loop)
      while j <= n:         # 1*n*(iterations of inner loop)
         j += 1             # 1*n*(iterations of inner loop)
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
  - Can simply multiply max runtime by $n$ (over-estimation)
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
- Big theta: mostly we care about showing that lower and upper bound have same
  functional form. To justify, need to justify that there is no situation where we
  will change the functional form of the runtime expression $T(n)$.
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

We will formalize this idea.

## O-notation

O-notation characterizes an **upper bound** on the asymptotic behavior of a function.

Formally: We say that $f(n)$ is $O(g(n))$

O-notation implies that a function grows *no faster* than a certain rate. The rate is determined by
the highest order term.

For example, $f(n) = 7n^3 + 100n^2 - 20n + 6$ is $O(n^3)$.

The function $f(n)$ is also $O(n^5)$, and in general is $O(n^c)$ for any constant $c \geq 3$.

## Ω-notation

Ω-notation characterizes a lower bound on the asymptotic behavior of a function, implying that a function grows
*at least as fast* as a certain rate. Again, this rate is based on the highest-order term.

Using the same function $f(n) = 7n^3 + 100n^2 - 20n + 6$, $f(n)$ is $\Omega(n^3)$.

The function $f(n)$ is also $\Omega(n^2)$, $\Omega(n)$, and $\Omega(n^c)$ for any $c \leq 3$.

## Θ-notation

$\Theta$-notation characterizes a *tight bound* on the asymptotic behavior of the function: it states
that a function grows at precisely a certain rate, based on the highest-order term (in the limit of large $n$).

Our example function $f(n) = 7n^3 + 100n^2 - 20n + 6$ is $\Theta(n^3)$, and is $\Theta(n^c)$ only for $c=3$.

The logical relationship between the notations is:

$$
O(f(n)) \wedge \Omega(f(n)) \iff \Theta(f(n))
$$

## lowercase asymptotics

The lowercase greek letter is used to indicate a "loose" bound, while upper case
indicates a "tight" bound.

# Computing runtime

- So far, we've been looking a lot at recurrences and how to analyze recursive
algorithms.
- Quick refresh of "non-recursive" runtime analysis

# Root method


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

`https://discrete.openmathbooks.org` is a great resource in general.

