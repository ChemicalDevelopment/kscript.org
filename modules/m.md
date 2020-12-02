---
layout: default
title: 'm: Math Module'
parent: Modules
---

# Math Module ('import m')
{: .no_toc }

 * TOC
{:toc}

The math module (`m`) provides functionality to aid in mathematical problems/needs. This module contains common mathematical constants (such as $\pi$, $\tau$, $e$, and so forth), as well as functions that efficiently and accurately compute commonly used functions (such as $\sin$, $\cos$, $\Gamma$, and so forth). This module also includes some integer and number-theoretic functions, such as computing the greatest common denominator ('gcd'), binomial coefficients, and primality testing.

This module is meant to work with the builtin `number` types and subtypes, such as `int`, `float`, and `complex`


## Constants

Constants are given in maximum precision possible within a `float`, but for all of these constants, their value is not exact. This causes some issues or unexpected results. For example, mathematically, $\sin(\pi) = 0$, but `m.sin(m.pi) = 1.22464679914735e-16`. This is expected when using finite precision. Just make sure to keep this in mind. 


For example:

```ks
# Bad, may cause unexpected results
if m.sin(m.pi) == 0, ...

# Better, uses a decent tolerance (1e-6 is pretty good)
if abs(m.sin(m.pi) - 0) < 1e-6 , ...
```

Here is a table of constants available:

| Constant | Value | Description|
|:-------|:--------|:-----|
| `m.pi` | `3.141592653589793238...` | [Pi](https://en.wikipedia.org/wiki/Pi) ($\pi$), which is the ratio of a perfect circle's circumference to its diameter |
| `m.tau` | `6.283185307179586476...` | Tau ($\tau$), which is equal to $2 * \pi$, is the ratio of a perfect circle's circumference to its diameter |
| `m.e` | `2.718281828459045235...` | [E](https://en.wikipedia.org/wiki/E_(mathematical_constant)) ($e$), or Euler's number, is defined as $\sum_{n=0}^{\infty} \frac{1}{n!}$ |
| `m.phi` | `1.618033988749894848...` | [The golden ratio](https://en.wikipedia.org/wiki/Golden_ratio) ($\phi$), is defined as $\frac{1+\sqrt 5}{2}$ |
| `m.mascheroni` | `0.577215664901532860...` | The [Euler-Mascheroni constant](https://en.wikipedia.org/wiki/Euler%E2%80%93Mascheroni_constant) ($\gamma$), is defined as $\lim_{n \to \infty}( -\ln n + \sum_{k=1}^{n} \frac{1}{k} )$ |


## Functions

### Arithmetic Functions

| Function | Description | Notes |
|:--|:--|:--|
| `m.floor(x)` | Computes the [floor](https://en.wikipedia.org/wiki/Floor_and_ceiling_functions) of `x` | Always returns an `int` |
| `m.ceil(x)` | Computes the [ceiling](https://en.wikipedia.org/wiki/Floor_and_ceiling_functions) of `x` | Always returns an `int` |
| `m.round(x)` | Returns the nearest `int` to `x`, rounding towards `+inf` if exactly between integers | Always returns an `int` |
| `m.sgn(x)` | Returns the [sign](https://en.wikipedia.org/wiki/Sign_function) of `x` | Returns either `+1`, `0`, or `-1` |
| `m.abs(x)` | Returns the absolute value | Behaves exactly like the `abs` function, except that it only accepts numeric types |
| `m.sqrt(x)` | Computes the [square root](https://en.wikipedia.org/wiki/Square_root) of `x` | Mostly equivalent to `x ** 0.5` |
| `m.cbrt(x)` | Computes the [cube root](https://en.wikipedia.org/wiki/Cube_root) of `x` | Mostly equivalent to `x ** (1 / 3)` |
| `m.exp(x)` | Computes the [base-$e$ exponential](https://en.wikipedia.org/wiki/Exponential_function) of `x` | Mostly equivalent to `m.e ** x` |
| `m.log(x, b=m.e)` | Computes the base `b` [logarithm](https://en.wikipedia.org/wiki/Logarithm) of `x`. If no second argument is given, then it is the [natural logarithm](https://en.wikipedia.org/wiki/Natural_logarithm) | |

### Trigonometric Functions

| Function | Description | Notes |
|:--|:--|:--|
| `m.rad(x)` | Convert `x` (which is in degrees) to radians | |
| `m.deg(x)` | Convert `x` (which is in radians) to degrees | |
| `m.hypot(x, y)` | Computes the hypotenuse of a right triangle with sides `x` and `y` | Approximately equal to $\sqrt{x^2 + y^2}$ |
| `m.sin(x)` |  |  |
| `m.cos(x)` | Computes the cosine of `x`, which is in radians |  |
| `m.tan(x)` | Computes the tangent of `x`, which is in radians |  |
| `m.asin(x)` | Computes the inverse sine of `x`, which is in radians |  |
| `m.acos(x)` | Computes the inverse cosine of `x`, which is in radians |  |
| `m.atan(x)` | Computes the inverse tangent of `x`, which is in radians |  |
| `m.atan2(x, y)` | Computes the [angle](https://en.wikipedia.org/wiki/Atan2) of a point in space | Unlike most implementations (which take `(y, x)`), this function accepts `(x, y)` |
| `m.sinh(x)` | Computes the hyperbolic sine of `x` |  |
| `m.cosh(x)` | Computes the hyperbolic cosine of `x` |  |
| `m.tanh(x)` | Computes the hyperbolic tangent of `x` |  |
| `m.asinh(x)` | Computes the inverse hyperbolic sine of `x` |  |
| `m.acosh(x)` | Computes the inverse hyperbolic cosine of `x` |  |
| `m.atanh(x)` | Computes the inverse hyperbolic tangent of `x` |  |

### Special Functions

| `m.erf(x)` | Computes the [error function](https://en.wikipedia.org/wiki/Error_function) of `x` | Defined as $\frac{2}{\sqrt \pi} \int_{0}^{x} e^{-t^2} dt$ |
| `m.erfc(x)` | Computes the complimentary error function of `x`| Defined as `1 - m.erf(x)` |
| `m.gamma(x)` | Computes the [Gamma function](https://en.wikipedia.org/wiki/Gamma_function) of `x` |  |
| `m.zeta(x)` | Computes the [Riemann Zeta function](https://en.wikipedia.org/wiki/Riemann_zeta_function) of `x` |  |

### Number Theoretic Functions

| Function | Description | Notes |
|:--|:--|:--|
| `m.modinv(x, n)` | Computes the [modular inverse](https://en.wikipedia.org/wiki/Modular_multiplicative_inverse) of `x` within $Z_n$ | A `MathError` is thrown if no such inverse exists |
| `m.gcd(x, y)` | Computes the [greatest common denominator](https://en.wikipedia.org/wiki/Greatest_common_divisor) of `x` and `y` | |
| `m.egcd(x, y)` | Computes the [extended greatest common denominator](https://en.wikipedia.org/wiki/Extended_Euclidean_algorithm) of `x` and `y`, returning `(g, s, t)` such that `x*s + y*t == g == m.gcd(x, y)` | If `abs(x) == abs(y)`, then `(g, 0, m.sgn(y))` is returned |

