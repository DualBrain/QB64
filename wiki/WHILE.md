See [WHILE...WEND](WHILE...WEND).

The **WHILE** condition is used in [WHILE...WEND](WHILE...WEND) or [DO...LOOP](DO...LOOP) loops to exit them.

## Syntax

> DO [WHILE] evaluation
> .
> .
> .
> LOOP [WHILE] evaluation

* Only one conditional evaluation can be made at the start or the end of a [DO...LOOP](DO...LOOP).
* DO WHILE evaluates a condition before and inside of the loop. The loop may not run at all.
* LOOP WHILE evaluates a condition inside of the loop. It has to loop once.
* Skips the loop or loops until an evaluation becomes False.

**Relational Operators:**

| Symbol | Condition | Example Usage |
| -- | -- | -- |
| = | Equal | IF a = b THEN |
| <> | NOT equal | IF a <> b THEN |
| < | Less than | IF a < b THEN |
| > | Greater than | IF a > b THEN |
| <= | Less than or equal | IF a <= b THEN |
| >= | Greater than or equal | IF a >= b THEN |

## See Also

* [UNTIL](UNTIL)
* [DO...LOOP](DO...LOOP)
* [WHILE...WEND](WHILE...WEND)
