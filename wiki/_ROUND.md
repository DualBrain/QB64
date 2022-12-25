The [_ROUND](_ROUND) function rounds to the closest even [INTEGER](INTEGER), [LONG](LONG) or [_INTEGER64](_INTEGER64) numerical value.

## Syntax

> value = [_ROUND](_ROUND)(number)

## Description

* Can round [SINGLE](SINGLE), [DOUBLE](DOUBLE) or [_FLOAT](_FLOAT) floating decimal point parameter values.
* Can be used when numerical values exceed the limits of [CINT](CINT) or [CLNG](CLNG).
* Rounding is done to the closest even [INTEGER](INTEGER) value. The same as QBasic does with [\](\).

## Example(s)

Displays how QB64 rounds to the closest even integer value.

```vb

PRINT _ROUND(0.5)
PRINT _ROUND(1.5)
PRINT _ROUND(2.5)
PRINT _ROUND(3.5)
PRINT _ROUND(4.5)
PRINT _ROUND(5.5) 

```

```text

0
2
2
4
4
6

```

## See Also

* [INT](INT), [CINT](CINT)
* [FIX](FIX), [CLNG](CLNG)
