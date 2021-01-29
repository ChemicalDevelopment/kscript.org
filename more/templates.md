---
layout: default
parent: More
title: 'Templates'
nav_order: 30
permalink: /more/templates
---

# Templates
{: .no_toc }

 * TOC
{:toc}


Templates in kscript are ways of creating subtypes of a template type based on template parameters. It is done by subscripting a type, i.e. `TypeName[A, B, ...]`. Examples of templates in the standard library are the types:

  * [`ffi.ptr[T]`](/modules/ffi#ptr): Templated type which refers to a pointer to another type
  * [`ffi;.func[ResultT, (ArgsT, ...)`](/modules/ffi#func): Templated type which refers to a function type which has differing types of the returned value and arguments passed in

Templates can held with the extremely dynamic nature of kscript -- they can be used as a sort of type checking, which may throw errors if operations use unsupported types.


