The [OCT$](OCT$) function returns the base-8 octal representation of an [INTEGER](INTEGER), [LONG](LONG) or [_INTEGER64](_INTEGER64) value as a [STRING](STRING).

## Syntax

> result$ = [OCT$](OCT$)(number)

## Parameters

* number can be any [INTEGER](INTEGER), [LONG](LONG) or [_INTEGER64](_INTEGER64) value, positive or negative.
* number can also be any [SINGLE](SINGLE), [DOUBLE](DOUBLE) or [_FLOAT](_FLOAT) value, but only the integer part of the value is converted in that case. That is, from the value *-123.45* the function would convert the *-123* only.

## Description

* The [OCT$](OCT$) function returns the octal (base-8) representation of number.
* number can be any integer value.
* No leading space is returned.
* [VAL](VAL) can convert octal string values to decimal when the "&O" prefix is added.

## Example(s)

Outputs all of the decimal, hexadecimal and octal digits:

```vb

LOCATE 2, 20: PRINT " Decimal | Hexadecimal | Octal "
LOCATE 3, 20: PRINT "---------+-------------+-------"
        template$ = "    ##   |     \\      |   ##  "

FOR n% = 0 TO 15
  LOCATE 4 + n%, 20: PRINT USING template$; n%; HEX$(n%); VAL(OCT$(n%))
NEXT n%


```

> *Note:* The actual octal value is converted by [VAL](VAL) directly back to a numerical value by **not using** the "&H" prefix.

```text

          Decimal | Hexadecimal | Octal 
         ---------+-------------+-------
            0     |      0      |   0   
            1     |      1      |   1   
            2     |      2      |   2   
            3     |      3      |   3   
            4     |      4      |   4   
            5     |      5      |   5   
            6     |      6      |   6   
            7     |      7      |   7   
            8     |      8      |   10  
            9     |      9      |   11  
            10    |      A      |   12  
            11    |      B      |   13  
            12    |      C      |   14  
            13    |      D      |   15  
            14    |      E      |   16  
            15    |      F      |   17  

```

Example 2: Converting a octal value to decimal.

```vb

octvalue$ = OCT$(255)
PRINT "Oct: "; octvalue$
PRINT "Converting Oct value to Decimal:"; VAL("&O" + octvalue$)

```

```text

Oct: 377
Converting Oct value to Decimal: 255

```

## See Also

* [HEX$](HEX$), [VAL](VAL)
* [&H](&H) (hexadecimal), [&O](&O) (octal), [&B](&B) (binary)
* [Base Comparisons](Base-Comparisons)
