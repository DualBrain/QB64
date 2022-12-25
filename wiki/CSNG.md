[CSNG](CSNG) converts a numerical value to the closest [SINGLE](SINGLE)-precision number.

## Syntax
 
> singleValue! = [CSNG](CSNG)(expression)

## Parameter(s)

* expression is any [TYPE](TYPE) of literal or variable numerical value or mathematical calculation.

## Description

* Returns the closest [SINGLE](SINGLE) decimal point value.
* Also used to define a value as [SINGLE](SINGLE)-precision up to 7 decimals.

## Example(s)

```vb

 A# = 975.3421222#
 PRINT A#, CSNG(A#)

```

```text

975.3421222      975.3421

```

## See Also
 
* [CDBL](CDBL), [CLNG](CLNG) 
* [CINT](CINT), [INT](INT) 
* [_ROUND](_ROUND)
