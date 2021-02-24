---
layout: default
title: 0. Running kscript
parent: Tutorial
nav_order: 0
---

# 0. Running kscript


Thee first part of this tutorial will cover how to set up kscript, and different ways to run kscript code.

You will need access to a kscript interpreter. There are a few ways to do that:

  * You can [install it](/install) (this is recommended)
  * You can [build it yourself](/build) (not recommended for newcomers)
  * You can run it free online, in your browser, at [term.kscript.org](https://term.kscript.org)

Installing or building it allows you to run files on your computer, whereas running online only provides a REPL shell (but, it is free and can run on your desktop, laptop, or phone). So, using the online REPL should be fine for the start of the tutorial, but at some point you will want to install or build kscript for your computer.

## REPL

A [REPL](https://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop) is a read-eval-print-loop, which is typically ran in a terminal or some other text-based interface. It is very useful for using kscript like a calculator, since it supports numeric operations out of the box, and a ton of utilities available as builtins.

There are a few ways to get a kscript REPL:
  
  * With kscript installed or built, there should be a `ks` binary (or `ks.exe` on windows). You can run `ks` or `ks -` to start a kscript REPL in your shell
  * Online, at [term.kscript.org](https//term.kscript.org), a free REPL 

A free online kscript REPL is provided at [term.kscript.org](//term.kscript.org). It uses a WASM-based build of kscript and runs in your browser! Just open it up and start typing



The kscript REPL repeats the following steps:

  * A prompt is printed (`>>>` is the default), which is asking the user to input the next line
  * The user types in the valid kscript code, and when the line is finished, should press `enter`/`submit` on their keyboard
    * If the line begins a multi-line construct (for example, `if true {`), then continuation props (`...` is the default) and lines are read until the constructs are finished
  * The input is executed
  * If there was an exception.error thrown, the exception is caught, printed, and then ignored. Otherwise, the result of the last line is printed
  * These steps are repeated until an EOF is given (normally pressing `control` and `D` on most keyboards), or the interpreter is exited (see [exit()](//docs.kscript.org/#exit))

The kscript REPL keeps track of variables, functions, and modules used thus far. So, assigning with `x = 4` means you can reference `x` in later lines. Additionally, the `_` variable is set on each prompt to be the result of the previous line, or the exception object if one was thrown as a result of the last line.

On this website, and the [docs](https://docs.kscript.org), REPL code may be shown in code blocks with `>>>` and `...` starting lines that correspond to input, and other lines being the output. Here's a short example:

```ks
>>> 2 + 3
5
>>> 1 / 0
MathError: Division by 0
Call Stack:
  #0: In '<inter-3>' (line 1, col 1):
1 / 0
^~~~~
  #1: In number.__div(L, R) [cfunc]
In <thread 'main'>
>>> 2 + 3 + 4
9
>>> _ + 5
14
```


Here's an example of using a multiline construct:

```ks
>>> if true {
...   print("good things")
... }
good things
```

## File Contents

Executing a file's contents on your computer can be done if you have installed or built kscript yourself. Currently, the free online kscript implementation does not have support for running files (although this feature is likely to be added at some point).

Files containing kscript code, by convention, are expected to end with the file extension `.ks`. You can run such files with the `ks` binary (`ks.exe` on Windows), by giving them as the first commandline argument. For example, to run `myfile.ks`, you would run `ks myfile.ks` (`ks.exe myfile.ks` on Windows).

In your shell, you can run:

```shell
$ ks myfile.ks
```

Which will read `myfile.ks`, and treat it as kscript code (throwing an error if it was invalid). Then, it runs the entire file contents and exits once it is done.

Here's a basic example:

```shell
$ echo 'print("hello, world")' > myfile.ks
$ cat myfile.ks
print("hello, world")
$ ks myfile.ks
hello, world
```

## Standard Input

On shells that support [pipes](https://en.wikipedia.org/wiki/Pipeline_(Unix)) (usually with `|`), kscript can execute code coming from a redirected input. For example:

```shell
$ echo 'print("hello, world")' > myfile.ks
$ cat myfile.ks
print("hello, world")
$ cat myfile.ks | ks myfile.ks
hello, world
```

This is actually running a REPL, but without printing the prompts out. This means that the interpreter executes line-by-line instead of reading all the input and executing at once

