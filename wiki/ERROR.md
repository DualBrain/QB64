The [ERROR](ERROR) statement is used to simulate a program error or to troubleshoot error handling procedures.

## Syntax

> [ERROR](ERROR) codeNumber%

## Description

* Can be used to test an error handling routine by simulating an error. 
* Error code 97 can be used to invoke the error handler for your own use, no real error in the program will trigger error 97.
* Use error codes between 100 and 200 for custom program errors that will not be responded to by QB64. 

## Example(s)

Creating custom error codes for a program that can be handled by an [ON ERROR](ON-ERROR) handling routine.

```vb

ON ERROR GOTO handler

IF x = 0 THEN ERROR 123
x = x + 1
IF x THEN ERROR 111

END

handler:
PRINT ERR, _ERRORLINE
BEEP
RESUME NEXT 

```

> **Note: Don't use error codes under 97 or over 200 as QB64 may respond to those errors and interrupt the program.**

## See Also

* [ON ERROR](ON-ERROR)
* [ERR](ERR), [ERL](ERL)
* [_ERRORLINE](_ERRORLINE), [_ERRORMESSAGE$](_ERRORMESSAGE$)
* [_INCLERRORLINE](_INCLERRORLINE), [_INCLERRORFILE$](_INCLERRORFILE$)
* [ERROR Codes](ERROR-Codes) (list)
