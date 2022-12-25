The **OR** conditional operator evaluates an expression to true (-1) if any of the arguments is also true.

## Syntax

> [IF](IF) expression1 **OR** expression2 THEN {code}

## Description

* OR adds an alternative to another conditional evaluation. If either element in the evaluation is true then the evaluation is true.
* Parenthesis may be used to clarify the order of comparisons in an evaluation.
* Not to be confused with the [AND](AND) and [OR](OR) numerical operations.

**Relational Operators:**

| Symbol | Condition | Example Usage |
| -- | -- | -- |
| = | Equal | IF a = b THEN |
| <> | NOT equal | IF a <> b THEN |
| < | Less than | IF a < b THEN |
| > | Greater than | IF a > b THEN |
| <= | Less than or equal | IF a <= b THEN |
| >= | Greater than or equal | IF a >= b THEN |

## Example(s)

```vb

a% = 100
b% = 50

IF (a% > b% AND a% < 100) OR b% = 50 THEN PRINT "True"

```

```text

True

```

>  *Explanation:* The first evaluation was False, but the OR evaluation made the statement true and the code was executed.

## See Also

* [AND](AND), [OR](OR) (logical operators)
* [AND (boolean)](AND-(boolean)), [XOR (boolean)](XOR-(boolean))
* [IF...THEN](IF...THEN)
