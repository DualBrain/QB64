The [$ASSERTS]($ASSERTS) metacommand enables debug tests with the [_ASSERT](_ASSERT) macro.

## Syntax

> [$ASSERTS]($ASSERTS)

> [$ASSERTS]($ASSERTS):CONSOLE

## Description

* If an error message is passed to the [_ASSERT](_ASSERT) statement, it is displayed in the console window if [$ASSERTS]($ASSERTS):CONSOLE is used.

## Availability

* Version 1.4 and up.

## Example(s)

Adding test checks for parameter inputs in a function.

```vb

$ASSERTS:CONSOLE

DO
    a = INT(RND * 10)
    b$ = myFunc$(a)
    PRINT a, , b$
    _LIMIT 3
LOOP UNTIL _KEYHIT

FUNCTION myFunc$ (value AS SINGLE)
    _ASSERT value > 0, "Value cannot be zero"
    _ASSERT value <= 10, "Value cannot exceed 10"

    IF value > 1 THEN plural$ = "s"
    myFunc$ = STRING$(value, "*") + STR$(value) + " star" + plural$ + " :-)"
END FUNCTION

```

## See Also

* [_ASSERT](_ASSERT)
* [$CHECKING]($CHECKING)
* [Relational Operations](Relational-Operations)
