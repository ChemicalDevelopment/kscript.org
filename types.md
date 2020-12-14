---
layout: default
title: Types
nav_order: 3
permalink: types
---

# Types
{: .no_toc }

kscript is purely object-oriented language, which means that every type is a subtype of [`object`](/types#object), and therefore the inheritance tree of all types has a single root node -- [`object`](/types#object). You normally don't have to specify types for general processing, and collection types (such as [`list`](/types#list), [`tuple`](/types#tuple), and [`dict`](/types#dict)) can store any type or combination of types without any special treatment.

Instances of types can be created with literals or calls to the constructor, which is the type itself. For example, you can create an [`int`](/types#int) object by calling `int()`. Constructors may also take arguments, which it will try to convert into that type. For example, to convert a string constant into an [`int`](/types#int), you can call it like so: `int("123")`. Constructors will often throw errors if the argument(s) could not be converted to the requested type.

There is also a syntactic sugar that allows conversion to a type on the right hand side of a value using the `as` operator. For example, `int("123")` is the same as `"123" as int`, which uses less parentheses and can be helpful/more readable in some circumstances. It can also be chained, if you have `float(int("123"))` (converting to an [`int`](/types#int) then a [`float`](/types#float)), you can equivalently write `"123" as int as float` or `("123" as int) as float`. This can help readability in many places

The type of an object can be determined via the `type` function. For example, `type(123) == int`. You can also check whether a type is a sub-type of another type via the `issub` function. For example: `issub(type(123), int) == true`, but `issub(type(123), str) == false`.


## Viewing Inheritance Trees
{: .no_toc }

You can view inheritance trees for any types (not just builtin ones) by using the [`graph`](/types#graph) type. Then, you can use the `graph._dotfile()` method to generate a string that can be passed to [Graphviz](https://graphviz.org/). For example:


```ks
>>> inher = int as graph
graph([int, enum, bool, logger.levels, ast.kind, number, object], [(0, 1), (1, 2), (1, 3), (1, 4), (5, 0), (6, 5)])
>>> print(inher._dotfile())
digraph G {
    0 [label="int"];
    0 -> 1;
    1 [label="enum"];
    1 -> 2;
    1 -> 3;
    1 -> 4;
    2 [label="bool"];
    3 [label="logger.levels"];
    4 [label="ast.kind"];
    5 [label="number"];
    5 -> 0;
    6 [label="object"];
    6 -> 5;
}
```

Which translates into the following inheritance tree:

![{{ site.baseurl }}/assets/images/tp-int-inher.svg]({{ site.baseurl }}/assets/images/tp-int-inher.svg)

## Builtins
{: .no_toc }

Here are all the builtin, global types available everywhere:

 * TOC
{:toc}

---

## `object`: Base type of all objects {#object}


---

## `type`: Data type, which describes objects {#type}


---

## `number`: Abstract base type of numeric types {#number}

All builtin numeric types are instances of `number`, and can be used interchangeably. There are many subtypes that implement specific numerical datatypes, including [`int`](#int), [`float`](#float), and [`complex`](#complex)

| Method | Description | Notes |
|:-------|:--------|:-----|
| `.__add__(L, R)`, `L + R` | Computes addition |  |
| `.__sub__(L, R)`, `L - R` | Computes subtraction |  |
| `.__mul__(L, R)`, `L * R` | Computes multiplication |  |
| `.__div__(L, R)`, `L / R` | Computes division |  |
| `.__floordiv__(L, R)`, `L // R` | Computes floor division (for real numbers only) |  |
| `.__mod__(L, R)`, `L % R` | Computes modulo (for real numbers only) | The result has the same sign as `R` |
| `.__pow__(L, R)`, `L ** R` | Computes exponentiation | `0**0 == 1` |
| `.__lt__(L, R)`, `L < R` | Computes less-than (returns [`bool`](/types#bool)) | Complex numbers cause a `MathError` |
| `.__le__(L, R)`, `L <= R` | Computes less-than-or-equal (returns [`bool`](/types#bool)) | Complex numbers cause a `MathError` |
| `.__gt__(L, R)`, `L > R` | Computes greater-than (returns [`bool`](/types#bool)) | Complex numbers cause a `MathError` |
| `.__ge__(L, R)`, `L >= R` | Computes greater-than-or-equal (returns [`bool`](/types#bool)) | Complex numbers cause a `MathError` |
| `.__eq__(L, R)`, `L == R` | Computes equal-to (returns [`bool`](/types#bool)) | |
| `.__ne__(L, R)`, `L != R` | Computes not-equal-to (returns [`bool`](/types#bool)) | |
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

### `int`: Integral type representing any integer {#int}

[Integers](https://en.wikipedia.org/wiki/Integer) are any whole number, i.e. numbers which has no fractional component. The [`int`](/types#int) type is a subtype of `number`

Some languages (`C`, `C++`, `Java`, and so forth) have sized integer types which are limited to (See [this page](https://en.wikipedia.org/wiki/Integer_(computer_science))). For example, a `32` bit unsigned integer may only represent the values from $0$ to $2^{32}-1$. However, in kscript, all integers are of arbitrary precision -- which means they may store whatever values can fit in the main memory of your computer (which is an extremely large limit on modern computers, and you are unlikely to hit that limit in any practical application).

Integer literals can be created via base-10 constants, such as `123`, `45`, and `0`. To specify constants in other bases, you can use `0` + character prefixes. For example, to specify base 10, you can use `0d123`, which is the same as `123`. Here are a table of such prefixes:


| Prefix | Base | Digits |
|:-------|:--------|:-----|
| `0b`, `0B` | 2 | `0`, `1` |
| `0o`, `0O` | 8 | `0`, ..., `7` |
| `0d`, `0D` | 10 | `0`, ..., `9` |
| `0x`, `0X` | 16 | `0`, ..., `9`, and `a`, `b`, ..., `f`, and `A`, `B`, ..., `F` |

---

### `bool`: Boolean type representing either a `true`/`false` {#bool}
[Booleans](https://en.wikipedia.org/wiki/Boolean_data_type) can hold one of two values. These are often referred to as `on`/`off`, `true`/`false`, `0`/`1`, `yes`/`no`, or something similar. In kscript, you can use the literals `true` and `false` to refer to these two values. These are special identifiers, which means you cannot assign or replace the names `true` and `false` in your programs

The truthiness value of an object can be determined by calling the [`bool`](/types#bool) type on an object:

```ks
bool(false) # false
bool(true) # true
bool(0) # false
bool(1) # true
bool(2) # true
bool('') # false
bool('AnyText') # true
```

Or, as is sometimes more readable, using the `as` operator:

```ks
false as bool
true as bool
0 as bool
1 as bool
2 as bool
'' as bool
'AnyText' as bool
```

This is done via delegation to the `__bool__` method on an object, but in general the rules are:

  * Numeric types yield `false` when they are equal to `0`, and `true` otherwise
  * Sequence/container types yield `false` when they are empty, and `true` when they are non-empty

---

### `float`: Real type representing a floating point value {#float}

[Floating point numbers](https://en.wikipedia.org/wiki/Floating-point_arithmetic) are limited by machine precisions. Specifically, the reference implementation of kscript uses the `C` double type, which is commonly an `binary64` format (i.e. 64 bit IEEE floating point). This means that certain operations may be limited, or truncated in precision. 

In addition to real numbers, [`float`](/types#float) can represent infinite values (positive and negative)

Float literals can be created, like [`int`](/types#int) literals, with literal base-10 digits, but a `.` is required. For example, `1.23` is a [`float`](/types#float) literal. Similarly, literals are allowed to have prefixes to signify different bases. 

Base 10 float literals may have an `e` or `E` after the main part of the literal (called the mantissa), followed by an optional sign and then an exponent, which is a form of scientific notation. For example, `1.2e3 == 1.2 * 10 ** 3 == 1200.0`.

Non-base-10 floats (i.e. base 2, 8, and 16 literals) may have a `p` or `P` after the mantissa, followed by an exponent (which is in base 10). The base of the exponentiation is 2, and not 10. For example, `0b11.1p4 == 0b11.1 * 2 ** 4 == 56`.


| Property | Common Value(s) | Explanation |
|:-------|:--------|:-----|
| `float.EPS` | `2.22044604925031e-16` | The difference between `1.0` and the next largest number |
| `float.MIN` | `2.2250738585072e-308` | The smallest positive value representable as a [`float`](/types#float) |
| `float.MAX` | `1.79769313486232e+308` | The largest (non-infinite) value representable as a [`float`](/types#float) |
| `float.DIG` | `15` | The number of base-10 digits that can be exactly represented in the type |

---

### `complex`: Complex type representing a pair of floating point components {#complex}

[Complex numbers](https://en.wikipedia.org/wiki/Complex_number) can be represented in kscript as the [`complex`](/types#complex) type, which is a complex number containing both components as [`float`](/types#float)s. You can access the elements via the attributes `.re`, `.real` (for the real component) and `.im`, `.imag` for the imaginary components.

Complex litererals are created by adding an `i` or `I` suffix to a [`float`](/types#float) literal. Complex numbers are created by adding imaginary literals with float literals. For example, `1.0 + 2.0i` is an operation which adds `1.0` (real) and `2.0i` (imaginary), which results in a single complex numbers.

Unlike other numeric types, `abs()` of a complex number returns a [`float`](/types#float) object. Specifically, it returns the [modulus](https://en.wikipedia.org/wiki/Absolute_value#Complex_numbers).

---

## `str`: String type representing Unicode text {#str}

kscript uses [Unicode](https://en.wikipedia.org/wiki/Unicode), and specifically [utf-8](https://en.wikipedia.org/wiki/UTF-8) to store textual information. A [`str`](/types#str) is a string of Unicode codepoints (sometimes called Unicode characters). The empty string (`''`) is represented as a [`str`](/types#str) object of length 0, and single characters are [`str`](/types#str) objects of length 1. Longer strings can be made by concatenating, joining, or other processing methods.

[`str`](/types#str) literals can be created with quotation marks (`'` and `"` are both allowed) around some textual data. For example, `'abc'` is a [`str`](/types#str) of length 3, containing the first 3 lowercase letters of the English alphabet. You can also use triple quotes (`'''` and `"""`) for multi-line [`str`](/types#str) literals (i.e. they include line breaks). Escape sequences are also included, which are used to encode data that is either hard to type, may be encoded incorrectly on disk, or to increase readability. Here is a table of escape codes that are present in [`str`](/types#str)s:

| Escape Sequence | Example | Description |
|---|---|---|
|`\\`| `'\\'` | Literal `\` |
|`\'`| `'\''` | Literal `'` |
|`\"`| `'\"'` | Literal `"` |
|`\a`| `'\a'` | ASCII `BEL` character |
|`\b`| `'\b'` | ASCII `BS` character (backspace) |
|`\f`| `'\f'` | ASCII `FF` character (formfeed) |
|`\n`| `'\n'` | ASCII `LF` character (linefeed/newline) |
|`\r`| `'\r'` | ASCII `CR` character (carriage return) |
|`\t`| `'\t'` | ASCII `HT` character (horizontal tab/tab) |
|`\v`| `'\v'` | ASCII `VT` character (vertical tab) |
|`\xXX`| `'\x61' == 'a'` | Single byte, where `XX` are 2 hex digits |
|`\uXXXX`| `'\u0061' == 'a'` | Unicode codepoint, where `XXXX` are 4 hex digits |
|`\UXXXXXXXX`| `'\U00000061' == 'a'` | Unicode codepoint, where `XXXXXXXX` are 8 hex digits |
|`\N[XX...X]`| `'\N[LATIN SMALL LETTER A]' == 'a'` | Unicode codepoint, where `XX...X` is the [name of the Unicode character](https://en.wikipedia.org/wiki/List_of_Unicode_characters) |


It's important to keep in mind that [`str`](/types#str) objects are immutable -- which means they can't be changed. So, you cannot assign to elements (`x[0] = 'c'` would not work), but you can re-assign modified versions to the variable names (variable names in kscript are just references to objects) like `x = 'c' + x[1:]`

The length of a string (from the `len()` function) is defined as the number of characters in the string, which may differ from the number of bytes stored in the string. But, in kscript code, all offsets are in characters, and not bytes. 

---

## `bytes`: Bytestring type representing raw bytes {#bytes}

Similar to [`str`](/types#str), but stores raw bytes (which may or may not be textual information). Useful for handling files which are not textual information, as well as general binary data. 

You can encode to and from [`str`](/types#str) and [`bytes`](/types#bytes)

---

## `regex`: Regular expression pattern {#regex}

[Regular expressions](https://en.wikipedia.org/wiki/Regular_expression), or [`regex`](/types#regex), are patterns for searching in text. Although the term 'regular expression' often refers to extended regular expressions (such as backreferences, recursive patterns, and so forth) in some programming languages, the kscript [`regex`](/types#regex) type is a true regex -- in that it describes [regular languages](https://en.wikipedia.org/wiki/Regular_language). Although this may be seen as restrictive, it means that the performance of regex operations can be much faster (see [here](https://swtch.com/~rsc/regexp/regexp1.html)).

Regex literals can be created similar to [`str`](/types#str) literals, except with  `` ` `` instead of quotation marks. The basic regex syntax from most languages is present, with a few modifications specific to the kscript dialect.

Regex syntax, and advanced usage is in [/more/regex](/more/regex)


## `list`: Collection {#list}

## `tuple`: Collection {#tuple}

## `set`: Collection {#set}

## `dict`: Collection {#dict}

## `graph`: Collection {#graph}

