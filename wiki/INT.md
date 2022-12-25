The [INT](INT) function rounds a numeric value down to the next whole number. 

## Syntax

> result = [INT](INT)(expression)

## Parameter(s)

* expression is any [Data types](Data-types) of literal or variable numerical value or mathematical calculation.

## Description

* [INT](INT) returns the first whole number [INTEGER](INTEGER) that is less than the expression value.
* This means that [INT](INT) rounds down for both positive and negative numbers.
* Use [FIX](FIX) to round negative values up. It is identical to [INT](INT) for positive values.

## Example(s)

Displaying the rounding behavior of [INT](INT).

```vb

PRINT INT(2.5)
PRINT INT(-2.5)

```

```text

 2 
-3

```

## See Also

* [CINT](CINT), [CLNG](CLNG), [FIX](FIX)
* [CSNG](CSNG), [CDBL](CDBL)
* [_ROUND](_ROUND), [_CEIL](_CEIL)
