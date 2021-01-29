---
layout: default
parent: Modules
title: 'gram: Grammar'
permalink: /modules/gram
nav_order: 150
---

# Grammar Module ('import gram')
{: .no_toc }

The grammar module (`gram`) provides commonly needed types and algorithms for dealing with computer grammars (for example, descriptions of programming language syntax)



 * TOC
{:toc}

---

## `gram.Lexer(rules, src=os.stdin)`: Regex-Based Lexer {#Lexer}

This type represents a lexer/tokenizer which token rules are defined as either [`str`](/builtins#str) literals or [`regex`](/builtins#regex) patterns.


The constructor takes an iterable of rules -- each rule is expected to be a tuple of length 2, containing `(pattern, action)`. `pattern` may be a [`str`](/builtins#str) or [`regex`](/builtins#regex); if it is a string, then the token matches that string literal exactly, and otherwise the token matches the regex pattern. `action` may be a function (in which case the result of a token being found is the result of `action(tokenstring)`). Otherwise, it is may be an integral object, which is the token kind. Commonly, these may be members of an enumeration meant to represent every token kind in a given context. Otherwise, `action` is expected to be `none`, in which case the potential token is discarded and the characters that made up that token are ignored. The rule that is chosen is that which generates the longest match from the current position in a file. If two rules match the same length, then the one given first in the `rules` variable is used first.

The second argument, `src`, is expected to be an object similar to [`io.BaseIO`](/modules/io#BaseIO) (default is [`os.stdin`](/modules/os#stdin)). This is the source from which characters are taken.


This is hard to grasp abstractly -- here is an example recognizing numbers and words, and ignoring everything else:

```ks
>>> L = gram.Lexer([
...     (`[:alpha:]+`,   0),
...     (`[:digit:]+`,   1),
...     (`.`,     none).
...     (`\n`,    none)
... ], io.StringIO("hey 123 456 test"))
gram.Lexer([(regex('[[:alpha:]_][[:alpha:]_[:digit:]]*'), 0), (regex('\\d+'), 1), (regex('.'), none), (regex('\\n'), none)], <'io.StringIO' @ 0x55A6E90CE990>)
>>> next(L)
gram.Token(0, 'hey')
>>> next(L)
gram.Token(1, '123')
>>> next(L)
gram.Token(1, '456')
>>> next(L)
gram.Token(0, 'test')
>>> next(L)
OutOfIterException: 
Call Stack:
  #0: In '<expr>' (line 1, col 1):
next(L)                                                                                                                                                                   ^~~~~~~
  #1: In next(obj) [cfunc]
  #2: In gram.Lexer.__next(self) [cfunc]
In <thread 'main'>
```

You can also iterate over a lexer to produce the token stream:

```ks
>>> L = gram.Lexer([
...     (`[:alpha:]+`,   0),
...     (`[:digit:]+`,   1),
...     (`.`,     none).
...     (`\n`,    none)
... ], io.StringIO("hey 123 456 test"))
gram.Lexer([(regex('[[:alpha:]_][[:alpha:]_[:digit:]]*'), 0), (regex('\\d+'), 1), (regex('.'), none), (regex('\\n'), none)], <'io.StringIO' @ 0x55A6E90CE990>)
>>> for tok in L, print(repr(tok))
gram.Token(0, 'hey')
gram.Token(1, '123')
gram.Token(1, '456')
gram.Token(0, 'test')
```
