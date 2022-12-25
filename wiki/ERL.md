The [ERL](ERL) function returns the closest previous line number before the last error.

## Syntax

> *lastErrorLine&* = [ERL](ERL)

## Description

* Used in an error handler to report the last line number used before the error.
* If the program does not use line numbers, then ERL returns 0.
* Use [_ERRORLINE](_ERRORLINE) to return the actual code line position of an error in a QB64 program.

## Example(s)

Using a fake error code to return the line number position in a program.

```vb

ON ERROR GOTO errorfix
1
ERROR 250
ERROR 250

5 ERROR 250

END
errorfix:
PRINT ERL
RESUME NEXT 

```

```text
1
1
5

```

## See Also

* [ERR](ERR)
* [ERROR](ERROR)
* [ON ERROR](ON-ERROR)
* [_ERRORLINE](_ERRORLINE), [_INCLERRORLINE](_INCLERRORLINE), [_INCLERRORFILE$](_INCLERRORFILE$), [_ERRORMESSAGE$](_ERRORMESSAGE$)
* [ERROR Codes](ERROR-Codes)
