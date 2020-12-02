---
layout: default
title: Types
nav_order: 3
permalink: types
---

# Types
{: .no_toc }

kscript is purely object-oriented language, which means that every object is a subclass of `object`, and therefore the inheritance tree of all types has a single root node -- `object`. You don't ever have to specify types, and collection types (such as `list`, `tuple`, and `dict`) can store any type or combination of types without any special treatment. 

Instances of types can be created with either literals, or calls to the constructor, which is the type itself. For example, you can create an `int` object by calling `int()`. Constructors may also take objects, which it will try to convert into that type. In kscript, you can call a constructor by treating the type as a function. For example, to convert a string constant into an `int`, you can call it like so: `int("123")`. Constructors will often throw errors if the argument(s) could not be converted to the requested type.

The type of an object can be determined via the `type` function. For example, `type(123) == int`. You can also check whether a type is a sub-type of another type via the `issub` function. For example: `issub(type(123), int) == true`, but `issub(type(123), str) == false`.


Here are all the builtin, global types available everywhere:

 * TOC
{:toc}

---

## [`object`: Base type of all objects](#object)




## [`type`: ](#type)

## [`number`: Abstract base type of numeric types](#number)

All builtin numeric types are instances of `number`, and can be used interchangeably. There are many common

| Method | Description | Notes |
|:-------|:--------|:-----|
| `.__add__(L, R)`, `L + R` | Computes addition |  |
| `.__sub__(L, R)`, `L - R` | Computes subtraction |  |
| `.__mul__(L, R)`, `L * R` | Computes multiplication |  |
| `.__div__(L, R)`, `L / R` | Computes division |  |
| `.__floordiv__(L, R)`, `L // R` | Computes floor division (for real numbers only) |  |
| `.__mod__(L, R)`, `L % R` | Computes modulo (for real numbers only) | The result has the same sign as `R` |
| `.__pow__(L, R)`, `L ** R` | Computes exponentiation | `0**0 == 1` |
| `.__lt__(L, R)`, `L < R` | Computes less-than (returns `bool`) | Complex numbers cause a `MathError` |
| `.__le__(L, R)`, `L <= R` | Computes less-than-or-equal (returns `bool`) | Complex numbers cause a `MathError` |
| `.__gt__(L, R)`, `L > R` | Computes greater-than (returns `bool`) | Complex numbers cause a `MathError` |
| `.__ge__(L, R)`, `L >= R` | Computes greater-than-or-equal (returns `bool`) | Complex numbers cause a `MathError` |
| `.__eq__(L, R)`, `L == R` | Computes equal-to (returns `bool`) | |
| `.__ne__(L, R)`, `L != R` | Computes not-equal-to (returns `bool`) | |
| `.__neg__(V)`, `-V` | Computes the negation | |
| `.__abs__(V)`, `abs(V)` | Computes [absolute value](https://en.wikipedia.org/wiki/Absolute_value) | For complex numbers, this is their modulus |
| `.__sqig__(V)`, `~V` | Computes [complex conjugation](https://en.wikipedia.org/wiki/Complex_conjugate) | |

Notes:

 * Arithmetic operations which combine multiple types (i.e. `L + R`) use type coercion, so the type of the result is determined by the 'most general' type of either of its operands. Here is a list of types in ascending order of coercion precedence:
   1. int
   2. rational
   3. float
   4. complex
 * Comparisons (`<`, `<=`, etc) involving `nan` always return false. For example, `nan == nan` results in `false`.

---

### [`bool`: Boolean type representing either a `true`/`false`](#bool)

[Booleans](https://en.wikipedia.org/wiki/Boolean_data_type) can hold one of two values. These are often referred to as `on`/`off`, `true`/`false`, `0`/`1`, `yes`/`no`, or something similar. In kscript, you can use the literals `true` and `false` to refer to these two values. These are special identifiers, which means you cannot assign or replace the names `true` and `false` in your programs

The truthiness value of an object can be determined by calling the `bool` type on an object:

```ks
bool(false) # false
bool(true) # true
bool(0) # false
bool(1) # true
bool(2) # true
bool('') # false
bool('AnyText') # true
```

This is done via delegation to the `__bool__` method on an object, but in general the rules are:

  * Numeric types yield `false` when they are equal to `0`, and `true` otherwise
  * Sequence/container types yield `false` when they are empty, and `true` when they are non-empty

### [`int`: Integral type representing any integer](#int)


[Integers](https://en.wikipedia.org/wiki/Integer) are any whole number, i.e. numbers which has no fractional component. The `int` type is a subtype of `number`

Some languages (`C`, `C++`, `Java`, and so forth) have sized integer types which are limited to (See [this page](https://en.wikipedia.org/wiki/Integer_(computer_science))). For example, a `32` bit unsigned integer may only represent the values from $0$ to $2^{32}-1$. However, in kscript, all integers are of arbitrary precision -- which means they may store whatever values can fit in the main memory of your computer (which is an extremely large limit on modern computers, and you are unlikely to hit that limit in any practical application).

Integer literals can be created via base-10 constants, such as `123`, `45`, and `0`. To specify constants in other bases, you can use `0` + character prefixes. For example, to specify base 10, you can use `0d123`, which is the same as `123`. Here are a table of such prefixes:


| Prefix | Base | Digits |
|:-------|:--------|:-----|
| `0b`, `0B` | 2 | `0`, `1` |
| `0o`, `0O` | 8 | `0`, ..., `7` |
| `0d`, `0D` | 10 | `0`, ..., `9` |
| `0x`, `0X` | 16 | `0`, ..., `9`, and `a`, `b`, ..., `f`, and `A`, `B`, ..., `F` |

---

### [`float`: Real type representing a floating point value](#float)


[Floating point numbers](https://en.wikipedia.org/wiki/Floating-point_arithmetic) are limited by machine precisions. Specifically, the reference implementation of kscript uses the `C` double type, which is commonly an `binary64` format (i.e. 64 bit IEEE floating point). This means that certain operations may be limited, or truncated in precision. 

In addition to real numbers, `float` can represent infinite values (positive and negative)


| Property | Common Value(s) | Explanation |
|:-------|:--------|:-----|
| `float.EPS` | `2.22044604925031e-16` | The difference between `1.0` and the next largest number |
| `float.MIN` | `2.2250738585072e-308` | The smallest positive value representable as a `float` |
| `float.MAX` | `1.79769313486232e+308` | The largest (non-infinite) value representable as a `float` |
| `float.DIG` | `15` | The number of base-10 digits that can be exactly represented in the type |


---


### [`complex`: Complex type representing a pair of floating point components](#complex)

## [`str`: String type representing Unicode text](#str)

## [`bytes`: Bytestring type representing raw bytes](#bytes)

## [`list`: Collection](#list)

## [`tuple`: Collection](#tuple)

## [`set`: Collection](#set)

## [`dict`: Collection](#dict)

## [`graph`: Collection](#graph)

