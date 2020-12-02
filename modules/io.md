---
layout: default
title: 'io: Input/Output'
parent: Modules
---

# Input/Output Module ('import io')
{: .no_toc }

 * TOC
{:toc}

The input/output module (`io`) provides functionality related to text and binary streams, and allows generic processing on streams from many sources.

Specifically, it provides file access (through `io.FileIO`), as well as in-memory stream-like objects for text (`io.StringIO`), as well as bytes (`io.BytesIO`). These types have similar interfaces such that they can be passed to functions and operated on generically. For example, you could write a text processor that iterates over lines in a file and performs a search (`grep`), and then a caller could actually give a `io.StringIO` and the search method would work exactly the same. Similarly, it is often useful to build up a file by using `.write()`, so that when outputting to a file, large temporary strings are not being built. However, sometimes you want to be able to build without creating a temporary file -- you can substitute an `io.StringIO` and then convert that to a string afterwards.


## Types

### [`io.BaseIO`: Abstract base class of other IO objects](#baseio)

You cannot instantiate `io.BaseIO` directly, but it defines functionality that can be used on instances of subtypes.

#### io.BaseIO.read(self, sz=none)
{: .method .no_toc }

<div class="method-text">
Reads a message, of up to `sz` length (returns truncated result if `sz` was too large). If size is ommitted, the rest of the stream is read and returned as a single chunk

For text-based IOs, `sz` gives the number of characters to read. For binary-based IOs, `sz` gives the number of bytes to read.
</div>


#### io.BaseIO.write(self, msg)
{: .method .no_toc }

<div class="method-text" markdown="1">
Writes a message to an IO

If 'msg' does not match the expected type (`str` for text-based IOs, and `bytes` for binary-based IOs), and no conversion is found, then an error is thrown
</div>

#### io.BaseIO.__close__(self)
{: .method .no_toc }

<div class="method-text" markdown="1">
Closes the IO and disables further reading/writing. Use the builtin `close()` function
</div>

---



### [`io.FileIO`: Access a file as a stream](#fileio)

`io.FileIO` represents access to a file on the disk, or otherwise an input/output stream from the operating system (such as a piped operation from the shell).

The reference implementation of kscript wraps the `FILE*` type from the C standard library, using the functions `fopen`, `fread`, `fclose`, etc to implement it

---




