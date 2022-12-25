The [ERR](ERR) function returns the last QBasic error code number. 

## Syntax

> errorNum% = [ERR](ERR)

## Description

* If there is no error, the function returns 0
* Can be used in an error handling routine to report the last error code number.

## Example(s)

Simulating an error to test a program error handler that looks for a "Subscript out of range" error.

```vb

ON ERROR GOTO handler

IF x = 0 THEN ERROR 111  'simulate an error code that does not exist
x = x + 1
IF x THEN ERROR 9        'simulate array boundary being exceeded

END

handler:
PRINT ERR, _ERRORLINE
BEEP
IF ERR = 9 THEN
  PRINT "The program has encountered an error and needs to close! Press a key!"
  K$ = INPUT$(1)
  SYSTEM
END IF
RESUME NEXT               'RESUME can only be used in error handlers 

```

## See Also

* [ON ERROR](ON-ERROR), [RESUME](RESUME)
* [ERL](ERL)
* [_ERRORLINE](_ERRORLINE), [_INCLERRORLINE](_INCLERRORLINE), [_INCLERRORFILE$](_INCLERRORFILE$), [_ERRORMESSAGE$](_ERRORMESSAGE$)
* [ERROR](ERROR)
* [ERROR Codes](ERROR-Codes)
