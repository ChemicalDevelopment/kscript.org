---
layout: default
title: Fibonacci
parent: Examples
nav_order: 10
---

# Fibonacci

[Fibonacci numbers](https://en.wikipedia.org/wiki/Fibonacci_number) make a good introduction to any programming language. This tutorial is designed to showcase the major features, such as recursion, argument parsing, and conversions. After finishing this tutorial, you should have a program you can call from the commandline.

Let's remind ourselves of the definition, where $F_n$ is the $n$th Fibonacci number: $F_0 = 0, F_1 = 1, F_{n} = F_{n-1} + F_{n-2}$. So, the sequence $F$ goes $0, 1, 1, 2, 3, 5, 8, 13, 21$ beginning with $n=0$. Our task is to generate a program to calculate the $n$th fibonacci number and print it out. Assuming our program is called `fib.ks`, here's how it should be used:

```shell
$ ./fib.ks 0
0
$ ./fib.ks 1
1
$ ./fib.ks 7
13
```

And so on. How can we do this? Let's get started

## First Program

Our first program will be quite simple. We can define a function to calculate the $n$th Fibonacci number like so:

```ks
# Calculates the 'n'th Fibonacci number
func fib(n) {
    if n == 0 || n == 1 {
        ret n
    } else {
        ret fib(n - 1) + fib(n - 2)
    }
}
```

kscript uses the `ret` keyword instead of `return`, but it just means 'return this expression as the result of the function'


Now, we need to read the input from the commandline arguments, and call the function with that argument. To access that, you can use [`os.argv`](#/modules/os#argv). Our program will have to `import os` before we use that. Also note that we can convert strings to integers via the [`int()`](/builtins#int) type, used as a constructor. 

```ks
# Since we use 'os.argv'
import os

# We must use 'argv[1]', since 'argv[0]' is our program name
n = int(os.argv[1])

print (fib(n))
```

However, it is best practice to add `import` statements at the top of the file, before any of the actual code. So, here's what our full code listing should look like:


```ks
#!/usr/bin/env ks
# ^ the above allows us to run directly as an executable

# Since we use 'os.argv'
import os

# Calculates the 'n'th Fibonacci number
func fib(n) {
    if n == 0 || n == 1 {
        ret n
    } else {
        ret fib(n - 1) + fib(n - 2)
    }
}

# We must use 'argv[1]', since 'argv[0]' is our program name
n = int(os.argv[1])

print (fib(n))
```

Indeed, this does work. And, if we run without any arguments, we will get an `IndexError` (since `os.argv` only has `1` element, the `1` index is out of bounds). Additionally, if we have multiple input arguments given, they will be ignored (say, for instance, running `./fib.ks 1 2`). 

If you get `Permission Denied` errors when you try and run `./fib.ks`, make sure to mark the file as executable by running (in your shell):

```shell
$ chmod +x fib.ks
```

While this is okay for a basic prototype, let's see if we can improve our program.


## Improved Program

We will use the `getarg` module to perform the argument parsing automatically. We will also use a special feature in kscript that allows implicit recursion, by calling the `...` singleton.

```ks
#!/usr/bin/env ks
# ^ the above allows us to run directly as an executable

import getarg

# Create an argument parser
p = getarg.Parser('fib', '0.0.1', 'Calculates Fibonacci numbers', ['Cade Brown <cade@kscript.org>'])

# Add a positional argument, which is of type 'int'
# p.pos(name, desc, num=1, trans=str)
p.pos('n', 'Which Fibonacci number to calculate', 1, int)

# Default arguments are 'os.argv', so we don't have to mention that
args = p.parse()

# Calculates the 'n'th Fibonacci number
func fib(n) {
    if n == 0 || n == 1 {
        ret n
    } else {
        # Calling '...' causes recursion 
        ret ...(n - 1) + ...(n - 2)
    }
}

# Now, we can use 'args.n' to directly reference it (it is already an 'int')
print (fib(args.n))

```

You can run the program with `./fib.ks -h` to print a usage message:

```shell
$ ks ./fib.ks -h
usage: fib [opts] n

    n                           Which Fibonacci number to calculate

opts:
    -h,--help                   Prints this help/usage message and then exits
    --version                   Prints the version information and then exits

authors:
    Cade Brown <cade@kscript.org>
version: 0.0.1
```

(again, if you can't run the file, make sure to run `chmod +x fib.ks`)

