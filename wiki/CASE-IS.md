See [SELECT CASE](SELECT-CASE).

[CASE IS](CASE-IS) can be used in a [SELECT CASE](SELECT-CASE) routine where you need to use relational conditional expressions.

## Syntax

> [CASE IS](CASE-IS) **{=|<|>|<=|>=|<>|[NOT](NOT)} expression**

## Description

* [AND (boolean)](AND-(boolean)) can be used to add extra conditions to a [CASE IS](CASE-IS) statement evaluation.
* [OR (boolean)](OR-(boolean)) can be used to add alternate conditions to a [CASE IS](CASE-IS) statement evaluation.
* Parenthesis are allowed in [CASE IS](CASE-IS) statements to clarify an evaluation.
* [CASE IS](CASE-IS) > 100 uses the greater than expression.
* [CASE IS](CASE-IS) <= 100 uses the less than or equal to expression.
* [CASE IS](CASE-IS) <> 100 uses the not equal to expression(same as [NOT](NOT) 100).

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

* [CASE](CASE), [CASE ELSE](CASE-ELSE)
* [SELECT CASE](SELECT-CASE)
