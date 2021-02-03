---
layout: default
parent: Syntax
title: 'Literals'
permalink: /syntax/literals
nav_order: 10
---

# Literals
{: .no_toc }

[Literals](https://en.wikipedia.org/wiki/Literal_(computer_programming)) are ways of specifying a value. Some literals are of immutable types (i.e. [`int`](/builtins#int), [`str`](/builtins#str), etc.), and some create a mutable type (i.e. [`list`](/builtins#list), [`dict`](/builtins#dict), etc.). Immutable



 * TOC
{:toc}

---


## Numbers {#numbers}

### Integers {#integers}

[Integer](/builtins#int) literals (which are of type [`int`](/builtins#int)) can be specified in a number of different ways. The most common is with the base 10 digits, together in the source code.

Note that there are no negative integer literals -- for example `-123` is actually a unary operator `-` applied positive integer literal `123`.

Integers may also be prefixed, in order to specify digits in a [base](https://en.wikipedia.org/wiki/Radix) other than ten. For example, the `0d`/`0D` prefix is for base-10 (although this prefix is completely unneccessary). Here are the other prefixes, and the format for each of them:


#### Base 2 (binary) (`0b`/`0B`)

Using the `0b`/`0B` prefix indicates that the number is in binary notation. Therefore, the only valid digits are `0` and `1`.

Examples:

```ks
>>> 0b1
1
>>> 0b10101
21
>>> 0b1111011
123
```

#### Base 8 (octal) (`0o`/`0O`)

Using the `0o`/`0O` prefix ("zero oh", the number, then the letter) indicates that the number is in binary notation. Therefore, the valid digits are `0`, `1`, `2`, `3`, `4`, `5`, `6`, and `7`.

Examples:

```ks
>>> 0o1
1
>>> 0o377
255
>>> 0o173
123
```

#### Base 10 (default) (decimal) (`0d`/`0D`/no prefix)

Using the `0d`/`0D` prefix or no prefix indicates that the number is in decimal notation. Therefore, the valid digits are `0`, `1`, `2`, `3`, `4`, `5`, `6`, `7`, `8`, and `9`.

Examples:

```ks
>>> 1
1
>>> 0d1
1
>>> 123
123
>>> 0d123
123
```

#### Base 16 (hexadecimal) (`0x`/`0X`)

Using the `0x`/`0x` prefix indicates that the number is in hexadecimal notation. Therefore, the valid digits are `0`, `1`, `2`, `3`, `4`, `5`, `6`, `7`, `8`, `9`, `a`/`A`, `b`/`B`, `c`/`C`, `d`/`D`, `e`/`E`, `f`/`F`.

See: [Hexadecimal](https://en.wikipedia.org/wiki/Hexadecimal)

Examples:

```ks
>>> 0x1
1
>>> 0xFF
255
>>> 0x7B
123
```

---

### Floats {#floats}

[Float](/builtins#float) literals, similar to [integer literals](#integers), are specified via the digits of their values. Floating point literals can represent any positive, real number, as well as `inf` (+infinity) and `nan` (not-a-number).  However, floating point literals must include either a `.` character, which specifies the units place, dividing the integral part from the fractional part, or an exponent suffix starting with `e` or `E`. This means that `123` is an integer literal but `123.` and `123e0` are floating point literal.


Floating point literals also support bases 2, 8, 10, and 16 with the same prefix as integer literals. However, the exponent tag differs. For base 10, the `e`/`E` exponent character is supported (See: [scientific notation](https://en.wikipedia.org/wiki/Scientific_notation)) for base-10 exponentiation. For other bases (2, 8, 16), the `p`/`P` exponent, and the exponent is specified in base-10, but the exponent is base-2.


```ks
>>> 1.0
1.0
>>> 0xFF.0
255.0
>>> 0x7B.0
123.0
```

---

### Complex (Imaginary) {#complexes}

[Complex](/builtins#complex) literals (specifically, imaginary literals) are created with any [integer literal](#integers) or [float literal](#floats) followed by an `i` or `I` suffix. Only positive imaginary complex numbers can be created as literals -- you can use the `+` or `-` operators to create a complex numbers with real and imaginary components.


Examples:

```ks
>>> 1i
1.0i
>>> 0xFFi
255.0i
```

---

## Others

### String {#strings}

[String](/builtins#str) literals are created via the quotes `'`, `"`, or the triple-quote variants `'''`, `"""`. The string must begin and end with the same quote. Everything in between the quotation marks is either a character or an escape sequence. Below is a table of allowed escape sequences:

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


Examples:

```ks
>>> "abc"
'abc'
>>> "\""  # Escape sequence
'"'
>>> "\u03C0 is yummy"  # Escape sequence
'π is yummy'
>>> "\N[GREEK SMALL LETTER PI] is yummy"  # Same thing, different escape sequence
'π is yummy'
```

---


## Containers

### List {#list}

[List](/builtins#list) literals are created with `[` and `]` enclosing the initial elements in the list. The empty list can be created with `[]` or `[,]`. 

Since lists are mutable, the resulting list is not a constant, but rather a mutable value initialized with the elements between `[` and `]`. Elements are seperated with `,`, and an optional `,` after all the elements.

Lists can be created with iterable unpacking, with the `*` prefix operator. For example, `[..., *x, ...]` places each element within `x` at that position at the list, unpacking it.

Lists can be created with comprehension, with the `a for b in c` and `a for b in c if d` expressions (see examples), which adds the expression `a`, evaluated for each `b` in `c`. If the `if d` part is added, then only elements `b` for which `d` is true are added 


Examples:

```ks
>>> [1, 2, 3]
[1, 2, 3]
>>> [1, 2, 3,] # Optional trailing ','
[1, 2, 3]
>>> [1, 2, *"abc"]   # Expands "abc", and adds each element to the list
[1, 2, 'a', 'b', 'c']
>>> [1, 2, *[3, 4, 5]]  # Flattens another list
[1, 2, 3, 4, 5]
>>> [x ** 2 for x in range(1, 4), x ** 3 for x in range(1, 4)]  # List comprehension
[1, 4, 9, 16, 1, 8, 27, 256]
>>> [x ** 2 for x in range(1, 4) if x > 2, x ** 3 for x in range(1, 4) if x > 3]  # List comprehension
[9, 16, 256]
```

---

### Tuple {#tuple}

[Tuple](/builtins#tuple) literals are created similar to [list literals](#list), except they use `(` and `)` around their elements. The empty tuple can be created with `()` or `(,)`. And tuples with a single initializer require a trailing comma to differentiate from a normal parenthetical grouping (i.e. `(x,)`)


Tuples can be created with iterable unpacking, with the `*` prefix operator. For example, `(..., *x, ...)` places each element within `x` at that position in the tuple, unpacking the contents

Tuples can be created with comprehension, with the `a for b in c` and `a for b in c if d` expressions (see examples), which adds the expression `a`, evaluated for each `b` in `c`. If the `if d` part is added, then only elements `b` for which `d` is true are added 

Examples:

```ks
>>> (1, 2, 3)
(1, 2, 3]
>>> (1, 2, 3,) # Optional trailing ','
(1, 2, 3)
>>> (1, 2, *"abc")   # Expands "abc", and adds each element to the list
(1, 2, 'a', 'b', 'c')
>>> (1, 2, *(3, 4, 5))  # Flattens another tuple
(1, 2, 3, 4, 5)
>>> (x ** 2 for x in range(1, 4), x ** 3 for x in range(1, 4))  # Tuple comprehension
(1, 4, 9, 16, 1, 8, 27, 256)
>>> (x ** 2 for x in range(1, 4) if x > 2, x ** 3 for x in range(1, 4) if x > 3)  # Tuple comprehension
(9, 16, 256)
```

---

### Set {#set}

[Set](/builtins#set) literals are created similar to [list literals](#list), except they use `{` and `}` around their elements. To avoid ambiguity with [dictionary literals](#dict), the empty set must be created via `set()` (as `{}` is the empty dictionary). 

Sets can be created with iterable unpacking, with the `*` prefix operator. For example, `{..., *x, ...}` places each element within `x` at that position in the set, unpacking the contents

Sets can be created with comprehension, with the `a for b in c` and `a for b in c if d` expressions (see examples), which adds the expression `a`, evaluated for each `b` in `c`. If the `if d` part is added, then only elements `b` for which `d` is true are added 

Examples:

```ks
>>> {1, 2, 3}
{1, 2, 3}
>>> {1, 2, 3,} # Optional trailing ','
{1, 2, 3}
>>> {1, 2, 3, 2, 1, 4}  # Duplicate elements are only added once
{1, 2, 3, 4}
>>> {1, 2, *"abc"}   # Expands "abc", and adds each element to the set
{1, 2, 'a', 'b', 'c'}
>>> {x ** 2 for x in range(1, 4), x ** 3 for x in range(1, 4)}  # Set comprehension
{1, 4, 9, 16, 8, 27, 256}
>>> {x ** 2 for x in range(1, 4) if x > 2, x ** 3 for x in range(1, 4) if x > 3}  # Set comprehension
[9, 16, 256]
```

---

### Dict {#dict}

[Dictionary](/builtins#dict) literals are created similar to [list literals](#list), except they use `{` and `}` around their elements, with `:` between each key and value. The empty dictionary is `{}`


Dictionaries can be created with comprehension, with the `ka: va for b in c` and `ka: va for b in c if d` expressions (see examples), which adds the key/val pair `ka: va`, evaluated for each `b` in `c`. If the `if d` part is added, then only elements `b` for which `d` is true are added 

Examples:

```ks
>>> {}
{}
>>> {"x": 2, "y": 3}
{'x': 2, 'y': 3}
>>> {"x": 2, "y": 3, "x": 4}  # The value for 'x' is changed, but the order is not
{'x': 4, 'y': 3}
```
