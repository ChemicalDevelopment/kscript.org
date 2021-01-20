---
layout: default
parent: Modules
title: 'io: Input/Output'
permalink: /modules/io
---

# Input/Output Module ('import io')
{: .no_toc }

 * TOC
{:toc}

The input/output module (`io`) provides functionality related to text and binary streams, and allows generic processing on streams from many sources.

Specifically, it provides file access (through [`io.FileIO`](#FileIO)), as well as in-memory stream-like objects for text ([`io.StringIO`](#StringIO)), as well as bytes ([`io.BytesIO`](#BytesIO)). These types have similar interfaces such that they can be passed to functions and operated on generically. For example, you could write a text processor that iterates over lines in a file and performs a search (like `grep`), and then a caller could actually give a `io.StringIO` and the search method would work exactly the same. Similarly, it is often useful to build up a file by using [`.write()`](#BaseIO.write), so that when outputting to a file, large temporary strings are not being built. However, sometimes you want to be able to build without creating a temporary file -- you can substitute an `io.StringIO` and then convert that to a string afterwards.

## `io.Seek`: Enumeration of 'whence' reference points {#Seek}

This type is an enum of `whence` values for various seek calls [`io.BaseIO.seek`](#BaseIO.seek). Their values are as follows:

#### `io.Seek.SET` {#Seek.SET}
{: .method .no_toc }

<div class="method-text" markdown="1">
Represents a reference point from the start of the stream
</div>

#### `io.Seek.CUR` {#Seek.CUR}
{: .method .no_toc }

<div class="method-text" markdown="1">
Represents a reference point from the current position in the stream
</div>

#### `io.Seek.END` {#Seek.END}
{: .method .no_toc }

<div class="method-text" markdown="1">
Represents a reference point from the end of the stream (i.e. the size of the stream)
</div>

---

## `io.fdopen(fd, mode='r', src=none)`: Open a file descriptor as buffered IO {#fdopen}

This function can be used to open an integral file descriptor `fd` as a buffered IO (i.e. [`io.FileIO`](#FileIO) object).

`src` can be given to give a readable name to the newly created IO object, but it is purely for debugging purposes.

---

## `io.BaseIO`: Abstract base class of other IO objects {#BaseIO}
{: .typeheader }

You cannot instantiate `io.BaseIO` directly, but it defines functionality that can be used on instances of subtypes. For example, [`io.BytesIO`](#BytesIO), [`io.StringIO`](#StringIO), [`io.FileIO`](#FileIO), and [`io.RawIO`](#RawIO). Those types implement the methods and attributes described by this type.

It also defines an iterator, which will iterate over lines in an input stream (by default, seperated by `'\n'`). For example, to iterate through lines on [`os.stdin`](/modules/os#variables), you can use:

```ks
for line in os.stdin {
    # do stuff with 'line'
}

```

#### io.BaseIO.read(self, sz=none) {#BaseIO.read}
{: .method .no_toc }

<div class="method-text" markdown="1">
Reads a message, of up to `sz` length (returns truncated result if `sz` was too large). If size is ommitted, the rest of the stream is read and returned as a single chunk

For text-based IOs, `sz` gives the number of characters to read. For binary-based IOs, `sz` gives the number of bytes to read.
</div>

#### io.BaseIO.write(self, msg) {#BaseIO.write}
{: .method .no_toc }

<div class="method-text" markdown="1">
Writes a message to an IO

If 'msg' does not match the expected type ([`str`](/builtins#str) for text-based IOs, and [`bytes`](/builtins#bytes) for binary-based IOs), and no conversion is found, then an error is thrown
</div>

#### io.BaseIO.seek(self, pos, whence=io.Seek.SET) {#BaseIO.seek}
{: .method .no_toc }

<div class="method-text" markdown="1">
Seek to a given position (`pos`) from a given reference point (see [`io.Seek`](#Seek))
</div>

#### io.BaseIO.tell(self) {#BaseIO.tell}
{: .method .no_toc }

<div class="method-text" markdown="1">
Returns an integer describing the current position within the stream, from the start (i.e. `0` is the start of the stream)
</div>

#### io.BaseIO.trunc(self, sz=0) {#BaseIO.trunc}
{: .method .no_toc }

<div class="method-text" markdown="1">
Attempts to truncate a stream to a given size (default: truncate complete to empty)
</div>

#### io.BaseIO.eof(self) {#BaseIO.eof}
{: .method .no_toc }

<div class="method-text" markdown="1">
Returns a boolean indicating whether the end-of-file (EOF) has been reached
</div>

#### io.BaseIO.close(self) {#BaseIO.close}
{: .method .no_toc }

<div class="method-text" markdown="1">
Closes the IO and disables further reading/writing
</div>




#### io.BaseIO.printf(self, fmt, *args) {#BaseIO.printf}
{: .method .no_toc }

<div class="method-text" markdown="1">
Print formatted text to `self`. Does not include a line break or spaces between arguments.

See [`printf`](/builtins#printf) for documentation on the `fmt` string and semantics

</div>


---

## `io.BytesIO`: In-memory bytes buffer IO {#BytesIO}

Represents an IO for byte-based information, being built in memory (i.e. not as a file on disk)


This is a subtype of [`io.BaseIO`](#BaseIO), which implements all the builtin methods (see that type for functionality)

---

## `io.FileIO`: Access a file as a stream {#FileIO}

Represents access to a file on the disk, or otherwise an input/output stream from the operating system (such as a piped operation from the shell).

The reference implementation of kscript wraps the `FILE*` type from the C standard library, using the functions `fopen`, `fread`, `fclose`, etc to implement it. 

This is a subtype of [`io.BaseIO`](#BaseIO), which implements all the builtin methods (see that type for functionality). In addition to `io.BaseIO` functionality, this type also implements:


#### io.FileIO.fileno {#FileIO.fileno}
{: .method .no_toc }

<div class="method-text" markdown="1">
This attribute retrieves the file descriptor associated with the stream.

For example, on most systems:

```ks
>>> os.stdin.fileno
0
>>> os.stdout.fileno
1
>>> os.stderr.fileno
2
```

</div>

---

## `io.RawIO`: Raw, unbuffered IO {#StringIO}

Represents an unbuffered IO using a file descriptor. This means that small reads may have bad performance, and this type is not generally recommended -- use [`io.FileIO`](#FileIO) instead. To get a `io.FileIO` from a `io.RawIO`, you can use the [`io.fdopen()`](#fdopen) function like so:

```ks
>>> x = io.RawIO("MyFile.txt")
<io.RawIO (fd=3, src='MyFile.txt', mode='r')>
>>> y = io.fdopen(x)
<io.FileIO (src='<fd:3>', mode='r')>
```


This is a subtype of [`io.BaseIO`](#BaseIO), which implements all the builtin methods (see that type for functionality). In addition to `io.BaseIO` functionality, this type also implements:

#### io.RawIO.fd {#RawIO.fd}
{: .method .no_toc }

<div class="method-text" markdown="1">
This attribute retrives the file descriptor associated with the stream

</div>

---

## `io.StringIO`: In-memory string buffer IO {#StringIO}

Represents an IO for textual information, being built in memory (i.e. not as a file on disk). It can be used in places where [`io.FileIO`](#FileIO).

---
