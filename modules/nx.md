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

# Concepts

## Rank {#rank}

The rank of an array/tensor is the number of dimensions it uses. For example, a matrix would be considered 2D (2 dimensional), so it would have a rank of 2. A scalar (i.e. single number) is said to have a rank of `0`. Tensors in the [`nx`](/modules/nx) module may be of rank from `0` to [`nx.MAXRANK`](#MAXRANK) (inclusive).

Some examples:

  * `rank==0`: Scalar, number
  * `rank==1`: Vector, list, pencil
  * `rank==2`: Matrix, 2D Image, panel
  * `rank==3`: Image with color channels, brick

You can retrieve an [`nx.array`](#array)'s rank with the attribute [`.rank`](#array.rank)

## Axes {#axes}

This is an axe: 

<img alt="Another kind of axe" src="/assets/images/axe-prank.jpeg" width="200" height="200" />

These are axes: 

<img alt="Real axes" src="/assets/images/axes-real.gif" width="200" height="200" />

Arrays in NumeriX have a [rank](#rank), which is the number of dimensions/axes that an array has. This section is about what it meants to operate upon an axis, or to transpose axes.

TODO: Explain this....


## Shape {#shape}

The shape of an array/tensor is the size in each dimension (in number of elements). For example, a matrix would be considered 2D (2 dimensional), so it would have a rank of 2 and a shape of the form `(M, N)`. A scalar (i.e. single number) is said to have a rank of `0`, and so the shape is an empty [`tuple`](/builtins#tuple): `(,)`.

You can retrieve an [`nx.array`](#array)'s shape with the attribute [`.shape`](#array.shape)


## Strides {#strides}

The strides of an array/tensor are the distances in each dimension (in number of bytes). A stride of `0` means that a single value is copied across the entire dimension. 

A dense array has dense strides, which follow the pattern:

```
arr.shape[arr.rank-1] = arr.dtype.size
...
arr.shape[i-1] = arr.shape[i] * arr.shape[i]
```


You can retrieve an [`nx.array`](#array)'s strides with the attribute [`.strides`](#array.strides)


## Broadcasting {#broadcasting}

Tensor broadcasting, also just called broadcasting, is a process of artificially expanding the shape of tensors so that they can be processed with tensors of other shapes. Most operations (e.g. [`nx.add`](#add), [`nx.sub`](#sub), and so forth) support broadcasting. A simple example is multiplying a 1D array by a scalar (a 0D array). The resulting array has every element in the 1D array muliplied by the scalar.

To broadcast two arrays, say `A` and `B`, the following rules are taken:

  * All input arrays have their shape extended to the left with `1`, up to the maximum rank of any input.
  * Now, iterate over every axis in all the padded inputs. If all sizes in that axis are either `1` or one other numbers, then that axis is broadcasted by repeating the inputs with size `1` to size `n` (which is the other number), and inputs of size `n` are not changed
  * Now, the shapes are the same for all inputs. If any of the stages fails, then the inputs are not broadcastable.

Let's see a basic example:

If we have `A.rank = 3, A.shape = (100, 200, 3)` (a 2D image with color channel) and `B.rank = 0, B.shape = (,)` (a scalar), and we try to add them, the shapes are lined up:

```
A 100, 200,  3
B   1,   1,  1
```

Now, we see that they agree everywhere (i.e. are either `1` or one other number per axis). The broadcasted `B` will have strides of `0`, since it should be repeated across the entire input.

If you were to give `A.rank = 3, A.shape = (100, 200, 3)`, but `B.rank = 1, B.shape = 3`, then it would also broadcast, but `B` would only be broadcast among the `0` and `1` axes, since it fills the `2` axis.


## Coercion {#coercion}

Type coercion, also just called coercion, are the rules by which types of expressions are determined. Most operations (e.g. [`nx.add`](#add), [`nx.sub`](#sub)), if not given a specific result argument, will allocate the result and return it. The datatype of the resulting array is determined using this coercion. Specifically, say you add an array of type [`nx.double`](#double) and [`nx.s32`](#s32). The result will be a `nx.double`, since it is higher in the coercion rules. Here are the precedences for coercion (higher overrides):

  * [`nx.bool`](#bool)
  * Unsigned integers ([`nx.u8`](#u8), ..., [`nx.u64`](#u64))
  * Signed integers ([`nx.s8`](#s8), ..., [`nx.s64`](#s64))
  * Floating points ([`nx.float`](#float), ..., [`nx.quad`](#quad))
  * Complex foating points ([`nx.complexfloat`](#complexfloat), ..., [`nx.complexquad`](#complexquad))


Some rules have different results, for example [`nx.abs`](#abs) converts complex arguments into the corresponding float datatype.



# Constants {#constants}

## `nx.MAXRANK` - Maximum rank {#MAXRANK}

This represents the maximum [rank](#rank) that an array can be.

```ks
>>> nx.MAXRANK
32
```


# Default Datatypes {#datatypes}

## `nx.float` - 32 bit float {#float}
## `nx.F` {#F}
{: .no_toc }
## `nx.float32` {#float32}
{: .no_toc }

This type represents a 32 bit floating point value, commonly `float` in C.


Properties:


#### nx.float.MIN {#float.MIN}
{: .method .no_toc }

<div class="method-text" markdown="1">
The minimum positive value representable by this datatype.

Example:

```ks
>>> nx.float.MIN
1.175494e-38
```
</div>


#### nx.float.MAX {#float.MAX}
{: .method .no_toc }

<div class="method-text" markdown="1">
The maximum finite value representable by this datatype.

Example:

```ks
>>> nx.float.MAX
3.402823e+38
```
</div>


#### nx.float.EPS {#float.EPS}
{: .method .no_toc }

<div class="method-text" markdown="1">
The difference between 1.0 and the next largest number

Example:

```ks
>>> nx.float.EPS
1.192093e-07
```
</div>


#### nx.float.DIG {#float.DIG}
{: .method .no_toc }

<div class="method-text" markdown="1">
An integer describing the number of digits being able to be represented exactly by this datatype
Example:

```ks
>>> nx.float.DIG
6
```
</div>

---

## `nx.double` - 64 bit float {#double}
## `nx.D` {#D}
{: .no_toc }
## `nx.float64` {#float64}
{: .no_toc }

This type represents a 64 bit floating point value, commonly `double` in C.


Properties:


#### nx.double.MIN {#double.MIN}
{: .method .no_toc }

<div class="method-text" markdown="1">
The minimum positive value representable by this datatype.

Example:

```ks
>>> nx.double.MIN
2.225073858507201e-308
```
</div>


#### nx.double.MAX {#double.MAX}
{: .method .no_toc }

<div class="method-text" markdown="1">
The maximum finite value representable by this datatype.

Example:

```ks
>>> nx.double.MAX
1.797693134862316e+308
```
</div>


#### nx.double.EPS {#double.EPS}
{: .method .no_toc }

<div class="method-text" markdown="1">
The difference between 1.0 and the next largest number

Example:

```ks
>>> nx.double.EPS
2.220446049250313e-16
```
</div>


#### nx.double.DIG {#double.DIG}
{: .method .no_toc }

<div class="method-text" markdown="1">
An integer describing the number of digits being able to be represented exactly by this datatype
Example:

```ks
>>> nx.double.DIG
15
```
</div>

---

## `nx.longdouble` - extended float {#longdouble}
## `nx.L` {#L}
{: .no_toc }

This type represents an extended floating point value, commonly `long double` in C.


Properties:


#### nx.longdouble.MIN {#longdouble.MIN}
{: .method .no_toc }

<div class="method-text" markdown="1">
The minimum positive value representable by this datatype.

Example:

```ks
>>> nx.longdouble.MIN
3.362103143112093506e-4932
```
</div>


#### nx.longdouble.MAX {#longdouble.MAX}
{: .method .no_toc }

<div class="method-text" markdown="1">
The maximum finite value representable by this datatype.

Example:

```ks
>>> nx.longdouble.MAX
1.189731495357231765e+4932
```
</div>


#### nx.longdouble.EPS {#longdouble.EPS}
{: .method .no_toc }

<div class="method-text" markdown="1">
The difference between 1.0 and the next largest number

Example:

```ks
>>> nx.longdouble.EPS
1.084202172485504434e-19
```
</div>


#### nx.longdouble.DIG {#longdouble.DIG}
{: .method .no_toc }

<div class="method-text" markdown="1">
An integer describing the number of digits being able to be represented exactly by this datatype
Example:

```ks
>>> nx.longdouble.DIG
18
```
</div>

---

## `nx.quad` - 128 bit float {#quad}
## `nx.Q` {#Q}
{: .no_toc }
## `nx.float128` {#float128}
{: .no_toc }

This type represents a 128 bit floating point value, commonly `__float128` in C.


Properties:


#### nx.quad.MIN {#quad.MIN}
{: .method .no_toc }

<div class="method-text" markdown="1">
The minimum positive value representable by this datatype.

Example:

```ks
>>> nx.quad.MIN
3.362103143112093506262677817321753e-4932
```
</div>


#### nx.quad.MAX {#quad.MAX}
{: .method .no_toc }

<div class="method-text" markdown="1">
The maximum finite value representable by this datatype.

Example:

```ks
>>> nx.quad.MAX
1.189731495357231765085759326628007e+4932
```
</div>


#### nx.quad.EPS {#quad.EPS}
{: .method .no_toc }

<div class="method-text" markdown="1">
The difference between 1.0 and the next largest number

Example:

```ks
>>> nx.quad.EPS
1.925929944387235853055977942584927e-34
```
</div>


#### nx.quad.DIG {#quad.DIG}
{: .method .no_toc }

<div class="method-text" markdown="1">
An integer describing the number of digits being able to be represented exactly by this datatype
Example:

```ks
>>> nx.quad.DIG
33
```
</div>


## `nx.complexfloat` - complex 32 bit float {#complexfloat}
## `nx.cF` {#cF}
{: .no_toc }
## `nx.complexfloat32` {#complexfloat32}
{: .no_toc }

This type represents a complex 32 bit floating point value, commonly `complex float` in C.


Properties:

---

## `nx.complexdouble` - complex 64 bit float {#complexdouble}
## `nx.cD` {#cD}
{: .no_toc }
## `nx.complexfloat64` {#complexfloat64}
{: .no_toc }

This type represents a complex 64 bit floating point value, commonly `complex double` in C.


Properties:

---

## `nx.complexlongdouble` - complex extended float {#complexlongdouble}
## `nx.cL` {#cL}
{: .no_toc }

This type represents a complex extended floating point value, commonly `complex long double` in C.

Properties:



---

## `nx.complexquad` - complex 128 bit float {#complexquad}
## `nx.cQ` {#cQ}
{: .no_toc }
## `nx.complexfloat128` {#complexfloat128}
{: .no_toc }

This type represents a complex 128 bit floating point value, commonly `complex __float128` in C.


Properties:


---


# Types


## `nx.dtype`: Datatype {#dtype}

This type represents a datatype, which arrays can hold elements of. Typically, these correspond to types in the C library, or hardware types for a specific platform. You can see a list of the builtin data types [here](#datatypes)

Datatypes can represent sized-integer values, floating point values, complex floating point values, or structures of other [`dtype`](#dtype)s. Most mathematical operations are only supported on the builtin numeric datayptes (which includes integer, float, and complex datatypes), which support by platform may vary


Some datatypes available are:

  * [`nx.float`](#float): Single precision IEEE floating point
  * [`nx.double`](#double): Double precision IEEE floating point
  * [`nx.quad`](#quad): Quadruple precision IEEE floating point
  * [`nx.longdouble`](#longdouble): C's


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
nx.double
>>> nx.array([1, 2, 3, 4, 5]).dtype
nx.double
>>> nx.array([[1, 2, 3, 4, 5], [6, 7, 8, 9, 10]], nx.s16).dtype
nx.s16
```
</div>


#### nx.array.rank {#array.rank}
{: .method .no_toc }

<div class="method-text" markdown="1">
This attribute retrieves the [rank](#rank) of the array, which is the number of dimensions of the array

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
This attribute retrieves the [shape](#shape), which is a [`tuple`](/builtins#tuple) of the size in each dimension, as [`int`](/builtins#int)s.

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
This attribute retrieves the [strides](#strides), which is a [`tuple`](/builtins#tuple) of the distance between each element in each dimension, as [`int`](/builtins#int)s.

This attribute will be datatype- and platform- specific, as different types may have different alignments and sizes on different platforms. For dense arrays, everything is stored in row-major order, so the strides will be largest-first and smallest-last

For example:

```ks
>>> nx.array(1).strides
(,)
>>> nx.array([1, 2, 3, 4, 5]).strides
(8,)
>>> nx.array([[1, 2, 3, 4, 5], [6, 7, 8, 9, 10]]).strudes
(40, 8)
```
</div>

#### nx.array.T {#array.T}
{: .method .no_toc }

<div class="method-text" markdown="1">
This attributes returns a view of the tranpose of the object. Here are the cases:

  * If `self.rank == 0`, then a view of `self` is returned
  * If `self.rank == 1`, then it is treated like a row-vector, and a column vector of shape `[N, 1]` is returned
  * Otherwise, the last two axes are swapped

For example:

```ks
>>> nx.array(1).T
1.0
>>> nx.array([1, 2, 3, 4, 5]).T
[[1.0],
 [2.0],
 [3.0],
 [4.0],
 [5.0]]
>>> nx.array([[1, 2, 3, 4, 5], [6, 7, 8, 9, 10]]).T
[[1.0, 6.0],
 [2.0, 7.0],
 [3.0, 8.0],
 [4.0, 9.0],
 [5.0, 10.0]]
```
</div>


---

# Reduction Functions {#reduction-functions}

## `nx.min(x, axes=none, r=none)`: Minimum along axes {#min}

Determines the minimum element in `x` among `axes` (default: all axes, see more: [axes](#axes)), and either returns a new [`nx.array`](#array) (if `r == none`), or stores the result in `r`, if it is not `none`.

If `axes` is not none, it may either be an integral value telling the index of the axis (negatives allowed), or an iterable of axes to reduce on.


For example, `nx.min(x, -1)` returns an `x.rank - 1` rank tensor, with the minimum of a pencil of last dimension as the corresponding value.

Examples:

```ks
>>> nx.min(nx.array(range(5)))
0.0
>>> nx.min([[1, 2], [3, 4]], 0)
[1, 2]
>>> nx.min([[1, 2], [3, 4]], 1)
[1, 3]
```

---


## `nx.max(x, axes=none, r=none)`: Maximum along axes {#max}

Determines the maximum element in `x` among `axes` (default: all axes, see more: [axes](#axes)), and either returns a new [`nx.array`](#array) (if `r == none`), or stores the result in `r`, if it is not `none`.

If `axes` is not none, it may either be an integral value telling the index of the axis (negatives allowed), or an iterable of axes to reduce on.


For example, `nx.min(x, -1)` returns an `x.rank - 1` rank tensor, with the maximum of a pencil of last dimension as the corresponding value.

Examples:

```ks
>>> nx.min(nx.array(range(5)))
4.0
>>> nx.max([[1, 2], [3, 4]], 0)
[3, 4]
>>> nx.max([[1, 2], [3, 4]], 1)
[2, 4]
```

---


## `nx.sum(x, axes=none, r=none)`: Sum along axes {#sum}

Determines the sum of `x` among `axes` (default: all axes, see more: [axes](#axes)), and either returns a new [`nx.array`](#array) (if `r == none`), or stores the result in `r`, if it is not `none`.

If `axes` is not none, it may either be an integral value telling the index of the axis (negatives allowed), or an iterable of axes to reduce on.


For example, `nx.sum(x, -1)` returns an `x.rank - 1` rank tensor, with the sum of a pencil of last dimension as the corresponding value.

Examples:

```ks
>>> nx.sum(nx.array(range(5)))
10.0
>>> nx.sum([[1, 2], [3, 4]], 0)
[4.0, 6.0]
>>> nx.sum([[1, 2], [3, 4]], 1)
[3.0, 7.0]
```

---



## `nx.prod(x, axes=none, r=none)`: Product along axes {#prod}

Determines the product of `x` among `axes` (default: all axes, see more: [axes](#axes)), and either returns a new [`nx.array`](#array) (if `r == none`), or stores the result in `r`, if it is not `none`.

If `axes` is not none, it may either be an integral value telling the index of the axis (negatives allowed), or an iterable of axes to reduce on.


For example, `nx.prod(x, -1)` returns an `x.rank - 1` rank tensor, with the product of a pencil of last dimension as the corresponding value.

Examples:

```ks
>>> nx.prod(nx.array(range(1, 5)))
24.0
>>> nx.prod([[1, 2], [3, 4]], 0)
[3.0, 8.0]
>>> nx.prod([[1, 2], [3, 4]], 1)
[2.0, 12.0]
```

---


# Elementwise Functions {#elementwise-functions}

## `nx.cast(x, dtype)`: Elementwise cast {#cast}

Calculates the value `x`, casted to dtype `dtype`, elementwise, and returns a new [`nx.array`](#array)

For complex-to-real conversions, the imaginary component is ignored

Examples:

```ks
>>> nx.cast([-2, -1, 0, 1, 2], nx.s8)
[-2, -1, 0, 1, 2]
```

SEE: [`nx.fpcast`](#fpcast)

---

## `nx.fpcast(x, dtype)`: Elementwise fixedpoint/floatingpoint cast {#fpcast}

Calculates the value `x`, casted to dtype `dtype`, with floating-to-fixed point (or vice-versa) conversion caried out, elementwise, and returns a new [`nx.array`](#array)

Here are the rules for conversions:

  * If `x.dtype` is an integral datatype and so is `dtype`, then it is the same as `nx.cast(x, dtype)`
  * If `x.dtype` is a floating point (including complex) datatype and so is `dtype`, then it is the same as `nx.cast(x, dtype)`
  * If `x.dtype` is an integral datatype, but `dtype` is a floating point, then `x` is treated as fixed point number, and it is converted to `dtype` with a resulting range of either `range(0, dtype.MAX)` (if `x` is unsigned), or `range(-dtype.MAX, dtype.MAX)` (if `x` is signed)
  * If `x.dtype` is a floating point, but `dtype` is an integral datatype, then this function is an inverse of the last description.
  


For complex-to-real conversions, the imaginary component is ignored

Examples:

```ks
>>> nx.fpcast([0, 0.25, 0.5, 0.75, 1.0], nx.u8)
[0, 63, 127, 191, 255]
>>> nx.fpcast([-1.0, -0.75, -0.5, -0.25, 0, 0.25, 0.5, 0.75, 1.0], nx.s8)
[-127, -95, -63, -31, 0, 31, 63, 95, 127]
```

---


## `nx.abs(x, r=none)`: Elementwise-absolute-value {#abs}

Calculates the absolute value of `x`, elementwise, and either returns a new [`nx.array`](#array) (if `r == none`), or stores the result in `r`, if it is not `none`.

For complex `x`, the result will be real-valued

Examples:

```ks
>>> nx.abs([-2, -1, 0, 1, 2])
[2.0, 1.0, 0.0, 1.0, 2.0]
```
---

## `nx.neg(x, r=none)`: Elementwise-negative {#neg}

Calculates the negative of `x`, elementwise, and either returns a new [`nx.array`](#array) (if `r == none`), or stores the result in `r`, if it is not `none`.

Examples:

```ks
>>> nx.neg([-2, -1, 0, 1, 2])
[2.0, 1.0, 0.0, -1.0, -2.0]
```

---

## `nx.conj(x, r=none)`: Elementwise-conjugation {#conj}

Calculates the [conjugate](https://en.wikipedia.org/wiki/Complex_conjugate) of `x`, elementwise, and either returns a new [`nx.array`](#array) (if `r == none`), or stores the result in `r`, if it is not `none`.

For real `x`, this function does nothing.

Examples:

```ks
>>> nx.conj(nx.complexdouble([0, 1, 2+3i, 4-5i]))
[0.0+0.0i, 1.0+0.0i, 2.0-3.0i, 4.0+5.0i]
```

---
## `nx.add(x, y, r=none)`: Elementwise-addition {#add}

Adds `x` and `y`, elementwise, with [broadcasting](#broadcasting) and [coercion](#coercion), and either returns a new [`nx.array`](#array) (if `r == none`), or stores the result in `r`, if it is not `none`.

Examples:

```ks
>>> nx.add(nx.array(range(5)), 100)
[100.0, 101.0, 102.0, 103.0, 104.0]
>>> nx.add([[1, 2], [3, 4]], [100, 200])
[[101.0, 202.0],
 [103.0, 204.0]]
```

---


## `nx.sub(x, y, r=none)`: Elementwise-subtraction {#sub}

Subtracts `x` and `y`, elementwise, with [broadcasting](#broadcasting) and [coercion](#coercion), and either returns a new [`nx.array`](#array) (if `r == none`), or stores the result in `r`, if it is not `none`.

Examples:

```ks
>>> nx.sub(nx.array(range(5)), 100)
[-100.0, -99.0, -98.0, -97.0, -96.0]
>>> nx.sub([[1, 2], [3, 4]], [100, 200])
[[-99.0, -198.0],
 [-97.0, -196.0]]
```

---


## `nx.mul(x, y, r=none)`: Elementwise-multiplication {#sub}

Multiplies `x` and `y`, elementwise, with [broadcasting](#broadcasting) and [coercion](#coercion), and either returns a new [`nx.array`](#array) (if `r == none`), or stores the result in `r`, if it is not `none`.

Examples:

```ks
>>> nx.mul(nx.array(range(5)), 100)
[0.0, 100.0, 200.0, 300.0, 400.0]
>>> nx.mul([[1, 2], [3, 4]], [100, 200])
[[100.0, 400.0],
 [300.0, 800.0]]
```

---


## `nx.div(x, y, r=none)`: Elementwise-division {#div}

Divides `x` and `y`, elementwise, with [broadcasting](#broadcasting) and [coercion](#coercion), and either returns a new [`nx.array`](#array) (if `r == none`), or stores the result in `r`, if it is not `none`.

This is a true division, and not a floored division. See [`nx.floordiv`](#floordiv) for floored division.

Examples:

```ks
>>> nx.div(nx.array(range(5)), 100)
[0.0, 0.01, 0.02, 0.03, 0.04]
>>> nx.div([[1, 2], [3, 4]], [100, 200])
[[0.01, 0.01],
 [0.03, 0.02]]
```

---

## `nx.floordiv(x, y, r=none)`: Elementwise-floored-division {#floordiv}

Divides `x` and `y`, elementwise, with [broadcasting](#broadcasting) and [coercion](#coercion), and either returns a new [`nx.array`](#array) (if `r == none`), or stores the result in `r`, if it is not `none`.

This is a floored division, and not a true division. See [`nx.div`](#div) for true division.

Examples:

```ks
>>> nx.floordiv(nx.array(range(5)), 100)
[0.0, 0.0, 0.0, 0.0, 0.0]
>>> nx.floordiv([[1, 2], [3, 4]], [100, 200])
[[0.0, 0.0],
 [0.0, 0.0]]
```

---


## `nx.mod(x, y, r=none)`: Elementwise-modulo {#mod}

Calculates `x` modulo `y`, elementwise, with [broadcasting](#broadcasting) and [coercion](#coercion), and either returns a new [`nx.array`](#array) (if `r == none`), or stores the result in `r`, if it is not `none`.

The result has the same sign as the corresponding element in `y`.

Examples:

```ks
>>> nx.mod(nx.array(range(5)), 3)
[0.0, 1.0, 2.0, 0.0, 1.0]
>>> nx.mod([[1, 2], [3, 4]], [2, 3])
[[1.0, 2.0],
 [1.0, 1.0]]
```

---

## `nx.pow(x, y, r=none)`: Elementwise-power {#pow}

Calculates `x` to the `y`th power, elementwise, with [broadcasting](#broadcasting) and [coercion](#coercion), and either returns a new [`nx.array`](#array) (if `r == none`), or stores the result in `r`, if it is not `none`.

`0 ** 0 == 1`

Examples:

```ks
>>> nx.pow(nx.array(range(5)), 3)
[0.0, 1.0, 8.0, 27.0, 64.0]
>>> nx.pow([[1, 2], [3, 4]], [2, 3])
[[1.0, 8.0],
 [9.0, 64.0]]
```
---

## `nx.sqrt(x, r=none)`: Elementwise square root {#sqrt}

Calculates the square root of `x`, elementwise, with [broadcasting](#broadcasting) and [coercion](#coercion), and either returns a new [`nx.array`](#array) (if `r == none`), or stores the result in `r`, if it is not `none`.

Examples:

```ks
>>> nx.sqrt(nx.array(range(5)))
[0.0, 1.0, 1.414213562373095, 1.732050807568877, 2.0]
```

---

## `nx.log(x, r=none)`: Elementwise logarithm {#log}

Calculates the natural logarithm of `x`, elementwise, with [broadcasting](#broadcasting) and [coercion](#coercion), and either returns a new [`nx.array`](#array) (if `r == none`), or stores the result in `r`, if it is not `none`.

Examples:

```ks
>>> nx.log(nx.array(range(5)))
[-inf, 0.0, 0.693147180559945, 1.09861228866811, 1.386294361119891]
```

---

## `nx.exp(x, r=none)`: Elementwise exponential {#exp}

Calculates the exponential function of `x`, elementwise, with [broadcasting](#broadcasting) and [coercion](#coercion), and either returns a new [`nx.array`](#array) (if `r == none`), or stores the result in `r`, if it is not `none`.

Examples:

```ks
>>> nx.exp(nx.array(range(5)))
[1.0, 2.718281828459045, 7.38905609893065, 20.085536923187668, 54.598150033144236]
```

---


# Pencil-wise Functions {#pencilwise-functions}

## `nx.sort(x, axis=-1, r=none)`: Sorting {#sort}

Sorts `x` among `axis` (default: last axis, see more: [axes](#axes)), and either returns a new [`nx.array`](#array) (if `r == none`), or stores the result in `r`, if it is not `none`.

If `axis` is not none, it should be an integral value telling the index of the axis (negatives allowed)

For example, `nx.cumsum(x, -1)` returns an `x.rank` rank tensor, with the cumulative sum of a pencil of last dimension as the corresponding value.

Examples:

```ks
>>> nx.sort([0, 10, 5, 20, 15])
[0.0, 5.0, 10.0, 15.0, 20.0]
```

---

## `nx.cumsum(x, axis=-1, r=none)`: Cumulative sum {#cumsum}

Determines the sum of `x` among `axis` (default: last axis, see more: [axes](#axes)), and either returns a new [`nx.array`](#array) (if `r == none`), or stores the result in `r`, if it is not `none`.

If `axis` is not none, it should be an integral value telling the index of the axis (negatives allowed)

For example, `nx.cumsum(x, -1)` returns an `x.rank` rank tensor, with the cumulative sum of a pencil of last dimension as the corresponding value.

Examples:

```ks
>>> nx.cumsum(nx.array(range(5)))
[0.0, 1.0, 3.0, 6.0, 10.0]
>>> nx.cumsum([[1, 2], [3, 4]], 0)
[[1.0, 2.0],
 [4.0, 6.0]]
>>> nx.cumsum([[1, 2], [3, 4]], 1)
[[1.0, 3.0],
 [4.0, 10.0]]
```

---


## `nx.cumprod(x, axis=-1, r=none)`: Cumulative product {#cumprod}

Determines the product of `x` among `axis` (default: last axis, see more: [axes](#axes)), and either returns a new [`nx.array`](#array) (if `r == none`), or stores the result in `r`, if it is not `none`.

If `axis` is not none, it should be an integral value telling the index of the axis (negatives allowed)

For example, `nx.cumsum(x, -1)` returns an `x.rank` rank tensor, with the cumulative product of a pencil of last dimension as the corresponding value.

Examples:

```ks
>>> nx.cumprod(nx.array(range(1, 5)))
[1.0, 2.0, 6.0, 24.0]
>>> nx.cumprod([[1, 2], [3, 4]], 0)
[[1.0, 2.0],
 [3.0, 8.0]]
>>> nx.cumprod([[1, 2], [3, 4]], 1)
[[1.0, 2.0],
 [3.0, 12.0]]
```

---
