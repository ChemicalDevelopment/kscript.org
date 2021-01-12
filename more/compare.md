---
layout: default
parent: More
title: 'Compare'
permalink: /more/compare
---

# Language Comparison
{: .no_toc }

 * TOC
{:toc}

This page documents comparisons between kscript and other programming languages. 


## kscript vs. Python

[Python](https://www.python.org/) and kscript are probably the closest languages in this page. They share a similar [object-oriented](https://en.wikipedia.org/wiki/Object-oriented_programming) and [duck-typed](https://en.wikipedia.org/wiki/Duck_typing) philosophy. Scoping rules are also similar, as there are 2 kinds of scope: global and function. They also share a lot of the same keywords (as a lot of languages do). A significant difference is that Python

A somewhat significant difference is that Python has [syntactically significant whitespace](https://wiki.c2.com/?SyntacticallySignificantWhitespaceConsideredHarmful), whereas kscript only requires whitespace between identifiers and some tokens. This is a holy war in and of itself, and many good arguments on both sides. However, kscript ultimately chose `{}` blocks and non-significant whitespace for (mainly) two reasons (which are related and similar in many ways): 

  * Copying and pasting code between different indentation levels with significant whitespace causes errors, or worse, changes the semantic meanings (think about cutting something in a 1-indentation deep block into a 4-indentation deep block -- it would still be at 1-indentation deep, and thus cause the 4-indentation deep block to cease)
  * Autoformatting/autoindenting code is impossible, as changing the indentation would change the semantic meaning, and changing the semantic meaning would change the formatting. Having non-significant whitespace solves this, as an IDE is free to indent/dedent and add newlines as it needs to properly format it

The internals of kscript and Python (specifically, CPython) are similar - both use a bytecode interpreter VM, along with a GIL to manage resources among threads.


## kscript vs. C

C and kscript are very different, even though [kscript is written in C](https://github.com/chemicaldevelopment/kscript). Interfacing between C and kscript is easy ([ffi](/modules/ffi) for calling C from kscript, and `libks` for calling kscript from C), but fundamentally kscript is more dynamic, object-oriented, and cross platform, and C programs typically are more efficient, although many kscript modules end up running compiled C code anyway, so number crunching and other expensive operations end up being similar performance.


kscript code is easier to read, write, and distribute. And, you can write your application/library once and then run on many platforms without modification -- that's rare in C.


