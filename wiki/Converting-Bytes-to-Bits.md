Although QB64 has [_BYTE](_BYTE) and [_BIT](_BIT) variable types, there may be times that you just want to know which bits are on of off in the byte value or convert the value to a [Binary](Binary) number.

Bits are numbered from 0 to 7 and normally are read from the most significant bit(MSB = 7) to the least significant bit(LSB = 0).

>  The following example shows how to convert an [_UNSIGNED](_UNSIGNED) [_BYTE](_BYTE) or [INTEGER](INTEGER) value(0 to 255) to a [Binary](Binary) [STRING](STRING) number in QBasic.

```vb

DIM byte as _UNSIGNED _BYTE

byte = 222

FOR bit = 7 to 0 STEP -1
  IF byte AND 2 ^ bit THEN PRINT "1"; ELSE PRINT "0";
NEXT 

```

> *Notes:* The above code can be adapted to place a value into a bit [Arrays](Arrays) for up to 8 flag values in a single Byte.

> How upper and lower [_BYTE](_BYTE) bits are read from an [INTEGER](INTEGER) value using whole decimal or [HEX$](HEX$) values. 

```vb

SCREEN 12

COLOR 11: LOCATE 10, 2: PRINT "      AH (High Register Byte Bits)           AL (Low Register Byte Bits)"
COLOR 14: LOCATE 11, 2: PRINT "    15   14  13   12   11  10    9   8    7   6    5   4    3    2   1    0"
COLOR 13: LOCATE 14, 2: PRINT " &H8000 4000 2000 1000 800 400  200 100  80   40  20   10   8    4   2  &H1"
COLOR 11: LOCATE 15, 2: PRINT "-32768 16384 8192 4096 2048 1024 512 256 128  64  32   16   8    4   2    1"
FOR i = 1 TO 16
  CIRCLE (640 - (37 * i), 189), 8, 9 'place bit circles
NEXT
LINE (324, 160)-(326, 207), 11, BF 'line splits bytes
DO
  IF Num THEN
    FOR i = 15 TO 0 STEP -1
      IF (Num AND 2 ^ i) THEN
        PAINT (640 - (37 * (i + 1)), 189), 12, 9
        Bin$ = Bin$ + "1"
      ELSE: PAINT (640 - (37 * (i + 1)), 189), 0, 9
        Bin$ = Bin$ + "0"
      END IF
    NEXT
    COLOR 10: LOCATE 16, 50: PRINT "Binary ="; VAL(Bin$)
    COLOR 9: LOCATE 16, 10: PRINT "Decimal ="; Num;: COLOR 13: PRINT "       Hex = "; Hexa$
    Hexa$ = "": Bin$ = ""
  END IF
  COLOR 14: LOCATE 17, 15: INPUT "Enter a decimal or HEX(&H) value (0 Quits): ", frst$
  first = VAL(frst$)
  LOCATE 17, 15: PRINT SPACE$(55)
  IF first THEN
    COLOR 13: LOCATE 17, 15: INPUT "Enter a second value: ", secnd$
    second = VAL(secnd$)
    LOCATE 16, 10: PRINT SPACE$(69)
  END IF
  Num = first + second
  Hexa$ = "&H" + HEX$(Num)
LOOP UNTIL first = 0 OR Num > 32767 OR Num < -32768 OR (Num < -1 AND Num > -32768 
END

```
<sub>Code by Ted Weissgerber</sub>

## See Also

* [Binary](Binary)
* [_SHL](_SHL), [_SHR](_SHR)
* [_BIT](_BIT), [&B](&B)
* [_BYTE](_BYTE)
