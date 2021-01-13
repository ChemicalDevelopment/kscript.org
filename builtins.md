---
layout: default
title: Builtins
nav_order: 30
permalink: builtins
---

# Builtins
{: .no_toc }

Builtins are available in the global namespace in kscript -- which means they are available without the use of `import` statments, and do not belong to a particular module.


 * TOC
{:toc}


---

### `bool`: Boolean type representing either a `true`/`false` {#bool}
[Booleans](https://en.wikipedia.org/wiki/Boolean_data_type) can hold one of two values. These are often referred to as `on`/`off`, `true`/`false`, `0`/`1`, `yes`/`no`, or something similar. In kscript, you can use the literals `true` and `false` to refer to these two values. These are special identifiers, which means you cannot assign or replace the names `true` and `false` in your programs

The truthiness value of an object can be determined by calling the [`bool`](/builtins#bool) type on an object:

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

This is done via delegation to the `__bool` method on an object, but in general the rules are:

  * Numeric types yield `false` when they are equal to `0`, and `true` otherwise
  * Sequence/container types yield `false` when they are empty, and `true` when they are non-empty

---

### `bytes`: Bytestring type representing raw bytes {#bytes}

Similar to [`str`](/builtins#str), but stores raw bytes (which may or may not be textual information). Useful for handling files which are not textual information, as well as general binary data. 

You can encode to and from [`str`](/builtins#str) and [`bytes`](/builtins#bytes)

---

### `complex`: Complex type representing a pair of floating point components {#complex}

[Complex numbers](https://en.wikipedia.org/wiki/Complex_number) can be represented in kscript as the [`complex`](/builtins#complex) type, which is a complex number containing both components as [`float`](/builtins#float)s. You can access the elements via the attributes `.re`, `.real` (for the real component) and `.im`, `.imag` for the imaginary components.

Complex litererals are created by adding an `i` or `I` suffix to a [`float`](/builtins#float) literal. Complex numbers are created by adding imaginary literals with float literals. For example, `1.0 + 2.0i` is an operation which adds `1.0` (real) and `2.0i` (imaginary), which results in a single complex numbers.

Unlike other numeric types, `abs()` of a complex number returns a [`float`](/builtins#float) object. Specifically, it returns the [modulus](https://en.wikipedia.org/wiki/Absolute_value#Complex_numbers).

---

### `dict`: Collection of key-value pairs {#dict}

A [dictionary, or hash table, or associative array](https://en.wikipedia.org/wiki/Hash_table) is a collection of unique, hashable keys and corresponding values (which need not be unique or hashable). Very similar to the [set](#set) datatype, which only stores unique, hashable keys, so a `dict` can be thought of as a `set` with values attached to each key.

`dict`s are ordered by first unique key insertion, which is reset when a key is deleted from a dictionary. So, setting the value of a new key means it is the last entry in the dictionary, and setting the value of an already existing key does not change the order of the dictionary.


You can subscript a dictionary like `x[key]` to retreive the value for a given key (or throw a `KeyError` if `key` is not present in `x`), and you can assign to a dictionary like `x[key] = val`


`dict`s are created with the `{}` delimiters, and `:` between keys and values. For example:

```ks
>>> x = {"Good": 1, "Neutral": 0, "Bad": -1}
{'Good': 1, 'Neutral': 0, 'Bad': -1}
>>> len(x)
3
>>> x['Good']
1
>>> x['Other']
KeyError: 'Other'
Call Stack:
  #0: In '<inter-5>' (line 1, col 1):
x['Other']
^~~~~~~~~~
In <thread 'main'>
```


### `enum`: Abstract enumeration type {#enum}

[Enums](https://en.wikipedia.org/wiki/Enumerated_type) have members which are integers, but also have an associated name. They behave exactly like integers (i.e. arithmetic works as expected), but when converting to string, they default to their name instead of their numeric value. They are also accessible as attributes of their types.

The `enum` type itself is abstract and has no members -- but you can create your own `enum` subtypes for values. For example, via the `enum` syntax:

```ks
# Create enumeration
enum MyEnum {
    MemberA,
    MemberB,
    MemberC,
    # Also, you can have ' = val', like this:
    # MemberD = 3,
}

print (MyEnum.MemberA)
# MyEnum.MemberA

print (MyEnum("MemberA"))
# MyEnum.MemberA

print (MyEnum.MemberA as int)
# 0
```

---

### `float`: Real type representing a floating point value {#float}

[Floating point numbers](https://en.wikipedia.org/wiki/Floating-point_arithmetic) are limited by machine precisions. Specifically, the reference implementation of kscript uses the `C` double type, which is commonly an `binary64` format (i.e. 64 bit IEEE floating point). This means that certain operations may be limited, or truncated in precision. 

In addition to real numbers, [`float`](/builtins#float) can represent infinite values (positive and negative)

Float literals can be created, like [`int`](/builtins#int) literals, with literal base-10 digits, but a `.` is required. For example, `1.23` is a [`float`](/builtins#float) literal. Similarly, literals are allowed to have prefixes to signify different bases. 

Base 10 float literals may have an `e` or `E` after the main part of the literal (called the mantissa), followed by an optional sign and then an exponent, which is a form of scientific notation. For example, `1.2e3 == 1.2 * 10 ** 3 == 1200.0`.

Non-base-10 floats (i.e. base 2, 8, and 16 literals) may have a `p` or `P` after the mantissa, followed by an exponent (which is in base 10). The base of the exponentiation is 2, and not 10. For example, `0b11.1p4 == 0b11.1 * 2 ** 4 == 56`.


| Property | Common Value(s) | Explanation |
|:-------|:--------|:-----|
| `float.EPS` | `2.22044604925031e-16` | The difference between `1.0` and the next largest number |
| `float.MIN` | `2.2250738585072e-308` | The smallest positive value representable as a [`float`](/builtins#float) |
| `float.MAX` | `1.79769313486232e+308` | The largest (non-infinite) value representable as a [`float`](/builtins#float) |
| `float.DIG` | `15` | The number of base-10 digits that can be exactly represented in the type |

---

### `int`: Integral type representing any integer {#int}

[Integers](https://en.wikipedia.org/wiki/Integer) are any whole number, i.e. numbers which has no fractional component. The [`int`](/builtins#int) type is a subtype of `number`

Some languages (`C`, `C++`, `Java`, and so forth) have sized integer types which are limited to (See [this page](https://en.wikipedia.org/wiki/Integer_(computer_science))). For example, a `32` bit unsigned integer may only represent the values from $0$ to $2^{32}-1$. However, in kscript, all integers are of arbitrary precision -- which means they may store whatever values can fit in the main memory of your computer (which is an extremely large limit on modern computers, and you are unlikely to hit that limit in any practical application).

Integer literals can be created via base-10 constants, such as `123`, `45`, and `0`. To specify constants in other bases, you can use `0` + character prefixes. For example, to specify base 10, you can use `0d123`, which is the same as `123`. Here are a table of such prefixes:


| Prefix | Base | Digits |
|:-------|:--------|:-----|
| `0b`, `0B` | 2 | `0`, `1` |
| `0o`, `0O` | 8 | `0`, ..., `7` |
| `0d`, `0D` | 10 | `0`, ..., `9` |
| `0x`, `0X` | 16 | `0`, ..., `9`, and `a`, `b`, ..., `f`, and `A`, `B`, ..., `F` |

---

### `list`: Mutable Collection {#list}

[Lists](https://en.wikipedia.org/wiki/List_(abstract_data_type)) (sometimes called arrays in other languages), are collections of elements that can be mutated (i.e. changed).

Lists can be created with either the `list(objs)` function, or via the `[]`, which create a list. Examples:

```ks
>>> type([])
list
>>> [1, 2, 3]
[1, 2, 3]
>>> list(range(1, 4))
[1, 2, 3]
```
---

### `number`: Abstract base type of numeric types {#number}

All builtin numeric types are instances of `number`, and can be used interchangeably. There are many subtypes that implement specific numerical datatypes, including [`int`](#int), [`float`](#float), and [`complex`](#complex)

| Method | Description | Notes |
|:-------|:--------|:-----|
| `number.__add(L, R)`, `L + R` | Computes addition |  |
| `number.__sub(L, R)`, `L - R` | Computes subtraction |  |
| `number.__mul(L, R)`, `L * R` | Computes multiplication |  |
| `number.__div(L, R)`, `L / R` | Computes division |  |
| `number.__floordiv(L, R)`, `L // R` | Computes floor division (for real numbers only) |  |
| `number.__mod(L, R)`, `L % R` | Computes modulo (for real numbers only) | The result has the same sign as `R` |
| `number.__pow(L, R)`, `L ** R` | Computes exponentiation | `0**0 == 1` |
| `number.__lt(L, R)`, `L < R` | Computes less-than (returns [`bool`](/builtins#bool)) | Complex numbers cause a `MathError` |
| `number.__le(L, R)`, `L <= R` | Computes less-than-or-equal (returns [`bool`](/builtins#bool)) | Complex numbers cause a `MathError` |
| `number.__gt(L, R)`, `L > R` | Computes greater-than (returns [`bool`](/builtins#bool)) | Complex numbers cause a `MathError` |
| `number.__ge(L, R)`, `L >= R` | Computes greater-than-or-equal (returns [`bool`](/builtins#bool)) | Complex numbers cause a `MathError` |
| `number.__eq(L, R)`, `L == R` | Computes equal-to (returns [`bool`](/builtins#bool)) | |
| `number.__ne(L, R)`, `L != R` | Computes not-equal-to (returns [`bool`](/builtins#bool)) | |
| `number.__neg(V)`, `-V` | Computes the negation | |
| `number.__abs(V)`, `abs(V)` | Computes [absolute value](https://en.wikipedia.org/wiki/Absolute_value) | For complex numbers, this is their modulus |
| `number.__sqig(V)`, `~V` | Computes [complex conjugation](https://en.wikipedia.org/wiki/Complex_conjugate) | |

Notes:

 * Arithmetic operations which combine multiple types (i.e. `L + R`) use type coercion, so the type of the result is determined by the 'most general' type of either of its operands. Here is a list of types in ascending order of coercion precedence:
   1. int
   2. rational
   3. float
   4. complex
 * Comparisons (`<`, `<=`, etc) involving `nan` always return false. For example, `nan == nan` results in `false`.

---

### `object`: Base type of all objects {#object}

`object` is a generic type which every other type is a subtype of (directly or indirectly).

For more on the object model, see [object model](/more/objectmodel)

---

### `regex`: Regular expression pattern {#regex}

[Regular expressions](https://en.wikipedia.org/wiki/Regular_expression), or [`regex`](/builtins#regex), are patterns for searching in text. Although the term 'regular expression' often refers to extended regular expressions (such as backreferences, recursive patterns, and so forth) in some programming languages, the kscript [`regex`](/builtins#regex) type is a true regex -- in that it describes [regular languages](https://en.wikipedia.org/wiki/Regular_language). Although this may be seen as restrictive, it means that the performance of regex operations can be much faster (see [here](https://swtch.com/~rsc/regexp/regexp1.html)).

Regex literals can be created similar to [`str`](/builtins#str) literals, except with  `` ` `` instead of quotation marks. The basic regex syntax from most languages is present, with a few modifications specific to the kscript dialect.

Regex syntax, and advanced usage is in [/more/regex](/more/regex)

---

### `set`: Collection of unique, hashable objects {#set}

Sets are collections of unique and hashable objects with cheap element testing. They are like [`dict`](#dict)s, except with no value associated with each key.

If you try to add an element that already exists, nothing is changed.

Sets are created, like dictionaries, with `{` and `}`, except that `set`s do not have `:` seperating keys and values. kscript will treat empty `{}` as a `dict`, so to create an empty set, use the constructor with no arguments: `set()`

Examples:

```ks
>>> {1, 2, 3, 2, 1}
{1, 2, 3}
```


---

### `str`: String type representing Unicode text {#str}

kscript uses [Unicode](https://en.wikipedia.org/wiki/Unicode), and specifically [utf-8](https://en.wikipedia.org/wiki/UTF-8) to store textual information. A [`str`](/builtins#str) is a string of Unicode codepoints (sometimes called Unicode characters). The empty string (`''`) is represented as a [`str`](/builtins#str) object of length 0, and single characters are [`str`](/builtins#str) objects of length 1. Longer strings can be made by concatenating, joining, or other processing methods.

[`str`](/builtins#str) literals can be created with quotation marks (`'` and `"` are both allowed) around some textual data. For example, `'abc'` is a [`str`](/builtins#str) of length 3, containing the first 3 lowercase letters of the English alphabet. You can also use triple quotes (`'''` and `"""`) for multi-line [`str`](/builtins#str) literals (i.e. they include line breaks). Escape sequences are also included, which are used to encode data that is either hard to type, may be encoded incorrectly on disk, or to increase readability. Here is a table of escape codes that are present in [`str`](/builtins#str)s:

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


It's important to keep in mind that [`str`](/builtins#str) objects are immutable -- which means they can't be changed. So, you cannot assign to elements (`x[0] = 'c'` would not work), but you can re-assign modified versions to the variable names (variable names in kscript are just references to objects) like `x = 'c' + x[1:]`

The length of a string (from the `len()` function) is defined as the number of characters in the string, which may differ from the number of bytes stored in the string. But, in kscript code, all offsets are in characters, and not bytes. 

---

### `tuple`: Immutable Collection {#tuple}

Tuples are like [`list`s](#list), except that they are immutable (i.e. the collection of objects doesn't change once the tuple has been created). They are denoted like lists, except that they use `()` for grouping:

```ks
>>> type(())
tuple
>>> (1, 2, 3)
(1, 2, 3)
>>> tuple(range(1, 3))
(1, 2, 3)
>>> (1,) # trailing ',' is required for tuples with 1 element
```

---

### `type`: Data type, which describes objects {#type}


(the language in this section may be confusing -- since `type` is itself a `type`)

Types represent a kind of object -- i.e. objects of the same (or related) type will share similar attributes and member functions. 

Every [`object`](#object) has a type, which can be retrieved via `type(obj)`. 


Types can be created with the `type` expression:

```
>>> type MyType extends object {
...     func __str(self) { 
...         ret "WhateverYouWant"
...     }
... }
MyType
>>> MyType()
<'MyType' @ 0x55E857201220>
>>> MyType() as str
'WhateverYouWant'
```

---


### `print(*args)`: Prints output {#print}

Prints all of `args` to [`os.stdout`](/modules/os#stdout) (by converting them to [`str`](#str)), adding a space between each one. Then, a newline is also printed


For more fine grain output control see the [`printf`](#printf) and [`io.BaseIO.printf`](/modules/io#BaseIO.printf) functions

---

### `printf(fmt, *args)`: Prints formatted output {#printf}

Like [`print`](#print) (it prints to [`os.stdout`](/modules/os#stdout)), except that it starts with a format string, and the rest of the arguments are converted sequentially according to the format string. No newline or space is added between arguments or after all of them.

The format string `fmt` is expected to be made up of format specifiers, and normal printable text. A format specifier is started with the character `%` (percent sign), and followed by fields, which control how the object is converted. Finally, each format specifier ends with a single character denoting the type. Text in between format specifiers is output verbatim without modification


Flags are optional characters that change the formatting for a specifier. All flags for a format specifier should be placed immediately after the `%`. Although different types may treat flags differently, generally their behavior is: 

 * `+` causes the sign of numeric outputs to always be included (so, even positive numbers will have their sign before the digits)
 * `-` causes the output to be left-aligned instead of right-aligned
 * `0` causes the output of left-aligned numbers to contain leading `0`s instead of spaces


After flags, there is an optional width field which can be an integer (for example, `%10s` has a width of `10`), or a `*`, which takes the next object from `args`, treats it like an integer, and treats that as the width (dynamic width).

After width, there is an optional precision field which can be a `.` followed by an integer (for example `%.10s` has a precision of `10`), or `.*`, which takes the next object from `args`, treats it like an integer, and treats that as the precision (dynamic precision).


Finally, there is the single-character format specifier which tells the type of output. Below are a table of specifiers:

#### `%%`
{: .method .no_toc }

<div class="method-text" markdown="1">
A literal `%` is added, and no more objects from the arguments are consumed
</div>

#### `%i`, `%I`, `%d`, `%D`
{: .method .no_toc }

<div class="method-text" markdown="1">
The next object from `args` is taken, and interpreted as an [`int`](#int), and its base-10 digits are added
</div>

#### `%b`, `%B`
{: .method .no_toc }

<div class="method-text" markdown="1">
The next object from `args` is taken, and interpreted as an [`int`](#int), and its base-2 bits are added
</div>

#### `%o`, `%O`
{: .method .no_toc }

<div class="method-text" markdown="1">
The next object from `args` is taken, and interpreted as an [`int`](#int), and its base-8 octal digits are added
</div>

#### `%x`, `%X`
{: .method .no_toc }

<div class="method-text" markdown="1">
The next object from `args` is taken, and interpreted as an [`int`](#int), and its base-16 hex digits are added

If `%x` is used, then the hex digits `a-f` are used. If `%X` is used, then the hex digits `A-F` are used instead.
</div>

#### `%f`, `%F`
{: .method .no_toc }

<div class="method-text" markdown="1">
The next object from `args` is taken, and interpreted as an [`float`](#float), and its base-10 digits are added
</div>


Here are some examples, which use `|` around some specifiers so it is easier to see the resulting size:

```ks
>>> printf('|%i|', 123)      # Direct translation
|123|
>>> printf('|%5i|', 123)     # Pads to size 5
|123  |
>>> printf('|%+5i|', 123)    # Pads to size 5, and always includes sign
|+123 |
>>> printf('|%-5i|', 123)    # Pads to size 5, and is left-aligned
|  123|
>>> printf('|%-+5i|', 123)   # Pads to size 5, and always includes sign, and is left-aligned
| +123|
>>> printf('|%05i|', 123)    # Pads to size 5, and includes leading zeros
|00123|
```


For formatted output on arbitrary IO objects, see the [`io.BaseIO.printf`](/modules/io#BaseIO.printf) function


---





