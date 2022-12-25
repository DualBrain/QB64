The [_SCREENIMAGE](_SCREENIMAGE) function stores the current desktop image or a portion of it and returns an image handle.

## Syntax

> imageHandle& = [_SCREENIMAGE](_SCREENIMAGE)(column1, row1, column2, row2)]

## Description

* imageHandle& is the handle to the new image in memory that will contain the desktop screenshot.
* The optional screen column and row positions can be used to get only a portion of the desktop image.
* The desktop image or partial image is always a 32-bit image. 
* The current screen resolution or width-to-height aspect ratio can be obtained with [_DESKTOPWIDTH](_DESKTOPWIDTH) and [_DESKTOPHEIGHT](_DESKTOPHEIGHT).
* Can be used to take screenshots of the desktop or used with [_PRINTIMAGE](_PRINTIMAGE) to print them.
* It is important to free unused or uneeded image handles with [_FREEIMAGE](_FREEIMAGE) to prevent memory overflow errors.
* [Keywords currently not supported](Keywords-currently-not-supported-by-QB64)

## Example(s)

Determining the present screen resolution of user's PC for a screensaver program.

```vb

 desktop& = _SCREENIMAGE
 MaxScreenX& = _WIDTH(desktop&)
 MaxScreenY& = _HEIGHT(desktop&)
 _FREEIMAGE desktop& 'free image after measuring screen(it is not displayed)
 SCREEN _NEWIMAGE(MaxScreenX&, MaxScreenY&, 256) 'program window is sized to fit
 _SCREENMOVE _MIDDLE

```

### Sample code to save images to disk

* [SAVEIMAGE](SAVEIMAGE)
* [Program ScreenShots](Program-ScreenShots) (member-contributed program for legacy screen modes)
* [ThirtyTwoBit SUB](ThirtyTwoBit-SUB)
* [SaveIcon32](SaveIcon32)

## See Also

* [_SCREENCLICK](_SCREENCLICK), [_SCREENPRINT](_SCREENPRINT)
* [_SCREENMOVE](_SCREENMOVE), [_SCREENX](_SCREENX), [_SCREENY](_SCREENY)
* [_WIDTH (function)](_WIDTH-(function)), [_HEIGHT](_HEIGHT)
* [_DESKTOPWIDTH](_DESKTOPWIDTH), [_DESKTOPHEIGHT](_DESKTOPHEIGHT)
* [_FULLSCREEN](_FULLSCREEN), [_PRINTIMAGE](_PRINTIMAGE)
* [Screen Saver Programs](Screen-Saver-Programs)
* [Bitmaps](Bitmaps), [Icons and Cursors](Icons-and-Cursors)
* [Hardware images](Hardware-images)
