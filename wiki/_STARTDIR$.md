The [_STARTDIR$](_STARTDIR$) function returns the user's working directory when the program was started.

## Syntax

> callPath$ = [_STARTDIR$](_STARTDIR$)

## Description

The user's working directory depends on how the program was launched. Note that these are ultimately controlled by the launching environment, so might differ in non-standard setups.
* If the program was run from a graphical file manager, _STARTDIR$ will be the path to the directory of the binary file.
* If launched from the command line, _STARTDIR$ is the shell's current working directory, as manipulated by the 'cd' command.
* If launched via a shortcut on Windows _STARTDIR$ will be the "Start in" property, which defaults to the location of the shortcut's target file.

The value of [_STARTDIR$](_STARTDIR$) may differ from [_CWD$](_CWD$) even at program start, because QB64 program change their current directory to the binary's location. _STARTDIR$ is the directory inherited from the user's environment, while [_CWD$](_CWD$) will start off as the location of the program binary file. Because files are opened relative to [_CWD$](_CWD$), this can be useful for programs that expect to open e.g. graphical or sound assets, but problematic for programs that want to interpret paths supplied by the user as relative to the user's current directory. In the latter case, add a 'CHDIR _STARTDIR$' to the top of the program. This will change back to the working directory inherited from the environment.

## Availability

* Version 1.000 and up.

## Example(s)

Showcasing QB64 path functions:

```vb

$CONSOLE:ONLY
_DEST _CONSOLE
SHELL "cd"
PRINT _CWD$
PRINT _STARTDIR$
SYSTEM 

```

## See Also

* [_CWD$](_CWD$)
* [SHELL](SHELL)
