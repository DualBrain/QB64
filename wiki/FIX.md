The [FIX](FIX) function rounds a numerical value to the next whole number closest to zero.

## Syntax

> result = [FIX](FIX)(expression)

## Parameter(s)

* expression is any [Data types](Data-types) of literal or variable numerical value or mathematical calculation.

## Description

* [FIX](FIX) effectively truncates (removes) the fractional part of expression, returning the integer part.
  * This means that [FIX](FIX) rounds down for positive values and up for negative values.
* Use [INT](INT) to round down negative values. Positive values are rounded down by both.

## Example(s)

Showing the behavior of [FIX](FIX) with positive and negative decimal point values.

```vb

 PRINT FIX(2.5)
 PRINT FIX(-2.5) 

``` 

```text
2 
-2

```

The NORMAL arithmetic method (round half up) can be achieved using the function in the example code below:

```vb

PRINT MATHROUND(0.5) 
PRINT MATHROUND(1.5)
PRINT MATHROUND(2.5)
PRINT MATHROUND(3.5)
PRINT MATHROUND(4.5)
PRINT MATHROUND(5.5)

FUNCTION MATHROUND(n)
    MATHROUND = FIX(n + 0.5 * SGN(n))
END FUNCTION 

``` 

```text
1
2
3
4
5
6

```

## See Also

* [_CEIL](_CEIL)
* [INT](INT), [CINT](CINT)
* [CLNG](CLNG), [_ROUND](_ROUND)
* [MOD](MOD), [\](\)
* [/](/)
