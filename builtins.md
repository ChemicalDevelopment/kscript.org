---
layout: default
title: Builtins
nav_order: 30
permalink: builtins
---

# Builtins
{: .no_toc }

Builtins are available in the global namespace in kscript -- which means they are available without the use of `import` statments, and do not belong to a particular module.

If you don't find the type or function you're looking for here, that functionality may be in the [standard modules](/modules)


 * TOC
{:toc}


---

## Types

### `object`: Base type of all objects {#object}

`object` is a generic type which every other type is a subtype of (directly or indirectly).

For more on the object model, see [object model](/more/objectmodel)

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

### `number`: Abstract base type of numeric types {#number}

This type is the abstract base type of all builtin numeric types ([`int`](#int), [`bool`](#bool), [`float`](#float), [`complex`](#complex)). In order for all those types to work well together, they all agree and conform to the numeric pattern (see: [patterns](/more/patterns)), which is documented here.

An object `obj` is said to be numeric if at least one of the following holds (and the first one is the preferred one):

  * If `obj.__integral()` exists, then `obj` is assumed to be a whole number, and this method should return an `int` equivalant to its numeric value
  * If `obj.__float()` exists, then `obj` is assumed to be a real number, and this method should return a `float` equivalent to its numeric value
  * If `obj.__complex()` exists, then `obj` is assumed to be a complex number, and this method should return a `complex` equivalent to its numeric value

Operations between numbers use value coercion, by the following rules (unless otherwise stated):

  * If all operands are integral, then an integral result ([`int`](#int)) is returned
  * If all operands are either integral or floating point, then a floating point result ([`float`](#float)) is returned
  * If none of the above rules are applicable, then at least one operand must be complex, and a complex result ([`complex`](#complex)) is returned

A notable exception is [division (`L / R`, documented in `number.__div`)](#number.__div)


#### number.__neg(self) {#number.__neg}
{: .method .no_toc }

<div class="method-text" markdown="1">
Computes negation (`-self`), with normal value coercion
</div>

#### number.__sqig(self) {#number.__sqig}
{: .method .no_toc }

<div class="method-text" markdown="1">
Computes conjugation (`~self`), which for real numbers, returns the `self`. For complex arguments, a new value with the same real component, but negated imaginary component is returned.
</div>


#### number.__abs(self) {#number.__abs}
{: .method .no_toc }

<div class="method-text" markdown="1">
Computes absolute value (`abs(self)`), with special coercion rules:

  * If `self` is integral, then an [`int`](#int) is returned
  * Otherwise, `self` must be either floating point or complex. In both cases, the returned value will be a real [`float`](#float)


</div>


#### number.__add(L, R) {#number.__add}
{: .method .no_toc }

<div class="method-text" markdown="1">
Computes addition (`L + R`), with normal value coercion
</div>


#### number.__sub(L, R) {#number.__sub}
{: .method .no_toc }

<div class="method-text" markdown="1">
Computes subtraction (`L - R`), with normal value coercion
</div>

#### number.__mul(L, R) {#number.__mul}
{: .method .no_toc }

<div class="method-text" markdown="1">
Computes multiplication (`L * R`), with normal value coercion
</div>

#### number.__div(L, R) {#number.__div}
{: .method .no_toc }

<div class="method-text" markdown="1">
Computes division (`L / R`), with special rules:

  * If both operands are either integral or floating point, then a [`float`](#float) result is returned, and the division is carried out to machine `double` precision (instead of floor division)
  * Otherwise, if none of the above rules apply, then at least one operand must be complex, and a complex ([`complex`](#complex)) result is returned

If `R == 0`, then a [`MathError`](#MathError) is thrown (see below for examples)

In some languages (for example, `C`), normal division between integers is floored or truncated. However, this is different in kscript. To get floor division, use the [floor division (`L // R`) operation](#number.__floordiv).

Examples:

```ks
>>> 1 / 1
1.0
>>> 1 / 2
0.5
>>> -1 / 2
-0.5
>>> 1 / 0
MathError: Division by 0
Call Stack:
  #0: In '<expr>' (line 1, col 1):
1 / 0
^~~~~
  #1: In number.__div(L, R) [cfunc]
In <thread 'main'>
```

See: [`number.__floordiv`](#number.__floordiv)

</div>

#### number.__floordiv(L, R) {#number.__floordiv}
{: .method .no_toc }

<div class="method-text" markdown="1">
Computes floor division (`L // R`), which is division rounded down, with normal value coercion rules.

If `R == 0`, then a [`MathError`](#MathError) is thrown (see below for examples)


Examples:

```ks
>>> 1 // 1
1
>>> 1 // 2
0
>>> -1 // 2
-1
>>> 1 // 0
MathError: Division by 0
Call Stack:
  #0: In '<expr>' (line 1, col 1):
1 // 0
^~~~~~
  #1: In number.__floordiv(L, R) [cfunc]
In <thread 'main'>
```

See: [`number.__div`](#number.__div), for normal division

</div>


#### number.__mod(L, R) {#number.__mod}
{: .method .no_toc }

<div class="method-text" markdown="1">
Computes modulo (`L % R`), with normal value coercion rules, except that complex numbers throw a `MathError`

The result has the same sign as `L`

For floating point numbers, the value is accurate to the precision of the type, which is to say non-exact. See [`float`](#float) for information on accuracy.

If `R == 0`, then a [`MathError`](#MathError) is thrown (see below for examples)

Examples:

```ks
>>> 1 % 1
0
>>> 1 % 2
1
>>> -1 % 2  # Notice, it is still positive
1
>>> 1 % -2
-1
>>> -1 % -2
-1
>>> 40 % 7
5
>>> 1 % 0
MathError: Modulo by 0
Call Stack:
  #0: In '<expr>' (line 1, col 1):
1 % 0
^~~~~
  #1: In number.__mod(L, R) [cfunc]
In <thread 'main'>
>>> 1i % 1i
MathError: Cannot 'mod' complex numbers
Call Stack:
  #0: In '<expr>' (line 1, col 1):
1i % 1i
^~~~~~~
  #1: In number.__mod(L, R) [cfunc]
In <thread 'main'>
```

</div>

#### number.__pow(L, R) {#number.__pow}
{: .method .no_toc }

<div class="method-text" markdown="1">
Computes power/exponentiation (`L ** R`), with normal value coercion rules

A few identities can be explained here:

  * `0 ** 0 == 1` (empty product rule)

Examples:

```ks
>>> 0 ** 0
1
>>> 2 ** 3
8
>>> 0 ** -1
MathError: Cannot raise 0 to negative power
Call Stack:
  #0: In '<expr>' (line 1, col 1):
0 ** -1
^~~~~~~
  #1: In number.__pow(L, R) [cfunc]
In <thread 'main'>
```

</div>

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

### `complex`: Complex type representing a pair of floating point components {#complex}

[Complex numbers](https://en.wikipedia.org/wiki/Complex_number) can be represented in kscript as the [`complex`](/builtins#complex) type, which is a complex number containing both components as [`float`](/builtins#float)s. You can access the elements via the attributes `.re`, `.real` (for the real component) and `.im`, `.imag` for the imaginary components.

Complex litererals are created by adding an `i` or `I` suffix to a [`float`](/builtins#float) literal. Complex numbers are created by adding imaginary literals with float literals. For example, `1.0 + 2.0i` is an operation which adds `1.0` (real) and `2.0i` (imaginary), which results in a single complex numbers.

Unlike other numeric types, `abs()` of a complex number returns a [`float`](/builtins#float) object. Specifically, it returns the [modulus](https://en.wikipedia.org/wiki/Absolute_value#Complex_numbers).

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

### `bytes`: Bytestring type representing raw bytes {#bytes}

Similar to [`str`](/builtins#str), but stores raw bytes (which may or may not be textual information). Useful for handling files which are not textual information, as well as general binary data. 

You can encode to and from [`str`](/builtins#str) and [`bytes`](/builtins#bytes)

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

---

### `regex`: Regular expression pattern {#regex}

[Regular expressions](https://en.wikipedia.org/wiki/Regular_expression), or [`regex`](/builtins#regex), are patterns for searching in text. Although the term 'regular expression' often refers to extended regular expressions (such as backreferences, recursive patterns, and so forth) in some programming languages, the kscript [`regex`](/builtins#regex) type is a true regex -- in that it describes [regular languages](https://en.wikipedia.org/wiki/Regular_language). Although this may be seen as restrictive, it means that the performance of regex operations can be much faster (see [here](https://swtch.com/~rsc/regexp/regexp1.html)).

Regex literals can be created similar to [`str`](/builtins#str) literals, except with  `` ` `` instead of quotation marks. The basic regex syntax from most languages is present, with a few modifications specific to the kscript dialect.

Regex syntax, and advanced usage is in [/more/regex](/more/regex)

---


## Functions


### `print(*args)`: Prints output {#print}

Prints all of `args` to [`os.stdout`](/modules/os#stdout) (by converting them to [`str`](#str)), adding a space between each one. Then, a newline is also printed


For more fine grain output control see the [`printf`](#printf) and [`io.BaseIO.printf`](/modules/io#BaseIO.printf) functions

Examples:

```ks
>>> print (123)
123
>>> print(123, 456)
123 456
```

---

### `printf(fmt, *args)`: Prints formatted output {#printf}

Like [`print`](#print) (it prints to [`os.stdout`](/modules/os#stdout)), except that it starts with a format string, and the rest of the arguments are converted sequentially according to the format string. No newline or space is added between arguments or after all of them.

The format string `fmt` is expected to be made up of format specifiers, and normal printable text. A format specifier is started with the character `%` (percent sign), and followed by fields, which control how the object is converted. Finally, each format specifier ends with a single character denoting the type. Text in between format specifiers is output verbatim without modification


Flags are optional characters that change the formatting for a specifier. All flags for a format specifier should be placed immediately after the `%`. Although different types may treat flags differently, generally their behavior is: 

 * `+` causes the sign of numeric outputs to always be included (so, even positive numbers will have their sign before the digits)
 * `-` causes the output to be left-aligned instead of right-aligned
 * `0` causes the output of right-aligned numbers to contain leading `0`s instead of spaces


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
>>> printf('|%0*i|', 5, 123) # Equivalent, but takes the width argument before the value it prints
|00123|
```

For formatted output on arbitrary IO objects, see the [`io.BaseIO.printf`](/modules/io#BaseIO.printf) function

---

### `chr(ord)`: Convert ordinal to character {#chr}

Converts an ordinal (`ord`), which is an integer, into a character. Assumes `ord` is the integer codepoint in Unicode.

Examples:

```ks
>>> chr(0x61)
'a'
>>> chr(0x62)
'b'
```

This function is the inverse of [`ord()`](#ord)

---

### `ord(chr)`: Convert character to ordinal {#ord}

Converts a character (`chr`), which should be a length-1 string, into its Unicode codepoint and return it as an integer

Examples:

```ks
>>> ord('a')
97
>>> ord('b')
98
```

This function is the inverse of [`chr()`](#chr)

---

### `issub(tp, of)`: Check if type is subtype of another {#issub}

Calculates whether `tp` is a subtype (or is the same type) as `of`, which should be either a [`type`](#type), or a tuple of `type`s

Examples:

```ks
>>> issub(int, object)
true
>>> issub(int, number)
true
>>> issub(number, int)
false
```

See also: [`isinst()`](#isinst)

---


### `isinst(obj, of)`: Check if object is instance of a type {#isinst}

Calculates whether `obj` is an instance of `of` or a derived type. `of` can be a `type` or a tuple of `type`s. Equivalent to `issub(type(obj), of)`.


Examples:

```ks
>>> isinst(1, object)
true
>>> isinst(1, number)
true
>>> isinst(1, float)
false
```

See also: [`issub()`](#issub)

---




### `repr(obj)`: Get representation {#repr}

Converts an object (`obj`) into a string representation, which delegates to `type(obj).__repr(obj)`, and must result in a [`str`](#str).

In general, this function returns a string of kscript code which will result in `obj` if executed. For example: `repr(1) == '1'`, `repr('abc') == '\'abc\''`, and `repr([1, 2, 3]) == '[1, 2, 3]'`. Although, this is not always possible. For example, `repr(object()) == '<\'object\' @ 0x564460528DD0>'`. For many types, it is equivalent to converting to a [`str`](#str), with the notable exception of `str` objects themselves -- which add `'` and escape sequences.


Examples:

```ks
>>> repr(1)
'1'
>>> repr("abc")
'\'abc\''
>>> repr([1, 2, 3])
'[1, 2, 3]'
```

---

### `abs(obj)`: Get absolute value {#abs}

Computes the absolute value of an object, which delegates to `type(obj).__abs(obj)`. 

For numeric types, it follows [`number.__abs()`](#number.__abs)

For [`os.path`](/modules/os#path) objects, it returns the [real path](/modules/os#path.real)

Other types are able to provide `__abs(self)`, and that is returned

Examples:

```ks
>>> abs(0)
0
>>> abs(1.0)
1.0
>>> abs(-1.0)
1.0
>>> abs(1 + 2i)
2.23606797749979
```

---

### `hash(obj)`: Get hash {#hash}

Computes the [hash](https://en.wikipedia.org/wiki/Hash_function) of an object, which delegates to `type(obj).__hash(obj)`, and must be an integral values.

Most immutable builtin types (including numeric types, [`tuple`](#tuple), [`str`](#str), and [`bytes`](#bytes)) provide a hashing function. And by default, new types created hash to their [`id`](#id). However, mutable collection types (such as [`list`](#list), [`set`](#set), and [`dict`](#dict)) are not hashable and will return a [`TypeError`](#TypeError).

Examples:

```ks
>>> hash(1)
1
>>> hash("abc")
193485963
>>> hash((1, 2, 3))
4415556888914394581
>>> hash([1, 2, 3])
TypeError: 'list' object is not hashable
Call Stack:
  #0: In '<expr>' (line 1, col 1):
hash([1, 2, 3])
^~~~~~~~~~~~~~~
  #1: In hash(obj) [cfunc]
In <thread 'main'>
>>> hash([1, 2, 3] as tuple) # Must wrap as a tuple
4415556888914394581
```

---


### `len(obj)`: Get length {#len}

Computes the length of an object, which delegates to `type(obj).__len(obj)`, and must be an integral value

For builtin container types ([`list`](#list), [`tuple`](#tuple), [`dict`](#dict), and so on), it returns the number of entries

Examples:

```ks
>>> len([])
0
>>> len([1, 2, 3])
3
>>> len("abcd")
4
```

---


### `id(obj)`: Get unique ID {#id}

Converts an object (`obj`) into its unique ID, which is an integer that is guaranteed to not be equivalent to any two currently living objects.

Most of the time, this is the memory address of the object

---

## Exceptions/Errors/Warnings

### `Exception`: Base type of all exceptions {#Exception}

This type is the base type of all exceptions that may be thrown via the `throw` statement (and caught via the `catch` construct). Unlike most patterns in kscript (see [`patterns`](/more/patterns)), exception throwing requires the type of the object being thrown to be a subtype of `Exception`, instead of having magic attributes.


#### Exception.what {#Exception.what}
{: .method .no_toc }

<div class="method-text" markdown="1">
A [`str`](#str) object representing an explanation of the exception
</div>

---

### `OutOfIterException`: Thrown when an iterable runs out {#OutOfIterException}

Objects of this type are thrown when an iterable runs out of elements, for example, when [`next()`](#next) is called but no more objects are in the iterator.

Objects of these type are automatically caught in `for` loops, at which point the loop stops running.

---

### `Error`: Generic error {#Error}

This type represents an error status -- which means something did not go as planned and needs to be dealt with. Generally, [`Exception`](#Exception) types can be used to alter control flow and not neccessarily signal an error (for example, [`OutOfIterException`](#OutOfIterException) how is used with `for` loops does not mean anything went wrong), but this type (and its subtypes) generally signal a problem.

There are many subtypes of `Error` which can be thrown in specific circumstances (for example, [`MathError`](#MathError) can be thrown on math-related operations), but `Error` objects can be thrown for general errors.

---

### `InternalError`: Internal error {#InternalError}

Errors of this type are thrown when something internally isn't working. Sometimes, it may signal a bug in kscript (such as an unexpected status, unexpected configuration, etc), or it may signal a C library returned something it promised not to.

In any case, these errors are hard to correct for, and when one is thrown, the status of the interpreter itself and objects that were mutated cannot be guaranteed to be predictable

---

### `SyntaxError`: Language syntax error {#SyntaxError}

Errors of this type are generally thrown at parsing time when a program is invalid, which could mean a number of things (unexpected tokens, invalid constructs, invalid characters, and so forth). Generally they have a descriptive message and highlight the offending part of the code, for easy debugging.


Examples:

```
# Some of this code is invalid...
>>> for }
SyntaxError: Unexpected token
for }
    ^
@ Line 1, Col 5 in '<expr>'
Call Stack:
In <thread 'main'>
>>> 2def
SyntaxError: Unexpected token, expected ';', newline, or EOF after
2def
 ^~~
@ Line 1, Col 2 in '<expr>'
Call Stack:
In <thread 'main'>
```

---

### `ImportError`: Module import error {#ImportError}

Errors of this type are generally thrown when importing a module fails, for whatever reason, including: missing dependencies, no such module, and error during initialization.


Examples:

```
>>> import asdf
ImportError: Failed to import 'asdf'
>>> import crazy_name_that_doesnt_exist
ImportError: Failed to import 'crazy_name_that_doesnt_exist'
```

---

### `TypeError`: Type error {#TypeError}

Errors of this type are thrown when the [`type`](#type) of an object doesn't match what is expected, or the type lacks an expected attribute (i.e. does not follow a [`pattern`](/more/patterns)).


Examples:

```
>>> int([])
TypeError: Could not convert 'list' object to 'int'
```

---


### `TemplateError`: Template error {#TemplateError}

This type is a subtype of [`TypeError`](#TypeError)

Errors of this type are thrown when a type is [templated](/more/templates) incorrectly, or an operation is forbidden by a template.

Examples:

```
>>> object[]
TemplateError: 'object' cannot be templated
```

---


### `NameError`: Unknown name error {#NameError}

Errors of this type are thrown when a variable/function/module name is used but has not been defined

Examples:

```
>>> asdf
NameError: Unknown name: 'asdf'
Call Stack:
  #0: In '<expr>' (line 1, col 1):
asdf
^~~~
In <thread 'main'>
```

---



### `AttrError`: Attribute error {#AttrError}

Errors of this type are thrown when any of the following things occur:

  * An attribute is requested on an object that doesn't have any such attribute
  * An attribute is read-only, but some code attempts to change it


Examples:

```
>>> object().a
AttrError: 'object' object had no attribute 'asdf'
Call Stack:
  #0: In '<expr>' (line 1, col 1):
object().asdf
^~~~~~~~~~~~~
In <thread 'main'>
```

---



### `KeyError`: Key error {#KeyError}

Errors of this type are thrown when any of the following things occur:

  * A key to a container (for example, a [`dict`](#dict)) is not found when searched
  * A key to a container is invalid (for example, [`dict`](#dict) keys must be [`hash`able](#hash))


Examples:

```
>>> x = { 'a': 1, 'b': 3 }
{ 'a': 1, 'b': 3 }
>>> x['c']
KeyError: 'c'
Call Stack:
  #0: In '<inter-2>' (line 1, col 1):
x['c']
^~~~~~
In <thread 'main'>
```

---


### `IndexError`: Index error {#IndexError}

This type is a subtype of the [`KeyError`](#KeyError) type

Errors of this type are thrown when any of the following things occur:

  * A index to a sequence (for example, a [`list`](#list)) is out of range


Examples:

```
>>> x = ['a', 'b']
['a', 'b']
>>> x[3]
KeyError: Index out of range
Call Stack:
  #0: In '<inter-5>' (line 1, col 1):
x[2]
^~~~
In <thread 'main'>

```

---


### `ValError`: Value error {#ValError}


Errors of this type are thrown when a value provided does not match what is expected


Examples:

```
>>> nan as int
ValError: Cannot convert 'nan' to int
Call Stack:
  #0: In '<expr>' (line 1, col 1):
nan as int
^~~~~~~~~~
  #1: In int.__new(self, obj=none, base=10) [cfunc]
In <thread 'main'>
```

---

### `MathError`: Math error {#MathError}

Errors of this type are thrown when a mathematical operation is given invalid or out of range operands

Examples:

```
>>> 1 / 0
MathError: Division by 0
Call Stack:
  #0: In '<expr>' (line 1, col 1):
1 / 0
^~~~~
  #1: In number.__div(L, R) [cfunc]
In <thread 'main'>
>>> import m
>>> m.sqrt(-1)
MathError: Invalid argument 'x', requirement 'x >= 0' failed
Call Stack:
  #0: In '<expr>' (line 1, col 1):
m.sqrt(-1)
^~~~~~~~~~
  #1: In m.sqrt(x) [cfunc]
In <thread 'main'>
>>> m.sqrt(-1 + 0i)  # Make sure to pass a 'complex' in if you want complex output
1.0i
```

---


### `ArgError`: Arg error {#ArgError}

Errors of this type are thrown when arguments to a function do not match the expected number, or type

Examples:

```
>>> ord('a', 'b')
ArgError: Given extra arguments, only expected 1, but given 2
Call Stack:
  #0: In '<expr>' (line 1, col 1):
ord('a', 'b')
^~~~~~~~~~~~~
  #1: In ord(chr) [cfunc]
```

---

### `SizeError`: Size error {#SizeError}

Errors of this type are thrown when arguments are of invalid sizes/shapes


---

### `OSError`: OS error {#OSError}

Errors of this type are thrown when an error is reported by the OS, for example by setting `errno`

This is a [templatable](/more/templates) type, which means there are subtypes based on the type of error expressed. The specific templated types are sometimes platform-specific, and we are currently working to standardize what we can. 

Examples:

```
>>> open("NonExistantFile.txt")
OSError[2]: Failed to open 'NonExistantFile.txt' (No such file or directory)
Call Stack:
  #0: In '<expr>' (line 1, col 1):
open("NonExistantFile.txt")
^~~~~~~~~~~~~~~~~~~~~~~~~~~
  #1: In open(src, mode='r') [cfunc]
  #2: In io.FileIO.__init(self, src, mode='r') [cfunc]
In <thread 'main'>
```

---

