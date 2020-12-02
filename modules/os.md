---
layout: default
title: 'os: Operating System'
parent: Modules
---

# Operating System Module ('import os')
{: .no_toc }

 * TOC
{:toc}

The operating system module (`os`) provides functionality and wrappers around operating system and platform specific functionality, including the filesystem, threads, and process information.

This module is meant to work with the builtin `number` types and subtypes, such as `int`, `float`, and `complex`


## Variables

| Name| Description|
|:-------|:-----|
| `os.argv` | Commandline arguments supplied to the process. `os.argv[0]` is the program name that was executed, and the rest are the (optional) arguments |
| `os.stdin` | A readable `io.FileIO` object, which represents the input to the program |
| `os.stdout` | A writeable `io.FileIO` object, which represents the main output of the program |
| `os.stderr` | A writeable `io.FileIO` object, which represents the error message output of the program |

## Types

### [`os.path`: Filesystem path](#path)

A [path](https://en.wikipedia.org/wiki/Path_(computing)) represents a location within a directory tree structure. In general, there can be both relative paths (for example, `myfile.txt`), or absolute paths (`/full/path/to/myfile.txt`). One some platforms (such as Unix-like OSes), (absolute) paths all have a root of `/`, which means the root of the entire system, even though there may other filesystems mounted at certain points. On other platforms, however (such as Microsoft Windows), path treatment becomes more complex -- relative paths are now relative to the current drive (commonly, `C:\` or `D:\`), paths do not have a common ancestor, and so forth.

Therefore, to simplify this burden, the `os.path` type can be used interchangeably among all systems, by having parts of the path (represented as a tuple of strings, with implicit seperators between the elements) and a root object (which is `none` in the case of relative paths, or `/` in the case of Unix-style absolute paths, or a specific drive in the case of Windows-style absolute paths).


You can construct an `os.path` with either a `str`, which will be parsed and transformed accordingly, or via a tuple of parts and an (optional) root. Here are some examples:

```ks
>>> import os
>>> os.path()
os.path(('.',))
>>> os.path('file.txt')
os.path(('file.txt',))
>>> os.path('dir/file.txt')
os.path(('dir', 'file.txt'))
>>> os.path('/full/dir/file.txt')
os.path(('full', 'dir', 'file.txt'), '/')
>>> str(_)
'/full/dir/file.txt'
```

While it may be tempting to use `L == R` to test whether paths `L` and `R` are equal, it is not in general what you want to do. They do not handle things like symlinks, or relative paths (because, those paths can represent files that aren't even really on your computer). To test whether two `os.path` objects refer to the same file on disk, you should first convert to an absolute path (via the builtin `abs` function, which usually works on numbers). For example:


```ks
>>> L = os.path('file.txt')
os.path(('file.txt',))
>>> R = os.path('../dir/file.txt')
os.path(('..', 'dir', 'file.txt'))
>>> L == R
false
>>> abs(L) == abs(R)
true
```

However, if there was no file `file.txt`, the last line would instead be:

```ks
>>> abs(L) == abs(R)
IOError: Failed to determine real path for '../dir/file.txt': No such file or directory
Call Stack:
  #0: In '<interactive-#22>' (line 1):
abs(L) == abs(R)
^~~~~~
  #1: In abs(obj) [cfunc]
  #2: In os.path.__abs__(self) [cfunc]
In thread 'main' @ 0x55E946DA7850
```


| Attribute | Description |
|:-------|:--------|
| `.root` | The root of the path object, which is either `none` for a relative path, or a string representing the filesystem (`/` on Unix, or `C:\`, `D:\`, etc. on Windows) |
| `.parts` | A tuple containing the parts of the path |



#### os.path.exists(self)
{: .method .no_toc }

<div class="method-text" markdown="1">
Determines whether a path exists on the filesystem, returning a `bool`
</div>

#### os.path.isfile(self)
{: .method .no_toc }
#### os.path.isdir(self)
{: .method .no_toc }
#### os.path.islink(self)
{: .method .no_toc }

<div class="method-text" markdown="1">
Determines whether a path refers to a regular file, directory, or a link respectively, returning a `bool`

Throws an `IOError` if the path did not exist
</div>


#### os.path.parent(self)
{: .method .no_toc }

<div class="method-text" markdown="1">
Returns a path representing the parent of the given path, i.e. the directory which contains `self`
</div>


#### os.path.last(self)
{: .method .no_toc }

<div class="method-text" markdown="1">
Returns the last item on the path

Throws an `Error` if it was an empty path

```ks
>>> os.path('a/b/c.txt').last()
'c.txt'
```
</div>


---



### [`os.mutex`: Mutual exclusion](#mutex)

A [mutual exclusion lock](https://en.wikipedia.org/wiki/Lock_(computer_science)), (`mutex` for short) allows locking for a critical section, usually to enforce certain data dependencies. For example, if modifying a list in multiple places, it may be useful to lock access manually, so that multiple threads are not modifying the list simultaneously.

By default, not using a mutex is safe, in that it won't crash the interpreter. But, it may have some undefined behavior that is undesirable. 

#### os.mutex.lock(self)
{: .method .no_toc }

<div class="method-text" markdown="1">
Acquires a lock on the mutex, which must be released via `self.unlock()`
</div>


#### os.mutex.unlock(self)
{: .method .no_toc }

<div class="method-text" markdown="1">
Unlocks the mutex, which was locked via `self.lock()`
</div>


#### os.mutex.trylock(self)
{: .method .no_toc }

<div class="method-text"  markdown="1">
Attempt to lock the mutex if it was not already locked. Returns whether it did lock it.

You should only call `self.unlock()` when this function returns true

Example:
```ks
>>> mut = os.mutex()
>>> if mut.trylock() {
...   # do stuff
...   mut.unlock()
... }
```

</div>


---

### [`os.thread`: Threaded execution](#thread)

A [thread](https://en.wikipedia.org/wiki/Thread_(computing)) can be thought of as a single strand of execution. Multiple threads may be running concurrently, meaning that they are both executing code within a certain timeframe, independent of each other.

Internally, kscript interpreters may use a global interpreter lock (GIL), which prevents these threads from running at the same exact time (they will switch back and forth), except for cases where no kscript API is called (for example, number crunching, blocking IO, and so forth).

The general process to creating threads is like so:

```ks
>>> t = os.thread(print, range(10))
<'os.thread' @ 0x55C4F4FB47E0>
>>> t.start() # start the thread
none
0 1 2 3 4 5 6 7 8 9
>>> # do more work here
>>> t.join() # ensures the thread has finished, even though we know it has by the output
```

However, running with threads printing to the interpreter can create jumbled output.



#### os.thread.start(self)
{: .method .no_toc }

<div class="method-text" markdown="1">
Begin executing a thread
</div>


#### os.thread.join(self)
{: .method .no_toc }

<div class="method-text" markdown="1">
Wait for a thread to finish executing and join it back
</div>


---



