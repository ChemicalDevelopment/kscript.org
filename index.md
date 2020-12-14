---
layout: default
title: Overview
nav_order: 1
description: "kscript is a scripting language with a rich standard library, well suited to solve all sorts of problems"
permalink: /
---


# kscript.org -- Official Documentation
{: .no_toc .fs-9 }

kscript is a programming language with expressive syntax, cross-platform support, and a rich standard library
{: .fs-6 .fw-300 }

[How To Install](#installation-guide){: .btn .btn-primary .fs-5 .mb-4 .mb-md-0 .mr-2 } [Basic Examples](#basic-examples){: .btn .fs-5 .mb-4 .mb-md-0 .mr-2 }

---

 * TOC
{:toc}


# Installation Guide

## Installation (Package Manager)

Installing with a package manager is the recommended way to install kscript. This will ensure that your distribution has been tested and will work on your system.

```shell
$ sudo apt install kscript # Debian, Ubuntu, and derivatives
```

Example:

```shell
$ ks --version
0.0.1
$ ks -e 'print ("Hello World")'
Hello World
$ ks -itime -e 'time.format()'
Mon Nov 30 18:27:35 2020
```


## Installation (From GitHub Releases)

If, for whatever reason, your package manager is not listed, or some other complication arises, you can download binaries from the [GitHub Releases](https://github.com/ChemicalDevelopment/kscript/releases).

The naming scheme is `kscript-<VERSION>-<ARCH>.tar.gz`. You can download that file and extract it. It will contain the directories:

```
bin/
lib/
include/
```

The structure is meant to mirror traditional Unix directory structure, which means you can extract to `/usr/local` and it should work as if you had installed it via a package manager. However, you can also extract it in a local directory, and run that local binary (i.e. `./bin/ks`).


Example:

```shell
$ tar xfv kscript-0.0.1-x86_64.tar.gz
bin/ks
lib/libks.so
... # all the files
include/ks/ks.h
$ ./bin/ks --version
0.0.1
$ ./bin/ks -e 'print ("Hello World")'
Hello World
$ ./bin/ks -itime -e 'time.format()'
Mon Nov 30 18:27:35 2020
```

## Building From Source

Sometimes you may want to build your own version from the source code. This is a guide for those users. Again, it should be reiterated that this option is not recommended for beginners

To get the source code, you can either clone the [repository on GitHub](https://github.com/ChemicalDevelopment/kscript):

```shell
$ git clone https://github.com/ChemicalDevelopment/kscript.git && cd kscript
```

Or, you can download [a specific version](https://github.com/ChemicalDevelopment/kscript/releases), and extract that archive.

Once you're inside the kscript source directory, you should be able to run these commands to configure and build kscript:

```shell
$ ./configure
$ make # use '-j<num>' for multicore compilation
$ make check # runs some sanity checks (optional, but recommended)
$ sudo make install # installs to '/usr/local' (optional)
```

You can run the kscript interpreter locally via:

```shell
$ ./bin/ks --version
0.0.1
$ ./bin/ks -im -e 'm.pi'
3.141592653589
```

On some platforms (for example, Windows), there is a `.exe` suffix. On those platforms, you should run:

```shell
$ ./bin/ks.exe --version
0.0.1
$ ./bin/ks.exe -im -e 'm.pi'
3.141592653589
```

To customize the installation, or specify custom paths/dependencies, you can run:

```shell
$ ./configure --help
Usage: ./configure [options]

  -h,--help               Print this help/usage message and exit
  -v,--verbose            Print verbose output for checks
  --prefix V              Sets the prefix that the software should install to (default: /usr/local)
  --dest-dir V            Destination locally to install to (but is not kept for runtime) (default: )

  --ucd-ascii             If given, then only use ASCII characters in the unicode database (makes the build smaller)

  --with-gmp V            Whether or not to use GMP for integers (default: auto)
  --with-readline V       Whether or not to use Readline for line-editing (default: auto)
  --with-pthreads V       Whether or not to use pthreads (Posix-threads) for threading interface (default: auto)
  --with-ffi V            Whether or not to use ffi from libffi (Foreign Function Interface) for C-function interop (default: auto)
  --with-fftw3 V          Whether or not to use FFTW3 for Fast-Fourier-Transforms (default: auto)

Any questions, comments, or concerns can be sent to:
Cade Brown <cade@kscript.org>
```

(output may differ based on the specific version you outputted)

For example, to build a very small version of kscript, you can use these options:


```shell
$ ./configure --ucd-ascii --with-gmp off --with-readline off --with-pthreads off --with-fftw3 off --with-ffi off
```

This will also reduce the number of requirements (typically, with these options turned off, only `libm`, `libdl`, and `libc` are linked). This can be used to build a version of kscript that can be embedded in another application, such as a game, text editor, or something else. The `--ucd-ascii` causes non-ASCII identifiers/names to cause the compiler to emit a `SyntaxError`, so that option is not recommended except for extreme circumstances


# Basic Examples

Some examples can be ran directly as an option to `-e/--expr`, or ran in the interactive interpeter via `-`. Some are recommended to save to a file, and run directly via `ks <filename>`.

You can see a list of examples in [the path '/examples'](https://github.com/ChemicalDevelopment/kscript/tree/master/examples)

## 0. Interactive Interpreter

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


## 1. 'Hello, World'

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
```

