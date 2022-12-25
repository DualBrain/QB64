The [AND (boolean)](AND-(boolean)) conditonal operator is used to include another evaluation in an [IF...THEN](IF...THEN) or [Boolean](Boolean) statement.

## Syntax

>  IF condition [AND (boolean)](AND-(boolean)) condition2

## Description

* If condition [AND (boolean)](AND-(boolean)) condition2 are true then the evaluation returns true (-1).
* condition and condition2 can also contain their own AND evaluations.
* Both the IF evaluation and the AND evaluation must be true for the statement to be true.
* Statements can use parenthesis to clarify an evaluation.
* [AND (boolean)](AND-(boolean)) and [OR (boolean)](OR-(boolean)) cannot be used to combine command line operations.
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

Using AND in an IF statement.

```vb

a% = 100
b% = 50

IF a% > b% AND a% < 200 THEN PRINT "True"


```

```text

True

```

*Explanation:* Both condition evaluations must be true for the code to be executed.

Using a AND a more complex way.

```vb

a% = 100
b% = 50
c% = 25
d% = 50
e% = 100

IF (a% > b% AND b% > c%) AND (c% < d% AND d% < e%) THEN
PRINT "True"
ELSE
PRINT "False"
END IF 

```

```text

True

```

*Explanation:* The evaluations in the paranteses are evaluated first then the evaluation *of* the paranteses takes place, since all evaluations return True the IF...THEN evaluation returns True. If any of the evaluations returned False then the IF...THEN evaluation would also return False.

## See Also

* [AND](AND), [OR](OR) (logical operators)
* [OR (boolean)](OR-(boolean)), [XOR (boolean)](XOR-(boolean))
* [IF...THEN](IF...THEN)
