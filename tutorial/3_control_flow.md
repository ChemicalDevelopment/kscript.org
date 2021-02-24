---
layout: default
title: 3. Control Flow
parent: Tutorial
nav_order: 30
---

# 3. Control Flow

[Control flow](https://en.wikipedia.org/wiki/Control_flow) is how you can specify what code is ran under which conditions. All programming languages have some sort of control flow, and kscript is no exception! (That was a terrible pun. Get it? Exception? Exception handling? Never mind)

Control flow is important in many contexts. If you've never programmed before, you can think of some situations that control flow is useful:

  * Imagine if you ask the user for multiple options. You should then check what they entered, and handle what they asked for
    * If the user inputs a file, you can check the extension. You may want to handle an audio file (`.ogg`, `.mp3`, `.wav`) differently from a video file (`.mp4`, `.flv`, `.avi`)
  * Imagine you accept either an integer or a string name. You should check which type of object was given, and handle it specifically
    * Converting a string to an integer may be different than converting from a float!
  * When having a collection of objects, you want to execute code for each element
    * For example, if the user inputs a bunch of files, and you need to process each one
  * Later on, when you learn about exception handling, you will want to throw error conditions, and then catch them and handle them
    * For example, when opening a file to read, if the file doesn't exist then an error is thrown

These use cases can be covered by the `if`, `while`, `for`, and `try` statements. We just cover the basics here, which should help you get started.

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

