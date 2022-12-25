[ON ERROR](ON-ERROR) is used with [GOTO](GOTO) to handle errors in a program.

## Syntax

>  [ON ERROR](ON-ERROR) [GOTO](GOTO) {*lineNumber*|*lineLabel*}

## Description

* An *untreated error* in a program will cause execution to stop and an error message is displayed to the user, who can choose to continue (ignore the error - which could have unexpected results) or end the program.
* Use [ON ERROR](ON-ERROR) when your program performs operations that are likely to generate errors, like file access operations.
* [ON ERROR](ON-ERROR) statements can be in the main module code or in [SUB](SUB) or [FUNCTION](FUNCTION) procedures. 
* [ON ERROR](ON-ERROR) statements take precedence in the order they are encountered. It will also handle any subroutine errors.
* **ON ERROR GOTO 0** can be used to disable custom [ON ERROR](ON-ERROR) trapping and give default error messages.
* A subsequent ON ERROR statement will override the previous one.
* [GOTO](GOTO) is required in the statement. Cannot use [GOSUB](GOSUB).
* Comment out [ON ERROR](ON-ERROR) to find specific error locations. QB64 can return the file line position with [_ERRORLINE](_ERRORLINE)
* Note: QB64 does not support the PDS (QuickBASIC 7) **ON ERROR RESUME NEXT** statement.

## Example(s)

Using an error handler that ignores any error.

```vb

 ON ERROR GOTO Errhandler
   ' Main module program error simulation code
 ERROR 7           ' simulate an Out of Memory Error
 PRINT "Error handled...ending program"
 SLEEP 4
 SYSTEM            ' end of program code

 Errhandler:              'error handler sub program line label
  PRINT "Error"; ERR; "on program file line"; _ERRORLINE
  BEEP             ' warning beep
 RESUME NEXT       ' moves program to code following the error. 

```

```text

Error 7 on program file line 3 
Error handled...ending program

```

> *Explanation:* The ON ERROR statement is normally placed at the beginning of the main module code.  Errhandle is the line label sub referred to in the statement. The handler prints the error code and attempts to use the next line of code using [RESUME](RESUME) NEXT which is only used in error handling procedures. [_ERRORLINE](_ERRORLINE) returns the program file's actual text line count found in the IDE.

Using an error handler in a [SUB](SUB) procedure.

```vb

s
END

hand:
PRINT "got error!"
RESUME NEXT

SUB s
ON ERROR GOTO hand
ERROR 1
ON ERROR GOTO 0
PRINT "Done!"
END SUB 

```

> *Explanation:* The [GOTO](GOTO) procedure must be in the main code area after [END](END) to avoid a [RESUME](RESUME) error later. Use GOTO 0 to clear the ON ERROR set in the sub so that later errors are not handled by it.

## See Also

* [ERR](ERR), [ERL](ERL), [RESUME](RESUME)
* [ON...GOTO](ON...GOTO)
* [_ERRORLINE](_ERRORLINE), [_INCLERRORLINE](_INCLERRORLINE), [_INCLERRORFILE$](_INCLERRORFILE$), [_ERRORMESSAGE$](_ERRORMESSAGE$)
* [ERROR](ERROR) (simulates an error)
* [ERROR Codes](ERROR-Codes)
