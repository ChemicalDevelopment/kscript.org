---
layout: default
parent: 'nx: NumeriX'
grand_parent: Modules
title: 'nx.la: Linear Algebra'
permalink: /modules/nx/la
---

# NumeriX Linear Algebra Module ('import nx.la')
{: .no_toc }

 * TOC
{:toc}

This module is a submodule of the [`nx`](/modules/nx) module. Specifically, it provides access to dense linear algebra functionality


## `nx.la.norm(x, r=none)`: Matrix norm {#norm}

Calculates the Frobenius norm of `x` (which should be at least 2D), which is equivalent to `nx.sqrt(nx.sum(nx.abs(x) ** 2, (-2, -1)))`.

---

## `nx.la.diag(x, r=none)`: Make diagonal matrix {#diag}

Creates a matrix with `x` as the diagonal. If `x.rank > 1`, then it is assumed to be a stack of diagonals, and this function returns a stack of matrices


Examples:

```ks
>>> nx.la.diag([1, 2, 3])
[[1.0, 0.0, 0.0],
 [0.0, 2.0, 0.0],
 [0.0, 0.0, 3.0]]
>>> nx.la.diag([[1, 2, 3], [4, 5, 6]])
[[[1.0, 0.0, 0.0],
  [0.0, 2.0, 0.0],
  [0.0, 0.0, 3.0]],
 [[4.0, 0.0, 0.0],
  [0.0, 5.0, 0.0],
  [0.0, 0.0, 6.0]]]
```

---

## `nx.la.perm(x, r=none)`: Make permutation matrix {#perm}

Creates a permutation matrix with `x` as the row interchanges. If `x.rank > 1`, then it is assumed to be a stack of row interfchanges, and this function returns a stack of matrices

Equivalent to `nx.onehot(x, x.shape[-1])`


Examples:

```ks
>>> nx.la.perm([0, 1, 2])
[[1.0, 0.0, 0.0],
 [0.0, 1.0, 0.0],
 [0.0, 0.0, 1.0]]
>>> nx.la.perm([1, 2, 0])
[[0.0, 1.0, 0.0],
 [0.0, 0.0, 1.0],
 [1.0, 0.0, 0.0]]
```

---

## `nx.la.matmul(x, y, r=none)`: Matrix multiplication {#matmul}

Calculates the matrix product `x @ y`. If `r` is none, then a result is allocated, otherwise it must be the correct shape, and the result will be stored in that.

Expects matrices to be of shape:

  * `x`: `(..., M, N)`
  * `y`: `(..., N, K)`
  * `r`: `(..., M, K)` (or `r==none`, it will be allocated)


Examples:

```ks
>>> nx.la.matmul([[1, 2], [3, 4]], [[5, 6], [7, 8]])
[[19.0, 22.0],
 [43.0, 50.0]]
```

---

## `nx.la.factlu(x, p=none, l=none, u=none)`: LU factorization {#factlu}

Factors `x` according to [LU decomposition with partial pivoting](https://en.wikipedia.org/wiki/LU_decomposition), and returns a tuple of `(p, l, u)` such that `x == nx.la.perm(p) @ l @ u` (within numerical accuracy), and `p` gives the row-interchanges required, `l` is lower triangular, and `u` is upper triangular. If `p`, `l`, or `u` is given, it is used as the destination, otherwise a new result is allocated.

Expects matrices to be of shape:

  * `x`: `(..., N, N)`
  * `p`: `(..., N)` (or if `p==none`, it will be allocated)
  * `l`: `(..., N, N)` (or if `l==none`, it will be allocated)
  * `u`: `(..., N, N)` (or if `u==none`, it will be allocated)


Examples:

```ks
>>> (p, l, u) = nx.la.factlu([[1, 2], [3, 4]])
([1, 0], [[1.0, 0.0],
 [0.333333333333333, 1.0]], [[3.0, 4.0],
 [0.0, 0.666666666666667]])
>>> nx.la.perm(p) @ l @ u
[[1.0, 2.0],
 [3.0, 4.0]]
```

---



