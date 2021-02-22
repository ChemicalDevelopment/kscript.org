---
layout: default
title: 1. Running kscript
parent: Tutorial
nav_order: 10
---

# 1. Running kscript

There are a variety of ways to actually run kscript code. This section goes over a few common ways to do this.

First, you will need access to kscript. You can [install it](/install), [build it](/build), or run it for free online at [term.kscript.org](//term.kscript.org). You can check these methods in this page for different ways of running kscript code, which may be easier or more well-suited for a particular use case


## REPL

A [REPL](https://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop) is a read-eval-print-loop, which is typically ran in a terminal or some other text-based interface. It is very useful for using kscript like a calculator, since it supports numeric operations out of the box, and a ton of utilities available as builtins.

A free online kscript REPL is provided at [term.kscript.org](//term.kscript.org). It uses a WASM-based build of kscript and runs in your browser! Just open it up and start typing


The basic format is as follows:

  * A prompt is printed on a new line (`>>>` is the default prompt for kscript)
  * The user types in the valid kscript code, and when enter/submit
    * If the line begins a multiline construct (for example, `if true {`), then continutation prompts (`...` is the default) are printed and lines are read until the constructs are finished
  * All the lines read are put together, and executed
  * If there was an exception thrown, the exception is caught, printed, and then ignored. Otherwise, the result of the last line is printed
  * Steps are repeated until EOF is given (via `ctrl-D` on most terminals), or the interpreter is exited (see [exit()](//docs.kscript.org/#exit))


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

You can also run a kscript file (typically ending with `.ks`, for example `myfile.ks`). You can do this with the `ks` (`ks.exe` on Windows) binary that was installed. This typically requires you to [install kscript](/install), [build kscript](/build), or be using a system that already has kscript installed.

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


