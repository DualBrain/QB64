The [_SCREENCLICK](_SCREENCLICK) statement simulates clicking on a pixel coordinate on the desktop screen with the left mouse button.

## Syntax

> [_SCREENCLICK](_SCREENCLICK) column%, row%[, button%]

## Description

* column% is the horizontal pixel coordinate position on the screen.
* row% is the vertical pixel coordinate position on the screen.
* Optional button% can be used to specify left button (1, default), right button (2) or middle button (3) (available with **build 20170924/68**).
* Coordinates can range from 0 to the [_DESKTOPWIDTH](_DESKTOPWIDTH) and [_DESKTOPHEIGHT](_DESKTOPHEIGHT). The desktop image acquired by [_SCREENIMAGE](_SCREENIMAGE) can be used to map the coordinates required.
* [Keywords currently not supported](Keywords-currently-not-supported-by-QB64)

## See Also

* [_SCREENIMAGE](_SCREENIMAGE), [_SCREENPRINT](_SCREENPRINT)
* [_SCREENMOVE](_SCREENMOVE), [_SCREENX](_SCREENX), [_SCREENY](_SCREENY)
* [_DESKTOPWIDTH](_DESKTOPWIDTH), [_DESKTOPHEIGHT](_DESKTOPHEIGHT)
