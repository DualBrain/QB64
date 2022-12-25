The [_SCREENEXISTS](_SCREENEXISTS) function returns true (-1) once a screen has been created.

## Syntax

> screenReady%% = [_SCREENEXISTS](_SCREENEXISTS)

## Description

* Function returns true (-1) once a program screen is available to use or change.
* Can be used to avoid program errors because a screen was not ready for input or alterations.
  * Use before [_TITLE](_TITLE), [_SCREENMOVE](_SCREENMOVE) and other functions that require the output window to have been created.

## Example(s)

The loop busy-waits until the screen exists to add the title.

```vb

SCREEN 12
DO: LOOP UNTIL _SCREENEXISTS
_TITLE "My Title"

```

## See Also

* [_FULLSCREEN](_FULLSCREEN)
* [_SCREENIMAGE](_SCREENIMAGE)
* [$CONSOLE]($CONSOLE)
* [$RESIZE]($RESIZE)
