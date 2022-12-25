The [_BIT](_BIT) datatype can return only values of 0 (bit off) and -1 (bit on). 

## Syntax

> [DIM](DIM) variable [AS](AS) [_UNSIGNED] [_BIT](_BIT) [* numberofbits]

> [_DEFINE](_DEFINE) Letter[-Range|,...] [AS](AS) [_UNSIGNED] [_BIT](_BIT) [* numberofbits]

## Description

* An [_UNSIGNED](_UNSIGNED) _BIT can hold 0 or 1 instead of 0 and -1, if you set the numberofbits you can hold larger values depending on the number of bits you have set (_BIT * 8 can hold the same values as [_BYTE](_BYTE) for example) and the information below is compromised if setting any number of bits other than 1.
* If you set the variable to any other number then the least significant bit of that number will be set as the variables number, if the bit is 1 (on) then the variable will be -1 and if the bit is 0 (off) then the variable will be 0.
* The least significant bit is the last bit on a string of bits (11111) since that bit will only add 1 to the value if set. The most significant bit is the first bit on a string of bits and changes the value more dramatically (significantly) if set on or off.
* The _BIT datatype can be succesfully used as a [Boolean](Boolean) (TRUE or FALSE) and it requires minimal amount of memory (the lowest amount possible actually, one byte can hold 8 bits, if you want to use bits in order to decrease memory usage, use them as arrays as a _BIT variable by itself allocates 4 bytes - DIM bitarray(800) AS _BIT uses 100 bytes).
* **When a variable has not been assigned or has no type suffix, the value defaults to [SINGLE](SINGLE).**
* **[Keywords_currently_not_supported_by_QB64](Keywords-currently-not-supported-by-QB64)** Use a [_BYTE](_BYTE) and assign up to 8 bit values as shown below.

Use a [_BYTE](_BYTE) and assign up to 8 bit values as shown below.

***Suffix Symbols** The [_BIT](_BIT) type suffix used is below the grave accent (\`), usually located under the tilde (~) key (not an apostrophe). Foreign keyboards may not have the \` key. Try Alt+96 in the IDE.

> You can define a bit on-the-fly by adding a \` after the variable, like this: `variable\` = -1`

> If you want an unsigned bit you can define it on-the-fly by adding ~\` instead, like this: `variable~\` = 1`

> You can set the number of bits on the fly by just adding that number - this defines it as being two bits: `variable\`2 = -1`

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

Shifting bits in a value in QB64 versions prior to 1.3 (you can use [_SHL](_SHL) and [_SHR](_SHR) starting with version 1.3).

```vb

n = 24
Shift = 3

PRINT LShift(n, Shift)
PRINT RShift(n, Shift)
END

FUNCTION LShift&(n AS LONG, LS AS LONG)
IF LS < 0 THEN EXIT FUNCTION
LShift = INT(n * (2 ^ LS))    
END FUNCTION

FUNCTION RShift&(n AS LONG, RS AS LONG)
IF RS < 0 THEN EXIT FUNCTION
RShift = INT(n / (2 ^ RS))
END FUNCTION 

```

```text

192
3

```

## See Also
 
* [&B](&B) (binary), [_BYTE](_BYTE)
* [_SHL](_SHL), [_SHR](_SHR)
* [_DEFINE](_DEFINE), [_UNSIGNED](_UNSIGNED)
* [DIM](DIM)
* [Binary](Binary), [Boolean](Boolean)
* [Variable Types](Variable-Types)
* [Converting Bytes to Bits](Converting-Bytes-to-Bits)
