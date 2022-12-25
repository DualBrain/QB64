The **SHELL** function displays the console and returns the [INTEGER](INTEGER) code value sent when the external program exits.

## Syntax

> return_code = **SHELL(*DOScommand$*)**

## Parameter(s)

* The literal or variable [STRING](STRING) *command* parameter can be any valid external command or call to another program.

## Usage

* A SHELL to a QB64 EXE program with an exit return code parameter after [END](END) or [SYSTEM](SYSTEM) will return that code value.
* The return_code is usually 0 when the external program ends with no errors.
* The console window may appear when using the SHELL function. The [_SHELLHIDE](_SHELLHIDE) function will hide the console from view.

## Example(s)

Shelling to another QB64 program will return the exit code when one is set in the  program that is run.

```text

'DesktopSize.BAS ** Compile in Windows with QB64 first

CONST SM_CXSCREEN = 0
CONST SM_CYSCREEN = 1

DECLARE LIBRARY
    FUNCTION GetSystemMetrics& (BYVAL n AS LONG)
END DECLARE

PRINT trimstr$(GetSystemMetrics(SM_CXSCREEN)); "X"; trimstr$(GetSystemMetrics(SM_CYSCREEN))

s& = _SCREENIMAGE
PRINT _WIDTH(s&); "X"; _HEIGHT(s&)

END 3 '<<<<<< add a code to return after END or SYSTEM in any program

FUNCTION trimstr$ (whatever)
  trimstr = LTRIM$(RTRIM$(STR$(whatever)))
END FUNCTION 

```

>  *Explanation:* To set a program exit code use an [INTEGER](INTEGER) parameter value after [END](END) or [SYSTEM](SYSTEM) in the called program. 

>  After compiling *DesktopSize.EXE* run the following code in the QB64 IDE. After 1st program is done 3 will appear on screen:

```vb

returncode% = SHELL("DesktopSize") 'replace call with name of any QB64 program EXE

PRINT returncode% 'prints code sent by called program after it is closed

END 

```

```text

3 

```

## See Also

* [_SHELLHIDE](_SHELLHIDE) (function)
* [SHELL](SHELL), [_HIDE](_HIDE)
* [_CONSOLE](_CONSOLE), [$CONSOLE]($CONSOLE)
* [SYSTEM](SYSTEM), [END](END)
