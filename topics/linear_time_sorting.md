# Linear time sorting

## Wait a minute...

We can show that comparison-based sorting algorithms have a fundamental lower
bound of $\Omega(n \log n)$.

Proof: Consider a *decision tree* representation of a sorting algorithm, where
each node represents a comparision of two elements.

For example, for insertion sort, the initial comparison is made between the
first and second element. Depending on the outcome of the comparison, the
elements will either be swapped or not; either way, the algorithm will then
proceed to comparing another pair of elements. The decision tree for insertion
sort then looks like a binary tree.

Assuming all elements in the array to be sorted are unique, each path from root
to leaf in the decision tree represents the process of sorting a unique
permutation of the elements.
  
