The [_COPYIMAGE](_COPYIMAGE) function creates an identical designated image in memory with a different negative [LONG](LONG) handle value.

## Syntax

> newhandle& = [_COPYIMAGE](_COPYIMAGE)[(imageHandle&[, mode%)]]

## Parameter(s)

* The [LONG](LONG) *newhandle&* value returned will be different than the source handle value supplied.
* If *imageHandle&* parameter is omitted or zero is designated, the current software [_DEST](_DEST) screen or image is copied.
* If 1 is designated instead of an *imageHandle&*, it designates the last OpenGL hardware surface to copy.
* *Mode* 32 can be used to convert 256 color images to 32 bit colors.
* *Mode* 33 images are hardware accelerated in **version 1.000 and up**, and are created using [_LOADIMAGE](_LOADIMAGE) or [_COPYIMAGE](_COPYIMAGE).

## Description

* The function copies any image or screen handle to a new and unique negative [LONG](LONG) handle value.
* Valid copy handles are less than -1. Invalid handles return -1 or 0 if it was never created.
* Every attribute of the passed image or program screen is copied to a new handle value in memory.
* **32 bit screen surface backgrounds (black) have zero [_ALPHA](_ALPHA) so that they are transparent when placed over other surfaces.**

> Use [CLS](CLS) or [_DONTBLEND](_DONTBLEND) to make a new surface background [_ALPHA](_ALPHA) 255 or opaque.

* **Images are not deallocated when the [SUB](SUB) or [FUNCTION](FUNCTION) they are created in ends. Free them with [_FREEIMAGE](_FREEIMAGE).**
* **It is important to free discarded images with [_FREEIMAGE](_FREEIMAGE) to prevent PC memory allocation errors!**
* **Do not try to free image handles currently being used as the active [SCREEN](SCREEN). Change screen modes first.**

## Example(s)

Restoring a Legacy SCREEN using the _COPYIMAGE return value.

```vb

SCREEN 13
CIRCLE (160, 100), 100, 40
DO: SLEEP: LOOP UNTIL INKEY$ <> ""

'backup screen before changing SCREEN mode
oldmode& = _COPYIMAGE(0)  'the 0 value designates the current destination SCREEN

s& = _NEWIMAGE(800, 600, 32)
SCREEN s&
LINE (100, 100)-(500, 500), _RGB(0, 255, 255), BF
DO: SLEEP: LOOP UNTIL INKEY$ <> ""

SCREEN oldmode&        'restore original screen
IF s& < -1 THEN _FREEIMAGE s&
END

```

> *Note:* Only free valid handle values with [_FREEIMAGE](_FREEIMAGE) AFTER a new [SCREEN](SCREEN) mode is being used by the program.

Program that copies desktop to a hardware image to form a 3D triangle:

```vb

SCREEN _NEWIMAGE(640, 480, 32)
my_hardware_handle = _COPYIMAGE(_SCREENIMAGE, 33) 'take a screenshot and use it as our texture
_MAPTRIANGLE (0, 0)-(500, 0)-(250, 500), my_hardware_handle TO_ 
(-1, 0, -1)-(1, 0, -1)-(0, 5, -10), , _SMOOTH
_DISPLAY
DO: _LIMIT 30: LOOP UNTIL INKEY$ <> ""

```

## See Also

* [_LOADIMAGE](_LOADIMAGE), [_NEWIMAGE](_NEWIMAGE)
* [_PUTIMAGE](_PUTIMAGE), [_MAPTRIANGLE](_MAPTRIANGLE)
* [_SOURCE](_SOURCE), [_DEST](_DEST)
* [_FREEIMAGE](_FREEIMAGE)
* [FILELIST$ (function)](FILELIST$-(function)) (Demo of _COPYIMAGE)
* [_DISPLAYORDER](_DISPLAYORDER)
* [Hardware images](Hardware-images)
