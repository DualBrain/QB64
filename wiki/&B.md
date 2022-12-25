The **&B&** prefix denotes that an integer value is expressed in a binary base 2 format using **QB64** only.

## Syntax

> a& = **&B1110110000111111**

* The base 2 numbering system uses binary digit values of 1 or 0, or bits on or bits off in computer register switches or memory.
* Leading zero values **can** be omitted as they add nothing to the byte return value.
* Eight binary digits would represent a one-byte value ranging from 0 to 255. Four-digit values("nibbles") range from 0 to 15.
* Decimal values returned can be any **signed** [INTEGER](INTEGER), [LONG](LONG) integer, or [_INTEGER64](_INTEGER64) value so use those type of variables when converting directly as shown in the Syntax. The program ["overflow"](ERROR-Codes) error limits are listed as:
    * [INTEGER](INTEGER): 16 binary digits or a decimal value range from -32,768 to 32,767
    * [LONG](LONG): 32 binary digits or a decimal value range from -2,147,483,648 to 2,147,483,647
    * [_INTEGER64](_INTEGER64): 64 binary digits or decimal values from -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807.
* [LONG](LONG) values can be returned by appending the &amp; or ~%([_UNSIGNED](_UNSIGNED) [INTEGER](INTEGER)) symbols after the binary number.
* [VAL](VAL) can be used to convert "&B" prefixed string values to decimal.

**[BITS](_BIT)**

* The **MSB** is the most significant(largest) bit value and **LSB** is the least significant bit of a binary or register memory address value. The order in which the bits are read determines the binary or decimal byte value. There are two common ways to read a byte:

* **"Big-endian"**: MSB is the first bit encountered, decreasing to the LSB as the last bit by position, memory address or time.
* **"Little-endian"**: LSB is the first bit encountered, increasing to the MSB as the last bit by position, memory address or time.

```text
         '''Offset or Position:    0    1   2   3   4   5   6   7      Example: 11110000'''
                              ----------------------------------             --------
    '''Big-Endian Bit On Value:'''   128  64  32  16   8   4   2   1                 240
 '''Little-Endian Bit On Value:'''    1    2   4   8  16  32  64  128                 15
```

> The big-endian method compares exponents of 2 <sup>7</sup> down to 2 <sup>0</sup> while the little-endian method does the opposite. 

**[BYTES](_BYTE)**

* [INTEGER](INTEGER) values consist of 2 bytes called the **HI** and **LO** bytes. Anytime that the number of binary digits is a multiple of 16 (2bytes, 4 bytes, etc.) and the HI byte's MSB is on(1), the value returned will be negative. Even with [SINGLE](SINGLE) or [DOUBLE](DOUBLE) values! 

```text
                                 '''16 BIT INTEGER OR REGISTER'''
              '''AH (High Byte Bits)                         AL (Low Byte Bits)'''
   BIT:    15    14   13   12   11   10   9   8  |   7   6    5   4    3    2   1    0
          ---------------------------------------|--------------------------------------
   HEX:   8000  4000 2000 1000  800 400  200 100 |  80   40  20   10   8    4   2    1
                                                 |
   DEC: -32768 16384 8192 4096 2048 1024 512 256 | 128   64  32   16   8    4   2    1
```

> The HI byte's **MSB** is often called the **sign** bit! When all 16 of the integer binary bits are on, the decimal return is -1.  

```text
                      '''Comparing the Base Numbering Systems'''

     '''Decimal (base 10)    Binary (base 2)    Hexadecimal (base 16)    Octal (base 8)'''

          0                  0000                  0                     0
          1                  0001                  1                     1
          2                  0010                  2                     2
          3                  0011                  3                     3
          4                  0100                  4                     4
          5                  0101                  5                     5
          6                  0110                  6                     6
          7                  0111                  7                     7 -- maxed
          8                  1000                  8                    10
  maxed-- 9                  1001                  9                    11
         10                  1010                  A                    12
         11                  1011                  B                    13
         12                  1100                  C                    14
         13                  1101                  D                    15
         14                  1110                  E                    16
         15  -------------   1111 <--- Match --->  F  ----------------  17 -- max 2
         16                 10000                 10                    20
        
      When the Decimal value is 15, the other 2 base systems are all maxed out!
      The Binary values can be compared to all of the HEX value digit values so
      it is possible to convert between the two quite easily. To convert a HEX
      value to Binary just add the 4 binary digits for each HEX digit place so:

                        F      A      C      E 
              &HFACE = 1111 + 1010 + 1100 + 1101 = &B1111101011001101

      To convert a Binary value to HEX you just need to divide the number into
      sections of four digits starting from the right (LSB) end. If one has less
      than 4 digits on the left end you could add the leading zeros like below:
 
             &B101011100010001001 = 0010 1011 1000 1000 1001  
                       hexadecimal = 2  + B  + 8 +  8  + 9 = &H2B889 

    See the Decimal to Binary conversion function that uses **[HEX$](HEX$)** on the **[&H](&H)** page.
 
```

## Example(s)

A Decimal to Binary [STRING](STRING) function that does not return leading zeroes.

```vb

PRINT BIN$(255)      '1 byte(8 bits) maximum
PRINT BIN$(32767)    'integer(2 byte, 15 bits) maximum
PRINT BIN$(-32768)   'integer(2 byte, 16 bits) minimum
PRINT BIN$(-1)       'all 16 bits on 

FUNCTION BIN$(n%)
  max% = 8 * LEN(n%) ': MSB% = 1   'uncomment for 16 (32 or 64) bit returns
  FOR i = max% - 1 TO 0 STEP -1    'read as big-endian MSB to LSB
    IF (n% AND 2 ^ i) THEN MSB% = 1: B$ = B$ + "1" ELSE IF MSB% THEN B$ = B$ + "0"
  NEXT
  IF B$ = "" THEN BIN$ = "0" ELSE BIN$ = B$    'check for empty string
END FUNCTION

```

<sub>Code by Ted Weissgerber</sub>

```text

11111111
111111111111111
1000000000000000
1111111111111111

```

*Note:* The MSB% flag allows zeroes to be added. Uncomment the MSB% = 1 statement for returns with leading zeroes.

QB64 converts the binary values from the example above to [INTEGER](INTEGER) decimal values automatically.

```VB

DEFLNG A-Z
a = &B11111111
b = &B111111111111111
c = &B1000000000000000 '& 'or ~%
d = &B1111111111111111 '& 'or ~%

PRINT a, b, c, d '' ''

```

```text

255               32767              -32768              -1

```

> *Bonus example:* Add an **&** symbol after the negative binary numbers to see the [LONG](LONG) decimal values below.

```text

255               32767               32768               65535

```

> *Note:* The [LONG](LONG) values returned are the same as the values you can get using [_UNSIGNED](_UNSIGNED) [INTEGER](INTEGER) (~%).

## See Also

* [_BIT](_BIT), [_BYTE](_BYTE)
* [_SHL](_SHL), [_SHR](_SHR)
* [OCT$](OCT$), [&O](&O) (octal)
* [HEX$](HEX$), [&H](&H) (hexadecimal)
