The [CINT](CINT) function rounds decimal point numbers up or down to the nearest [INTEGER](INTEGER) value.  

## Syntax

> value% = [CINT](CINT)(expression)

## Parameter(s)

* expression is any [TYPE](TYPE) of literal or variable numerical value or mathematical calculation.

## Description

* Values greater than .5 are rounded up. Values lower than .5 are rounded down.
* *Warning:* Since [CINT](CINT) is used for integer values, the input values cannot exceed 32767 to -32768! 
* Use [CLNG](CLNG) for [LONG](LONG) integer values exceeding [INTEGER](INTEGER) limitations.
* Note: When decimal point values are given to BASIC functions requiring [INTEGER](INTEGER)s the value will be [CINT](CINT)ed.

## Example(s)

Shows how CINT rounds values up or down as in "bankers' rounding". 

```vb

a% = CINT(1.49): b% = CINT(1.50): c = 11.5
COLOR c: PRINT a%, b%, c 

```

```text

1       2       11.5

```

## See Also

* [_ROUND](_ROUND), [_CEIL](_CEIL)
* [CLNG](CLNG), [CSNG](CSNG), [CDBL](CDBL)
* [INT](INT), [FIX](FIX)
