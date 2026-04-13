# Recursion and Induction

"The control of a large force is the same principle as the control of a few men:
it is merely a question of deviding up their numbers" - Sun Zi, Art of War,
400CE

"To understand recursion, one must first understand recursion." - Abraham
Lincoln

- Common strategy for algorithms is "divide and conquer," intentionally
  splitting a problem into smaller sub-problems.
- This is a certain type of recursion, described loosely as:
  - If the given instance of the problem can be solved directly, do it.
  - Otherwise, reduce it to one or more simpler instances of the **same** problem.

For example, instead of thinking of cleaning your entire apartment, often we
start by saying "I will just clean my bedroom floor / bathroom counter / kitchen
sink." By completing enough smaller problems, we can solve the large problem.

## The recursion fairy

We can imagine the recursive call being done by us, or by someone else, even a
magical being.

We will call this hypothetical magical being *the recursion fairy*.

Once we have defined the recursive call and the base case, we stop and let the
recursion fairy handle the rest!

## Examples

### Example: Tower of Hanoi

Fun (?) fact: puzzle was developed by a French mathematician at the same time as the
original French invasion and colonization of Hanoi, and the establishment of
French Indochina. The inventor made up a legend about an Indian temple (?) and
sold the game commercially.

How to approach the problem?

- Can't solve until largest (nth) disk is moved
- So first, we must move all (n-1) smaller disks to the spare peg.
- Then, move largest disk to the destination.
- Now, all we have to figure out is....

**No!** We are done!

Test with n=0, n=1, n=2, n=3

Can write recursive algorithm:

```
Hanoi(n, src, dst, tmp):

if n > 0:
  Hanoi(n-1), src, tmp, dst)
  move disk n from src to dst
  Hanoi(n-1, tmp, dst, src)
```

## How to analyze?

Let T(n) denote the number of moves required to transfer *n* disks.

We have:

- T(0) = 0
- T(n) = 2T(n-1)+1

Compute first several values of T(n): 0, 1, 3, 7, 15, 31, 63...

Leads us to guess that $T(n) = 2^n - 1$, which happens to be correct.


### Example: Peasant Multiplication

Consider the following method for multiplication (traced back to at least 17th
century BC!):

x*y =

1. 0 if x=0
2. floor(x/2)*(y+y) if x is even
3. floor(x/2)*(y+y) + y if x is odd

Can also be expressed algorithmically as:

```
PeasantMultiply(x, y):

if x=0:
  return 0
else
  xNext = x // 2
  yNext = y+y
  prod = PeasantMultiply(xNext, yNext)
  if x is odd:
    prod = prod + y
  return prod
```

Recurrence?

T(n,m) = C + T(n/2, 2n)

We have two inputs to the algorithm. However, termination of the algorithm is
determined entirely by the value of the first input, so we can ignore the
second, yielding

T(n) = C + T(n/2)

How to solve this recurrence?

## Recursion trees

Idea: represent "work done" during recursion as a X-ary tree (where X depends on
the number of recursions.

Each node of the tree should store the work done at that "level" of recursion,
while edges represent recursive calls.

Then, we can sum the values of all the nodes to get the overall runtime of the
algorithm.

Consider the example of the multiplication algorithm above. We have one
recursive call, which divides the input size in half, and we have some constant
time work at each level of recursion, which we could represent as a unary tree:

C
|
C
|
C
|
....

How many levels are in this tree?

At an arbitrary level i, the input will have size $n/2^i$, since input is
divided in half each time. We stop when $x=0$, which will only happen when $x=1$
in the previous step ($1 // 2  = 0$). So we can solve for $i in the equation

```math
1 = n/(2^i)
2^i = n
i = \log_2(n)
```

to find that the maximum number of levels in our tree is $O(log n)$. The base of
the log changes depending on what the input size is divided by in the recursive
call, but as long as we are **dividing,** we will have a logarithmic number of
calls on our recursion stack.

### A note on stacks
