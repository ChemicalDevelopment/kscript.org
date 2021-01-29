---
layout: default
title: Overview
nav_order: 1
description: "kscript is a dynamic programming language with a rich standard library, well suited to solve all sorts of problems"
permalink: /
---


# kscript.org -- Official Documentation
{: .no_toc .fs-9 }

kscript is a programming language with expressive syntax, cross-platform support, and a rich standard library
{: .fs-6 .fw-300 }

[How To Install](/install#install-guide){: .btn .btn-primary .fs-5 .mb-4 .mb-md-0 .mr-2 } [How To Build](/install#build-guide){: .btn .btn-primary .fs-5 .mb-4 .mb-md-0 .mr-2 }

---


 * TOC
{:toc}



## What is kscript?

kscript ([https://kscript.org](https://kscript.org)) is a dynamic programming language with expressive syntax, cross platform support, and a rich standard library. Its primary aim is to allow developers to write platform agnostic programs that can run anywhere, and require little or no platform- or os- specific code.

Documentation is available at [kscript.org](https://kscript.org), which provides examples, tutorials, and coverage of the standard library. Formal specifications are available at the GitHub repository ([https://github.com/ChemicalDevelopment/kscript](https://github.com/ChemicaldDvelopment/kscript)), within the `docs` folder.


## Why is kscript?

kscript was designed to be a tool useful in many different circumstances -- as a computer calculator, as a task-automation language, GUI development language, numerical programming, and more. A few languages may come to mind -- namely Python, tcl, and so forth.

I found that I had issues with some choices the Python team made. Syntactically, I dislike required/syntactically-significant whitespace, and dislike Python's overuse of `:`. . I feel that many Python modules (for example, `os`) do not give the best interface to their functionality, and often require the programmer to use platform-specific code. I'd like to conclude this paragraph with a redeeming note -- Python has been very successful and I largely do enjoy the language (even though I have my complaints), and even borrow the great ideas Python has had.

To see comparisons of kscript to other languages, see [more/compare](/more/compare)

## Who is kscript?

kscript is developed by free software enthusiasts, under the organization [ChemicalDevelopment](https://chemicaldevelopment.us). Feel free to contact current authors with questions, comments, or concerns at any time:

  * [Cade Brown &lt;cade@kscript.org&gt;](mailto:cade@kscript.org)
  * [Gregory Croisdale &lt;greg@kscript.org&gt;](mailto:greg@kscript.org)

See more [here](/contact)


## Basic Examples

Some examples can be ran directly as an option to `ks -e`, or ran in the interactive interpeter via `ks -`. Some are recommended to save to a file, and run directly via `ks <filename>`.

You can see a list of examples in [the path '/examples'](https://github.com/ChemicalDevelopment/kscript/tree/master/examples)

### 0. Interactive Interpreter

The interactive interpreter can be started a few ways:

```shell
$ ks
>>>
$ ks -
>>>
```

Once you are in the interactive interpreter, prompts (`>>>`) are given and you can enter in statements one after another, which will be executed. If the statement was an expression, and nothing else was printed during its execution, the result of the expression is printed. 

The variable `_` is the result of the last expression executed. Or, if there was an error thrown, then the `_` variable is set to the exception that was thrown.

You can enter the `EOF` character (on most terminals, this is done with the `Control+D` key combination) to terminate the interpreter. Using `Control+C` will cause the following message to be printed:

```shell
$ ks
>>> 
Use 'CTRL-D' or 'exit()' to quit the process
>>>
```

Multi-line constructs are supported, but you must begin your braces on that line. For example, entering a simple `for` loop (that uses 3 lines) can be done like so:

```shell
$ ks
>>> for i in range(4) {
...   print (i)
... }
0
1
2
3
>>>
```

All it requires is that `(`, `[`, or `{` occurs more than the corresponding `)`, `]`, and `}`. While there are more left sides of these groupings, the interpreter will give more continuation lines that begin with `...` instead of the primary prompt `>>>`. You can use `Control+C` to cancel and throw away any lines created if you made a mistake. For example:


```shell
$ ks
>>> for i in Range(4) {
... <Control+C>
>>> for i in range(4) {
...   print (i)
... }
0
1
2
3
>>>
```

(note the `Range` when `range` was intended)


You can also use the interactive interpreter with a redirected source to the input:


```shell
$ echo 'print ("Hello World")' | ks -
Hello World
$ ./bin/ks - <<<'for i in range(4), print (i)'
0
1
2
3
```

Syntax for redirection will vary based on your shell or other utility. The examples shown are for Bash.


### 1. 'Hello, World'

The most basic example in kscript is very easy:

Full source code, including a [shebang](https://en.wikipedia.org/wiki/Shebang_(Unix)), documentation string, and the actual code itself is located [here](https://github.com/ChemicalDevelopment/kscript/blob/master/examples/hello_world.ks)

```ks
#!/usr/bin/env ks
""" hello_world.ks - the classic 'first program' example, implemented in kscript


NOTE: https://en.wikipedia.org/wiki/%22Hello,_World!%22_program

@author: Cade Brown <cade@kscript.org>
"""

print ("hello, world")
```

Running:

```shell
$ ks hello_world.ks
hello, world
$ ./hello_world.ks
hello, world
```

