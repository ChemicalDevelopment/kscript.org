---
layout: default
title: 2. Builtins
parent: Tutorial
nav_order: 20
---

# 2. Builtins

Now that we've covered basics of how to program kscript, we will introduce the so-called "builtins". This term refers to the types and functions available as part of the default namespace, without having to import any extra modules.

We've already covered some of the builtin types (`int`, `str`, `list`, etc), so this section focuses on the builtin functions. You can find a full list [here](https://docs.kscript.org/#Functions).


## Output

At some point (probably immediately) you will want your program to actually display results in some way. This may be printing to the console, writing to a file, or something else.

There are a few ways to print, and they are listed in this section


### print(*args)


The most common way to output information is the [`print`](https://docs.kscript.org/#print) function, which takes any number of arguments, and prints them all out (with a space in between each), and then a newline.


Here are some examples:

```ks
# No arguments is okay, just prints a newline
#
print()

# 1 argument just prints out the argument (converted to string)
# 1
print(1)

# 2 or more arguments prints out all arguments, converted to string, with spaces in between
# 1 2 3
print(1, 2, 3)



```

### printf(fmt, *args)

The [`printf`](https://docs.kscript.org/#printf) function is similar to `print`, but it prints formatted output (thus the `f` after `print`). You can see the [documentation for `printf`](https://docs.kscript.org/#printf) for a full description, but here are the basics:

  * The argument `fmt` is required, and is required to be a string. It contains format specifiers, which tell what kind of object to print
  * `args` is the list of arguments that `fmt` references the kind of with specifiers
  * The character `%` is special. To print a `%`, you need to put `%%` in the first argument
  * When `%` has a letter after it (for example, `%i`, `%f`), it is treated as a format specifier
    * `%i` is for integer, `%f` is for floats, and so on
  * Text in between format specifiers and `%%` is printed normally
  * There are no spaces or newlines added

Note: If you want to print a newline, you should add `\n` to the end of `fmt`. Without this, a newline will not be printed

Here are some examples:


```ks
# This is not okay! At least one argument is required
printf()

# A format string can be printed ('\n' will end the line, required in printf)
# example text
printf("example text\n")

# Replaces '%i' with the corresponding argument, treated as an integer
# value: 123
printf("value: %i\n", 123)

# Replaces each format specifier with each argument
# values: 1, 2, 3.0
printf("values: %i, %i, %f\n", 1, 2, 3)

```

### open(src, mode='r')

The [`open`](https://docs.kscript.org/#open) function can open a file for reading (and/or writing) on your hard drive. kscript will throw an error if there was no such file. You can see the exact semantics at the [official docs]([`open`](https://docs.kscript.org/#open))


`mode` is an optional argument, which tells how the file should be opened. There are quite a few modes, but for most users, they care about text-based modes (i.e. strings, human-readable text). Here are the basic modes:

  * `r` (default): Opens the file for reading
  * `w`: Opens the file for writing (and clears the file if it existed)
  * `a`: Opens the file for appending (i.e. writes to the end)



TODO: This is not finished

