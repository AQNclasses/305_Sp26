# Search in Trees

## Binary Search Trees

Definition: a binary tree where each node contains a **key.** Keys are
comparable, and we'll use the usual operators `<`, `>`, and `=` to compare them.
For each node, the left child (if it exists) must contain a key "less than" the
key of the parent. The right child must contain a key "greater than" the key of
the parent.

This raises the immediate question of what to do with duplicate keys; you can
either randomize where they go, or set a default (always left or always right).

What are the pros and cons of these approaches?

For the rest of these notes, we'll assume keys are distinct.

### BST Construction

Imagine the case of constructing a not-self-balancing BST from a given array of keys.

Consider a BST-construct algorithm that consumes the first element in the array, sets
it as the root node, then consumes the next key, setting as right or left child, and
repeats until all elements are consumed.

What is the worst-case input structure for this algorithm? Recall that the
worst-case structure of a BST is defined by the longest possible path from root
to leaf node (bounds the maximum number of operations during a search).

### Accessing Data

When accessing data in the BST (for example, to check if a key is present or
not), the best performance occurs when the BST is fully balanced. In this case,
the maximum length path in the tree is O(log n), making search very efficient.

There are various self-balancing BST data structures: AVL trees, red-black
trees, B-trees, splay trees, etc. These generally will use "rotations" when data
is added, and can achieve good performance since they are performing these
rotations on an already mostly-balanced tree. Rotations are usually implemented
via pointer manipulation, so they're quite efficient (even for constant-time
operations).

However, defining and analyzing these algorithms can be quite tedious (lots of
book-keeping). Instead, we will examine some randomized alternatives. But first,
we need to learn or recall *treaps.*

## Treaps

A **treap** is a binary search tree where each node has both a *search key* and
a *priority*. Treaps have the invariant that the inorder sequence of search
keys (left -> root -> right traversal order) is sorted. Additionally, the
priority of each node must be smaller than the priorities of its children. As
the name implies, this data structures mixes properties of a tree (the inorder
traversal invariant) and a min-heap (the parent to child priority invariant).

### Adding data

To insert a new node, we start by using the regular BST algorithm to insert the
node in sorted order according to its search key. At this point, the BST property is satisfied, but not
necessarily the heap-priority order property.

Thus, we may need to perform a rotation if the new node's priority is smaller
than its parent. We perform a rotation that will decrease the depth of the new
node, and increase the depth of its parent (see diagram on page 3 of this
week's reading).

Performance: at most, we will need to take O(depth) time to traverse down the
treap to the location of new data, then at most O(depth) time to rotate the new
node into the correct position.

Performance of deletion, split and join operations are analyzed similarly; like
BSTs, performance depends on how well the treap is balanced.

## Randomized Treaps

If we have a case where we don't actually need the priorities of the treap, we
can implement a BST with randomized priorities and use the treap structure to
keep the BST balanced.

How this works: whenever we insert a new node into the treap, we generate a new
random number. The random numbers should be independent and uniformly
distributed. In practice, this looks like choosing random integers from a large
range and breaking ties arbitrarily. To make analysis cleaner, we'll say our
random numbers are random real numbers between 0 and 1.

To find the performance of search, insert, delete, split, and join operations we
need to find the expected depth of an arbitrary node in the treap constructed
using this strategy.

### Analysis

Let $x_k$ denote the node with the $k$th smallest search key. We will write $i
\uparrow k$ to mean that $x_i$ is an ancestor of $x_k$. We can write the depth
of a vertex in terms of its number of ancestors, since we're working in a tree,
as

```math
depth(x_k) = \sum_{i=1}^n [i \uparrow k]
```

where we're using bracket notation to represent an indicator variable.

Now we can express the expected depth of a node as

```math
E[depth(x_k)] = \sum_{i=1}^n E[[i \uparrow k]] = \sum_{i=1}^n \Pr( i \uparrow k )
```

which allows us to compute the expected depth of nodes in our randomized treap
if we can figure out the probability that some node is the direct ancestor of
another node.

To prove this, we need to prove a small lemma first.

Let $X(i,k)$ be the subset of treap nodes ${x_i, x_{i+1}, \ldots, x_k}$ if
$i < k$, or the subset ${x_k, x_{k+1}, \ldots, x_i}$ if $k < i$.

**Lemma 1:** For all $i \neq k$, we have $i \uparrow k$ if and only if $x_i$ has
the smallest priority among all nodes in $X(i,k)$.

**Proof:** There are four cases to consider.

Case 1: If $x_i$ is the root node, then $i \uparrow k$ and by definition it has the
smallest priority out of all nodes in the treap. Thus, $x_i$ must have the
smallest priority in $X(i,k)$.

Case 2: If $x_k$ is the root, then we cannot have $i \uparrow k$, and by
definition $x_k$ has the smallest priority in $X(i,k)$.

Case 3: Suppose some other node $x_j$ is the root node. If $x_i$ and $x_k$ are
in different subtrees, then neither can be the ancestor of the other, and $x_j$
has the smallest priority in $X(i,k)$.

Case 4: Suppose some other node $x_j$ is the root node. If $x_i$ and $x_k$ are
in the same subtree, then this lemma follows from an inductive hypothesis, since
the subtree is a smaller treap! The empty treap is the base case.

Thus concludes the proof of our Lemma 1.

The final key insight to get the expected depth of an abitrary node in a
randomized treap is to realize that every node in $X(i,k)$ is equally likely to
have the smallest priority, since we choose priorities uniformly at random.

Thus, we can write down our probability as

```math
\Pr(i \uparrow k) = \frac{[i \neq k]}{|k-i| + 1} = \begin{cases}
\frac{1}{k-i+1} & \text{if $i < k$} \\
0 & \text{if $i = k$} \\
\frac{1}{i-k+1} & \text{if $i > k$} \\
\end{cases}
```

and we can plug this into our summation to find the expected depth as

```math
E[depth(x_k)] = \sum_{i=1}^n \Pr( i \uparrow k )
```
