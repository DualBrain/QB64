The [_CONTROLCHR (function)](_CONTROLCHR-(function)) function returns the current state of the [_CONTROLCHR](_CONTROLCHR) statement as -1 when OFF and 0 when ON.

## Syntax

> status% = [_CONTROLCHR (function)](_CONTROLCHR-(function))

## Description

* The function requires no parameters.
* Default return is 0 when the _CONTROLCHR statement has never been used previous to a function read.
* When the statement has been use to turn OFF control characters, the characters can be printed as text without screen formatting.

## See Also

* [_CONTROLCHR](_CONTROLCHR)
* [CHR$](CHR$), [ASC](ASC)
* [INKEY$](INKEY$), [_KEYHIT](_KEYHIT)
* [ASCII](ASCII) (codes)
