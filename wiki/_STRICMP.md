The [_STRICMP](_STRICMP) function compares the relationship between two strings, ignoring upper or lower case letters.

## Syntax

> comparison% = [_STRICMP](_STRICMP)(string1$, string2$)

## Description

* Function returns -1 when string1$ is less than string2$, 0 when equal or 1 when string1$ is greater than string2$.
* Alphabet comparisons will be evaluated without regard to the letter case in the 2 strings. 

## See Also

* [_STRCMP](_STRCMP)
* [STR$](STR$)
* [STRING](STRING)
* [ASCII](ASCII)
