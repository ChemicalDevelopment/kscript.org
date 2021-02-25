---
layout: default
title: 4. Types And Functions
parent: Tutorial
nav_order: 40
---

# 4. Types And Functions

A time comes in every programmers life when they stop running single expressions in a REPL, and begin actually writing code that other people might use. Or, at the very least, code that they themselves may re-use at some point in the future. So, programmers need to package their existing logic/code into some sort of container that can be reused, and modularized so that you can reason about things at a higher level. Enter: types and functions

Types and functions are integral to making your code reusable, and kscript allows you to do it easily. This part of the tutorial shows you how to define custom types and functions in kscript.


## Functions

Custom functions are created with the `func` keyword. You can see the formal syntax definition [here](https://docs.kscript.org/#Function_Definition). There are a few ways to create a function:


```ks
# Anonymous function, takes 0 arguments
func {
    # The 'ret' statement is used to return a value from the current function
    ret 42
}

# Named function, takes 2 arguments
func foo(x, y) {
    ret x + y
}

# Named function, takes 1 or 2 arguments
# If only one is given, the other defaults to '2'
func foo(x, y=2) {
    ret x + y
}

# Named function, takes at least 1 argument
# 'y' will be a list of all other arguments
# For example:
#   foo(1) -> x=1, y=[]
#   foo(1, 2) -> x=1, y=[2]
#   foo(1, 2, 3) -> x=1, y=[2, 3]
# etc.
func foo(x, *y) {
    ret y
}

# Named function, takes at least 2 arguments
# 'y' will be a list of all other arguments
# For example:
#   foo(1, 2) -> x=1, y=[], z=2
#   foo(1, 2, 3) -> x=1, y=[2], z=3
#   foo(1, 2, 3, 4) -> x=1, y=[2, 3], z=4
# etc.
func foo(x, *y, z) {
    ret y
}
```

Then, functions can be called (just like builtin functions), and the code inside them will run. The result of the function call will be what is returned via the `ret` statement, or `none` if the end of the function is encountered without any such statement.

Here's an example:


```ks
# Simple adder function, with a default value
func foo(x, y=2) {
    ret x + y
}

# 3
print (foo(1))

# 6
print (foo(1, 5))
```


## Lambdas

[Lambda expressions](https://docs.kscript.org/#Lambda_Expression) are like functions, except their notation is more compact. This is extremely useful for short code or short functions which would only consist of a single `ret` statement. 

You can use the right arrow (`->`) to specify a lambda. It has the form `(params) -> value`, where `params` may be a single name, or a tuple literal full of the names of the lambda. `value` is the expression that is ran. This is equivalent to:

```ks
func (params) {
    ret value
}
```

But, is obviously much more compact.

Here are some examples:

```
# Simple adder (we assign to a name)
foo = (x, y) -> x + y

# Use with 'filter' to apply a selective filter
# pos == [1, 2]
pos = filter(x -> x > 0, [-2, -1, 0, 1, 2]) as list

```

## Types

Custom types are created with the `type` keyword. The new type created acts as its constructor. So, if you define a type called `MyType`, you can call it as a function (like `MyType()`) to create an instance of that type. You can check whether an object is an instance of a type with the [`isinst`](https://docs.kscript.org/#isinst) function, and whether a type is a subtype of another type with the [`issub`](https://docs.kscript.org/#issub) function.


You can see the formal syntax definition [here](https://docs.kscript.org/#Type_Definition). There are a few different ways to create a type:

```ks
# Anonymous type, not recommended (by default, you should name your types)
type {
    ...
}

# Named type
type MyType {
    ...
}

# Anonymous type, derived from 'SomeOtherType'
type extends SomeOtherType {
    ...
}

# Named type, derived from 'SomeOtherType'
type MyType extends SomeOtherType {
    ...
}
```

Within the body (`...` in the examples), you can define type attributes and functions. Typically, a type will want to define a few [magic attributes](https://docs.kscript.org/#Magic_Attributes). The most important one is `__init`, which has the general signature of `type.__init(self, *args)`. It takes a newly created object (`self`), and initializes it with the arguments passed to the constructor. Here's an example of a `Person` type being defined:


```ks
# Type representing a human being. New humans can be created by calling 'Person()'
# In the past, a mutex lock called "marriage" was required to do this
type Person {

    # Called every time 'Person()' is called to create a new instance
    func __init(self, name, age=none) {
        # Set attributes on the instance of the type, 'self'
        self.name = name
        self.age = age
    }

    # Called when a 'Person' object is printed or converted to string
    func __str(self) {
        ret str(self.name)
    }

    # Called when a 'Person' object is printed inside a container, or converted to repr
    func __repr(self) {
        # '%' does printf-style string formatting
        ret '%T(%R, %R)' % (self, self.name, self.age)
    }

    # Member function that can be called whenever
    func is_old(self) {
        # Subjective!
        ret self.age > 65
    }
}

# This would cause an error! Since '__init' expects at least a 'name' to be given,
#   this will throw an error
me = Person()

# Create a new 'Person' and assign it to the variable 'me'
me = Person("cade", 20)

# Create another person, and assign it to 'you'
you = Person("greg", 99)

# prints:
# cade greg
print(me, you)

# prints:
# Person('cade', 20) Person('greg', 99)
print(me as repr, you as repr)

# You can put objects into a list, so let's do that:
people = [me, you]

# prints:
# [Person('cade', 20), Person('greg', 99)]
print(people)

# Now, let's modify one of the people:
# Happy birthday!
people[0].age += 1


# prints:
# [Person('cade', 21), Person('greg', 99)]
print(people)

# Since collections only store references to objects, our original 'me' object will reflect the change:
# Person('cade', 21)
print(me as repr)


# We can access member functions as attributes:
# false
print(me.is_old())
# true
print(you.is_old())

```

