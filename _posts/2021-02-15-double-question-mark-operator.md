---
layout: post
title: "Short-Circuiting Exception-Catching Operator: '??'"
author: Cade Brown
tags: plt
---


This [operator](https://docs.kscript.org/#Operators), `??`, is an unique invention to kscript (as far as I know). If not, please let me know: [cade@kscript.org](mailto:cade.kscript.org). It works similar to `||` (the short-circuiting or), but instead of using truth value to alter control flow, it instead uses exception handling. Therefore, the `??` operator is sometimes called an inline [`try`/`catch` statement](https://docs.kscript.org/#Try_Statement).

<!--more-->

## What is it?

Simply put, the `??` operator is an inline `try`/`catch` block, which tries to evaluate the left operand. If an exception was thrown while executing that, the exception is caught and ignored, and the right operand is attempted. If no exception was thrown in the left operand, then the right operand is never ran (aka short-circuiting it)

Further, the `??` may be chained to create a series of attempts. If an exception occurs in the last expression on the right, then the exception is not caught and instead thrown upwards to the next `try`/`catch` statement. Example: `x(1) ?? y(1) ?? z(1)`


## Why was it created?

I created the `??` after seeing lots of code which uses the pattern (in Python):

```python
# Python code

# Example method which checks a number of keys on `x`, and returns
#  the first found
def foo(x):
    try:
        return x['key']
    except:
        pass
    
    try:
        return x['key2']
    except:
        pass

    try:
        return x['key3']
    except:
        pass
    
    raise Exception('Failed to find any alternative key')

```

The code above searches through a list of keys and attempts to return the value associated with each one. I've seen and even written code like this, when you want to fall back to another commonly used key, or if you want to support multiple keys. And, by all means, it follows some of the most recommended [style recommendations (specifically, EAFP)](https://docs.python.org/3.4/glossary.html).

However, I thought: "Why couldn't this be an expression?". And, I searched online, but could not find any such exception-catching operator. So, I added it to kscript. Here's the above code, as kscript code using the `??` operator:


```ks
# kscript code

# Example method which checks a number of keys on `x`, and returns
#  the first found
func foo(x) {
    ret x['key'] ?? x['key2'] ?? x['key3']
}

```

The code is effecively the same, except that the kscript code throws `KeyError: 'key3'` if none are found. However, the amount of lines reduces drastically, and it is more straightforward to read as "try x['key1'], then x['key2'], and finally x['key3']". It can also be thought of as a quick-and-dirty solution to "try a bunch of things and use the first one that worked".


## Drawbacks

Of course, there are some drawbacks when using the `??` operator. The biggest one is that you can't inspect the exception that was thrown. You can still use a `try`/`catch` statement instead of this shortened form, however. 

## Use Cases

Here are some use cases that are motivated by my own experience:

```ks
# Get as a number, returning the most specific type it can,
#   preferring integers, then floats, then complex numbers
func getnum(x) {
    ret int(x) ?? float(x) ?? complex(x)
}

# Unwraps 'x', which may be a wrapped value (with the "real" value associated with '.val'), or
#   otherwise, default to 'x'
func unwrap(x) {
    ret x.val ?? x
}

```

You can also write `x ?? none`, to effectively attempt running `x`, but ignore any exceptions thrown while executing it.



