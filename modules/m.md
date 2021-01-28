---
layout: default
parent: Modules
title: 'm: Math'
permalink: /modules/m
nav_order: 40
---

# Math Module ('import m')
{: .no_toc }

The math module (`m`) provides functionality to aid in mathematical problems/needs. This module contains common mathematical constants (such as $\pi$, $\tau$, $e$, and so forth), as well as functions that efficiently and accurately compute commonly used functions (such as $\sin$, $\cos$, $\Gamma$, and so forth). This module also includes some integer and number-theoretic functions, such as computing the greatest common denominator ('gcd'), binomial coefficients, and primality testing.

This module is meant to work with the types that follow the [`number`](/builtins#number) pattern, such as [`int`](/builtins#int), [`float`](/builtins#float), and [`complex`](/builtins#complex). Most functions are defined for real and complex evaluation. If a real number is given, then (generally) a real number is returned. If a complex number is given, then (generally) a complex number is returned. If a real number is given (for example, to [`m.sqrt`](#sqrt)) and the result would be a complex number (i.e. `m.sqrt(-1)`), then an error is thrown (this makes it easy to find bugs, and in general real numbers are what most people care about -- and they would like an error on code such as `m.sqrt(-1)`). To get around this, you can write: `m.sqrt(complex(-1))`, and the result will always be a `complex`, and an error won't be thrown for negative numbers.

Constants are given in maximum precision possible within a [`float`](/builtins#float), but for all of these constants, their value is not exact. This causes some issues or unexpected results. For example, mathematically, $\sin(\pi) = 0$, but `m.sin(m.pi)` is approximately equal to `1.22464679914735e-16`. This is expected when using finite precision. Just make sure to keep this in mind. 

For example:

```ks
# Bad, may cause unexpected results
if m.sin(m.pi) == 0, ...

# Better, uses a decent tolerance (1e-6 is pretty good)
if abs(m.sin(m.pi) - 0) < 1e-6 , ...

# Best, use the m.isclose() function
if m.isclose(m.sin(m.pi), 0), ...
```


 * TOC
{:toc}

---

## Constants

#### `m.pi`: Pi ($\pi$), the circle constant {#pi}
{: .method }
<div class="method-text" markdown="1">
[Pi](https://en.wikipedia.org/wiki/Pi) ($\pi$) is the ratio of a circle's circumference to its diameter

```ks
>>> m.pi
3.141592653589793
```
</div>

---

#### `m.tau`: Pi ($\tau$), another circle constant {#tau}
{: .method }
<div class="method-text" markdown="1">
[Pi](https://en.wikipedia.org/wiki/Pi) ($\pi$) is the ratio of a circle's circumference to its ratio

$\tau = 2 \pi$

```ks
>>> m.tau
6.283185307179586
```
</div>

---

#### `m.e`: E ($e$), Euler's number {#e}
{: .method }
<div class="method-text" markdown="1">
[E](https://en.wikipedia.org/wiki/E_(mathematical_constant)) ($e$), or Euler's number, is defined as $\sum_{n=0}^{\infty} \frac{1}{n!}$

```ks
>>> m.e
2.718281828459045
```
</div>

---

#### `m.phi`: Phi ($\phi$), Golden ratio {#phi}
{: .method }
<div class="method-text" markdown="1">
[The golden ratio](https://en.wikipedia.org/wiki/Golden_ratio) ($\phi$), is defined as $\frac{1+\sqrt 5}{2}$

```ks
>>> m.phi
1.618033988749895
```
</div>

---

#### `m.mascheroni`: gamma ($\gamma$), Euler-Mascheroni constant {#mascheroni}
{: .method }
<div class="method-text" markdown="1">
The [Euler-Mascheroni constant](https://en.wikipedia.org/wiki/Euler%E2%80%93Mascheroni_constant) ($\gamma$), is defined as $\lim_{n \to \infty}( -\ln n + \sum_{k=1}^{n} \frac{1}{k} )$

```ks
>>> m.mascheroni
0.577215664901533
```
</div>

---


## Functions

### Arithmetic Functions

#### `m.isclose(x, y, abs_err=1e-6, rel_err=1e-6)`: Closeness-testing {#isclose}
{: .method }

<div class="method-text" markdown="1">
Computes whether `x` and `y` are "close", i.e. within `abs_err` absolute error or having a relative error of `rel_err`.

Is equivalent to:

```ks
func isclose(x, y, abs_err=1e-6, rel_err=1e-6) {
    ad = abs(x - y)
    ret ad <= abs_err && ad <= abs_err * max(abs(x), abs(y))
}
```
</div>

#### `m.floor(x)`: Floor {#floor}
{: .method }

<div class="method-text" markdown="1">
Computes the [floor](https://en.wikipedia.org/wiki/Floor_and_ceiling_functions) of `x`, as an `int`
</div>

#### `m.ceil(x)`: Ceiling {#ceil}
{: .method }

<div class="method-text" markdown="1">
Computes the [ceiling](https://en.wikipedia.org/wiki/Floor_and_ceiling_functions) of `x`, as an `int`
</div>

#### `m.round(x)`: Rounding {#round}
{: .method }

<div class="method-text" markdown="1">
Computes the nearest [`int`](/builtins#int) to `x`, rounding towards `+inf` if exactly between integers
</div>

#### `m.sgn(x)`: Sign {#sgn}
{: .method }

<div class="method-text" markdown="1">
Computes the [sign](https://en.wikipedia.org/wiki/Sign_function) of `x`, returning `+1`, `0`, or `-1`
</div>

#### `m.sqrt(x)`: Square root {#sqrt}
{: .method }

<div class="method-text" markdown="1">
Computes the [square root](https://en.wikipedia.org/wiki/Square_root) of `x`

If `x` is a real type (i.e. `int`, or `float`), then negative numbers will throw a [`MathError`](/builtins#MathError). You can write `m.sqrt(complex(x))` instead to always handle negative numbers
</div>

#### `m.cbrt(x)`: Cube root {#cbrt}
{: .method }

<div class="method-text" markdown="1">
Computes the [cube root](https://en.wikipedia.org/wiki/Cube_root) of `x`
</div>


#### `m.exp(x)`: Exponential function {#exp}
{: .method }

<div class="method-text" markdown="1">
Computes the [base-$e$ exponential](https://en.wikipedia.org/wiki/Exponential_function) of `x`
</div>

#### `m.log(x, b=m.e)`: Logarithm function {#log}
{: .method }

<div class="method-text" markdown="1">
Computes the base `b` [logarithm](https://en.wikipedia.org/wiki/Logarithm) of `x`. If `b` is not given, then it is the [natural logarithm](https://en.wikipedia.org/wiki/Natural_logarithm)
</div>



### Trigonometric Functions

#### `m.rad(x)`: Radians from degrees {#rad}
{: .method }

<div class="method-text" markdown="1">
Convert `x` (which is in degrees) to radians
</div>

#### `m.deg(x)`: Degrees from radians {#deg}
{: .method }

<div class="method-text" markdown="1">
Convert `x` (which is in radians) to degrees
</div>

#### `m.hypot(x, y)`: Hypotenuse {#hypot}
{: .method }

<div class="method-text" markdown="1">
Computes the hypotenuse of a right triangle with sides `x` and `y`

Approximately equal to $\sqrt{x^2 + y^2}$
</div>

#### `m.sin(x)`: Sine {#sin}
{: .method }

<div class="method-text" markdown="1">
Computes the sine of `x`, which is in radians
</div>

#### `m.cos(x)`: Cosine {#cos}
{: .method }

<div class="method-text" markdown="1">
Computes the cosine of `x`, which is in radians
</div>

#### `m.tan(x)`: Tangent {#tan}
{: .method }

<div class="method-text" markdown="1">
Computes the tangent of `x`, which is in radians
</div>

#### `m.sinh(x)`: Hyperbolic sine {#sinh}
{: .method }

<div class="method-text" markdown="1">
Computes the hyperbolic sine of `x`
</div>

#### `m.cosh(x)`: Hyperbolic cosine {#cosh}
{: .method }

<div class="method-text" markdown="1">
Computes the hyperbolic cosine of `x`
</div>

#### `m.tanh(x)`: Hyperbolic tangent {#tanh}
{: .method }

<div class="method-text" markdown="1">
Computes the hyperbolic tangent of `x`
</div>

#### `m.asin(x)`: Inverse sine {#asin}
{: .method }

<div class="method-text" markdown="1">
Computes the inverse sine of `x`, which is in radians
</div>

#### `m.acos(x)`: Inverse cosine {#acos}
{: .method }

<div class="method-text" markdown="1">
Computes the inverse cosine of `x`, which is in radians
</div>

#### `m.atan(x)`: Inverse tangent {#atan}
{: .method }

<div class="method-text" markdown="1">
Computes the inverse tangent of `x`, which is in radians
</div>

#### `m.asinh(x)`: Inverse hyperbolic sine {#asinh}
{: .method }

<div class="method-text" markdown="1">
Computes the inverse hyperbolic sine of `x`
</div>

#### `m.acosh(x)`: Inverse hyperbolic cosine {#acosh}
{: .method }

<div class="method-text" markdown="1">
Computes the inverse hyperbolic cosine of `x`
</div>

#### `m.atanh(x)`: Inverse hyperbolic tangent {#atanh}
{: .method }

<div class="method-text" markdown="1">
Computes the inverse hyperbolic tangent of `x`
</div>

#### `m.atan2(x, y)`: Cartesian coordinates to angle {#atan2}
{: .method }

<div class="method-text" markdown="1">
Computes the [angle](https://en.wikipedia.org/wiki/Atan2) of a point in space

Unlike most implementations (which take `(y, x)`), this function accepts `(x, y)`
</div>

### Special Functions

#### `m.erf(x)`: Error function {#erf}
{: .method }

<div class="method-text" markdown="1">
Computes the [error function](https://en.wikipedia.org/wiki/Error_function) of `x`

Defined as $\frac{2}{\sqrt \pi} \int_{0}^{x} e^{-t^2} dt$
</div>

#### `m.erfc(x)`: Complimentary error function {#erfc}
{: .method }

<div class="method-text" markdown="1">
Computes the complimentary error function of `x`

Defined as `1 - `m.erf(x)`:`
</div>

#### `m.gamma(x)`: Gamma function {#gamma}
{: .method }

<div class="method-text" markdown="1">
Computes the [Gamma function](https://en.wikipedia.org/wiki/Gamma_function) of `x`
</div>


#### `m.zeta(x)`: Riemann Zeta Function {#zeta}
{: .method }

<div class="method-text" markdown="1">
Computes the [Riemann Zeta function](https://en.wikipedia.org/wiki/Riemann_zeta_function) of `x`
</div>


### Number Theoretic Functions

#### `m.modinv(x, n)`: Modular inverse {#modinv}
{: .method }

<div class="method-text" markdown="1">
Computes the [modular inverse](https://en.wikipedia.org/wiki/Modular_multiplicative_inverse) of `x` within $Z_n$

A `MathError` is thrown if no such inverse exists
</div>

#### `m.gcd(x, y)`: Greatest Common Denominator (GCD) {#gcd}
{: .method }

<div class="method-text" markdown="1">
Computes the [greatest common denominator](https://en.wikipedia.org/wiki/Greatest_common_divisor) of `x` and `y`
</div>

#### `m.egcd(x, y)`: Extended Greatest Common Denominator (EGCD) {#egcd}
{: .method }

<div class="method-text" markdown="1">
Computes the [extended greatest common denominator](https://en.wikipedia.org/wiki/Extended_Euclidean_algorithm) of `x` and `y`, returning `(g, s, t)` such that `x*s + y*t == g == `m.gcd(x, y)`:`

If `abs(x) == abs(y)`, then `(g, 0, `m.sgn(y))`:` is returned
</div>
