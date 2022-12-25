The [_ERRORLINE](_ERRORLINE) function returns the source code line number that caused the most recent runtime error.

## Syntax

> e% = [_ERRORLINE](_ERRORLINE)

## Description

* Used in program error troubleshooting.
* Does not require that the program use line numbers as it counts the actual lines of code.
* The code line can be found using the QB64 IDE (Use the shortcut **Ctrl+G** to go to a specific line) or any other text editor such as Notepad.

## Example(s)

Displaying the current program line using a simulated [ERROR](ERROR) code.

```vb

ON ERROR GOTO DebugLine 'can't use GOSUB 

ERROR 250 'simulated error code 

END 
DebugLine: 
PRINT _ERRORLINE 
RESUME NEXT 

```

## See Also

* [ON ERROR](ON-ERROR)
* [_INCLERRORLINE](_INCLERRORLINE), [_INCLERRORFILE$](_INCLERRORFILE$), [_ERRORMESSAGE$](_ERRORMESSAGE$)
* [ERR](ERR), [ERL](ERL)
* [ERROR](ERROR)
* [ERROR Codes](ERROR-Codes)
