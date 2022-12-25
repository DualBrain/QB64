The [_DELAY](_DELAY) statement suspends program execution for the specified number of seconds.

## Syntax

> [_DELAY](_DELAY) seconds!

## Parameter(s)

* seconds! is the time to wait, accurate to nearest millisecond (.001).

## Description

* While waiting, CPU cycles are relinquished to other applications.
* Delays are not affected by midnight timer corrections.

## See Also

* [_LIMIT](_LIMIT)
* [TIMER](TIMER)
* [ON TIMER(n)](ON-TIMER(n))
