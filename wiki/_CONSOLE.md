The [_CONSOLE](_CONSOLE) statement can be used to turn a console window ON/OFF.

## Syntax

> [_CONSOLE](_CONSOLE) {OFF|ON}
> _DEST [_CONSOLE](_CONSOLE)

* [_CONSOLE](_CONSOLE) OFF or ON must be used after the [$CONSOLE]($CONSOLE) [Metacommand](Metacommand) has established that a console window is desired.
* [_CONSOLE](_CONSOLE) OFF turns the console window off once a console has been established using [$CONSOLE]($CONSOLE):ON or ONLY.
* [_CONSOLE](_CONSOLE) ON should only be used after the console window has been turned OFF previously.
* [_DEST](_DEST) [_CONSOLE](_CONSOLE) can be used to send screen output to the console window using QB64 commands such as [PRINT](PRINT).
* [_SCREENHIDE](_SCREENHIDE) or [_SCREENSHOW](_SCREENSHOW) can be used to hide or display the main program window.
* The [$SCREENHIDE]($SCREENHIDE) [Metacommand](Metacommand) can hide the main program window throughout a program when only the console is used.
* **Note:** Text can be copied partially or totally from console screens in Windows by highlighting and using the title bar menu. 
  * To copy console text output, right click the title bar and select *Edit* for *Mark* to highlight and repeat to *Copy*. 

## Example(s)

Hiding and displaying a console window. Use [_DELAY](_DELAY) to place console in front of main program window.

```vb

$CONSOLE
_CONSOLE OFF 'close original console
_DELAY 2
_CONSOLE ON 'place console above program window

_DEST _CONSOLE 
INPUT "Enter your name: ", nme$ 'get program input
_CONSOLE OFF 'close console

_DEST 0 'destination program window
PRINT nme$
END 

```

> *Explanation:* The [_DEST](_DEST) must be changed with [_DEST](_DEST) [_CONSOLE](_CONSOLE) to get [INPUT](INPUT) from the [$CONSOLE]($CONSOLE) screen.

[_CONSOLETITLE](_CONSOLETITLE) can be used to create a console title, but it must be redone every time the console window is restored once turned off:

```vb

$CONSOLE

_CONSOLETITLE "firstone"
_DELAY 10

_CONSOLE OFF
_DELAY 10

_CONSOLE ON
_CONSOLETITLE "secondone"

```

> *Note:* Some versions of Windows may display the program path or Administrator: prefix in console title bars.

## See Also

* [$CONSOLE]($CONSOLE), [_CONSOLETITLE](_CONSOLETITLE)
* [$SCREENHIDE]($SCREENHIDE), [$SCREENSHOW]($SCREENSHOW) (QB64 [Metacommand](Metacommand)s)
* [_SCREENHIDE](_SCREENHIDE), [_SCREENSHOW](_SCREENSHOW)
* [_DEST](_DEST)
