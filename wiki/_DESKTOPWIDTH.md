The [_DESKTOPWIDTH](_DESKTOPWIDTH) function returns the width of the users current desktop.

## Syntax

> x& = [_DESKTOPWIDTH](_DESKTOPWIDTH)

## Description

* No parameters are needed for this function.
* This returns the width of the user's desktop, not the size of any screen or window which might be open on that desktop.

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

* [_HEIGHT](_HEIGHT), [_DESKTOPHEIGHT](_DESKTOPHEIGHT)
* [_WIDTH](_WIDTH), [_SCREENIMAGE](_SCREENIMAGE)
