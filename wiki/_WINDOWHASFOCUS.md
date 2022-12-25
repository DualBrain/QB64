The [_WINDOWHASFOCUS](_WINDOWHASFOCUS) function returns true (-1) if the current program's window has focus. Windows-only.

## Syntax

>  hasFocus%% = [_WINDOWHASFOCUS](_WINDOWHASFOCUS)

## Description

* The function returns true (-1) if the current program is the topmost window on the user's desktop and has focus. If the current program is running behind another window, the function returns false (0).
* [Keywords currently not supported](Keywords-currently-not-supported-by-QB64).

## Availability

* Build 20170924/68 and up.

## Example(s)

 Detecting if the current program has focus. Windows and Linux-only.

```vb

DO
    IF _WINDOWHASFOCUS THEN
        COLOR 15, 6
        CLS
        PRINT "*** Hi there! ***"
    ELSE
        COLOR 0, 7
        CLS
        PRINT "(ain't nobody looking...)"
    END IF
    _DISPLAY
    _LIMIT 30
LOOP

```

>  *Explanation:* The program will display *"*** Hi There! ***"* while the window is the topmost and is being manipulated by the user. If another window, the taskbar or the desktop are clicked, the program window loses focus and the message *"(ain't nobody looking...)"* is displayed.

## See Also

* [_SCREENEXISTS](_SCREENEXISTS)
