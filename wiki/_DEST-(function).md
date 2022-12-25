The [_DEST](_DEST) function returns the handle value of the current write page (the image used for drawing).

## Syntax

> result& = [_DEST](_DEST)

## Description

* The current write page is where all drawing occurs by default.
* The value returned is the same as the latest [SCREEN](SCREEN)'s handle when creating custom screen modes using [_NEWIMAGE](_NEWIMAGE).
* Keep the _NEWIMAGE handle values when you move to another SCREEN mode so that you can return to that screen later. You can go to another screen mode and return without having to redo the screen. 
* [_DEST](_DEST) return values do not change in legacy screen modes. The value will not help restore them.

## See Also

* [_DEST](_DEST)
* [_SOURCE (function)](_SOURCE-(function))
* [SCREEN](SCREEN)
