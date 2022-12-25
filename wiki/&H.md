The **&H** prefix denotes that an integer value is expressed in a Hexadecimal base 16 format. Every 2 digits represent a [_BYTE](_BYTE).

## Syntax

> a& = &HFACE

* The base 16 numbering system uses hexadecimal digit values of 0 to F. A = 10, B = 11, C = 12, D = 13, E = 14 and F = 15.
* Leading zero values can be omitted just like in decimal values as they add nothing to the return value.
* Decimal values returned can be any **signed** [INTEGER](INTEGER), [LONG](LONG) integer, or [_INTEGER64](_INTEGER64) value so use those type of variables when converting directly as shown above in the Syntax. The program ["overflow"](ERROR-Codes) error limits are listed as:
    * [_BYTE](_BYTE): 2 hex digits or a decimal value range from -128 to 127. [_UNSIGNED](_UNSIGNED): 0 to 255.
    * [INTEGER](INTEGER): 4 hex digits or a decimal value range from -32,768 to 32,767. [_UNSIGNED](_UNSIGNED): 0 to 65535.
    * [LONG](LONG): 8 hex digits or a decimal value range from -2,147,483,648 to 2,147,483,647. [_UNSIGNED](_UNSIGNED): 0 to 4294967295.
    * [_INTEGER64](_INTEGER64): 16 hex digits or decimal values from -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807. 
    * [_UNSIGNED](_UNSIGNED) [_INTEGER64](_INTEGER64): 0 to 18446744073709551615.
* The maximum hexadecimal value for each numerical type is the maximum number of digits listed above, each valued at F.
* Convert hexadecimal to [[LONG]] values by appending the values with &. Example: &H8000 = -32768: &H8000& = 32768
* [LONG](LONG) 32-bit [_RGB](_RGB) values can be made using hexadecimal values from **&HFF000000** to **&HFFFFFFFF** with full [_ALPHA](_ALPHA) only.
* [LONG] 32-bit [_RGBA](_RGBA) values can be made using hexadecimal values from **&H00000000** to **&HFFFFFFFF** with any [_ALPHA](_ALPHA).
* Hexadecimal **0x** is often used to prefix [HEX$](HEX$) port addresses in documentation. Replace 0x with [&H](&H) in QB64 or QBasic.
* To convert hex strings returned from [HEX$](HEX$) with [VAL](VAL) you need to prefix the string with &H (for example; if the string is "FF" you should do VAL("&HFF") or VAL("&H" + hexvalue$).

## Example(s)

The maximum octal values of decimal value -1 in each numerical type are:

```vb
c&& = -1: d& = -1: e% = -1: f%% = -1
hx$ = HEX(f%%)
PRINT "Max hex _BYTE = "; hx$; " with"; LEN(hx$); "digits ="; VAL("&H" + hx$)
hx$ = HEX$(e%)
PRINT "Max hex INTEGER = "; hx$; " with"; LEN(hx$); "digits ="; VAL("&H" + hx$)
hx$ = HEX$(d&amp;)
PRINT "Max hex LONG = "; hx$; " with"; LEN(hx$); "digits ="; VAL("&H" + hx$)
hx$ = HEX$(c&&)
PRINT "Max hex _INTEGER64 = "; hx$; " with"; LEN(hx$); "digits ="; VAL("&H" + hx$)
hx$ = HEX$(9223372036854775807)
PRINT "Max _INTEGER64 value = "; hx$; " with"; LEN(hx$); "digits"
hx$ = HEX$(-9223372036854775808)
PRINT "Min _INTEGER64 value = "; hx$; " with"; LEN(hx$); "digits"

```

```text

Max hex _BYTE = FF with 2 digits = 255
Max hex INTEGER = FFFF with 4 digits = 65535
Max hex LONG = FFFFFFFF with 8 digits = 4294967295
Max hex _INTEGER64 = FFFFFFFFFFFFFFFF with 16 digits =-1
Max _INTEGER64 value = 7FFFFFFFFFFFFFFF with 16 digits
Min _INTEGER64 value = 8000000000000000 with 16 digits

```

Converting a decimal number to a binary string value using [HEX$](HEX$).

```vb

FUNCTION BIN$ (n&)
  h$ = HEX$(n&)                     'get hexadecimal string value
  FOR i = 1 TO LEN(h$)              'scan the HEX$ digits
    SELECT CASE MID$(h$, i, 1)      'read each HEX$ digit
        CASE "0": b$ = b$ + "0000"
        CASE "1": b$ = b$ + "0001"
        CASE "2": b$ = b$ + "0010"
        CASE "3": b$ = b$ + "0011"
        CASE "4": b$ = b$ + "0100"
        CASE "5": b$ = b$ + "0101"
        CASE "6": b$ = b$ + "0110"
        CASE "7": b$ = b$ + "0111"
        CASE "8": b$ = b$ + "1000"
        CASE "9": b$ = b$ + "1001"
        CASE "A": b$ = b$ + "1010"
        CASE "B": b$ = b$ + "1011"
        CASE "C": b$ = b$ + "1100"
        CASE "D": b$ = b$ + "1101"
        CASE "E": b$ = b$ + "1110"
        CASE "F": b$ = b$ + "1111"
    END SELECT
  NEXT i
  b$ = RIGHT$(b$, LEN(b$) - INSTR(b$, "1") + 1)   'eliminate leading zeroes
  IF VAL(b$) THEN BIN$ = b$ ELSE BIN$ = "0"       'return zero if n& = 0
END FUNCTION

```

<sub>Code by CodeGuy</sub>

> *Explanation:* Hexadecimal digits can be any value up to 15 which also corresponds to all four bits on in binary. The function above just adds every four-bit binary string value together to return the binary value. After they are concatenated, the leading bit on is found by [INSTR](INSTR) and everything from that point is kept removing the leading zeros.

## See Also

* [HEX$](HEX$), [OCT$](OCT$)
* [&B](&B) (binary), [&O](&O) (octal)
* [Base Comparisons](Base-Comparisons)
