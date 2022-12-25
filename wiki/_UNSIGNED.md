[_UNSIGNED]([_UNSIGNED](_UNSIGNED) defines a numerical value as being only positive.

## Syntax
 
> [DIM](DIM) variable [AS](AS) [[_UNSIGNED](_UNSIGNED)] datatype

> [_DEFINE](_DEFINE) letterRange [AS](AS) [[_UNSIGNED](_UNSIGNED)] datatype

## Description

* Datatype can be any of the following: [INTEGER](INTEGER), [LONG](LONG), [_BIT](_BIT), [_BYTE](_BYTE), [_INTEGER64](_INTEGER64), [_OFFSET](_OFFSET)
***[SINGLE](SINGLE), [DOUBLE](DOUBLE) and [_FLOAT](_FLOAT) variable types cannot be [_UNSIGNED](_UNSIGNED).**
* [_UNSIGNED](_UNSIGNED) can be used in a [_DEFINE](_DEFINE) statement to set undefined variable name first letters as all positive-only values.
* Can also be used in [DIM](DIM) statements or subprocedure parameter definitions following [AS](AS).
* [_UNSIGNED](_UNSIGNED) allows larger positive numerical variable value limits than signed ones.
* The unsigned variable type suffix used is the **tilde (~)**, right before the number's own type suffix: variableName~&

How negative values affect the [_UNSIGNED](_UNSIGNED) value returned by a [_BYTE](_BYTE) (8 bits). 

```text


                        00000001 - unsigned & signed are both 1    
                        01111111 - unsigned & signed are both 127  
                        11111111 - unsigned is 255 but signed is -1
                        11111110 - unsigned is 254 but signed is -2
                        11111101 - unsigned is 253 but signed is -3

```

## Example(s)

 In **QB64**, when a signed [INTEGER](INTEGER) value exceeds 32767, the value may become a negative value:

```vb

i% = 38000
PRINT i% 

```

```text

-27536

```

> *Explanation:* Use an [_UNSIGNED](_UNSIGNED) [INTEGER](INTEGER) or a ~% variable type suffix for only positive integer values up to 65535.

In **QB64**, [_UNSIGNED](_UNSIGNED) [INTEGER](INTEGER) values greater than 65535 cycle over again from zero:

```vb

i~% = 70000
PRINT i~% 

```

```text

 4464

```

> *Explanation:* In QB64 an unsigned integer value of 65536 would be 0 with values increasing by the value minus 65536. 

Demonstrating how _UNSIGNED variables expand the [INTEGER](INTEGER) range.

```vb

DIM n AS _UNSIGNED INTEGER
DIM pn AS _UNSIGNED INTEGER
LOCATE 3, 6: PRINT "Press Esc to exit loop"
FOR n = 1 TO 80000
  _LIMIT 10000 ' 6.5 second loop 
  LOCATE 12, 37: PRINT n ' display current value
  IF n > 0 THEN pn = n ' find highest value
  IF n = 0 THEN Count = Count + 1: LOCATE 14, 37: PRINT "Count:"; Count; "Max:"; pn
  IF INP(&H60) = 1 THEN EXIT FOR ' escape key exit
NEXT n
END 

```

```text

   Press Esc to exit loop

                           65462

                          Count: 13 Max: 65535


```

*Explanation:* The maximum value can only be 65535 (32767 + 32768) so the FOR loop repeats itself. Remove the [_UNSIGNED](_UNSIGNED) parts and run it again.

## See Also

* DECLARE, [SUB](SUB), [FUNCTION](FUNCTION)
* [DIM](DIM), [_DEFINE](_DEFINE)
* [DEFSTR](DEFSTR), [DEFLNG](DEFLNG), [DEFINT](DEFINT), [DEFSNG](DEFSNG), [DEFDBL](DEFDBL)
* [INTEGER](INTEGER), [LONG](LONG), [_INTEGER64](_INTEGER64)
* [ABS](ABS), [SGN](SGN)
* [Variable Types](Variable-Types)
