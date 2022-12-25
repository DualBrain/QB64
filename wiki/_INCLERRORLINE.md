The [_INCLERRORLINE](_INCLERRORLINE) function returns the line number in an [$INCLUDE]($INCLUDE) file that caused the most recent error.

## Syntax

> errline& = [_INCLERRORLINE](_INCLERRORLINE)

## Description

* If the last error occurred in the main module, _INCLERRORLINE returns 0.
* By checking _INCLERRORLINE you can report exactly what line inside an included module caused the last error.

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

* [_INCLERRORFILE$](_INCLERRORFILE$), [_ERRORMESSAGE$](_ERRORMESSAGE$)
* [ON ERROR](ON-ERROR), [ERR](ERR)
* [ERROR](ERROR)
* [ERROR Codes](ERROR-Codes)
* [$INCLUDE]($INCLUDE)
