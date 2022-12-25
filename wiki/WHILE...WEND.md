The WHILE...WEND statement is used to repeat a block of statements while the condition is met.

## Syntax

> WHILE condition
> .
> .
> .
> WEND

## Description

* condition is a numeric expression used to determine if the loop will execute.
* statements will execute repeatedly while condition is a non-zero value.
* [EXIT WHILE](EXIT-WHILE) can be used for emergency exits from the loop.
* Use [_CONTINUE](_CONTINUE) to skip the remaining lines in the iteration without leaving the loop.
* A [DO...LOOP](DO...LOOP) can use the same DO WHILE condition to get the same results.
* WHILE loops only run if the WHILE condition is True.

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

Reading an entire file. Example assumes the program has a [OPEN](OPEN) as #1

```vb
  
OPEN "Readme.txt" FOR INPUT AS #1
WHILE NOT EOF(1)
    _LIMIT 1                                    'limit line prints to one per second 
    LINE INPUT #1, text$
    IF INKEY$ = CHR$(27) THEN EXIT WHILE        'ESC key exits
    PRINT text$
WEND 

```

Clearing the keyboard buffer.

```vb

WHILE INKEY$ <> "" : WEND 

```

## See Also

* [DO...LOOP](DO...LOOP)
* [FOR...NEXT](FOR...NEXT)
* [UNTIL](UNTIL) (condition)
* [_CONTINUE](_CONTINUE)
