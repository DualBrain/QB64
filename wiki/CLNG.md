The [CLNG](CLNG) function rounds decimal point numbers up or down to the nearest [LONG](LONG) integer value. 

## Syntax

> value& = [CLNG](CLNG)(expression)

## Parameter(s)

* expression is any [TYPE](TYPE) of literal or variable numerical value or mathematical calculation.

## Description

* Used when integer values exceed 32767 or are less than -32768.
* Values greater than .5 are rounded up; .5 or lower are rounded down. 
* CLNG can return normal [INTEGER](INTEGER) values under 32768 too.
* Use it when a number could exceed normal [INTEGER](INTEGER) number limits.

## Example(s)

```vb

a& = CLNG(2345678.51)
PRINT

```

```text

 2345679 

```

## See Also

* [CINT](CINT), [INT](INT) 
* [CSNG](CSNG), [CDBL](CDBL)
* [_ROUND](_ROUND)
