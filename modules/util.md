---
layout: default
parent: Modules
title: 'util: Utilities'
permalink: /modules/util
nav_order: 10
---

# Utilities Module ('import util')
{: .no_toc }

The utilities module (`util`) provides commonly needed datastructures and algorithms that are not available as [builtins](/builtins). If you notice that a common data structure is not in this module, then check the [builtins](#builtins) for it first. If you still haven't found it, please [contact us](/contact) and tell us what you think is missing from this module -- if we agree, we'll add it.



 * TOC
{:toc}

---

## `util.BST(objs={})`: Binary Search Tree {#BST}

This type represents a key-value mapping following the [`dict`](/builtins#dict) [pattern](/more/patterns). Unlike `dict`, however, keys must be comparable (not neccessarily hashable), and are stored in sorted order (as opposed to first insertion order). This is important for algorithms which maintain a sorted list.


You can construct a [`util.BST`](#BST) from a [`dict`](#dict) through its constructor, like so:

```ks
>>> util.BST({2: 'a', 1: 'b'})
util.BST({1: 'b', 2: 'a'})    # NOTE: keys are in sorted order now
```


You can iterate over these objects like a `dict`, too:

```ks
>>> x = util.BST({2: 'a', 1: 'b'})
util.BST({1: 'b', 2: 'a'})
>>> for k in x, print (k, x[k])
1 b
2 a
```


More examples:

```ks
>>> x = util.BST({2: 'a', 1: 'b'})
util.BST({1: 'b', 2: 'a'})
>>> 1 in x
true
>>> 3 in x
false
>>> x[0] = 'hey'
>>> x
util.BST({0: 'hey', 1: 'b', 2: 'a'})
```

---

