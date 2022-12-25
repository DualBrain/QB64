The **UNTIL** condition is used in [DO...LOOP](DO...LOOP) exit verifications.

## Syntax

> DO [UNTIL] evaluation
>  .
>  .
>  .
> LOOP UNTIL evaluation

* Only one conditional evaluation can be made at the start or the end of a [DO...LOOP](DO...LOOP).
* DO UNTIL evaluates a condition before and inside of the loop. The loop may not run at all.
* LOOP UNTIL evaluates a condition inside of the loop. It has to loop once.
* Skips the loop or loops until an evaluation becomes True.

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

* [WHILE](WHILE)
* [DO...LOOP](DO...LOOP)
* [WHILE...WEND](WHILE...WEND)
