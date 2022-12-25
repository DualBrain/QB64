The [$SCREENHIDE]($SCREENHIDE) [Metacommand](Metacommand) can be used to hide the main program window throughout a program.

## Syntax

>  [$SCREENHIDE]($SCREENHIDE)

* $SCREENHIDE may be used at the start of a program to hide the main program window when using a [$CONSOLE]($CONSOLE) window.
* The [_SCREENHIDE](_SCREENHIDE) statement must be used before [_SCREENSHOW](_SCREENSHOW) can be used in sections of a program.
* **QB64 [Metacommand](Metacommand)s cannot be commented out with [apostrophe](apostrophe) or [REM](REM)**.

## Example(s)

 Hiding a program when displaying a message box in Windows.

```vb

$SCREENHIDE
DECLARE DYNAMIC LIBRARY "user32"
  FUNCTION MessageBoxA& (BYVAL hWnd%&, BYVAL lpText%&, BYVAL lpCaption%&, BYVAL uType~&)
END DECLARE
DECLARE DYNAMIC LIBRARY "kernel32"
  SUB ExitProcess (BYVAL uExitCode~&)
END DECLARE
DIM s0 AS STRING
DIM s1 AS STRING
s0 = "Text" + CHR$(0)
s1 = "Caption" + CHR$(0)
ExitProcess MessageBoxA(0, _OFFSET(s0), _OFFSET(s1), 0)

```

## See Also

* [$CONSOLE]($CONSOLE), [$SCREENSHOW]($SCREENSHOW)
* [_SCREENHIDE](_SCREENHIDE), [_SCREENSHOW](_SCREENSHOW)
* [_CONSOLE](_CONSOLE)
