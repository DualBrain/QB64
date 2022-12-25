The [_HEIGHT](_HEIGHT) function returns the height of an image handle or of the current write page.

## Syntax

> columns& = [_HEIGHT](_HEIGHT)[(imageHandle&)]

## Description

* If imageHandle& is omitted, it's assumed to be the handle of the current [SCREEN](SCREEN) or write page.
* To get the height of the current program [SCREEN](SCREEN) window use zero for the handle value or nothing: lines& = [_HEIGHT](_HEIGHT)(0) *or* lines& = [_HEIGHT](_HEIGHT)
* If the image specified by imageHandle& is in text only ([SCREEN](SCREEN) 0) mode, the number of characters per row is returned.
* If the image specified by imageHandle& is in graphics mode, the number of pixels per row is returned. 
* If imageHandle& is an invalid handle, then an [ERROR Codes](ERROR-Codes) is returned.
* The last visible pixel coordinate of a program [SCREEN](SCREEN) is **[_HEIGHT](_HEIGHT) - 1**.

## See Also

* [_WIDTH (function)](_WIDTH-(function)), [_LOADIMAGE](_LOADIMAGE), [_NEWIMAGE](_NEWIMAGE)
* [Bitmaps](Bitmaps)
