---
layout: default
parent: Modules
title: 'nx: NumeriX'
has_children: true
permalink: /modules/nx
---

# NumeriX Module ('import nx')
{: .no_toc }

Submodules:
  * [`nx.rand`: Random Generation](/modules/nx/rand)
  * [`nx.la`: Linear Algebra](/modules/nx/la)
  * [`nx.fft`: Fast Fourier Transform (FFT)](/modules/nx/fft)

Main module:

  * TOC
{:toc}

The NumeriX module (`nx`) provides tensor operations, linear algebra, and other math related functionality.



## `nx.array(obj, dtype=nx.double)`: Multi-dimensional array {#array}

This type represents a multi-dimensional array (sometimes used as a tensor), which has elements and an associated datatype (of type [`nx.dtype`](#dtype)). Operations on this type typically act as vectorized operations -- which means applying the operation to every element, in one batch job. This means that the code can be more efficient internally, whereas if you write a for-loop to manually perform the operation, it may be 100 or 1000 times slower!


Examples:

```ks
>>> nx.array(range(5))
[0.0, 1.0, 2.0, 3.0, 4.0]
>>> _ + 100     # Creates new array with '100' added to each element
[100.0, 101.0, 102.0, 103.0, 104.0]
>>> -_          # Creates new array with negative elements
[-100.0, -101.0, -102.0, -103.0, -104.0]
>>> nx.array([  # Creates a 2D array with the given elements
...   [1, 2],
...   [3, 4],
... ])
[[1.0, 2.0],
 [3.0, 4.0]]
```

---




## `nx.add(x, y, r=none)`: Elementwise-addition {#array}

This type represents a multi-dimensional array (sometimes used as a tensor), which has elements and an associated datatype (of type [`nx.dtype`](#dtype)). Operations on this type typically act as vectorized operations -- which means applying the operation to every element, in one batch job. This means that the code can be more efficient internally, whereas if you write a for-loop to manually perform the operation, it may be 100 or 1000 times slower!


Examples:

```ks
>>> nx.array(range(5))
[0.0, 1.0, 2.0, 3.0, 4.0]
>>> _ + 100     # Creates new array with '100' added to each element
[100.0, 101.0, 102.0, 103.0, 104.0]
>>> -_          # Creates new array with negative elements
[-100.0, -101.0, -102.0, -103.0, -104.0]
>>> nx.array([  # Creates a 2D array with the given elements
...   [1, 2],
...   [3, 4],
... ])
[[1.0, 2.0],
 [3.0, 4.0]]
```

---




