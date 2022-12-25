The [$SCREENSHOW]($SCREENSHOW) [Metacommand](Metacommand) can be used to display the main program window throughout the program.

## Syntax

>  $SCREENSHOW

## Description

* The metacommand is intended to be used in a modular program when a screen surface is necessary in one or more modules.
* $SCREENSHOW can only be used after [$SCREENHIDE]($SCREENHIDE) or [_SCREENHIDE](_SCREENHIDE) have been used in another program module.
* If [$SCREENHIDE]($SCREENHIDE) and then [$SCREENSHOW]($SCREENSHOW) are used in the same program module the window will not be hidden.
* **QB64 [Metacommand](Metacommand)s cannot be commented out with [apostrophe](apostrophe) or [REM](REM).**

## See Also

* [$CONSOLE]($CONSOLE), [$SCREENHIDE]($SCREENHIDE) (QB64 [Metacommand](Metacommand)s)
* [_SCREENHIDE](_SCREENHIDE), [_SCREENSHOW](_SCREENSHOW)
* [_CONSOLE](_CONSOLE)
