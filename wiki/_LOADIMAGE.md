The [_LOADIMAGE](_LOADIMAGE) function loads an image into memory and returns valid [LONG](LONG) image handle values that are less than -1. 

## Syntax

> handle& = [_LOADIMAGE](_LOADIMAGE)(filename$[, mode%])

## Parameter(s)

* filename$ is literal or variable [STRING](STRING) file name value.
* Optional mode% [INTEGER](INTEGER) values can be:
  * 32 = 32-bit
  * 33 = hardware image

## Description

* Various common image file formats supported, like BMP, JPG, PNG, etc. A path can also be given.
* The mode% can designate 32-bit color or 33 (**version 1.000 and up**). Omit to use the current graphic screen settings.
* Mode 33 images are **hardware** accelerated and are created using [_LOADIMAGE](_LOADIMAGE) or [_COPYIMAGE](_COPYIMAGE) (**version 1.000 and up**).
* Loaded images can be read invisibly using [POINT](POINT). Image coordinates start at 0 up to the [_WIDTH (function)](_WIDTH-(function)) - 1 and [_HEIGHT](_HEIGHT) - 1.
* Images can be made into a program [SCREEN (statement)](SCREEN-(statement)) or page adopting the size and palette settings or placed using [_PUTIMAGE](_PUTIMAGE).
* Returns -1 as an invalid handle if it can't load the image. Valid [LONG](LONG) handle returns are less than -1 (handle& < -1).
* Valid images only need to be loaded once. The handle can be used repeatedly until freed.
* **Images are not deallocated when the [SUB](SUB) or [FUNCTION](FUNCTION) they are created in ends. Free them with [_FREEIMAGE](_FREEIMAGE).**

## Error(s)

* Some picture file images may not load when a mode% value is designated. Try loading it without a mode% designation.
* **It is important to free unused or discarded images with [_FREEIMAGE](_FREEIMAGE) to prevent CPU memory overflow errors.**
* **In text-only [SCREEN](SCREEN) 0, mode% 32 must be specified.** When loading an [_ICON](_ICON) image use 32 for the mode% too.

## Example(s)

To display an image in 32-bit color using its resolution as a program screen:

```vb

i& = _LOADIMAGE("mypic.jpg", 32)
SCREEN i& 

```

[DRAW](DRAW)ing and rotating an image 360 degrees using Turn Angle. [POINT](POINT) is used to read the invisible image source.

```vb

SCREEN _NEWIMAGE(800, 600, 32)
img& = _LOADIMAGE("QB64.PNG")                           'load the image file to be drawn

wide% = _WIDTH(img&): deep% = _HEIGHT(img&)
TLC$ = "BL" + STR$(wide% \ 2) + "BU" + STR$(deep% \ 2)  'start draw at top left corner
RET$ = "BD BL" + STR$(wide%)                            'return to left side of image
_SOURCE img&
_DEST 0
DO
  FOR angle% = 0 TO 360 STEP 15
    CLS
    DRAW "BM400, 300" + "TA=" + VARPTR$(angle%) + TLC$
    FOR y = 0 TO deep% - 1
      FOR x = 0 TO wide% - 1
        DRAW "C" + STR$(POINT(x, y)) + "R1"            'color and DRAW each pixel
      NEXT
      DRAW RET$
    NEXT
    _DISPLAY                         'NOTE: CPU usage will be HIGH!
  NEXT
LOOP UNTIL INKEY$ > "" 

```


> *NOTE:* Speed varies with image size.

### More examples

* [SAVEIMAGE](SAVEIMAGE) (QB64 Image to Bitmap SUB by Galleon)
* [Program ScreenShots](Program-ScreenShots) (Member-contributed program for legacy screen modes)
* [ThirtyTwoBit SUB](ThirtyTwoBit-SUB) (QB64 Image area to bitmap)

## See Also

* [_FREEIMAGE](_FREEIMAGE), [_ICON](_ICON)
* [_PUTIMAGE](_PUTIMAGE), [_MAPTRIANGLE](_MAPTRIANGLE)
* [_NEWIMAGE](_NEWIMAGE), [_COPYIMAGE](_COPYIMAGE)
* [_PRINTIMAGE](_PRINTIMAGE) (printer)
* [_PALETTECOLOR (function)](_PALETTECOLOR-(function)), [_COPYPALETTE](_COPYPALETTE), [_ICON](_ICON)
* [SCREEN (statement)](SCREEN-(statement))
* [Hardware images](Hardware-images)
* [Bitmaps](Bitmaps), [Icons and Cursors](Icons-and-Cursors), [GIF Images](GIF-Images)
