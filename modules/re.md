---
layout: default
title: 're: Regular Expressions'
parent: Modules
---

# Regular Expressions Module ('import re')
{: .no_toc }

 * TOC
{:toc}

The [regular expressions](https://en.wikipedia.org/wiki/Regular_expression) module (`re`) provides types and methods for searching through text to find patterns. This can be very helpful in writing utilities (which may look for a pattern, and process lines that match), as well as when writing a lexer to tokenize an input stream, which makes it easier to process.

Although the term 'regular expressions' originally referred to expressions describing truly regular languages (as in formal language theory), we use the term to mean an extended number of pattern descriptions (such as backreferences). However, these features often complicate the algorithms required to match, resulting in slower match times and degraded performance.

kscript has a special syntax for regex patterns, with `` `<pattern>` ``. For example, `` `a*b` `` matches any number of `a` characters followed by a `b` character. The syntax is equivalent to `re.compile('<pattern>')` as a string input. Thus:

```ks
>>> `a*b` == re.compile('a*b')
true
>>> `[abc]+(def)*` == re.compile('[abc]+(def)*')
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

kscript allows you to inspect regular expressions, as [nondeterministic finite automata](https://en.wikipedia.org/wiki/Nondeterministic_finite_automaton). To do this, you should first convert a regex pattern into a `graph`:

```ks
>>> pat = `a*b`
`a*b`
>>> nfa = graph(pat)
graph(['s0', 's1', 's2', 's3'], [(0, 1), (0, 2), (1, 0, 'a'), (2, 3, 'b')])
>>> fp = open('out.dot', 'w'); fp.write(nfa._dotfile()); close(fp)
>>> # Now, you can run the 'dot' tool on the contents of that file
```

Converting to a `png` via the `dot` tool (see: [https://graphviz.org/](https://graphviz.org/)), we get the following image:

![{{ site.baseurl }}/assets/images/nfa-0.svg]({{ site.baseurl }}assets/images/nfa-0.svg)

Edges which have no value/label are [epsilon transitions](https://en.wikipedia.org/wiki/Epsilon_transition)


Here are some other examples:

![{{ site.baseurl }}/assets/images/nfa-1.svg]({{ site.baseurl }}assets/images/nfa-1.svg)



## Types

It is not recommended to instantiate `re` module's types directly, but rather just call `re.compile()`, which will return the best type for the regular expression (for example, if no backreferences are used, then a faster datastructure will be returned that has equivalent functionality).

### [`re.Regex`: Represents a regular expression pattern](#regex)


#### re.Regex.exact(self, src)
{: .method .no_toc }

<div class="method-text" markdown="1">
Calculate whether the pattern `self` matches `src` exactly (i.e. the match begins at the start of `src` and matches the full length)
</div>


---

## Functions


#### re.compile(expr)
{: .method }

<div class="method-text" markdown="1">
Compiles the regular expression `expr`, and returns a suitable pattern. 

This method will return the most optimized datastructure -- for example, if no backreferences are used, then the resulting datastructure will be very efficient
</div>


---




