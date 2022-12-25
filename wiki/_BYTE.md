A [_BYTE](_BYTE) variable can hold signed variable values from -128 to 127 (one byte or 8 [_BIT](_BIT)s). [_UNSIGNED](_UNSIGNED) from 0 to 255.

## Syntax

> [DIM](DIM) byte [AS](AS) [[_UNSIGNED]([_UNSIGNED)] [[_BYTE]]

## Description

* Signed _BYTE values can range from -128 to 127.
* [_UNSIGNED](_UNSIGNED) _BYTEs can hold values from 0 to 255. [_UNSIGNED](_UNSIGNED) expands the range of positive values.
* Can be defined in a **QB64** [_DEFINE](_DEFINE) statement using a starting letter range of variable names.
* Also can be used in a subroutine parameter [AS](AS) _BYTE variable definitions.
* Define a byte using the suffix %% after the variable name: variable%% = -54
* Define an unsigned byte by adding the suffix ~%% after the variable name: variable~%% = 54
* **When a variable has not been assigned or has no type suffix, the value defaults to [SINGLE](SINGLE).**

**[_BIT](_BIT)**

* The **MSB** is the most significant(largest) bit value and **LSB** is the least significant bit of a binary or register memory address value. The order in which the bits are read determines the binary or decimal byte value. There are two common ways to read a byte:

  * **"Big-endian"**: MSB is the first bit encountered, decreasing to the LSB as the last bit by position, memory address or time.
  * **"Little-endian"**: LSB is the first bit encountered, increasing to the MSB as the last bit by position, memory address or time.

```text

         **Offset or Position:    0    1   2   3   4   5   6   7      Example: 11110000**
                              ----------------------------------             --------
    **Big-Endian Bit On Value:**   128  64  32  16   8   4   2   1                 240
 **Little-Endian Bit On Value:**    1    2   4   8  16  32  64  128                 15

```

> The big-endian method compares exponents of 2<sup>7</sup> down to 2<sup>0</sup> while the little-endian method does the opposite. 

**[_BYTE](_BYTE)**

* [INTEGER](INTEGER) values consist of 2 bytes called the **HI** and **LO** bytes. Anytime that the number of binary digits is a multiple of 16 (2bytes, 4 bytes, etc.) and the HI byte's MSB is on(1), the value returned will be negative. Even with [SINGLE](SINGLE) or [DOUBLE](DOUBLE) values! 

```text

                                 **16 BIT INTEGER OR REGISTER**
              **AH (High Byte Bits)                         AL (Low Byte Bits)**
   BIT:    15    14   13   12   11   10   9   8  |   7   6    5   4    3    2   1    0
          ---------------------------------------|--------------------------------------
   HEX:   8000  4000 2000 1000  800 400  200 100 |  80   40  20   10   8    4   2    1
                                                 |
   DEC: -32768 16384 8192 4096 2048 1024 512 256 | 128   64  32   16   8    4   2    1

```

> The HI byte's **MSB** is often called the **sign** bit! When all 16 of the integer binary bits are on, the decimal return is -1.  

## Example(s)

> How negative assignments affect the _UNSIGNED value returned by a byte (8 bits).

```vb

DIM unsig AS _UNSIGNED _BYTE
DIM sig AS _BYTE

CLS
unsig = 1
sig = 1
PRINT "00000001 = unsigned & signed are both" + STR$(unsig AND sig)

unsig = 127
sig = 127
PRINT "&B01111111 = unsigned & signed are both" + STR$(unsig AND sig)

unsig = 255
sig = 255
PRINT "&B11111111 = unsigned is" + STR$(unsig) + " but signed is " + STR$(sig)

unsig = 254
sig = 254
PRINT "&B11111110 = unsigned is" + STR$(unsig) + " but signed is " + STR$(sig)

unsig = 253
sig = 253
PRINT "&B11111101 = unsigned is" + STR$(unsig) + " but signed is " + STR$(sig)

PRINT
PRINT "The signed value needs the MSB bit for the sign."
PRINT "The most significant bit is furthest to the left."

```

```text

&B00000001 = unsigned & signed are both 1
&B01111111 = unsigned & signed are both 127
&B11111111 = unsigned is 255 but signed is -1
&B11111110 = unsigned is 254 but signed is -2
&B11111101 = unsigned is 253 but signed is -3

The signed value needs the MSB bit for the sign.
The most significant bit is furthest to the left.

```

## See Also

* [_BIT](_BIT), [&B](&B)
* [_DEFINE](_DEFINE), [DIM](DIM)
* [_UNSIGNED](_UNSIGNED)
* [_SHL](_SHL), [_SHR](_SHR)
* [Mathematical Operations](Mathematical-Operations)
* [Screen Memory](Screen-Memory)
* [Variable Types](Variable-Types)
* [Converting Bytes to Bits](Converting-Bytes-to-Bits)
