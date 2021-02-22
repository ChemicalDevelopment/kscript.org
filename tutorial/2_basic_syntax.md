---
layout: default
title: 2. Basic Syntax
parent: Tutorial
nav_order: 10
---

# 2. Basic Syntax

This part of the tutorial covers the basic syntactical elements of kscript code and how to write them. A lot of syntax should be familiar to people who have programmed in other languages, but this is also written with new programmers (and non-programmers) in mind. A more formal and full syntax documentation can be found at [https://docs.kscript.org/#Syntax](https://docs.kscript.org/#Syntax), but this is a good first step


## Terminology

The basic syntactical elements are called either "expression" (syntactical elements which yield a value) and "statements" (syntactical elements which do not yield a value). Elements which are represented by a single token are called "atom" elements. For example, numbers (i.e. `123`, `.5`, ...), names (`aname`, `another_name`, ...), and strings (`"stringvalue"`, `"anotherstring"`, ...) are all atomic elements.

So, we will first cover the atomic elements (which are all expressions) and then see how they can be combined to create more complicated programs


## Atom Expressions

### Numbers

Numbers are able to be created via numeric literals. Specifically, there are a few classes of numbers that you may want to create:

  * [`int`](https://docs.kscript.org/#int), representing an [integer](https://en.wikipedia.org/wiki/Integer)
  * [`float`](https://docs.kscript.org/#float), representing a [real number](https://en.wikipedia.org/wiki/Real_number)
  * [`complex`](https://docs.kscript.org/#complex), representing a [complex number](https://en.wikipedia.org/wiki/Complex_number), having a real and imaginary component

kscript supports all of these classes of numbers, which each have their own type in kscript. All builtin numeric types are subtypes of the [`number`](https://docs.kscript.org/#number) type (which is abstract and cannot be created directly). The numeric value can be specified with the base-10 digits of the number. The value can be specified in normal notation, [scientific notation](https://en.wikipedia.org/wiki/Scientific_notation) with the `e` or `E` characters. 


Here are some examples:

```ks
>>> 123    # int, since no '.' or exponent
123
>>> 456
456
>>> 123.   # float, due to '.'
123.0
>>> 456.   # float, due to '.'
456.0
>>> 123e0  # float, due to 'e0' (scientific notation)
123.0
>>> 123E1  # float, due to 'E1' (scientific notation)
1230.0
```

You can create a complex number by appending an `i` or `I` to the end of an integer or floating point literal (the value has a real component of 0 and an imaginary component of that integer or floating point value):

```ks
>>> 1i
1.0i
>>> 123e2i
12300.0i
```

For exact descriptions, see:

  * [Integer Literal](https://docs.kscript.org/#Integer_Literal)
  * [Float Literal](https://docs.kscript.org/#Float_Literal)
  * [Complex Literal](https://docs.kscript.org/#Complex_Literal)


### Strings


[Strings](https://en.wikipedia.org/wiki/String_(computer_science)) are sequences of characters. Specifically, strings support [unicode codepoints](https://en.wikipedia.org/wiki/Unicode) in kscript, and can be given as [UTF-8](https://en.wikipedia.org/wiki/UTF-8) literals. Most text should be stored as UTF-8, which is cross platform and cross operating system.

Strings in kscript are represented by the [`str`](https://docs.kscript.org/#str) type, and are immutable. This means that a string cannot be modified -- you need to create a new string and re-assign it to the name that the old string comes from. 

To create a string you put the textual data in between quotation marks (`'`, `"`, `'''`, or `"""`). There is no difference between using `'` and `"`, but using triple quotes (`'''` or `"""`) enables the string to wrap multiple lines and will contain the newlines (single quote strings will throw an error if they are not terminated on the same line).

Strings also support escape codes. For example, `\n` is a newline, `\\` is a literal backslash, and so on. You can see a full list [here](https://docs.kscript.org/#String_Literal)


Here are some examples of strings:

```ks
>>> "hello, world"
'hello, world'
>>> 'hello, world'
'hello, world'
```

For an exact syntactical description, see: [String Literal](https://docs.kscript.org/#String_Literal)


### Names

A variable name can be specified with a valid identifier. A valid identifier must begin with a letter, or `_`, and then it may be followed by any number of letters, digits, or `_`s. Letters may be in any alphabet recognized by Unicode.

Here are some valid identifiers that can be names in kscript:

  * `a`
  * `abc`
  * `abc123`
  * `a_very_long_name`
  * `aVeryLongName`
  * `друг`
  * `久有归天愿`

These reference a variable, in some scope. If it is defined within the current function that value is used. Then, other functions that the current function is within are searched though, and finally the global scope is searched. If none of those scopes contained a definition for the variable name, then an error is thrown


## Nested Expressions

### Lists

[Lists](https://en.wikipedia.org/wiki/List_(abstract_data_type)) are collections of other objects. They are represented by the [`list`](https://docs.kscript.org/#list) type in kscript, and can be created as literals.


To create a list, you begin with `[`, followed by the contents of the list, seperated by `,`, and finally ending with `]`. For example, an empty list can be created with `[]`. Lists can contain any expression, including other lists.

```ks
>>> []
[]
>>> [1, 2, 3]
[1, 2, 3]
>>> [[1, 2], [3, 4]]
[[1, 2], [3, 4]]
```

### Tuples

Tuples are like lists, but are immutable (which means they cannot be changed). They are represented by the [`tuple`](https://docs.kscript.org/#tuple) type in kscript, and can be created as literals.


To create a tuple, you begin with `(`, followed by the contents of the list, seperated by `,`, and finally ending with `)`. For example, the empty tuple can be created with `()`. Tuples can contain any expression, including other tuples. To avoid amibiguity, tuples with a single element must have a trailing `,`. For example: `(x,)`

```ks
>>> ()
()
>>> (1, 2, 3)
(1, 2, 3)
>>> (1)        # Not a tuple!
1
>>> (1,)       # That's better
(1,)
```


### Dictionaries

[Dictionaries, also called associative arrays,](https://en.wikipedia.org/wiki/Associative_array) are containers that hold key-val entries. You can specify dictionaries with `{`, followed by key-val pairs of `key: val`, seperated by `,`, and finally ending with `}`.

Dictionaries are ordered by insertion order of the key, which is reset when a key is deleted.

```ks
>>> {}
{}
>>> {'a': 1, 'b': 2}
{'a': 1, 'b': 2}
>>> {'a': 1, 'b': 2, 'a': 3}    # 'a' is overwritten, but keeps its place
{'a': 3, 'b': 2}
```

