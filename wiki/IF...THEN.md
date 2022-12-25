[IF...THEN](IF...THEN) statements make boolean (true or false) evaluations to automate program decision making.

## Syntax

### Single-line

>  [IF](IF) conditionStatement [THEN](THEN) *{code}* [ELSE](ELSE) *{alternativeCode}*

>  [IF](IF) conditionStatement [GOTO](GOTO) *lineLabel*

### Block

> [IF](IF) conditionStatement [THEN](THEN)
>   *{code}*
>   ⋮
> [ELSEIF](ELSEIF) conditionStatement2 [THEN](THEN)
>   *{code}*
>   ⋮
> [ELSE](ELSE)
>   *{code}*
>   ⋮
> [END IF](END-IF)

## Description

* The conditionStatement evaluation by [IF](IF) must be true (-1) or a **non-zero numerical value** for the [THEN](THEN) *{code}* to be executed.
* Multiple conditional evaluations can be made using inclusive [AND (boolean)](AND-(boolean)) or alternative [OR (boolean)](OR-(boolean)) conditional expressions.
* [THEN](THEN) is not required when [GOTO](GOTO) is used to send program flow to a line number or label.
* [IF](IF) statements can also have alternative evaluations using [ELSEIF](ELSEIF) and [ELSE](ELSE) conditions. 
* When the [IF](IF) statement and/or code to be run is more than code line, an [END IF](END-IF) statement must be used.
* With multiple code lines to run, end the IF statement with THEN and place all of the code on lines below that line.
* Multiple code line block statements require that the [IF...THEN](IF...THEN), [ELSEIF](ELSEIF), [ELSE](ELSE) and [END IF](END-IF) be on separate lines.
* **The IDE may return an error of *[NEXT](NEXT) without [FOR](FOR)* or *[LOOP](LOOP) without [DO...LOOP](DO...LOOP)* when [END IF](END-IF) does not end a statement block.**
* The **QB64** IDE will indicate an error in the IF statement line until END IF closes the statement block.
* Use [colon](colon)s to execute multiple statements in a single-line IF statement.
* An **[underscore](underscore)** can be used anywhere after the code on a single-line to continue it to the next line in **QB64**.
* **NOTE:** [STRING](STRING) values can only be evaluated in an IF statement if a value is compared to a literal or [CHR$](CHR$) string value. **QB64 may not compile literal IF string statements or indicate an IDE coding error.** Use [LEN](LEN) or [ASC](ASC) to compare strings numerically.

**Relational Operators:**

| Symbol | Condition | Example Usage |
| -- | -- | -- |
| = | Equal | IF a = b THEN |
| <> | NOT equal | IF a <> b THEN |
| < | Less than | IF a < b THEN |
| > | Greater than | IF a > b THEN |
| <= | Less than or equal | IF a <= b THEN |
| >= | Greater than or equal | IF a >= b THEN |

 When evaluating a number value, no IF value > 0 operation is necessary for values not 0. Use: IF value THEN

**Boolean Conditional Operators:**

> * [AND (boolean)](AND-(boolean)) can be used to add extra conditions to a boolean statement evaluation.
> * [OR (boolean)](OR-(boolean)) can be used to add alternate conditions to a boolean statement evaluation.
> * Parenthesis are allowed inside of boolean statements to clarify an evaluation.

**Mathematical Logical operators:**

* Truth table of the 6 BASIC Logical Operators:

The results of the bitwise logical operations, where *A* and *B* are operands, and *T* and *F* indicate that a bit is set or not set:

| A | B |   | [NOT](NOT) B | A [AND](AND) B | A [OR](OR) B | A [XOR](XOR) B | A [EQV](EQV) B | A [IMP](IMP) B |
| - | - | - | - | - | - | - | - | - |
| T | T |   | F | T | T | F | T | T |
| T | F |   | T | F | T | T | F | F |
| F | T |   | F | F | T | T | F | T |
| F | F |   | T | F | F | F | T | T |

**[Relational Operations](Relational-Operations) return negative one (-1, all bits set) and zero (0, no bits set) for *true* and *false*, respectively.**
This allows relational tests to be inverted and combined using the bitwise logical operations.

* **Note that Basic returns -1 for True and 0 for False.**

## Example(s)

In a one line IF statement, only [REM](REM) can be used to comment out the action without an [END IF](END-IF) error:

```vb

INPUT "Enter a number over or under 100: ", x
IF x > 100 THEN PRINT x 
IF x > 100 THEN REM PRINT x * '

```

IF statement blocks require that the IF THEN and END IF statements be separate from the code executed.

```vb

INPUT "Enter a number over or under 100: ", x
IF x > 100 THEN
  y = 200
  PRINT y
  PRINT x
END IF 

```

True or False evaluation of a numerical value executes only when the value is not 0. **Cannot evaluate [STRING](STRING) values.**

```vb

INPUT "Enter a number or just hit Enter: ", x
IF x THEN PRINT x 

```

> Example will only print if a numerical value is True (positive or negative). (Equivalent to: IF x > 0 OR x < 0 THEN evaluation)

Multiple evaluations using parenthesis to determine the order.

```vb

INPUT "Enter a number over or under 100 or 50: ", value
IF (value% > 100 AND value% < 200) OR value% = 50 THEN PRINT "OK" 

```

Using multiple IF options in a one line statement.

```vb

INPUT "Enter a number over or under 200: ", x
IF x > 200 THEN PRINT "High" ELSEIF x < 0 THEN PRINT "Low" ELSE PRINT "OK"


```

[STRING](STRING) values can be compared using greater than, less than, not equal to or equal to operators only.

```vb

PRINT "Press a letter key: ";
Key$ = INPUT$(1)
PRINT Key$ 
IF Key$ >= CHR$(65) AND Key$ <= CHR$(90) THEN PRINT "A to Z"

```

> *Explanation:* Long [STRING](STRING) expression values are compared by their cumulative [ASCII](ASCII) code values.

**QBasic decimal point value comparison errors**
* Floating decimal point numerical values may not be compared as exactly the same value. QB64 will compare them the same.
> QBasic would print *unequal* in the IF comparison code below even though it is exactly the same value printed.

```vb

x# = 5 / 10
y# = 6 / 10
z# = x# + y#
PRINT x#, y#, z#
IF x# + y# = z# THEN PRINT "equal" ELSE PRINT "unequal" 

```

> Note: QB64 will make the calculation correctly and print *equal*. Change older program code that relies on the error accordingly.

## See Also

* [ELSEIF](ELSEIF), [ELSE](ELSE)
* [AND (boolean)](AND-(boolean)), [OR (boolean)](OR-(boolean)) 
* [NOT](NOT), [GOTO](GOTO)
* [SELECT CASE](SELECT-CASE)
* [Boolean](Boolean) (numerical comparisons return a true or false value)
