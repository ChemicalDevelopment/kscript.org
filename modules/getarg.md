---
layout: default
parent: Modules
title: 'getarg: Arguments'
permalink: /modules/getarg
nav_order: 180
---

# Argument Parsing Module ('import getarg')
{: .no_toc }

The argument parsing module (`getarg`) provides primarily a single type -- [`getarg.Parser`](#Parser), which enables the application to parse commandline arguments

The most common use case of this module is writing a commandline utility. In which case, the usage looks similar to this:


```ks
# From: https://github.com/ChemicalDevelopment/kscript/blob/main/examples/greet.ks
import getarg

p = getarg.Parser("greet", "0.1.0", "Prints a personalized greeting", ["Cade Brown <cade@kscript.org>"])

# opt(name, opts, doc, trans=str, defa=none)
p.opt("greeting", ["-g", "--greeting"], "The greeting message to use", str, "hello,")
# pos(name, doc, num=1, trans=str, defa=none)
p.pos("names", "List of names to greet", -1)

# parse the args, throwing an error if something incorrect was given
# or, if `-h` or `--help` are given, print out a usage message and exit successfully
args = p.parse()
```

Then, you can run the file like:

```shell
$ ./greet.ks -h
usage: greet [opts] names...

    names                       List of names to greet

opts:
    -h,--help                   Prints this help/usage message and then exits
    --version                   Prints the version information and then exits
    -g,--greeting[=str]         The greeting message to use (default: hello,)

authors:
    Cade Brown <cade@kscript.org>
version: 0.1.0
```

You can print the help, version, and additional information. It also automatically parses commandline options and arguments.


---

## `getarg.Parser(name, version, desc, authors)`: Argument Parser {#Parser}

This type represents a commandline parser, which accepts positional arguments (via [`.pos`](#Parser.pos)), optional arguments (via [`.opt`](#Parser.opt)), and flags (via [`.flag`](#Parser.flag)). You can then use [`.parse()`](#Parser.parse) to parse a list of arguments (default: [`os.argv`](/modules/os#argv), the commandline arguments passed to the kscript interpreter).

A few default flags are included:

  * `-h/--help`: Prints the generated help menu and exits
  * `--version`: Prints the version and exits


The examples for this type are not using the interpreter -- but rather they use entire files. This is because it is a much more common use case.

#### Example 0: One positional argument
{: .method .no_toc }

<div class="method-text" markdown="1">
This example is one of the simplest use cases of the `getarg` module. It accepts a single argument on the commandline, and throws an error if it is not given, or if an extra argument is given.

```
#!/usr/bin/env ks
# ex0.ks - example 0
import getarg

p = getarg.Parser("ex0", "0.0.1", "Example 0, prints a single argument", ["Cade Brown <cade@kscript.org>"])

# pos(name, doc, num=1, trans=str, defa=none)
p.pos("arg", "Single argument")

# Now, parse, and throw an exception if required
args = p.parse()

# Notice we use '.arg', since we gave "arg" to the 'p.pos()' call
print (args.arg)

```

Now, running it:

```shell
$ ks ex0.ks
Error: Not enough of positional argument 'arg' given
Call Stack:
  #0: In 'ex0.ks' (line 11, col 8):
args = p.parse()
       ^~~~~~~~~
  #1: In getarg.Parser.parse(self, args=os.argv) [cfunc]
In <thread 'main'>
$ ks ex0.ks -h
usage: ex0 [opts] arg

    arg                         Single argument

opts:
    -h,--help                   Prints this help/usage message and then exits
    --version                   Prints the version information and then exits

authors:
    Cade Brown <cade@kscript.org>
version: 0.0.1
$ ke ex0.ks myinput
myinput
```

</div>



#### Example 1: Positional argument, optional argument, and flag argument
{: .method .no_toc }

<div class="method-text" markdown="1">
This example showcases many uses of the `getarg` module. It accepts a single argument on the commandline, and allows you to optionally multiply it by another value (`-m/--mul`), and then print it in normal (decimal) notation, or hex via `--hex` flag

```
#!/usr/bin/env ks
# ex1.ks - example 1
import getarg

p = getarg.Parser("ex1", "0.0.1", "Example 1, prints a single argument, optionally multiplied, optionally in hex", ["Cade Brown <cade@kscript.org>"])

# pos(name, doc, num=1, trans=str, defa=none)
# NOTE: this means we are accepting 1 'int', and the conversion will be automatic
p.pos("arg", "Single argument", 1, int)

# opt(name, opts, doc, trans=str, defa=none)
p.opt("fact", ["-m", "--mul"], "Number to multiply by", int, 1)

# flag(name, opts, doc, action=none)
p.flag("hex", ["--hex"], "If given, then output in hex")

# Now, parse, and throw an exception if required
args = p.parse()

# Notice we use '.arg', since we gave "arg" to the 'p.pos()' call
res = args.arg * args.fact
if args.hex {
    print (str(res, 16))
} else {
    print (res)
}

```

Now, running it:

```shell
$ ks ex1.ks
Error: Not enough of positional argument 'arg' given
Call Stack:
  #0: In 'ex1.ks' (line 18, col 8):
args = p.parse()
       ^~~~~~~~~
  #1: In getarg.Parser.parse(self, args=os.argv) [cfunc]
In <thread 'main'>
$ ks ex1.ks -h
usage: ex1 [opts] arg

    arg                         Single argument

opts:
    -h,--help                   Prints this help/usage message and then exits
    --version                   Prints the version information and then exits
    --hex                       If given, then output in hex
    -m,--mul[=int]              Number to multiply by (default: 1)

authors:
    Cade Brown <cade@kscript.org>
version: 0.0.1
$ k ex1.ks 2 -m 3
6
$ k ex1.ks 123 --hex
0x7B
$ k ex1.ks 2 -m 100 --hex
0xC8
```

</div>

#### getarg.Parser.pos(self, name, doc, num=1, trans=str, defa=none) {#Parser.pos}
{: .method .no_toc }

<div class="method-text" markdown="1">
Adds a positional argument to `self`, which is required if `defa` is not given, or optional if it is, and stored in the parse result as `args.<name>`. Specifically, it requires `num` arguments to be consumed (default: 1). If `num==-1`, then any amount are allowed, and extra arguments on the commandline are assumed to be this positional argument

The transformation (`trans`) of the input is a function/type to run on the commandline string to return the result. For example, giving `trans==int` causes `int(argstr)` to be called, and that is used as the argument value instead of the raw string. If `int(argstr)` caused an error, then it is thrown up the call stack.

If `defa` is not given, then this argument is required. Otherwise, it is not required and if it is not given, then `defa` will be used instead

Examples:

```ks
>>> # Adds a required argument
>>> p.pos("file", "Input file to process")
```

```ks
>>> # Allows arbitrarily many input files to be given (and 'p.parse().files' will be a list of each)
>>> p.pos("files", "A list of input files", -1)
```

</div>

#### getarg.Parser.opt(self, name, opts, doc, trans=str, defa=none) {#Parser.opt}
{: .method .no_toc }

<div class="method-text" markdown="1">
Adds a option argument to `self`, which is required if `defa` is not given, or optional if it is, and stored in the parse result as `args.<name>`. Specifically, it requires one string in `opts` to be present, which is the option signifier, and the next argument is used as the value for this option.

The transformation (`trans`) of the input is a function/type to run on the commandline string to return the result. For example, giving `trans==int` causes `int(argstr)` to be called, and that is used as the argument value instead of the raw string. If `int(argstr)` caused an error, then it is thrown up the call stack.

If `defa` is not given, then this argument is required. Otherwise, it is not required and if it is not given, then `defa` will be used instead

Examples:

```ks
>>> # Adds a '-p/--port' option that can be passed from the commandline
>>> p.opt("port", ["-p", "--port"], "The network port for the server to bind to", int, 8080)
```

</div>

#### getarg.Parser.flag(self, name, opts, doc, action=none) {#Parser.flag}
{: .method .no_toc }

<div class="method-text" markdown="1">
Adds a flag argument to `self`, and stored in the parse result as `args.<name>`. Specifically if any of the strings in `opts` is given, then `self.parse().<name>` will evaluate to `true`, and otherwise it will be a falsy value

The transformation (`trans`) of the input is a function/type to run on the commandline string to return the result. For example, giving `trans==int` causes `int(argstr)` to be called, and that is used as the argument value instead of the raw string. If `int(argstr)` caused an error, then it is thrown up the call stack.

If `action` is given, then it is expected to be callable, and on *each* time the flag is given, the following code is ran: `action(parser, name, arg)`, where `parser` is the parser that is parsing it, `name` is the argument name, and `arg` is the argument that triggered it.

Examples:

```ks
>>> # Adds a '--silent' flag that can be passed from the commandline
>>> p.flag("silent", ["-s", "--silent"], "If given, do not print things")
```

```ks
>>> # Adds a '--loud' flag that prints itself
>>> p.flag("loud", ["--loud"], "Print some stuff!", (parser, name, arg) -> printf("I am so loud! %r caused me!\n", arg))
```

</div>


#### getarg.Parser.parse(self, args=os.argv) {#Parser.parse}
{: .method .no_toc }

<div class="method-text" markdown="1">
Parses a list of arguments, `args`, (default: [`os.argv`](/modules/os#argv), the commandline arguments), which is expected to have `args[0]` be the program name, and the rest be commandline arguments given to it.

Returns an object with attributes being the names of positional arguments, option arguments, and flags that the parser has. For example, if you called `self.pos("MyName", ...)`, then `self.parse().MyName` would give the value of the positional argument

</div>




