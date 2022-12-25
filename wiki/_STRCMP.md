The [_STRCMP](_STRCMP) function compares the relationship between two strings, comparing upper or lower case.

## Syntax

> comparison% = [_STRCMP](_STRCMP)(string1$, string2$)

## Description

* Function returns -1 when string1$ is less than string2$, 0 when equal or 1 when string1$ is greater than string2$.
* Upper case letters are valued less than lower case letters in the [ASCII](ASCII) evaluation.

## See Also

* [_STRICMP](_STRICMP)
* [STR$](STR$)
* [STRING](STRING)
* [ASCII](ASCII)
