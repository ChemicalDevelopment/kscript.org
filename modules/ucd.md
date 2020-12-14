---
layout: default
title: 'ucd: Unicode Database'
parent: Modules
---

# Unicode Database Module ('import ucd')
{: .no_toc }

 * TOC
{:toc}


[Unicode](https://en.wikipedia.org/wiki/Unicode) is a set of standards for text encoding, representation, and character sets. Supporting unicode is easy to do in kscript, which allows the [`str`](/types#str) type to take on any of the unicode codepoints. However, sometimes you want to do more than just store the text, and print it out. Sometimes, you would like to, for example, tell what kind of character a part of a string is. This module allows you to look up information about Unicode characters dynamically.

Note: Your system may or may not be compiled for full Unicode support. For example, if you have an embedded version of kscript, or are running on systems with low amounts of resources.


## Variables

| Name | Description|
|:-------|:-----|
| `ucd.NUM` | Number of unicode codepoints defined in the database. If <= 256, then kscript is compiled in ASCII-only mode |


## Types


---

## Functions


#### ucd.lookup(name) {#lookup}
{: .method }

<div class="method-text" markdown="1">

Searches for a Unicode character with a specific name


See: [https://en.wikipedia.org/wiki/List_of_Unicode_characters](https://en.wikipedia.org/wiki/List_of_Unicode_characters)

Examples:

```ks
>>> ucd.lookup('LATIN SMALL LETTER A')
...
```

</div>


#### ucd.info(chr) {#info}
{: .method }

<div class="method-text" markdown="1">
Returns a structure describing information about a character

Requires the input to be a string of length 1
</div>

#### ucd.name(chr) {#name}
{: .method }

<div class="method-text" markdown="1">
Returns the Unicode codepoint name (which is all ASCII) of the 

Examples:

```ks
>>> ucd.name('a')
'LATIN SMALL LETTER A'
>>> ucd.name('4')
'DIGIT FOUR'
>>> ucd.name('∑')
'N-ARY SUMMATION'
>>> ucd.name('π')
'GREEK SMALL LETTER PI'
```

</div>

---

