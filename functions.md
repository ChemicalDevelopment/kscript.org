---
layout: default
title: Functions
nav_order: 4
permalink: functions
---

# Functions
{: .no_toc }



Here are all the builtin, global functions available everywhere:

 * TOC
{:toc}

---

#### print(*args)
{: .method }

<div class="method-text" markdown="1">
Prints any number of arguments converted to [`str`](/types#str), seperated by a space (`' '`), and then a newline (`'\n'`) to the main output of the program, which is `os.stdout`

If objects are strings, they are printed directly. Otherwise, `str(arg)` is called, and the result of that call is printed 

Example:

```ks
>>> print("hello, world")
hello, world
>>> print (2 + 3 * 4)
14
```

</div>

---

