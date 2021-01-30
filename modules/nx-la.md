---
layout: default
parent: 'nx: NumeriX'
grand_parent: Modules
title: 'nx.rand: PRNG'
permalink: /modules/nx/rand
---

# NumeriX Random Module ('import nx.rand')
{: .no_toc }

 * TOC
{:toc}

This module is a submodule of the [`nx`](/modules/nx) module. Specifically, it provides access to (psuedo-)random number generation (PRNG/RNG), through functions as well as generator types.


## `nx.rand.State(seed=none)`: Generator state {#State}

This type represents a random number generator state, which can be used to produce all sorts of distributions (see the functions under this type). Essentially, it can be thought of as a generator of random or psuedo-random bytes (see [`nx.rand.State.randb`](#State.randb) and [`nx.rand.randb`](#randb)), which can then be transformed into integers, floats, or real numbers in a given distribution (such as a Guassian/Bellcurve/Normal distribution, see [`nx.rand.State.normal`](#State.normal) and [`nx.rand.normal`](#normal)).


Calling this type as a function creates a new random number generator, with an optional seed. If no seed is given, or `none` is given, then the random number generator is attempted to be seeded by the following sources (if one isn't available, it tries the next one, and so forth):

  * OS-provided source of randomness (i.e. `/dev/urandom`)
  * Current time, in seconds, since the epoch (i.e. `time()` function in the C library)
  * The number [`42`](https://en.wikipedia.org/wiki/42_(number)#The_Hitchhiker's_Guide_to_the_Galaxy)

Random states can be re-seeded via the [`nx.rand.State.seed`](#State.seed) function at anytime, which will reset the internal implementation and going forward will act as a new random state initialized with a given seed. You can reseed the default state used by this entire module via the [`nx.seed`](#seed) function.


---