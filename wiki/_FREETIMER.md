The [_FREETIMER](_FREETIMER) function returns a free [TIMER](TIMER) number for multiple [ON TIMER(n)](ON-TIMER(n)) events.

## Syntax

> timerhandle% = [_FREETIMER](_FREETIMER)

## Description

* QB64 can use an unlimited number of ON TIMER (number, seconds!) event [INTEGER](INTEGER) values at once. 
* Every time _FREETIMER is called the [INTEGER](INTEGER) value returned will increase by one, starting at 1, whether it is used or not.
* Store multiple returns in different variable names to refer to separate events later.

## See Also

* [ON TIMER(n)](ON-TIMER(n))
