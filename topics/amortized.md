---
author: Alexandra Nilles
title: Amortized Analysis
---

# Example 1

Consider the scenario of obtaining a mortgage loan for a house.

- Draw example on board
- Constraint: constant payments for lifetime of mortgage
- But, the loan charges interest on the principal you have not paid back. So
interest amounts are higher earlier in the loan.
- The bank *amortizes* the loan by changing the split of interest/principal in
each payment over time. At the beginning, more of your payment is going to
interest. Toward the end, more of your payment is going to principal.
- This is preferred for a few reasons: *consistency* being the most applicable
to our discussion of amortized analysis of algorithms. Even though "under the
hood" each payment isn't the same, we can effectively treat them as identical,
even though some interest payments are much more than others.

# Example 2

Consider the task of implementing a hash table using an array.

- Define array A.
- Define `insert(x)` as the operation that will hash `x` and insert it in the table.
- However, if array is full, need to allocate new array and move data
- Very expensive single operation for `insert`, but only sometimes. How to
characterize performance of data structure?

**Cost model:** assign cost of add as 1, and resizing array is number
of elements moved.

To begin, we'll assume our hashing functions are magically perfect and never
cause collisions (we'll relax this assumption later).

## Algorithm 1

First, assume we naively implement our hash table by resizing our array from $n$ to $n+1$ every time we run out of space.

- Start with array of size 1
- perform $n$ `insert`s
- total cost of resizing = $1 + 2 + 3 + 4 + \ldots + n = n(n+1)/2$
- total cost $n + n(n+1)/2$
- average cost per operation is $1 + (n+1)/2$
- note how this is a **different** type of average than the average case of a
  randomized algorithm (which is why we use a different term: amortized).
- We say the cost of the resize operation is amortized over all operations.

## Algorithm 2

Next, assume we try a scheme where we double the size of our array every time we run out of space.

- Again, start with array of size 1
- $n$ `inserts`
- total cost for resizing = $1 + 2 + 4 + 8 + \ldots + 2^i$

How to get sum?

Doubling in size every time we resize gives a total resize cost of

$$
\sum_{i=0}^k 2^i
$$

such that for an input of size $n$, the final (kth) resize has the property $2^k <= n$. Thus our upper bound is
$k <= lg n$, and we take the upper bound $k = lg n$ for our runtime analysis.

In the more general case of summation to $N$, this is a geometric series, so we can apply our general formula

$$
\sum_{i=0}^N r^i = \frac{1-r^{N+1}}{1-r}
$$

to find

$$
\sum_{i=0}^{lg n} 2^i = 2^{1 + lg n}-1 = 2 \dot 2^{lg n} - 1 = 2 n - 1.
$$

The result can also be shown inductively.

- sum is at most $2n - 1$, plus $n$ for the insert operations.
- Total cost $3n-1$, amortized cost per operation is $<3$: constant time!

# Example 3

Consider the following implementation of a binary counter:

```python
# B is array of bits
def Increment(B):
  i = 0
  while B[i] = 1:
    B[i] = 0
    i = i+1
  B[i] = 1
```

How long will this algorithm take to terminate for an arbitrary input binary number? How long to count up to $n$?

- If first $k$ bits are all ones, it will take $\Theta(k)$ time.
- Binary representation of integer $n$ is $lg n +1$ bits long.
- So to call Increment $n$ times, starting at zero, we estimate $O(n lg n)$ for
total running time to count up to $n$.

We can actually do better!

## Method one: Summation

- Observe that we don't flip all log(n) bits every time
- Least significant bit B[0] does flip every time
- B[1] flips every other time
- B[2] flips every 4th iteration
- B[i] flips every $2^i$th iteration

Pattern yields the sum:

$$
\sum_{i=0}^{lg n} \frac{n}{2^i} < \sum_{i=0}^\infty \frac{n}{2^i} = 2n
$$

Thus, on average, each call to Increment runs in constant time.

Note this is a different sense of "on average" than we consider with
randomized algorithms.

## Method 2: Accountant's method

Imagine if instead of paying for each bit flip, the "Increment Revenue Service"
charges us two dollars whenever we set a bit from zero to 1. When we flip the
same bit back to zero, the IRS pays us back a dollar.

So amortized cost of increment is just 2, since only one bit is flipped each
time.

Can also think of this method as charging the cost of later steps in the
algorithm to earlier steps.

## Method 3: Physicist's method

Prepaid work is *potential* that can be used to power later operations.

```math
a_i = c_i + \phi_i - \phi_{i-1}
```

Binary counter: define potential $\phi_i$ to be the number of bits with value 1

At step $i$, $c_i$ is number of bits changed from 0 to 1 + bits from 1 to zero. Change in potential is
number of bits changed from 0 to 1 - bits changed from 1 to zero.

Amortized cost:

$$
a_i = c_i + \phi_i - \phi_{i-1} = 2 (bits from 0 to 1)
$$
