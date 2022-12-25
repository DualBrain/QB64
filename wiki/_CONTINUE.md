The [_CONTINUE](_CONTINUE) statement is used in a [DO...LOOP](DO...LOOP), [WHILE...WEND](WHILE...WEND) or [FOR...NEXT](FOR...NEXT) block to skip the remaining lines of code in a block (without exiting it) and start the next iteration. It works as a shortcut to a [GOTO](GOTO), but without the need for a [line numbers](line-numbers). 

## Syntax

> [_CONTINUE](_CONTINUE)

## Availability

* Build 20170628/55 and up.

## Example(s)

```vb

FOR i = 1 TO 10
    IF i = 5 THEN _CONTINUE
    PRINT i;
NEXT

```

```text

 1  2  3  4  6  7  8  9  10

```

## See Also

* [DO...LOOP](DO...LOOP)
* [WHILE...WEND](WHILE...WEND)
* [FOR...NEXT](FOR...NEXT)
* [GOTO](GOTO)
