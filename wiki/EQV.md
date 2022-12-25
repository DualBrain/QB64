The [EQV](EQV) operator returns a value based on the *equivalence* of two conditions or values.

## Syntax

>  result = firstValue [EQV](EQV) secondValue

## Description

* Returns true (-1) when both values are the same (*equivalent*).
* Turns a bit on if both bits are the same, turns a bit off if both bits are different.

The results of the bitwise logical operations, where *A* and *B* are operands, and *T* and *F* indicate that a bit is set or not set:

| A | B |   | [NOT](NOT) B | A [AND](AND) B | A [OR](OR) B | A [XOR](XOR) B | A [EQV](EQV) B | A [IMP](IMP) B |
| - | - | - | - | - | - | - | - | - |
| T | T |   | F | T | T | F | T | T |
| T | F |   | T | F | T | T | F | F |
| F | T |   | F | F | T | T | F | T |
| F | F |   | T | F | F | F | T | T |

**[Relational Operations](Relational-Operations) return negative one (-1, all bits set) and zero (0, no bits set) for *true* and *false*, respectively.**
This allows relational tests to be inverted and combined using the bitwise logical operations.

## See Also

* [Binary](Binary)
* [Boolean](Boolean)
