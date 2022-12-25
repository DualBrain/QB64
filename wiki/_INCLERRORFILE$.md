The [_INCLERRORFILE$](_INCLERRORFILE$) function returns the name of the original source code [$INCLUDE]($INCLUDE) module that caused the most recent error.

## Syntax

> errfile$ = [_INCLERRORFILE$](_INCLERRORFILE$)

## Description

If the last error occurred in the main module, [_INCLERRORFILE$](_INCLERRORFILE$) returns an empty string.

## Availability

* Version 1.1 and up.

## Example(s)

```vb

ON ERROR GOTO DebugLine

ERROR 250 'simulated error code - an error in the main module leaves _INCLERRORLINE empty (= 0)

'$INCLUDE:'haserror.bi'

END

DebugLine:
PRINT "An error occurred. Please contact support with the following details:
PRINT "ERROR "; ERR; " ON LINE: "; _ERRORLINE
IF _INCLERRORLINE THEN
    PRINT "    IN MODULE "; _INCLERRORFILE$; " (line"; _INCLERRORLINE; ")"
END IF
RESUME NEXT 

```

```text

An error occurred. Please contact support with the following details:
ERROR  250  ON LINE:  6

An error occurred. Please contact support with the following details:
ERROR  250  ON LINE:  9
    IN MODULE haserror.bi ( line 1 )

```

## See Also

* [_INCLERRORLINE](_INCLERRORLINE), [_ERRORMESSAGE$](_ERRORMESSAGE$)
* [ON ERROR](ON-ERROR), [ERR](ERR)
* [ERROR](ERROR)
* [ERROR Codes](ERROR-Codes)
* [$INCLUDE]($INCLUDE)
