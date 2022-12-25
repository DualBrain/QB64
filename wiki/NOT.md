[NOT](NOT) is a [Boolean](Boolean) logical operator that will change a false statement to a true one and vice-versa. 

## Syntax

> *True* = -1: *False* = [NOT](NOT) True

## Description

* In QBasic, True = -1 and False = 0 in boolean logic and evaluation statements.
* [NOT](NOT) evaluates a value and returns the bitwise opposite, meaning that `NOT 0 = -1`.
* Often called a negative logic operator, it returns the opposite of a value as true or false.
* Values are changed by their bit values so that each bit is changed to the opposite of on or off. See example 3 below.

**Relational Operators:**

| Symbol | Condition | Example Usage |
| -- | -- | -- |
| = | Equal | IF a = b THEN |
| <> | NOT equal | IF a <> b THEN |
| < | Less than | IF a < b THEN |
| > | Greater than | IF a > b THEN |
| <= | Less than or equal | IF a <= b THEN |
| >= | Greater than or equal | IF a >= b THEN |

The results of the bitwise logical operations, where *A* and *B* are operands, and *T* and *F* indicate that a bit is set or not set:

| A | B |   | [NOT](NOT) B | A [AND](AND) B | A [OR](OR) B | A [XOR](XOR) B | A [EQV](EQV) B | A [IMP](IMP) B |
| - | - | - | - | - | - | - | - | - |
| T | T |   | F | T | T | F | T | T |
| T | F |   | T | F | T | T | F | F |
| F | T |   | F | F | T | T | F | T |
| F | F |   | T | F | F | F | T | T |

**[Relational Operations](Relational-Operations) return negative one (-1, all bits set) and zero (0, no bits set) for *true* and *false*, respectively.**
This allows relational tests to be inverted and combined using the bitwise logical operations.

## Example(s)

Alternating between two conditions in a program loop.

```vb

DO
switch = NOT switch       'NOT changes value from -1 to 0 and vice-versa
LOCATE 10, 38
IF switch THEN PRINT "True!" ELSE PRINT "False"
SLEEP
k$ = INKEY$
LOOP UNTIL k$ = CHR$(27) ' escape key quit

```

Reading a file until it reaches the End Of File.

```vb

DO WHILE NOT EOF(1) 
  INPUT #1, data1, data2, data3
LOOP 

```

> *Explanation:* [EOF](EOF) will return 0 until a file ends. NOT converts 0 to -1 so that the loop continues to run. When EOF becomes -1, NOT converts it to 0 to end the loop.

So why does **NOT 5 = -6**? Because NOT changes every bit of a value into the opposite:

```vb

PRINT NOT 5
PRINT
ReadBits 5
ReadBits -6

SUB ReadBits (n AS INTEGER) 'change type value and i bit reads for other whole type values
FOR i = 15 TO 0 STEP -1 'see the 16 bit values
    IF n AND 2 ^ i THEN PRINT "1"; ELSE PRINT "0";
NEXT
PRINT
END SUB 

```

```text

-6

0000000000000101
1111111111111010

```

> *Explanation:* The bit values of an [INTEGER](INTEGER) are 2 [_BYTE](_BYTE)s and each bit is an exponent of 2 from 15 to 0 (16 bits). Thus comparing the numerical value with those exponents using [AND](AND) reveals the bit values as "1" for bits on or "0" for bits off as text. 

>  QB64 can use [&B](&B) to convert the above [_BIT](_BIT) values back to [INTEGER](INTEGER) or [_BYTE](_BYTE) values as shown below:

```vb

'16 bit INTEGER values from -32768 to 32767
a% = &B0000000000000101
PRINT a%
b% = &B1111111111111010
PRINT b%
'8 bit BYTE values from -128 to 127
a%% = &B00000101
PRINT a%%
b%% = &B11111010
PRINT b%%

```

## See Also

* [_BIT](_BIT), [&B](&B), [_BYTE](_BYTE)  
* [AND](AND), [XOR](XOR), [OR](OR)
* [Binary](Binary), [Boolean](Boolean) 
* [Mathematical Operations](Mathematical-Operations)
