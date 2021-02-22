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

## Operators

Like most languages, kscript supports operators. Specifically, it supports unary, binary, and ternary operators. You can see a full list [here](https://docs.kscript.org/#Operators). There are precedences to the operators, which match most other programming languages. So, for example, `a + b * c` is parsed the same as `a + (b * c)`, whereas `a + b + c` is parsed the same as `(a + b) + c`.

Check out the [official operators documentation]([here](https://docs.kscript.org/#Operators)) for the full list of operators and their precedences.

In general, the operators work like you'd expect them to. `+` add numeric types, `-` subtracts them, and so forth. One difference in kscript compared to some languages is the division operator(s). In kscript, there is normal division (`/`) and floored division (`//`). Normal division returns a close approximation to the true value. For example, `1 / 2 == 0.5` (yes, two integers divided with `/` will result in a floating point value). Floored division, however, will return an integer of the result, rounded down. This means that `1 // 2 == 0` and `-1 // 2 == -1`.

Here are some examples:

```ks
>>> 2 + 3
5
>>> 2 ** 3   # Exponentiation
8
```

Operators, however, also have uses for types other than numbers. Take, for example, the `+` operator (the 'add' operator). It is overloaded to support `list` objects as well:

```ks
>>> [1, 2] + [3, 4]
[1, 2, 3, 4]
```

You can check specific types to see what operators they overload


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


## If Statements

[If statements](https://docs.kscript.org/#If_Statement) are created with the `if` keyword. They take a conditional, a body of other statements, and then a list of clauses (`elif`, or `else` clauses)

The basic control flow is:

  * Evaluate the conditional expression
  * If the conditional was truthy, evaluate the body and stop
  * If the conditional was not truthy, go through each `elif` clause and evaluate conditionals until a truthy one is discovered. Run that body and stop
  * If there were no `elif` clauses found with a truthy conditional, and there was an `else` clause, run the body of that `else` clause and stop


Here are some examples:

```ks
if true {
    print("this always runs")
}

if false {
    print("this never runs")
} else {
    print("this always runs")
}

# Assume 'coinflip' is a fair function defined...
if coinflip() {
    print("this runs half the time")
} else {
    print("this runs the other half")
}

if coinflip() {
    print("this runs half the time")
} elif coinflip() {
    print("this runs half of the other half (so .25 of the time)")
} elif coinflip() {
    print("this runs half of the other half of the other half (so .125 of the time)")
} elif {
    print("extremely unlikely!")
}

```


## While Statements

[While statements](https://docs.kscript.org/#While_Statement) are similar to `if` statements, except that they continually execute their body while the conditional is true.

While statements also allow `elif` and `else` clauses. However, they are only checked on the first run of the conditional. If it returns false, then it works like an `if` statement. However, if the conditional was truthy on the first run, and then falsey on a subsequent run, then the `elif`/`else` clauses are not even checked.


Here are some examples:

```ks
while true {
    print("infinite loop")
}

while false {
    print("never runs")
} else {
    print("runs once")
}

x = true
while x {
    print("runs once")
    x = false
} else {
    print("never runs")
}

# Example showing 'elif' clause
while true {
    ...
} elif false {
    ...
} elif other_value {
    ...
} else {
    ...
}

```

You can use [`break` statements](https://docs.kscript.org/#Break_Statement) and [`cont` statements](https://docs.kscript.org/#Cont_Statement) to break the current loop or continue through to the next iteration

## For Statements

[For statements](https://docs.kscript.org/#For_Statement) iterate over collections, and any other iterable objects. `for` loops in kscript are what some languages call `foreach`, in that they loop over collections instead of being a glorified `while` loop. They are specified with the `for` keyword, followed by an assignable expression, followed by the `in` keyword, and followed by an expression which is the iterable being looped over. Then, a body is specified to be ran for each element in the iterable. Before the body is ran, the item from the iterable is assigned to the assignable expression.


For statements also allow `elif` and `else` clauses. However, they are only checked on the first run of the iterable. If it is empty, then it works like an `if` statement. However, if the iterable had an element on the first run, and then is empty on a subsequent run, then the `elif`/`else` clauses are not even checked.


Here are some examples:

```ks
# Will print 1, 2, and then 3
for x in [1, 2, 3] {
    print(x)
}

for x in [] {
    print("never runs")
} else {
    print("runs once")
}

# Example showing 'elif' clause
for x in [] {
    print("never runs")
} elif false {
    ...
} elif true {
    print("runs once")
} else {
    ...
}

```

You can use [`break` statements](https://docs.kscript.org/#Break_Statement) and [`cont` statements](https://docs.kscript.org/#Cont_Statement) to break the current loop or continue through to the next iteration



