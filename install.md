---
layout: default
title: Install
nav_order: 20
permalink: install
---

# Installation Guide {#install-guide}
{: .no_toc .fs-9 }

Using a package manager is the recommended way to install kscript. This will ensure that your installation has been tested and will work on your system.

You can also [build from source](#build-guide)

Below are ways to install on various platforms:

## Windows

The kscript package is not available on Windows yet.

## `apt`: Debian, Ubuntu, and derivatives

The kscript package is not available on `apt` yet.


## `brew`: MacOS (Homebrew)

The kscript package is not available on `brew` yet.




# Build Guide {#build-guide}
{: .no_toc .fs-9 }

This is a guide of how to build kscript. If you just want to run kscript programs, you probably just want to follow the [installation guide](#install-guide)

The source code is available [here](https://github.com/chemicaldevelopment/kscript). You can download specific versions from the ['releases' page](https://github.com/ChemicalDevelopment/kscript/releases).

## Unix-like OSes (MacOS, Linux, BSD, etc.)

### Requirements

Building on MacOS, Linux, or other Unix-like OSes is a similar process, and assumes that you have:

  * A POSIX-compliant shell (`/bin/sh`) and the normal POSIX utilities, including:
    * `echo`
    * `printf`
    * `mkdir`
    * `sed`
    * `uname`
  * A `make` build system
  * A C compiler, capable of compiling at least C89 (ANSI) C (some parts of kscript may not be strictly C89, such as `//` comments)
    * kscript has been confirmed to compile with `gcc`, `clang`, and `tcc`

Additionally, there are optional dependencies which can result in better performance, or more features in kscript. These are automatically detected during the configure stage, but none are hard requirements. Here is a list of them:

  * [GMP](https://gmplib.org/) (`./configure --with-gmp on`): If included, use the GMP library for (faster) integer arithmetic. Otherwise, use a smaller stand-in library (called `minigmp`). 
  * [FFI](https://sourceware.org/libffi/) (`./configure --with-ffi on`): If included, use the Foreign Function Interface (FFI) library to allow the `ffi` module to execute functions loaded dynamically at runtime. Otherwise, throw an error when such a function call is issued
  * [pthreads](https://en.wikipedia.org/wiki/POSIX_Threads) (`./configure --with-pthreads on`): If included (and it almost always is), then threading is enabled. Otherwise, an error is thrown when a thread spawn is attempted
  * [readline](https://tiswww.case.edu/php/chet/readline/rltop.html) (`./configure --with-readline on`): If included, use the GNU readline library with the `input()` builtin and the interactive interpreter. Otherwise, use un-line-edited interface


### Configure

To configure kscript, using defaults, run:

```shell
$ ./configure

 -- Headers -- 

Searching for 'dirent.h                ' ... Succeeded
Searching for 'unistd.h                ' ... Succeeded
Searching for 'dlfcn.h                 ' ... Succeeded
Searching for 'time.h                  ' ... Succeeded

...
... (many, many more)
...

Generating 'include/ks/config.h' ...
  Done!
Generating 'makefile' ...
  Done!

Configuration was successful, run 'make' to build kscript

Any problems, questions, concerns, etc. can be sent to:
Cade Brown <brown.cade@gmail.com>
```

That script should print out what elements were found on your installation. To see options, run with `-h` (output may differ slightly):

```shell
$ ./configure -h
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

### Compile

To compile kscript, run:

```shell
$ make
cc -O3 -I./include -DKS_BUILD -fPIC -c -o .tmp/src/mem.o src/mem.c
cc -O3 -I./include -DKS_BUILD -fPIC -c -o .tmp/src/lexer.o src/lexer.c
...
... (many, many more)
...
cc -L./lib -Wl,-rpath,'$ORIGIN' -Wl,-rpath,'$ORIGIN/../lib' \
	.tmp/src/ks/ks.o \
	-lks -lm -ldl -pthread -lffi -lgmp -lreadline -o bin/ks
```

Now, the following files should have been created (and possibly more, depending on your configuration):

```bash
bin/ks
lib/libks.so
```

### Check (optional)

To run a series of checks (i.e. sanity checks), you can run:

```shell
$ make check
PASSED: tests/t_basic.ks
PASSED: tests/t_uninames.ks
...
... (many, many more)
...
PASSED: tests/t_re.ks
Success
```

### Install (optional)

To install kscript to your system, you can run:

```shell
$ sudo make install
install -d /usr/local/lib/ks-0.2.2/include/ks
install -d /usr/local/lib/ks-0.2.2/bin
install -d /usr/local/lib/ks-0.2.2/lib
... (many, many more)
ln -sf ks-0.2.2/lib/libks.so /usr/local/lib/libks.so
ln -sf ../lib/ks-0.2.2/bin/ks /usr/local/bin/ks
ln -sf ../lib/ks-0.2.2/include/ks /usr/local/include/ks
ln -sf ../lib/ks-0.2.2 /usr/local/lib/ks
```

Which will install to whatever `--prefix` was given to `./configure` (default: `/usr/local`)

To uninstall, run `sudo make uninstall`

  
## Windows

The Visual Studio solution and projects are located in the `winbuild` directory. Good luck. (I will try and write a formal guide once I figure it all out myself -- I don't much care for Windows)


