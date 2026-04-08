# Recursion

## Towers of Hanoi

Goal: move stack from start peg to end peg.

Rules:

- move one disk at a time
- larger disks cannot be placed on top of smaller disks.

\centering ![](slides/figs/hanoi.png){width=200px}

## How to solve?

> 1. Move top n-1 disks to "spare peg."
> 2. Move bottom disk to the end peg.
> 3. Move n-1 disks on spare peg to the end peg.

. . .

Done!
This procedure both solves the game, and lets us count the number of moves
needed.

## Recurrence

```math
T(n) = 2T(n-1) + 1
```

How to solve?

## Strategy 1: Iterate using Definition


```math
T(n) = 2T(n-1) + 1
T(n) = 2(2T(n-2) + 1) + 1
T(n) = 2(2(2(T(n-3) + 1) + 1) + 1
```

Pattern?

## Strategy 2: Compute sequence

```math
T(0) = 0
T(1) = 1
T(2) = 3
T(3) = 7
T(4) = 15
T(5) = 31
```

Combine with pattern from before?

Guess: $T(n) = 2^n - 1$

## Strategy 3: Check with Induction
