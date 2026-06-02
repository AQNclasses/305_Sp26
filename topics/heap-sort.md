# Heap Sort

## Heaps

- A (binary) heap can be considered a nearly complete binary tree.
- Tree is filled on all levels except possibly the last, which must be filled
from left to right.
- Can be stored in arrays

## Max- and min-heaps

A max-heap $A$ must satisfy the condition

$$
A\[parent(i)\] \geq A[i]
$$

such that children cannot hold data values greater than their parents.

A min-heap is organized in the opposite way, so that children will be greater
than or equal to their parents.

Heaps often used to implement priority queues.

**Height** of node on heap is the number of *edges* on the longest downward path
from the node to a leaf.

```python
Max-Heapify(A, i):
  l = left(i) # index of left child
  r = right(i) # index of right child
  if l <= A.heap_size and A[l] > A[i]:
    largest = l
  else:
    largest = i
  if r <= A.heap_size and A[r] > A[largest]:
    largest = r
  if largest != i:
    swap A[i] and A[largest] # constant time, constant memory
    Max-Heapify(A, largest) # recurse!
```

How to analyze?

For tree rooted at node $i$, we have $\Theta(1)$ operations to "fix" $A[i]$
$A[left(i)]$ and $A[right(i)]$, plus one recursive call on one of the children.

Child subtrees have size at most $2n/3$. Why?

### Sketch of proof

The "most unbalanced" heap is one where every level is full, except the last
level, which is half full (draw and convince yourself).

Call the tree rooted at the left child of the root $L$, and call the tree rooted
at the right child of the root $R$. If $R$ contains $k$ nodes, then $L$ contains
$k + (k+1)$ nodes (can see this from the summation formula of total nodes in a
full binary tree). Thus, the total number of nodes in the tree is $n = 1 + k +
(2k + 1) = 3k + 2$. The ratio of the left (bigger) subtree to the size of the
overall heap is then $R = 2k+1 / 3k + 2$, which is bounded above by $2/3$.

A few other proofs [at this link](https://stackoverflow.com/questions/9099110/worst-case-in-max-heapify-how-do-you-get-2n-3).



So, putting this bound into a runtime recurrence, we have

$$
T(n) = \Theta(1) + T(2n/3)
$$

which gives $O(\lg(n))$.

$$
1 + 2+ 4 + i + \ldots + 2^{h+1} = 2^{h+2} -1
$$

## Space Usage

If we use the following encoding scheme

```
LeftChild(i) = 2*i
RightChild(i) = 2*i + 1
Parent(i) = floor((i-1)/2)
```

we can store a heap in an array (indexed starting at 1, easy to adapt to index
starting at zero). Given an arbitrary node in the array at index $i$, we can
access its children and parents in constant time.

Thus, space usage is $O(n)$, and can be highly optimized.

## Build-Max-Heap

We can build a max heap from an array using our heapify algorithm.

```
BUILD-MAX-HEAP(A)
    n = A.length
    for i = floor(n / 2) downto 1
        MAX-HEAPIFY(A, i)
```
