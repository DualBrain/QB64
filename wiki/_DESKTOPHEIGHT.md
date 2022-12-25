The [_DESKTOPHEIGHT](_DESKTOPHEIGHT) function returns the height of the users current desktop.

## Syntax

> y& = [_DESKTOPHEIGHT](_DESKTOPHEIGHT)

## Description

* No parameters are needed for this function.
* This returns the height of the user's desktop, not the size of any screen or window which might be open on that desktop.

## Availability

* Version 1.000 and up.

## Example(s)

```vb

s& = _NEWIMAGE(800, 600, 256)
SCREEN s&
PRINT _DESKTOPWIDTH, _DESKTOPHEIGHT
PRINT _WIDTH, _HEIGHT

```

> *Explanation:* This will print the size of the user desktop (for example *1920, 1080* for a standard hdmi monitor), and then the size of the current [SCREEN](SCREEN) (800, 600).

## See Also

* [_HEIGHT](_HEIGHT), [_DESKTOPWIDTH](_DESKTOPWIDTH)
* [_WIDTH](_WIDTH), [_SCREENIMAGE](_SCREENIMAGE)
