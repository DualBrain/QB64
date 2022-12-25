## Basic and QB64 Numerical Types

**QBasic Number Types**

* [INTEGER](INTEGER) [**%**]: 2 Byte signed whole number values from -32768 to 32767. 0 to 65535 unsigned. (not checked in QB64) 
* [LONG](LONG) [**&**]: 4 byte signed whole number values from -2147483648 to 2147483647. 0 to 4294967295 unsigned.
* [SINGLE](SINGLE) [**!**]: 4 byte signed floating decimal point values of up to 7 decimal place accuracy. **Cannot be unsigned.** 
* [DOUBLE](DOUBLE) [#]: 8 byte signed floating decimal point values of up to 15 decimal place accuracy. **Cannot be unsigned.**
* To get **one byte** values, can use an [ASCII](ASCII) [STRING](STRING) character to represent values from 0 to 255 as in [BINARY](BINARY) files.

**QB64 Number Types**

* [_BIT](_BIT) [**\`**]: 1 bit signed whole number values of 0 or -1 signed or 0 or 1 unsigned. [_BIT](_BIT) * 8 can hold a signed or unsigned [_BYTE](_BYTE) value.
* [_BYTE](_BYTE) [**%%**]: 1 byte signed whole number values from -128 to 127. Unsigned values from 0 to 255.
* [_INTEGER64](_INTEGER64) [**&&**]: 8 byte signed whole number values from -9223372036854775808 to 9223372036854775807
* [_FLOAT](_FLOAT) [##]: currently set as 10 byte signed floating decimal point values up to 1.1897E+4932. **Cannot be unsigned.**
* [_OFFSET](_OFFSET) [%&]: undefined flexible length integer offset values used in [DECLARE DYNAMIC LIBRARY](DECLARE-DYNAMIC-LIBRARY) declarations.

**Signed and Unsigned Integer Values**

Negative (signed) numerical values can affect calculations when using any of the BASIC operators. SQR cannot use negative values! There may be times that a calculation error is made using those negative values. The SGN function returns the sign of a value as -1 for negative, 0 for zero and 1 for unsigned positive values. ABS always returns an unsigned value.

> * [SGN](SGN)(n) returns the value's sign as -1 if negative, 0 if zero or 1 if positive.
> * [ABS](ABS)(n) changes negative values to the equivalent positive values.
> * **QB64:** [_UNSIGNED](_UNSIGNED) in a [DIM](DIM), [AS](AS) or [_DEFINE](_DEFINE) statement for only positive [INTEGER](INTEGER) values.

[_UNSIGNED](_UNSIGNED) integer, byte and bit variable values can use the tilde ~ suffix before the type suffix to define the type.

## Mathematical Operation Symbols

Most of the BASIC math operators are ones that require no introduction. The addition, subtraction, multiplication and division operators are ones commonly used as shown below:

| Symbol | Procedure Type | Example Usage | Operation Order |
| -- | -- | -- | -- |
| + | Addition | c = a + b | Last |
| - | Subtraction | c = a - b | Last |
| - | Negation | c = -a | Last |
| * | Multiplication | c = a * b | Second |
| / | Division | c = a / b | Second |

BASIC can also use two other operators for **[INTEGER](INTEGER) division**. Integer division returns only whole number values. [MOD](MOD) **remainder division** returns a value only if an integer division cannot divide a number exactly. Returns 0 if a value is exactly divisible.

| Symbol | Procedure Type | Example Usage | Operation Order |
| -- | -- | -- | -- |
| \ | Integer division | c = a \ b | Second |
| MOD | Remainder division | c = a MOD b | Second |

***It is an [ERROR](ERROR) to divide by zero or to take the remainder modulo zero.***

There is also an operator for **exponential** calculations. The exponential operator is used to raise a number's value to a designated exponent of itself. In QB the exponential return values are [DOUBLE](DOUBLE) values. The [SQR](SQR) function can return a number's Square Root. For other **exponential roots** the operator can be used with fractions such as (1 / 3) designating the cube root of a number. 

| Symbol | Procedure | Example Usage | Operation Order |
| -- | -- | -- | -- |
| ^ | Exponent | c = a ^ (1 / 2) | First |
| SQR | Square Root | c = SQR(a ^ 2 + b ^ 2) | First |

### Notes

* Exponent fractions should be enclosed in () brackets in order to be treated as a root rather than as division.
* Negative exponential values must be enclosed in () brackets in QB64.

## Basic's Order of Operations

When a normal calculation is made, BASIC works from left to right, but it does certain calculations in the following order:

* Exponential and exponential Root calculations including [SQR](SQR).
* Negation (Note that this means that *- 3 ^ 2* is treated as *-(3 ^ 2)* and not as *(-3) ^ 2.)*
* Multiplication, normal Division, [INTEGER](INTEGER) Division and Remainder([MOD](MOD)) Division calculations
* Addition and Subtraction calculations

**Using Parenthesis to Define the Operation Order**

Sometimes a calculation may need BASIC to do them in another order or the calculation will return bad results. BASIC allows the programmer to decide the order of operations by using [parenthesis](parenthesis) around parts of the equation. BASIC will do the calculations inside of the [parenthesis](parenthesis) brackets  first and the others from left to right in the normal operation order.

## Basic's Mathematical Functions

| Function | Description |
| -- | -- |
| ABS(n) | returns the absolute (positive) value of n: ABS(-5) = 5 |
| ATN(angle*) | returns the arctangent of an angle in radians: pi = 4 * ATN(1) |
| COS(angle*) | returns the cosine of an angle in radians. (horizontal component) |
| EXP(n) | returns e ^ x, (n <= 88.02969): e = EXP(1) ' (e = 2.718281828459045) |
| LOG(n) | returns the base e natural logarithm of n. (n > 0) |
| SGN(n) | returns -1 if n < 0, 0 if n = 0, 1 if n > 0: SGN(-5) = -1 |
| SIN(angle*) | returns the sine of an angle in radians. (vertical component) |
| SQR(n) | returns the square root of a number. (n >= 0) |
| TAN(angle*) | returns the tangent of an angle in radians |

*** angles measured in radians**

Degree to Radian Conversion.

```vb

FUNCTION Radian (degrees)
Radian = degrees * (4 * ATN(1)) / 180
END FUNCTION

FUNCTION Degree (radians)
Degree = radians * 180 / (4 * ATN(1))
END FUNCTION

```

Logarithm to base n.

```vb

FUNCTION LOGN (X, n)    
IF n > 0 AND n <> 1 AND X > 0 THEN LOGN = LOG(X) / LOG(n) ELSE BEEP
END FUNCTION

FUNCTION LOG10 (X)    'base 10 logarithm
IF X > 0 THEN LOG10 = LOG(X) / LOG(10) ELSE BEEP
END FUNCTION 

```

**The numerical value of n in the [LOG](LOG)(n) evaluation must be a positive value.**

**The numerical value of n in the [EXP](EXP)(n) evaluation must be less than or equal to 88.02969.**

**The numerical value of n in the [SQR](SQR)(n) evaluation *cannot* be a negative value.**

## Derived Mathematical Functions

The following Trigonometric functions can be derived from the **BASIC Mathematical Functions** listed above. Each function checks that certain values can be used without error or a [BEEP](BEEP) will notify the user that a value could not be returned. An error handling routine can be substituted if desired. **Note:** Functions requiring **π** use 4 * [ATN](ATN)(1) for [SINGLE](SINGLE) accuracy. Use [ATN](ATN)(1.#) for [DOUBLE](DOUBLE) accuracy.

```vb

FUNCTION SEC (x)  'Secant
IF COS(x) <> 0 THEN SEC = 1 / COS(x) ELSE BEEP
END FUNCTION

FUNCTION CSC (x)  'CoSecant 
IF SIN(x) <> 0 THEN CSC = 1 / SIN(x) ELSE BEEP
END FUNCTION 

FUNCTION COT (x)  'CoTangent 
IF TAN(x) <> 0 THEN COT = 1 / TAN(x) ELSE BEEP
END FUNCTION 

FUNCTION ARCSIN (x)   'Inverse Sine           
IF x < 1 THEN ARCSIN = ATN(x / SQR(1 - (x * x))) ELSE BEEP
END FUNCTION 

FUNCTION ARCCOS (x) ' Inverse Cosine
IF x < 1 THEN ARCCOS = (2 * ATN(1)) - ATN(x / SQR(1 - x * x)) ELSE BEEP
END FUNCTION

FUNCTION ARCSEC (x)   ' Inverse Secant        
IF x < 1 THEN ARCSEC = ATN(x / SQR(1 - x * x)) + (SGN(x) - 1) * (2 * ATN(1)) ELSE BEEP
END FUNCTION 

FUNCTION ARCCSC (x)  ' Inverse CoSecant 
IF x < 1 THEN ARCCSC = ATN(1 / SQR(1 - x * x)) + (SGN(x)-1) * (2 * ATN(1)) ELSE BEEP 
END FUNCTION 

FUNCTION ARCCOT (x)  ' Inverse CoTangent 
ARCCOT = (2 * ATN(1)) - ATN(x)
END FUNCTION

FUNCTION SINH (x)  ' Hyperbolic Sine 
IF x <= 88.02969 THEN SINH = (EXP(x) - EXP(-x)) / 2 ELSE BEEP
END FUNCTION

FUNCTION COSH (x)  ' Hyperbolic CoSine 
IF x <= 88.02969 THEN COSH = (EXP(x) + EXP(-x)) / 2 ELSE BEEP
END FUNCTION

FUNCTION TANH (x)  ' Hyperbolic Tangent or SINH(x) / COSH(x)
IF 2 * x <= 88.02969 AND EXP(2 * x) + 1 <> 0 THEN 
     TANH = (EXP(2 * x) - 1) / (EXP(2 * x) + 1) 
  ELSE
    BEEP
END IF 
END FUNCTION

FUNCTION SECH (x)  ' Hyperbolic Secant or (COSH(x)) ^ -1
IF x <= 88.02969 AND (EXP(x) + EXP(-x)) <> 0 THEN SECH = 2 / (EXP(x) + EXP(-x)) ELSE BEEP  
END FUNCTION

FUNCTION CSCH (x)  ' Hyperbolic CoSecant or (SINH(x)) ^ -1
IF x <= 88.02969 AND (EXP(x) - EXP(-x)) <> 0 THEN CSCH = 2 / (EXP(x) - EXP(-x)) ELSE BEEP  
END FUNCTION

FUNCTION COTH (x)  ' Hyperbolic CoTangent or COSH(x) / SINH(x)
IF 2 * x <= 88.02969 AND EXP(2 * x) - 1 <> 0 THEN 
     COTH = (EXP(2 * x) + 1) / (EXP(2 * x) - 1) 
  ELSE
    BEEP
END IF
END FUNCTION

FUNCTION ARCSINH (x)  ' Inverse Hyperbolic Sine 
IF (x * x) + 1 >= 0 AND x + SQR((x * x) + 1) > 0 THEN 
ARCSINH = LOG(x + SQR(x * x + 1)) 
  ELSE
    BEEP
END IF
END FUNCTION

FUNCTION ARCCOSH (x)  ' Inverse Hyperbolic CoSine 
IF x >= 1 AND x * x - 1 >= 0 AND x + SQR(x * x - 1) > 0 THEN 
ARCCOSH = LOG(x + SQR(x * x - 1)) 
  ELSE
    BEEP
END IF
END FUNCTION

FUNCTION ARCTANH (x)  ' Inverse Hyperbolic Tangent 
IF x < 1 THEN ARCTANH = LOG((1 + x) / (1 - x)) / 2 ELSE BEEP
END FUNCTION 

FUNCTION ARCSECH (x)  ' Inverse Hyperbolic Secant 
IF x > 0 AND x <= 1 THEN ARCSECH = LOG((SGN(x) * SQR(1 - x * x) + 1) / x) ELSE BEEP  
END FUNCTION

FUNCTION ARCCSCH (x)  ' Inverse Hyperbolic CoSecant 
IF x <> 0 AND x * x + 1 >= 0 AND (SGN(x) * SQR(x * x + 1) + 1) / x > 0 THEN 
     ARCCSCH = LOG((SGN(x) * SQR(x * x + 1) + 1) / x) 
  ELSE
    BEEP
END IF
END FUNCTION

FUNCTION ARCCOTH (x)  ' Inverse Hyperbolic CoTangent 
IF x > 1 THEN ARCCOTH = LOG((x + 1) / (x - 1)) / 2 ELSE BEEP
END FUNCTION 

```

```text

                           **Hyperbolic Function Relationships:**

                                   COSH(-x) = COSH(x)
                                   SINH(-x) = -SINH(x)
                                    
                                   SECH(-x) = SECH(x)
                                   CSCH(-x) = -CSCH(x)
                                   TANH(-x) = -TANH(x)
                                   COTH(-x) = -COTH(x)

                       **Inverse Hyperbolic Function Relatonships:**

                              ARSECH(x) = ARCOSH(x) ^ -1 
                              ARCSCH(x) = ARSINH(x) ^ -1 
                              ARCOTH(x) = ARTANH(x) ^ -1 

              **Hyperbolic sine and cosine satisfy the Pythagorean trig. identity:**

                           (COSH(x) ^ 2) - (SINH(x) ^ 2) = 1

```

[Microsoft's Derived BASIC Functions (KB 28249)](http://support.microsoft.com/kb/28249)

## Mathematical Logical Operators

The following logical operators compare numerical values using bitwise operations. The two numbers are compared by the number's [Binary](Binary) bits on and the result of the operation determines the value returned in decimal form. [NOT](NOT) checks one value and returns the opposite. It returns 0 if a value is not 0 and -1 if it is 0. See [Binary](Binary) for more on bitwise operations.

**Truth table of the 6 BASIC Logical Operators**

The results of the bitwise logical operations, where *A* and *B* are operands, and *T* and *F* indicate that a bit is set or not set:

| A | B |   | [NOT](NOT) B | A [AND](AND) B | A [OR](OR) B | A [XOR](XOR) B | A [EQV](EQV) B | A [IMP](IMP) B |
| - | - | - | - | - | - | - | - | - |
| T | T |   | F | T | T | F | T | T |
| T | F |   | T | F | T | T | F | F |
| F | T |   | F | F | T | T | F | T |
| F | F |   | T | F | F | F | T | T |

**[Relational Operations](Relational-Operations) return negative one (-1, all bits set) and zero (0, no bits set) for *true* and *false*, respectively.**

This allows relational tests to be inverted and combined using the bitwise logical operations.

BASIC can accept any + or - value that is not 0 to be True when used in an evaluation.

## Relational Operators

Relational Operations are used to compare values in a Conditional [IF...THEN](IF...THEN), [SELECT CASE](SELECT-CASE), [UNTIL](UNTIL) or [WHILE](WHILE) statement.

**Relational Operators:**

| Symbol | Condition | Example Usage |
| -- | -- | -- |
| = | Equal | IF a = b THEN |
| <> | NOT equal | IF a <> b THEN |
| < | Less than | IF a < b THEN |
| > | Greater than | IF a > b THEN |
| <= | Less than or equal | IF a <= b THEN |
| >= | Greater than or equal | IF a >= b THEN |

## Basic's Rounding Functions

> Rounding is used when the program needs a certain number value or type. There are 4 [INTEGER](INTEGER) or [LONG](LONG) Integer functions and one function each for closest [SINGLE](SINGLE) and closest [DOUBLE](DOUBLE) numerical types. Closest functions use "bankers" rounding which rounds up if the decimal point value is over one half. Variable types should match the return value.

| Name | Description |
| -- | -- |
| INT(n) | rounds down to lower Integer value whether positive or negative |
| FIX(n) | rounds positive values lower and negative to a less negative Integer value |
| CINT(n) | rounds to closest Integer. Rounds up for decimal point values over one half. |
| CLNG(n) | rounds Integer or Long values to closest value like CINT.(values over 32767) |
| CSNG(n) | rounds Single values to closest last decimal point value. |
| CDBL(n) | rounds Double values to closest last decimal point value. |
| _ROUND(n) | rounds to closest numerical integer value. |

### Note

* Each of the above functions define the value's type in addition to rounding the values.

## Base Number Systems

```text

                   **Comparing the [INTEGER](INTEGER) Base Number Systems**

  **Decimal (base 10)    Binary (base 2)    Hexadecimal (base 16)    Octal (base 8)**

                          **   [&B](&B)                 [&H](&H) [HEX$](HEX$)(n)           [&O](&O) [OCT$](OCT$)(n)**      

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
      sections of four digits starting from the right(LSB) end. If one has less
      than 4 digits on the left end you could add the leading zeros like below:
 
             &B101011100010001001 = 0010 1011 1000 1000 1001  
                       hexadecimal =  2  + B  + 8 +  8  + 9 = &H2B889 

    See the Decimal to Binary conversion function that uses **[HEX$](HEX$)** on the **[&H](&H)** page.
 

```

**[VAL](VAL) converts [STRING](STRING) numbers to Decimal values.**

* VAL reads the string from left to right and converts numerical string values, - and . to decimal values until it finds a character other than those 3 characters. Commas are not read.
* HEXadecimal and OCTal base values can be read with [&H](&H) or [&O](&O).

**The [OCT$](OCT$) [STRING](STRING) function return can be converted to a decimal value using [VAL](VAL)("&O" + OCT$(n)).**

**The [HEX$](HEX$) [STRING](STRING) function return can be converted to a decimal value using [VAL](VAL)("&H" + HEX$(n)).**

> [STR$](STR$) converts numerical values to string characters for [PRINT](PRINT) or variable strings. It also removes the right number PRINT space.

## Bits and Bytes

**[_BIT](_BIT)**

The **MSB** is the most significant(largest) bit value and **LSB** is the least significant bit of a binary or register memory address value. The order in which the bits are read determines the binary or decimal byte value. There are two common ways to read a byte:

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

[INTEGER](INTEGER) values consist of 2 bytes called the **HI** and **LO** bytes. Anytime that the number of binary digits is a multiple of 16 (2bytes, 4 bytes, etc.) and the HI byte's MSB is on(1), the value returned will be negative, even with [SINGLE](SINGLE) or [DOUBLE](DOUBLE) values. 

```text

                                 **16 BIT INTEGER OR REGISTER**
              **AH (High Byte Bits)                         AL (Low Byte Bits)**
   BIT:    15    14   13   12   11   10   9   8  |   7   6    5   4    3    2   1    0
          ---------------------------------------|--------------------------------------
   HEX:   8000  4000 2000 1000  800 400  200 100 |  80   40  20   10   8    4   2    1
                                                 |
   DEC: -32768 16384 8192 4096 2048 1024 512 256 | 128   64  32   16   8    4   2    1

```

> The HI byte's **MSB** is often called the **sign** bit! When the highest bit is on, the signed value returned will be negative.  

## Example(s)

Program displays the bits on for any integer value between -32768 and 32767 or &H80000 and &H7FFF.

```vb

DEFINT A-Z
SCREEN 12
COLOR 11: LOCATE 10, 2
 PRINT "      AH (High Register Byte Bits)           AL (Low Register Byte Bits)"
COLOR 14: LOCATE 11, 2
 PRINT "    15   14  13   12   11  10    9   8    7   6    5   4    3    2   1    0"
COLOR 13: LOCATE 14, 2
 PRINT " &H8000 4000 2000 1000 800 400  200 100  80   40  20   10   8    4   2  &H1"
COLOR 11: LOCATE 15, 2
 PRINT "-32768 16384 8192 4096 2048 1024 512 256 128  64  32   16   8    4   2    1"
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
      ELSE
        PAINT (640 - (37 * (i + 1)), 189), 0, 9
        Bin$ = Bin$ + "0"
      END IF
    NEXT
    COLOR 10: LOCATE 16, 50: PRINT "Binary ="; VAL(Bin$)
    COLOR 9: LOCATE 16, 10: PRINT "Decimal ="; Num;: COLOR 13: PRINT "       Hex = "; Hexa$
    Hexa$ = "": Bin$ = ""
   END IF
   COLOR 14: LOCATE 17, 15: INPUT "Enter a decimal or HEX(&H) value (0 Quits): ", frst$
   first = VAL(frst$)  
   IF first THEN
     LOCATE 17, 15: PRINT SPACE$(55)
     COLOR 13: LOCATE 17, 15: INPUT "Enter a second value: ", secnd$
     second = VAL(secnd$)
     LOCATE 17, 10: PRINT SPACE$(69)
   END IF
  Num = first + second
  Hexa$ = "&H" + HEX$(Num)
LOOP UNTIL first = 0 OR Num > 32767 OR Num < -32767
COLOR 11: LOCATE 28, 30: PRINT "Press any key to exit!";
SLEEP
SYSTEM 

```

## OFFSET

* [_OFFSET (function)](_OFFSET-(function)) returns the memory offset position as a flexible sized value for a designated variable. See [Using _OFFSET](Using--OFFSET).

**Warning: [_OFFSET](_OFFSET) values cannot be reassigned to other variable [TYPE](TYPE).**

**[_OFFSET](_OFFSET) values can only be used in conjunction with [_MEM](_MEM)ory and [DECLARE DYNAMIC LIBRARY](DECLARE-DYNAMIC-LIBRARY) procedures.**

## See Also

* [_OFFSET](_OFFSET), [_MEM](_MEM)
* [DIM](DIM), [_DEFINE](_DEFINE)
* [TYPE](TYPE)
