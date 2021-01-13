---
layout: default
parent: Modules
title: 'os: Operating System'
permalink: /modules/os
---

# Operating System Module ('import os')
{: .no_toc }

 * TOC
{:toc}

The operating system module (`os`) provides functionality and wrappers around operating system and platform specific functionality, including the filesystem, threads, and process information.


## `os.argv`: Commandline arguments {#argv}

The commandline arguments supplied to the process. 

`os.argv[0]` is the program name that was executed, and the rest are arguments passed after the binary name

---

## `os.stdin`: Standard input {#stdin}

A readable [io.FileIO](/modules/io#FileIO) object, which represents input to the process

---

## `os.stdout`: Standard output {#stdout}

A writeable [io.FileIO](/modules/io#FileIO) object, which represents output from the process

This is the output of the [`print`](/builtins#print) function

---

## `os.stderr`: Standard error {#stderr}

A writeable [io.FileIO](/modules/io#FileIO) object, which represents error output from the process

---

## `os.getenv(key, defa=none)`: Get environment variable {#getenv}

<div class="method-text" markdown="1">
Search for the [environment variable](https://en.wikipedia.org/wiki/Environment_variable) with the name `key`, or throw a `KeyError` if it was not found

If `defa` is given, no error is thrown, and it is returned instead

</div>

---

## `os.setenv(key, val)`: Set environment variable {#setenv}

<div class="method-text" markdown="1">
Set an [environment variable](https://en.wikipedia.org/wiki/Environment_variable) with the name `key` to the given value `val`

</div>

---

## `os.cwd()`: Current working directory {#cwd}

Returns the current working directory

---

## `os.chdir(path)`: Change directory {#chdir}

Changes the current directory to `path`

`path` should be either [`str`](/builtins#str) or [`os.path`](#path).

---


## `os.mkdir(path, mode=0o777, parents=false)`: Make a directory {#mkdir}

Creates a new directory `path` on the filesystem, with a given mode

On some platforms, `mode` may be ignored, but it is meant to be a permissions mask given in octal. 

`path` should be either [`str`](/builtins#str) or [`os.path`](#path).

---

## `os.rm(path, parents=false)`: Remove a directory {#rm}

Removes a file or directory from the filesystem

If `parents` is true, and `path` refers to a directory, then it is recursively deleted (similar to `mkdir -p` in the shell). However, if `parents` is `false`, and `path` is a non-empty directory, an exception is thrown.

---

## `os.listdir(path)`: List directory contents {#listdir}

<div class="method-text" markdown="1">
Returns a tuple of `(dirs, files)` which are the sub-directories and files within `path` on disk. Throws an error if `path` is not a valid directory

`path` should be either [`str`](/builtins#str) or [`os.path`](#path).

</div>

---

## `os.fstat(fd)`: Query information about a file descriptor {#fstat}

Queries information about an open file descriptor `fd` (which should be an [`int`](/builtins#int) or integral value).

Returns an [`os.stat`](#stat) object

---

## `os.lstat(path)`: Query filesystem information without following symbolic links {#lstat}

Queries information about a path in the file system, but does not follow symbolic links. So, if you call it with `path` being a symbolic link, it will return information about the link itself, rather than the path pointed to by the link.

Returns an [`os.stat`](#stat) object

---

## `os.stat(path)`: Query filesystem information {#stat}

This type represents status of a file or directory or link on a filesystem. It is also callable as a function, which performs a query on the given path.

Queries information about a path in the file system, but does not follow symbolic links. So, if you call it with `path` being a symbolic link, it will return information about the link itself, rather than the path pointed to by the link.


See [`os.fstat`](#fstat) and [`os.lstat`](#lstat) for querying information about file descriptors and without following symbolic links.

#### os.stat.gid {#stat.gid}
{: .method .no_toc }
<div class="method-text" markdown="1">
Group ID and name of the owner
</div>

#### os.stat.uid {#stat.uid}
{: .method .no_toc }
<div class="method-text" markdown="1">
User ID and name of the owner
</div>


#### os.stat.dev {#stat.dev}
{: .method .no_toc }
<div class="method-text" markdown="1">
This attribute is an integer representing the device on which the queried entry is located. This is highly platform specific, and is often encoded as major/minor versions.

On Unix-like OSes, for example, you can extract it like such:

```ks
>>> x = os.stat("File.txt")
<os.stat dev=2049, inode=19138881, gid=1000, uid=1000, size=4249, mode=0o100664>
>>> major = (x.dev >> 8) & 0xFF
8
>>> minor = x.dev & 0xFF
1
```
</div>

#### os.stat.inode {#stat.inode}
{: .method .no_toc }
<div class="method-text" markdown="1">
This attribute is an integer representing the [inode](https://en.wikipedia.org/wiki/Inode) within the filesystem, which can be thought of as an ID.
</div>

#### os.stat.size {#stat.size}
{: .method .no_toc }
<div class="method-text" markdown="1">
This attribute is an integer representing the size in bytes of the file
</div>

#### os.stat.mtime {#stat.mtime}
{: .method .no_toc }
<div class="method-text" markdown="1">
This attribute is a [`float`](/builtins#float) representing the time of last modification (time since epoch).
</div>

#### os.stat.atime {#stat.mtime}
{: .method .no_toc }
<div class="method-text" markdown="1">
This attribute is a [`float`](/builtins#float) representing the time of last access (time since epoch).
</div>

#### os.stat.ctime {#stat.mtime}
{: .method .no_toc }
<div class="method-text" markdown="1">
This attribute is a [`float`](/builtins#float) representing the time of last status change (time since epoch).
</div>

---

## `os.pipe()`: Create a new pipe {#path}

Creates a new pipe, and returns a tuple of `(readio, writeio)` representing the readable and writable ends as [`io.RawIO`](/modules/io#RawIO) objects.

---

## `os.dup(fd, to=-1)`: Duplicate a file descriptor {#path}

Duplicates an open file descriptor `fd` (which an be a [`io.RawIO`](/io#RawIO), [`io.FileIO`](/io#FileIO), or integral value).

If `to < 0` (default), then this function creates a new file descriptor and returns it. Otherwise, it replaces `to` with a copy of `fd`

---

## `os.fork()`: Fork the process {#path}

Forks the process, creating a new child process, after which the parent and the child will execute the same code. This function returns `0` in the child process, and the process ID (PID) in the parents

---

## `os.exec(cmd)`: Execute a shell command {#path}

Execute a command as if typed into the default system shell, and return the exit code

For more involved process launching, see the [`os.proc`](#proc) type, which allows for capturing inputs and outputs and more fine-grained control

---



## `os.path(obj='.', root=none)`: Filesystem path {#path}

A [path](https://en.wikipedia.org/wiki/Path_(computing)) represents a location within a directory tree structure. In general, there can be both relative paths (for example, `myfile.txt`), or absolute paths (`/full/path/to/myfile.txt`). On some platforms (such as Unix-like OSes), (absolute) paths all have a root of `/`, which is the root of the entire system, even though there may other filesystems mounted at certain points. On other platforms, however (such as Microsoft Windows), path treatment becomes more complex -- absolute paths are now on a specific drive (commonly, `C:\` or `D:\`), paths do not have a common ancestor, and so forth.

Therefore, to simplify this burden, the [`os.path`](/modules/os#path) type can be used interchangeably among all systems, by having parts of the path (represented as a tuple of strings, with implicit seperators between the elements) and a root object (which is `none` in the case of relative paths, or `'/'` in the case of Unix-style absolute paths, or a specific drive in the case of Windows-style absolute paths, such as `'C:\'` or `'D:\'`).


You can construct an [`os.path`](/modules/os#path) with either a [`str`](/builtins#str), which will be parsed and transformed accordingly, or via a tuple of parts and an (optional) root. Here are some examples:

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

While it may be tempting to use `L == R` to test whether paths `L` and `R` are equal, it is not in general what you want to do. They do not handle things like symlinks, or relative paths (because, those paths can represent files that aren't even really on your computer). To test whether two [`os.path`](/modules/os#path) objects refer to the same file on disk, you should first convert to an absolute path (via the builtin `abs` function, which usually works on numbers). For example:


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
  #2: In os.path.__abs(self) [cfunc]
In <thread 'main'>
```


| Attribute | Description |
|:-------|:--------|
| `.root` |  |
| `.parts` | A tuple containing the parts of the path |



#### os.path.root {#path.root}
{: .method .no_toc }

<div class="method-text" markdown="1">
The root of the path, which is either `none` for a relative path, or a [`str`](/builtins#str) with `/` (for Unix-like OSes), or something like `C:\` or `D:\` (for Windows-like OSes).
</div>

#### os.path.parts {#path.parts}
{: .method .no_toc }

<div class="method-text" markdown="1">
Tuple of directory/path entries, which have been split on directory seperators
</div>


#### os.path.parent(self) {#path.parent}
{: .method .no_toc }

<div class="method-text" markdown="1">
Returns a path representing the parent of the given path, i.e. the directory which contains `self`

This is a string operation -- if used on symbolic links, it will return the parent directory of the link, not the file it points to.
</div>


#### os.path.last(self) {#path.last}
{: .method .no_toc }

<div class="method-text" markdown="1">
Returns the last item on the path

Throws an `Error` if it was an empty path

```ks
>>> os.path('a/b/c.txt').last()
'c.txt'
```
</div>


#### os.path.exists(self) {#path.exists}
{: .method .no_toc }

<div class="method-text" markdown="1">
Determines whether a path exists on the filesystem

This is a helper method based on [`os.stat`](#stat) output
</div>

#### os.path.isfile(self) {#path.isfile}
{: .method .no_toc }

<div class="method-text" markdown="1">
Determines whether a path refers to a regular file

This is a helper method based on [`os.stat`](#stat) output
</div>

#### os.path.isdir(self) {#path.isdir}
{: .method .no_toc }
<div class="method-text" markdown="1">
Determines whether a path refers to a directory

This is a helper method based on [`os.stat`](#stat) output
</div>

#### os.path.islink(self) {#path.islink}
{: .method .no_toc }

<div class="method-text" markdown="1">
Determines whether a path refers to a symbolic link

This is a helper method based on [`os.stat`](#stat) output
</div>

---

## `os.walk(path='.', topdown=false)`: Filesystem walk iterator {#walk}

This type represents a recursive top-down or bottom-up iterator through directories.

Being a stateful iterator, it can be iterated via the [`next`](/builtins#next) or in a `for` loop. It yields tuples of `(subdir, dirs, files)`, where `subdir` is the current directory being emitted, and `dirs` are the directories in `subdir`, and `files` are the files in `subdir`. Equivalently, `(dirs, files) = os.listdir(subdir)`

If `topdown` is `false` (default), then the result is bottom-up, which means subdirectories are emitted by their parents. Otherwise, a directory is emitted, and then its subdirectories are.

---


## `os.mutex()`: Mutual exclusion {#mutex}

A [mutual exclusion lock](https://en.wikipedia.org/wiki/Lock_(computer_science)), (`mutex` for short) allows locking for a critical section, usually to enforce certain data dependencies. For example, if modifying a list in multiple places, it may be useful to lock access manually, so that multiple threads are not modifying the list simultaneously.

By default, not using a mutex is safe, in that it won't crash the interpreter. But, it may have some undefined behavior that is undesirable. 

#### os.mutex.lock(self) {#mutex.lock}
{: .method .no_toc }

<div class="method-text" markdown="1">
Acquires a lock on the mutex, which must be released via `self.unlock()`
</div>


#### os.mutex.unlock(self) {#mutex.unlock}
{: .method .no_toc }

<div class="method-text" markdown="1">
Unlocks the mutex, which was locked via `self.lock()`
</div>

#### os.mutex.trylock(self) {#mutex.trylock}
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

## `os.proc(argv)`: Process execution {#proc}

A [process](https://en.wikipedia.org/wiki/Process_(computing)) can be thought of as a running program, which has one or more threads.

Processes are launched by using this type as a function, which accepts the `argv` to launch. For example: `os.proc(["/bin/echo", "hi"])` will attempt to launch a process to echo `hi` to the screen. However, that requires there to be a file located at `/bin/echo`, so launching a process will depend on your system installation and avaiable programs.

#### os.proc.argv {#proc.argv}
{: .method .no_toc }

<div class="method-text" markdown="1">
This attribute is a tuple of the arguments the process was launched with, or `none` if they are unknown (for example, wrapping a process that kscript didn't launch)
</div>

#### os.proc.pid {#proc.pid}
{: .method .no_toc }

<div class="method-text" markdown="1">
This attribute is an integer representing the process ID of PID
</div>

#### os.proc.join(self) {#proc.join}
{: .method .no_toc }

<div class="method-text" markdown="1">
Waits for the process to finish executing and returns the exit code of that process
</div>

#### os.proc.isalive(self) {#proc.isalive}
{: .method .no_toc }

<div class="method-text" markdown="1">
Polls the process and returns whether it is still alive
</div>

#### os.proc.signal(self, code) {#proc.isalive}
{: .method .no_toc }

<div class="method-text" markdown="1">
Sends a signal to the process, which should be an `int`
</div>

#### os.proc.kill(self) {#proc.isalive}
{: .method .no_toc }

<div class="method-text" markdown="1">
Attempts to kill the process forcibly
</div>

---

## `os.thread(func, args=(), name=none)`: Threaded execution {#thread}

A [thread](https://en.wikipedia.org/wiki/Thread_(computing)) can be thought of as a single strand of execution. Multiple threads may be running concurrently, meaning that they are both executing code within a certain timeframe, independent of each other.

Internally, kscript interpreters may use a global interpreter lock (GIL), which prevents these threads from running at the same exact time (they will switch back and forth), except for cases where no kscript API is called (for example, number crunching, blocking IO, and so forth).

The general process to creating threads is like so:

```ks
>>> t = os.thread(print, range(10))
<thread '0x55B0CDB907D0'>
>>> t.start() # start the thread
none
0 1 2 3 4 5 6 7 8 9
>>> # do more work here
>>> t.join() # ensures the thread has finished, even though we know it has by the output
```

However, running with threads printing to the interpreter can create jumbled output.


#### os.thread.start(self) {#thread.start}
{: .method .no_toc }

<div class="method-text" markdown="1">
Begin executing a thread
</div>

#### os.thread.join(self) {#thread.join}
{: .method .no_toc }

<div class="method-text" markdown="1">
Wait for a thread to finish executing and join it back
</div>

#### os.thread.isalive(self) {#thread.isalive}
{: .method .no_toc }

<div class="method-text" markdown="1">
Polls the thread and returns whether it is still alive
</div>

---

