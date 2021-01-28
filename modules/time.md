---
layout: default
parent: Modules
title: 'time: Time'
permalink: /modules/time
nav_order: 70
---

# Time Module ('import time')
{: .no_toc }

The time module (`time`) provides functionality related computers telling time, such as getting/setting the current time, converting times, and waiting for an amount of time. 

Handling time is quite ugly -- calendars and systems of time are among the worst things standardized by human kind. Inconsistent, imperfect, and in many cases, limited by actual physical phenomena. As a result, this module is not as pure as many other modules, and has some very human-specific language, operations, and so forth. This is to be expected however, as things like the Earth, stars, and so forth cause things like leap seconds, timezones, etc. to be introduced. This module attempts to document what exactly is done and given by each function.

 * TOC
{:toc}

---

## `time.ISO8601`:  {#ISO8601}

[ISO8601](https://en.wikipedia.org/wiki/ISO_8601) is a standard for representing date and time data. Specifically, it gives a way to represent a date as a combination of the year, month, and day-of-the-month. For example, the first day of the year 1970 is `1970-01-01`. A specific time would be: `1970-01-01T00:00:00+0000`

This attribute of the `time` module expands to a string that can be passed to [`time.format`](#format) to result in ISO8601-format strings

---

## `time.time()`: Current time {#time}

Returns the current time as a floating point number representing the time since the Epoch in seconds. The Epoch is commonly 1970-01-01 (in [`ISO8601`](#ISO8601)) (January 1st, 1970)

---

## `time.clock()`: Current process time {#clock}

Returns the number of seconds since the process was started as a floating point number

---

## `time.sleep(dur)`: Go to sleep {#sleep}

Causes the current thread to sleep for `dur` seconds (allows floating point numbers). 

If your platform did not provide a sane sleep function (such as `nanosleep()` or `usleep()` in its C-library), this function may only sleep to the nearest second.

---

## `time.now()`: Get a DateTime referring the present {#now}

Returns a [`time.DateTime`](#DateTime) object representing the current moment, in UTC

See [`time.localnow()`](#localnow) for a local-timezone alternative

---

## `time.localnow()`: Get a DateTime referring the present {#now}

Returns a [`time.DateTime`](#DateTime) object representing the current moment, in the local time zone

See [`time.now()`](#now) for a UTC-timezone alternative

---

## `time.parse(val, fmt=time.ISO8601)`: Parse a DateTime {#parse}

Parses a time (a `str` stored in `val`) according to a format `fmt`, and returns a [`time.DateTime`](#DateTime) object representing it.

For format specifiers, see [`time.format`](#format) documentation

---

## `time.format(val=none, fmt=time.ISO8601)`: Format a DateTime {#format}

Formats a time `val` according to a format string `fmt`

`val` can be a real number (in which case it is interpreted as a time-since-epoch, i.e. the result of [`time.time()`](#time)), or a [`time.DateTime`](#DateTime) object

NOTE: This API may change soon... Cross platform support is very important and some of the names of the format can be redone

#### `%%`
{: .method .no_toc }
<div class="method-text" markdown="1">
Literal `%`
</div>

#### `%Y`
{: .method .no_toc }
<div class="method-text" markdown="1">
Outputs the year, in full
</div>

#### `%y`
{: .method .no_toc }
<div class="method-text" markdown="1">
Outputs the year modulo 100 (i.e. 1970 would result in `70`)
</div>


#### `%m`
{: .method .no_toc }
<div class="method-text" markdown="1">
Outputs the number of the month (starting at 1), zero-padded to 2 digits (01 though 12)
</div>

#### `%b`
{: .method .no_toc }
<div class="method-text" markdown="1">
Outputs the month in the current locale, abbreviated
</div>

#### `%B`
{: .method .no_toc }
<div class="method-text" markdown="1">
Outputs the month in the current locale, full
</div>

#### `%U`
{: .method .no_toc }
<div class="method-text" markdown="1">
Week of the year as a decimal number (starting on Sunday==0)

Days before the first sunday are week 0
</div>

#### `%W`
{: .method .no_toc }
<div class="method-text" markdown="1">
Week of the year as a decimal number (starting on Monday==0)

Days before the first monday are week 0
</div>

#### `%W`
{: .method .no_toc }
<div class="method-text" markdown="1">
Day of the year as a decimal number, padded to 3 digits (001...366)

Days before the first monday are week 0
</div>

#### `%d`
{: .method .no_toc }
<div class="method-text" markdown="1">
Day of the month as a decimal number, padded to 2 digits (01...31)
</div>

#### `%A`
{: .method .no_toc }
<div class="method-text" markdown="1">
Day of the week in locale, full
</div>

#### `%a`
{: .method .no_toc }
<div class="method-text" markdown="1">
Day of the week in locale, abbreviated
</div>

#### `%w`
{: .method .no_toc }
<div class="method-text" markdown="1">
Day of the week as an integer (Monday==0)
</div>

#### `%H`
{: .method .no_toc }
<div class="method-text" markdown="1">
Hour (in 24-hour clock) as zero-padded number (00...23)
</div>

#### `%I`
{: .method .no_toc }
<div class="method-text" markdown="1">
Hour (in 12 hour clock) as zero-padded number (00, 12)
</div>

#### `%M`
{: .method .no_toc }
<div class="method-text" markdown="1">
Minute as zero-padded number (00-59)
</div>

#### `%S`
{: .method .no_toc }
<div class="method-text" markdown="1">
Seconds as zero-padded decimal number (00-59)
</div>

#### `%f`
{: .method .no_toc }
<div class="method-text" markdown="1">
Microsecond as decimal number, formatted as '%-06i'
</div>

#### `%z`
{: .method .no_toc }
<div class="method-text" markdown="1">
Zone UTC offset in '(+|-)HHMM[SS.[ffffff]]'
</div>

#### `%Z`
{: .method .no_toc }
<div class="method-text" markdown="1">
Zone name (or empty if there was none)
</div>

#### `%p`
{: .method .no_toc }
<div class="method-text" markdown="1">
Locale's equiv of AM/PM
</div>

#### `%c`
{: .method .no_toc }
<div class="method-text" markdown="1">
Locale's full default date/time representation
</div>

#### `%x`
{: .method .no_toc }
<div class="method-text" markdown="1">
Locale's default date representation
</div>

#### `%X`
{: .method .no_toc }
<div class="method-text" markdown="1">
Locale's default time representation
</div>

---

## `time.DateTime(obj=none, tz=none)`: Get a DateTime referring the present {#DateTime}

This type represents a broken-down time structure comprised of the elements (accessible as attributes) humans commonly associate with a time. For example, the year, month, day, and so forth. 

You can create a datetime with the empty constructor (`time.DateTime()`) which is equivalent to calling [`time.now()`](#now). Or, you can pass in the first argument as a number of seconds since the Epoch (i.e. what is returned by [`time.time()`](#time)). For example, `time.DateTime(0)` will give you a datetime representing the Epoch itself. 

The constructor also accepts another argument `tz` which is the timezone. If not given, or `none`, the resulting datetime is in `UTC` (which is to say, a reasonable default). To get a datetime in local time, you can pass `"local"` as the second argument. You can also give it a specific name of a timezone, and it will attempt to use that timezone.

This type is not a completely consistent datatype (as it must deal with things like daylight savings, leap seconds, leap year, and so forth), so it is recommended to use a [`float`](/builtins#float) to capture absolute times, and deal with timestamps. 


Here are some examples of creating datetimes in various ways (the output may differ based on your location, obviously!):

```ks
>>> time.DateTime()      # Current datetime, in UTC
<time.DateTime '2021-01-13T01:10:26+0000'>
>>> time.DateTime(0)     # Epoch, in UTC
<time.DateTime '1970-01-01T00:00:00+0000'>
>>> time.DateTime(0, "local") # Epoch, in current timezone
<time.DateTime '1969-12-31T19:00:00-0500'>
```

#### time.DateTime.tz {#DateTime.tz}
{: .method .no_toc }
<div class="method-text" markdown="1">
This attribute retrieves the timezone, which may be a `str` or `none`
</div>

#### time.DateTime.tse {#DateTime.tse}
{: .method .no_toc }
<div class="method-text" markdown="1">
This attribute retrieves the time-since-epoch, in seconds, as a floating point value
</div>

#### time.DateTime.year {#DateTime.year}
{: .method .no_toc }
<div class="method-text" markdown="1">
This attribute retrieves the year as an integer
</div>

#### time.DateTime.month {#DateTime.month}
{: .method .no_toc }
<div class="method-text" markdown="1">
This attribute retrieves the month of the year as an integer, starting at 1
</div>

#### time.DateTime.day {#DateTime.day}
{: .method .no_toc }
<div class="method-text" markdown="1">
This attribute retrieves the day of the month as an integer, starting at 1
</div>

#### time.DateTime.hour {#DateTime.hour}
{: .method .no_toc }
<div class="method-text" markdown="1">
This attribute retrieves the hour of the day as an integer
</div>

#### time.DateTime.min {#DateTime.min}
{: .method .no_toc }
<div class="method-text" markdown="1">
This attribute retrieves the minute of the hour as an integer
</div>

#### time.DateTime.sec {#DateTime.sec}
{: .method .no_toc }
<div class="method-text" markdown="1">
This attribute retrieves the second of the minute as an integer
</div>

#### time.DateTime.nano {#DateTime.nano}
{: .method .no_toc }
<div class="method-text" markdown="1">
This attribute retrieves the nanosecond of the second as an integer
</div>

---
