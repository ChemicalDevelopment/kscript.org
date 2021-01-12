---
layout: default
parent: More
title: Object Model
permalink: /more/objectmodel
---

# Object Model
{: .no_toc }

 * TOC
{:toc}

---


kscript is a purely object-oriented language, which means that every type is a subtype of [`object`](/builtins#object), and therefore the inheritance tree of all types has a single root node -- [`object`](/builtins#object). You normally don't have to specify types for general processing, and collection types (such as [`list`](/builtins#list), [`tuple`](/builtins#tuple), and [`dict`](/builtins#dict)) can store any type or combination of types without any special treatment.

Instances of types can be created with literals or calls to the constructor, which is the type itself (it may be treated like a function). For example, you can create an [`int`](/builtins#int) object by calling `int()`. Constructors may also take arguments, which it will try to convert into that type. For example, to convert a string constant into an [`int`](/builtins#int), you can call it like so: `int("123")`. Constructors will often throw errors if the argument(s) could not be converted to the requested type.

There is also a syntactic sugar that allows conversion to a type on the right hand side of a value using the `as` operator. For example, `int("123")` is the same as `"123" as int`, which uses less parentheses and can be helpful/more readable in some circumstances. It can also be chained, if you have `float(int("123"))` (converting to an [`int`](/builtins#int) then a [`float`](/builtins#float)), you can equivalently write `"123" as int as float` or `("123" as int) as float`. This can help readability in many places

The type of an object can be determined via the [type](/builtins#type) function. For example, `type(123) == int`. You can also check whether a type is a sub-type of another type via the [issub](/builtins/#issub) function. For example: `issub(type(123), int) == true`, but `issub(type(123), str) == false`. You can check whether an object is an instance of a given type (or subtype of that type) via the [isinst](/builtins/#isinst) function.


## Viewing Inheritance Trees

You can view inheritance trees for any types (not just builtin ones) by using the [`graph`](/builtins#graph) type. Then, you can use the `graph._dotfile()` method to generate a string that can be passed to [Graphviz](https://graphviz.org/). For example:


```ks
>>> inher = int as graph
graph([int, enum, bool, logger.levels, ast.kind, number, object], [(0, 1), (1, 2), (1, 3), (1, 4), (5, 0), (6, 5)])
>>> print(inher._dotfile())
digraph G {
    0 [label="int"];
    0 -> 1;
    1 [label="enum"];
    1 -> 2;
    1 -> 3;
    1 -> 4;
    2 [label="bool"];
    3 [label="logger.levels"];
    4 [label="ast.kind"];
    5 [label="number"];
    5 -> 0;
    6 [label="object"];
    6 -> 5;
}
```

Which translates into the following inheritance tree:

![{{ site.baseurl }}/assets/images/tp-int-inher.svg]({{ site.baseurl }}/assets/images/tp-int-inher.svg)
