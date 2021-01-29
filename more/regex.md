---
layout: default
title: 'Regular Expressions'
nav_order: 40
parent: More
---

# (More) Regular Expressions
{: .no_toc }

 * TOC
{:toc}

[Regular expressions](https://en.wikipedia.org/wiki/Regular_expression) (the [`regex`](/builtins#regex) type in kscript) provides functionality for searching through text to find patterns. This can be very helpful in writing utilities (which may look for a pattern, and process lines that match), as well as when writing a lexer to tokenize an input stream, which makes it easier to process.

Although the term 'regular expressions' originally referred to expressions describing truly [regular languages](https://en.wikipedia.org/wiki/Regular_language) (as in formal language theory), many programming languages have included non-regular extensions (such as backreferences, and so forth). In kscript, however, regular expressions are true regular expressions (so, no backreferences are allowed). Although this may be seen as restrictive, it means that the performance of regex operations can be much faster (see [here](https://swtch.com/~rsc/regexp/regexp1.html)).


kscript has a special syntax for regex patterns, with `` `<pattern>` ``. For example, `` `a*b` `` matches any number of `a` characters followed by a `b` character. The syntax is equivalent to `regex('<pattern>')`, which compiles a string expression. Thus:

```ks
>>> `a*b` == regex('a*b')
true
>>> `[abc]+(def)*` == regex('[abc]+(def)*')
true
```

## Regex Syntax

A regular expression is made up of multiple terms, which are seperated by the `|` character. Within each term, there may be any number of factors concatenated together. Each factor is an item, with modifiers (`?`, `+`, `*`) applied. And, at the lowest level, an item is either a character literal (such as `a`, `b`, and so forth), a character set within `[]`, a group `()`, or a metacharacter (`\d`, `\w`, and so forth). In an [EBNF](https://en.wikipedia.org/wiki/Extended_Backus%E2%80%93Naur_form) like syntax:


```
REGEX    = TERM ('|' TERM)*
TERM     = FACTOR *

FACTOR   = ITEM ('?' | '+' | '*')*

ITEM     = SET
         | GROUP
         | '\' CHAR
         | CHAR
        
GROUP    = '(' REGEX ')'

(* '^' indicates negation *)
SET      = '[' '^'?  SET_ITEM* ']'

SET_ITEM = '\' CHAR
         | CHAR '-' CHAR  (* Range of codepoints *)
         | CHAR

CHAR     = ? unicode character ?
```


## NFA Inspection

kscript allows you to inspect regular expressions, as [nondeterministic finite automata](https://en.wikipedia.org/wiki/Nondeterministic_finite_automaton). To do this, you should first convert a regex pattern into a [`util.Graph`](/modules/util#Graph):

```ks
>>> import util
>>> pat = `a*b`
`a*b`
>>> nfa = pat as util.Graph
util.Graph(['s0', 's1', 's2', 's3'], [(0, 1), (0, 2), (1, 0, 'a'), (2, 3, 'b')])
>>> print (nfa._dotfile())
digraph G {
    0 [label="s0"];
    0 -> 1;
    0 -> 2;
    1 [label="s1"];
    1 -> 0 [label="a"];
    2 [label="s2"];
    2 -> 3 [label="b"];
    3 [label="s3"];
}
>>> # Now, you can run the 'dot' tool on the contents of that file
```

Converting to a `svg` via the `dot` tool (see: [https://graphviz.org/](https://graphviz.org/)), we get the following image:

![{{ site.baseurl }}/assets/images/nfa-0.svg]({{ site.baseurl }}/assets/images/nfa-0.svg)

Edges which have no value/label are [epsilon transitions](https://en.wikipedia.org/wiki/Epsilon_transition)


Here are some other examples:

![{{ site.baseurl }}/assets/images/nfa-1.svg]({{ site.baseurl }}/assets/images/nfa-1.svg)

