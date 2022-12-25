[_DONTWAIT](_DONTWAIT) is used with the [SHELL](SHELL) statement in **QB64** to specify that the program shouldn't wait until the external command/program is finished (which it otherwise does by default).

## Syntax

> [SHELL](SHELL) [_DONTWAIT] [commandLine$]

## Description

*Runs the command/program specified in commandline$ and lets the calling program continue at the same time in its current screen format.
*Especially useful when CMD /C or START is used in a SHELL command line to run another program. 
* **QB64** automatically uses CMD /C or COMMAND /C when using SHELL. 
* **QB64** program screens will not get distorted or minimized like QBasic fullscreen modes would.

## Example(s)

```vb

SHELL _DONTWAIT "notepad " + filename$

FOR x = 1 TO 5
    _LIMIT 1
    PRINT x
NEXT

```

(opens up notepad at the same time as counting to 5)

```text

 1
 2
 3
 4
 5

```

## See Also

* [SHELL](SHELL), [_HIDE](_HIDE)
