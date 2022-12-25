The [_SHELLHIDE](_SHELLHIDE) function hides the console window and returns any [INTEGER](INTEGER) code sent when a program exits.

## Syntax

> returnCode% = [_SHELLHIDE](_SHELLHIDE)(externalCommand$)

## Parameter(s)

* The literal or variable [STRING](STRING) externalCommand$ parameter can be any external command or call to another program.

## Description

* A QB64 program can return codes specified after [END](END) or [SYSTEM](SYSTEM) calls.
* The returnCode% is usually 0 when the external program ends with no errors.

## Example(s)

Shelling to another QB64 program will return the exit code when one is set in the  program that is run.

```vb

returncode% = _SHELLHIDE("DesktopSize") 'replace call with your program EXE

PRINT returncode%

END 

```

> *Explanation:* To set a program exit code use an [INTEGER](INTEGER) parameter value after [END](END) or [SYSTEM](SYSTEM) in the called program. 

## See Also

* [SHELL (function)](SHELL-(function))
* [SHELL](SHELL), [_HIDE](_HIDE)
* [_CONSOLE](_CONSOLE), [$CONSOLE]($CONSOLE)
* [SYSTEM](SYSTEM), [END](END)
