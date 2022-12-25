The [HEX$](HEX$) function returns the base 16 hexadecimal representation of an [INTEGER](INTEGER), [LONG](LONG) or [_INTEGER64](_INTEGER64) value as a [STRING](STRING).

## Syntax

> result$ = [HEX$](HEX$)(decimalNumber)

## Parameter(s)

* number can be any [INTEGER](INTEGER), [LONG](LONG) or [_INTEGER64](_INTEGER64) value, positive or negative.
* number can also be any [SINGLE](SINGLE), [DOUBLE](DOUBLE) or [_FLOAT](_FLOAT) value, but only the integer part of the value is converted in that case. That is, from the value *-123.45* the function would convert the *-123* only.

## Description

* The function returns the string hexadecimal (base-16) representation of decimalNumber.
* The function does not return a leading sign space so [LTRIM$](LTRIM$) is not necessary.
* [VAL](VAL) can convert the string value back to a decimal value by prefixing the string return with "&H": `dec = VAL("&H" + hexvar$)`.

## Example(s)

Comparing decimal, hexadecimal and octal string values 0 to 15.

```vb

LOCATE 2, 20: PRINT "   Decimal | Hexadecimal | Octal  "
LOCATE 3, 20: PRINT "-----------+-------------+--------"
        template$ = "    \ \    |     \\      |    \\  "

FOR n% = 0 TO 15
  LOCATE 4 + n%, 20: PRINT USING template$; STR$(n%); HEX$(n%); OCT$(n%)
NEXT n%

```

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

*Note:* Decimal [STR$](STR$) values contain a leading sign space so values require an extra space in the template using the slash format.

Converting hex value to decimal.

```vb

h$ = HEX$(255)
PRINT "Hex: "; h$
PRINT "Converting Hex value to Decimal:"; VAL("&H" + h$)

```

```text

Hex: FF
Converting Hex value to Decimal: 255

```

## See Also

* [OCT$](OCT$), [STR$](STR$), [VAL](VAL)
* [&H](&H) (hexadecimal), [&O](&O) (octal), [&B](&B) (binary)
* [Base Comparisons](Base-Comparisons)
* [HEX$ 32 Bit Values](HEX$-32-Bit-Values)
