The [_CEIL](_CEIL) function rounds a numeric value up to the next whole number or [INTEGER](INTEGER) value. 

## Syntax

> result = [_CEIL](_CEIL)(expression)

* [_CEIL](_CEIL) returns he smallest integral value that is greater than the numerical expression (as a floating-point value).
* This means that [_CEIL](_CEIL) rounds up for both positive and negative numbers.

## Availability

* Version 1.000 and up.

## Example(s)

Displaying the rounding behavior of [INT](INT), [CINT](CINT) and [FIX](FIX) vs [_CEIL](_CEIL).

```vb

PRINT INT(2.5), CINT(2.5), FIX(2.5), _CEIL(2.5)
PRINT INT(-2.5), CINT(-2.5), FIX(-2.5), _CEIL(-2.5)

```

```text

 2        2         2         3
-3       -2        -2        -2

```

## See Also

* [INT](INT), [FIX](FIX)
* [CINT](CINT), [CLNG](CLNG), 
* [CSNG](CSNG), [CDBL](CDBL)
* [_ROUND](_ROUND)
