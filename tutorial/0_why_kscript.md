---
layout: default
title: 0. Why kscript?
parent: Tutorial
nav_order: 01
---

# 0. Why kscript?


kscript ([kscript.org](https://kscript.org)) is a dynamic programming language meant to be usable in a large number of situations. It is also meant to work on all sorts of computers, operating systems, and architectures. It even runs on the web ([term.kscript.org](https://term.kscript.org))


Here are some use cases that kscript excels at:

  * A desktop calculator with support for common mathematical functions and quick prototyping of algorithms
  * Writing automation programs that manage your files (maybe copying them, processing them, etc)
  * Implementing other languages (in the standard library, there are lexing and parsing utilities)

Here are some use cases that kscript is *not* meant for:

  * Embedded programming on extremely low memory devices
  * Implementing performance-critical routines from scratch
    * This can be done in many cases, if the operations are common. See the [`nx` module](https://docs.kscript.org/#nx)

You can also see a list of pros/cons in the [comparison page](/more/compare), but in general, the features that make kscript stand out are:

  * Completely object-oriented design. Everything is an `object`, and so containers and algorithms can handle objects of any type
  * Very strong, platform-agnostic standard library. Interfacing with the operating system looks the same on Windows, MacOS, Linux, and other OSes
  * Clean syntax, with very little boilerplate and/or "syntax noise". Contrasted with, say, C++ or Rust, which contain lots of `&`, `mut`, `::`, `<>`
  * Overridable semantics, such as operator overloading and dynamic attributes, are supported. You can write your own types and functions which do almost anything



