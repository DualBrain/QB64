[CDBL](CDBL) converts a value to the closest [DOUBLE](DOUBLE)-precision value.

## Syntax

> doubleValue# = [CDBL](CDBL)(expression)

## Parameter(s)

* expression is any [TYPE](TYPE) of literal or variable numerical value or mathematical calculation.

## Description

* Rounds to the closest [DOUBLE](DOUBLE) floating decimal point value.
* Also can be used to define a value as [DOUBLE](DOUBLE)-precision up to 15 decimals.

## Example(s)

Prints a double-precision version of the single-precision value stored in the variable named A.

```vb

 A = 454.67
 PRINT A; CDBL(A)

```

```text

 454.67 454.6700134277344

```

>  The last 11 numbers in the double-precision number change the value in this example, since A was previously defined to only two-decimal place accuracy.

## See Also

* [CINT](CINT), [CLNG](CLNG) 
* [CSNG](CSNG), [_ROUND](_ROUND)
