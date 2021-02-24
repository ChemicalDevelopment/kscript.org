---
layout: default
title: 1. Basics
parent: Tutorial
nav_order: 10
---

# 1. Basics

The [syntax of kscript](https://docs.kscript.org/#Syntax) is large, and covers many corner cases that aren't needed in an introduction. Therefore, this part of the tutorial deals with the most commonly used parts of kscript, and shows newcomers (who may or may not be programmers) how kscript works.

The full syntax specification for kscript can be found [here](https://docs.kscript.org/#Syntax), which you are welcome to read

To understand kscript code, you should understand [object-oriented programming (OOP)](https://en.wikipedia.org/wiki/Object-oriented_programming). While it may seem complicated, it is actually quite easy to understand the basic principles of OOP. Here is how I like to explain it:

  * Every value (including numbers, strings, lists, etc.) is an [object](https://en.wikipedia.org/wiki/Object_(computer_science)). So, a number is an object, a string is an object, and so forth.
  * Every object has a [type](https://en.wikipedia.org/wiki/Data_type) (some languages call it a "class", but kscript calls them types), which describes what kind of object it is, and what features the object will have
    * Individual objects, however, may have additional features not present in the type
  * Types are derived from other types, and all types are eventually derived from [`object`](https://docs.kscript.org/#object)
    * This forms what is called the [type (or class) hierarchy](https://en.wikipedia.org/wiki/Class_hierarchy)
  * New objects can be created in a number of ways, the most common being calling the constructor
    * The constructor is just a fancy name for calling the type as a function. For example, calling `int("123")` is calling the `int` constuctor to make a new object

On top of standard OOP, kscript adds elements of [duck typing](https://en.wikipedia.org/wiki/Duck_typing), and features common in other [dynamic programming languages](https://en.wikipedia.org/wiki/Dynamic_programming_language). Here are some of those features:

  * Variables are not typed, which means they can contain objects of any kind
  * Manual type checks are not required (most of the time). Instead, the [duck test](https://en.wikipedia.org/wiki/Duck_test) is applied


## Numbers

Numbers in kscript are instances of the [`number`](https://docs.kscript.org/#number) type. But, since it an abstract type, there can't be any actual `number` objects directly. Instead, they must be a member of a derived type. Here are some of the builtin types:

  * [`int`](https://docs.kscript.org/#int), which represents an [integer](https://en.wikipedia.org/wiki/Integer)
  * [`bool`](https://docs.kscript.org/#bool), which represents a [boolean](https://en.wikipedia.org/wiki/Boolean_data_type)
    * There are only two 'bool' values, `true` and `false`. They behave like the integers `1` and `0` respectively
  * [`float`](https://docs.kscript.org/#float), which represents a [floating point number](https://en.wikipedia.org/wiki/Floating-point_arithmetic)
  * [`complex`](https://docs.kscript.org/#complex), which represents a [complex number](https://en.wikipedia.org/wiki/Complex_number), with floating point real and imaginary components


Numbers can be created the way they are typically written out. Numbers that have a `.` in them are considered floats, and numbers without them are considered integers. An `i` or `I` can be added to the end of an integer or float to create an imaginary number (i.e. a complex number with a real component of `0.0`). Here are some examples:

```ks
>>> 123      # integer
123
>>> 123.0    # float
123.0
>>> 123i     # complex
123.0i
```

You can also use [scientific notation](https://en.wikipedia.org/wiki/Scientific_notation) to describe floating point values (using `e` or `E` as the mantissa-exponent seperator):


```ks
>>> 1.23e2
123.0
>>> 123e-2
1.23
```

There are a few global variables which represent special values:

```ks
>>> inf      # float, represents infinity
inf
>>> nan      # float, represents not-a-number
nan
>>> true     # bool, represents 'true'/'yes'/1
true
>>> false    # bool, represents 'false'/'no'/0
false
```


You can use the standard operators to combine numbers in common operations. A full list of operators can be found [here](https://docs.kscript.org/#Operators).

There are precedences to the operators, which match most other programming languages. So, for example, `a + b * c` is parsed the same as `a + (b * c)`, whereas `a + b + c` is parsed the same as `(a + b) + c`.

In general, the operators work like you'd expect them to. `+` add numeric types, `-` subtracts them, and so forth. One difference in kscript compared to some languages is the division operator(s). In kscript, there is normal division (`/`) and floored division (`//`). Normal division returns a close approximation to the true value. For example, `1 / 2 == 0.5` (yes, two integers divided with `/` will result in a floating point value). Floored division, however, will return an integer of the result, rounded down. This means that `1 // 2 == 0` and `-1 // 2 == -1`.


## Strings


[Strings](https://en.wikipedia.org/wiki/String_(computer_science)) are sequences of characters. Specifically, kscript strings support [unicode codepoints](https://en.wikipedia.org/wiki/Unicode), and can be given as [UTF-8](https://en.wikipedia.org/wiki/UTF-8) literals. Most text should be stored as UTF-8, which is cross platform and cross operating system.

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


## Variables

[Variables](https://en.wikipedia.org/wiki/Variable_(computer_science)) in kscript can be specified with a valid identifier. A valid identifier must begin with a letter, or `_`, and then it may be followed by any number of letters, digits, or `_`s. Letters may be in any alphabet recognized by Unicode.

Here are some valid identifiers that can be names in kscript:

  * `a`
  * `abc`
  * `abc123`
  * `a_very_long_name`
  * `aVeryLongName`
  * `друг`
  * `久有归天愿`

These reference a variable, in some scope. If the given name is defined within the current function that value is used. Then, other functions that the current function is within are searched though, and finally the global scope is searched. If none of those scopes contained a definition for the variable name, then an error is thrown

You can assign to variables with the `=` operator, and then recall the value of the variable with the name assigned to. Here are some examples:

```ks
>>> var_name        # not defined yet!
NameError: Unknown name: 'var_name'
Call Stack:
  #0: In '<inter-0>' (line 1, col 1):
var_name
^~~~~~~~
In <thread 'main'>
>>> var_name = 123  # assign an 'int' to it
123
>>> var_name        # now, recall the value
123
```

## Functions




## Lists

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

## Tuples

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


## Dictionaries

[Dictionaries, also called associative arrays,](https://en.wikipedia.org/wiki/Associative_array) are containers that hold key-val entries. You can specify dictionaries with `{`, followed by key-val pairs of `key: val`, seperated by `,`, and finally ending with `}`.

Dictionaries are ordered by insertion order of the key, which is reset when a key is deleted.

Dictionaries in kscript are represented by the [`dict`](https://docs.kscript.org/#tuple) type.

```ks
>>> {}
{}
>>> {'a': 1, 'b': 2}
{'a': 1, 'b': 2}
>>> {'a': 1, 'b': 2, 'a': 3}    # 'a' is overwritten, but keeps its place
{'a': 3, 'b': 2}
```

Dictionaries can be subscripted to retrieve the value associated with a given key:

```ks
>>> {'a': 1, 'b': 2}['a']
1
```


## Statements

## Import Statements

[Import statements](https://docs.kscript.org/#Import_Statement) are specified with the `import` keyword and can be used to import a module with a given name into the current namespace. See the [standard modules](https://docs.kscript.org/#Modules) for example modules that are always available


Examples:

```ks
# imports operating system module
import os

# Prints: <'os' module from '<builtin>'>
print (os)

# imports networking module
import net

```
## Throw Statements

[Throw statements](https://docs.kscript.org/#Throw_Statement) are specified with the `throw` keyword and are used to throw an exception up the call stack, to a corresponding `try` statement.


Examples:

```ks
# Throw an error
throw Error("This is really bad!")

# Throws a different type of error
throw MathError("This isn't adding up...")

```

## Try Statements

[Try statements](https://docs.kscript.org/#Try_Statement) are specified with the `try` keyword, a body of possibly-volatile code, followed by `catch` clauses and, optionally, a `finally` clause.


Here are some examples:

```ks

try {
    possibly_bad_operation()
} catch NameError as err {
    # Unknown name
} catch MathError as err {
    # Some math issue
} finally {
    # Free some resources...
}

```

If there are no matching `catch` clauses with a type that matches the exception type thrown, then the `finally` block is ran, and the exception is not handled, but rather keeps travelling upwards until another `try`/`catch` statement is found, or, if there are no more, then the program halts and prints a message

