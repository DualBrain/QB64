The [IMP](IMP) logical operator converts the result of two comparative values and returns a bit result.

## Syntax
 
> result = firstValue [IMP](IMP) secondValue

## Description

* Returns a different result from [AND](AND), [OR](OR) or [XOR](XOR) - see truth table below.
* Evaluates if firstValue ***imp**lies* secondValue.
**If firstValue is true then secondValue must also be true.
**So if firstValue is true, and secondValue false, then the condition is false, otherwise it is true (see table below).

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
