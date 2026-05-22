# Hash Tables

Recall that a hash table is an array paired with a *hashing function*.

The hashing function takes data and maps to a location in the hash table.
Ideally, the locations are independent and uniformly random. In practice, this
is not possible, but we can get pretty close. For this analysis, we will assume
we have a perfect uniformly random hash function, so the probability of data
being mapped to one of $m$ positions in the hash table is $1/m$.

When collisions occur (two different data values are mapped to the same position),
we must perform collision resolution. We'll discuss two approaches, chaining and
linear probing.

## Load Factor

For a hash table $T$ with $m$ slots that stores $n$ elements, we define the **load
factor** to be

```math
\alpha = n/m
```

so that it represents the fraction of the table being filled; with $\alpha=0$ being an
empty hash table and $\alpha=1$ being completely full.

Exercise: Assuming independent uniform hashing, what is the expected number of
collisions when we hash $n$ distinct keys into a table of size $m$? What is this
value in terms of $\alpha$?

## Chaining

Recall that for a chaining hash table, each entry in the table stores a linked
list containing all keys which hash to that entry $T[j]$.

Theorem: In a hash table in which collisions are resolved by chaining, an
unsuccessful search takes $\Theta(1+\alpha)$ time on average, under the
assumption of independent uniform hashing.

Proof: A key $k$ is equally likely to hash to any of the $m$ slots. The expected
time to search unsuccessfully for a key $k$ is the expected time to search to
the end of an average list. Under the uniform hashing assumption, the expected
length of any given list is $n/m$, where $n$ is the number of keys already
inserted. Note this is equal to the load factor $\alpha$. Thus, we require one
unit of computation to perform the hash, the total time to search for an element
that is not present is $\Theta(1 + \alpha)$ in the average case.

Theorem: In a hash table in which collisions are resolved by chaining, a successful
search takes $\Theta(1+\alpha)$ time on average, under the assumption of independent uniform hashing.

Proof: Omitted here; see Thm 11.2 of CLRS. The intuition follows from above
(we still have to search chains of average length $\alpha$), but
the full proof includes an analysis of where in the chaining list the target key
may be.

**Takeaway:** If the number of elements in the table is proportional to the size
of the table ($n = O(m)$), then we have $\alpha = O(m)/m = O(1)$, and search and
insertion in a chaining hash table takes constant time on average.

## Linear Probing

The full proof of expected runtime of linear and/or quadratic probing schemes
will be provided as an optional reading.

The intuitive explanation is as follows:

The first "probe" (attempt to insert key into table) always occurs. With
probability $\alpha$ (the load factor of the table), a collision will occur. The
probability of two subsequent collisions is $1/\alpha^2$ (and so forth).

The number of probes can then be expressed as

```math
1 + \alpha + \alpha^2 + \ldots = \sum_{i=0}^{\infty} \alpha^i =
\frac{1}{1-\alpha}.
```

This expression is constant, though it approaches infinity as $\alpha$
approaches 1. Therefore open addressing schemes will take
constant time to insert keys.
