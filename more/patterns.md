---
layout: default
parent: More
title: 'Patterns'
nav_order: 20
permalink: /more/patterns
---

# Patterns
{: .no_toc }

 * TOC
{:toc}


Patterns in kscript refer to sets of attributes and/or methods that objects are expected to have in order to fulfill a certain purpose (i.e. [`io.BaseIO`](/modules/io#BaseIO) objects are expected to have `.read()` and `.write()` methods). Objects that fit a pattern (i.e. have the attributes/functions) can be used like other objects in that pattern -- this is the basis of all [duck-typed](https://en.wikipedia.org/wiki/Duck_typing) languages, of which kscript is one.

Patterns are a similar concept to what are called interfaces or contracts in other languages, but are in practice much looser, as you don't have to actually specify the pattern. You can think of interfaces/contracts/etc as a more formal specification, whereas patterns are completely interpretive and dynamic -- all they require is that the method/attribute is available when the object is treated like a given pattern.

Although the type doesn't matter, many types patterns will have an abstract base type which other types are subtypes of. This is primarily done to simplify code and reduce redundancy (i.e. if all numeric types had to implement their own `add`, `sub`, `mul`, and so forth, there would be a lot of code bloat), but again is completely optional. 


Some examples of patterns in the standard library are:

  * Numeric pattern, documented by the abstract base type [`number`](/builtins#number)
  * IO pattern, documented by the abstract base type [`io.BaseIO`](/modules/io#BaseIO)


## Example (Animals)

This example was taken from Wikipedia and translated into kscript:

```
type Duck {
    func fly(self) {
        print ("Duck is flying")
    }
}

type Sparrow {
    func fly(self) {
        print ("Sparrow is flying")
    }
}

type Whale {
    func swim(self) {
        print ("Whale is flying")
    }
}

for animal in [Duck(), Sparrow(), Whale()] {
    animal.fly()
}

```

The output of this code segment is:

```
Duck is flying
Sparrow is flying
AttrError: 'Whale' object had no attribute 'fly'
```

