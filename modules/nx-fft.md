---
layout: default
parent: 'nx: NumeriX'
grand_parent: Modules
title: 'nx.fft: Transforms'
permalink: /modules/nx/fft
---

# NumeriX FFT Module ('import nx.fft')
{: .no_toc }

This module is a submodule of the [`nx`](/modules/nx) module. Specifically, it provides [FFT (Fast Fourier Transform)](https://en.wikipedia.org/wiki/Fast_Fourier_transform) functionality.

Different languages/libraries use different conventions for FFT/IFFT/other transforms as well. It's important you know which is used by kscript, as they are explained per-function.


 * TOC
{:toc}

---

## `nx.fft.fft(x, axes=none, r=none)`: Forward FFT {#fft}

Calculates the forward FFT of `x`, upon `axes` (default: all axes), and stores in `r` (or, if `r==none`, then a result is allocated)

The result of this function is always complex. If an integer datatype input is given, the result will be [`nx.complexdouble`](/modules/nx#complexdouble). All numeric datatypes are supported, and are to full precision (even [`nx.complexquad`](/modules/nx#complexquad)). 

For a 1D FFT, let $N$ be the size, $x$ be the input, and $X$ be the output. Then, the corresponding entries of $X$ are given by:

$$X_j = \sum_{k=0}^{N-1} x_k e^{-2 \pi i j k /N}$$

For an ND FFT, the result is equivalent to doing a 1D FFT over each of `axes`

See [`nx.fft.ifft`](#ifft) (the inverse of this function)

Examples:

```ks
>>> nx.fft.fft([1, 2, 3, 4])
[10.0+0.0i, -2.0-2.0i, -2.0+0.0i, -2.0+2.0i]
```
---

## `nx.fft.ifft(x, axes=none, r=none)`: Inverse FFT {#fft}

Calculates the inverse FFT of `x`, upon `axes` (default: all axes), and stores in `r` (or, if `r==none`, then a result is allocated)

The result of this function is always complex. If an integer datatype input is given, the result will be [`nx.complexdouble`](/modules/nx#complexdouble). All numeric datatypes are supported, and are to full precision (even [`nx.complexquad`](/modules/nx#complexquad)). 

For a 1D IFFT, let $N$ be the size, $x$ be the input, and $X$ be the output. Then, the corresponding entries of $X$ are given by:

$$X_j = \sum_{k=0}^{N-1} \frac{x_k e^{2 \pi i j k / N}}{N}$$

Note that there is a $\frac{1}{N}$ term in the summation. Some other libraries do different kinds of scaling. The kscript fft/ifft functions will always produce the same result (up to machine precision) when given: `nx.fft.ifft(nx.fft.fft(x))`

For an ND IFFT, the result is equivalent to doing a 1D IFFT over each of `axes`

See [`nx.fft.fft`](#fft) (the inverse of this function)

Examples:

```ks
>>> nx.fft.ifft([1, 2, 3, 4])
[2.5+0.0i, -0.5+0.5i, -0.5+0.0i, -0.5-0.5i]
```
---


