---
layout: default
parent: Modules
title: 'nx: NumeriX'
has_children: true
permalink: /modules/nx
nav_order: 50
---

# NumeriX Module ('import nx')
{: .no_toc }


The NumeriX module (`nx`) provides tensor operations, linear algebra, and other math related functionality.

Submodules:
  * [`nx.rand`: Random Generation](/modules/nx/rand)
  * [`nx.la`: Linear Algebra](/modules/nx/la)
  * [`nx.fft`: Fast Fourier Transform (FFT)](/modules/nx/fft)

---

This module:

  * TOC
{:toc}

---

## Datatypes {#datatypes}

#### `nx.float` - 32 bit float {#float}
#### `nx.F`
#### `nx.fp32`

This type represents a 32 bit floating point value, commonly `float` in C.


Properties:

```ks
>>> nx.float.EPS


```


---

## `nx.array(obj, dtype=nx.double)`: Multi-dimensional array {#array}

This type represents a multi-dimensional array (sometimes used as a tensor), which has elements and an associated datatype (of type [`nx.dtype`](#dtype)). Operations on this type typically act as vectorized operations -- which means applying the operation to every element, in one batch job. This means that the code can be more efficient internally, whereas if you write a for-loop to manually perform the operation, it may be 100 or 1000 times slower!

It (approximately) follows the [`number`](/builtins#number) [pattern](/more/patterns) for rank-0 arrays, but allows for multi-dimensional inputs to be computed at the same time.

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


#### nx.array.data {#array.data}
{: .method .no_toc }

<div class="method-text" markdown="1">
This attribute retrieves the pointer to the first element of the array (and the point which offsets are calculated). The result is a non-negative [`int`](/builtins#int) describing the address of the array.


For example:

```ks
>>> nx.array(1).data
93975771879584
```
</div>

#### nx.array.dtype {#array.dtype}
{: .method .no_toc }

<div class="method-text" markdown="1">
This attribute retrieves the [datatype](#dtype) of the array, which is the type of each element.

For example:

```ks
>>> nx.array(1).dtype
double
>>> nx.array([1, 2, 3, 4, 5]).dtype
double
>>> nx.array([[1, 2, 3, 4, 5], [6, 7, 8, 9, 10]], nx.s16).shape
s16
```
</div>


#### nx.array.rank {#array.rank}
{: .method .no_toc }

<div class="method-text" markdown="1">
This attribute retrieves the rank of the array, which is the number of dimensions of the array

For example:

```ks
>>> nx.array(1).rank
1
>>> nx.array([1, 2, 3, 4, 5]).rank
1
>>> nx.array([[1, 2, 3, 4, 5], [6, 7, 8, 9, 10]]).rank
2

```
</div>


#### nx.array.shape {#array.shape}
{: .method .no_toc }

<div class="method-text" markdown="1">
This attribute retrieves the shape, which is a [`tuple`](/builtins#tuple) of the size in each dimension, as [`int`](/builtins#int)s.

For example:

```ks
>>> nx.array(1).shape
(,)
>>> nx.array([1, 2, 3, 4, 5]).shape
(5,)
>>> nx.array([[1, 2, 3, 4, 5], [6, 7, 8, 9, 10]]).shape
(2, 5)
```
</div>


#### nx.array.strides {#array.strides}
{: .method .no_toc }

<div class="method-text" markdown="1">
This attribute retrieves the strides, which is a [`tuple`](/builtins#tuple) of the distance between each element in each dimension, as [`int`](/builtins#int)s.

This attribute will be datatype- and platform- specific, as different types may have different alignments and sizes on different platforms. For dense arrays, everything is stored in row-major order, so the strides will be largest-first and smallest-last

For example:

```ks
>>> nx.array(1).strides
(,)
>>> nx.array([1, 2, 3, 4, 5]).strides
(5,)
>>> nx.array([[1, 2, 3, 4, 5], [6, 7, 8, 9, 10]]).shape
(2, 5)
```
</div>


---

## `nx.dtype`: Datatype {#dtype}

This type represents a datatype, which arrays can hold elements of. Typically, these correspond to types in the C library, or hardware types for a specific platform. You can see a list of the builtin data types [here](#datatypes)

Datatypes can represent sized-integer values, floating point values, complex floating point values, or structures of other [`dtype`](#dtype)s. Most mathematical operations are only supported on the builtin numeric datayptes (which includes integer, float, and complex datatypes), which support by platform may vary


Some datatypes available are:

  * [`fp16`/`half`/`H`](#fp16): Single precision IEEE floating point
  * [`fp32`/`float`/`S`](#fp32): Single precision IEEE floating point
  * [`fp64`/`double`/`D`](#fp64): Double precision IEEE floating point
  * [`fp128`/`quad`/`Q`](#fp128): Quad precision IEEE floating point
  * [`fp80`/`long double`/`L`](#longdouble): C's


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




