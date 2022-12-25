[_PUTIMAGE](_PUTIMAGE) puts an area of a source image to an area of a destination image in one operation, like [GET (graphics statement)](GET-(graphics-statement)) and [PUT (graphics statement)](PUT-(graphics-statement)).

## Syntax
 
> [_PUTIMAGE](_PUTIMAGE) [STEP] [(dx1, dy1)-[STEP][(dx2, dy2)]][, sourceHandle&][, destHandle&][, ][STEP][(sx1, sy1)[-STEP][(sx2, sy2)]][*_SMOOTH*]

### Sample usage

> [_PUTIMAGE](_PUTIMAGE) 'full source image to fit full destination area after [_SOURCE](_SOURCE) and [_DEST](_DEST) are set

> [_PUTIMAGE](_PUTIMAGE) , sourceHandle&, destHandle& 'size full source to fit full destination area

> [_PUTIMAGE](_PUTIMAGE) (*dx1*, *dy1*), sourceHandle&, destHandle& 'full source to top-left corner destination position

> [_PUTIMAGE](_PUTIMAGE) (*dx1*, *dy1*)-(*dx2*, *dy2*), sourceHandle&, destHandle& 'size full source to destination coordinate area

> [_PUTIMAGE](_PUTIMAGE) (*dx1*, *dy1*), sourceHandle&, destHandle&, (*sx1*, *sy1*)-(*sx2*, *sy2*) 'portion of source to the top-left corner of the destination page

> [_PUTIMAGE](_PUTIMAGE) , sourceHandle&, destHandle&, (*sx1*, *sy1*)-(*sx2*, *sy2*) 'portion of source to full destination area

> [_PUTIMAGE](_PUTIMAGE) (*dx1*, *dy1*)-(*dx2*, *dy2*), sourceHandle&, destHandle&,(*sx1*, *sy1*) 'right side of source from top-left corner to destination

> Note: The top-left corner position designates the leftmost and topmost portion of the image to use.

## Parameter(s)

* Relative coordinates to a previous graphical object can be designated using [STEP](STEP) as opposed to literal surface coordinates.
* Coordinates *dx* and *dy* map the box area of the [_DEST](_DEST) area to use. When omitted the entire desination area is used. If only one coordinate is used, the source is placed with its original dimensions. Coordinates can be set to flip or resize the image.
  * dx1 = the column coordinate at which the insertion of the source will begin (leftmost); when larger than *dx2*, reverses image.
  * dy1 = the row coordinate at which the insertion of the source will begin (topmost); when larger than *dy2*, inverts image.
  * dx2 = the column coordinate at which the insertion of the source will end (rightmost); further apart, widens image.
  * dy2 = the row coordinate at which the insertion of the source will end (bottommost); closer together, shrinks image
* sourceHandle& = the [LONG](LONG) handle of the [_SOURCE](_SOURCE) image created with [_NEWIMAGE](_NEWIMAGE), [_LOADIMAGE](_LOADIMAGE) or [_COPYIMAGE](_COPYIMAGE).
* destHandle& = the [LONG](LONG) handle of the [_DEST](_DEST) image may be created with [_NEWIMAGE](_NEWIMAGE), [SCREEN](SCREEN) or [_DEST](_DEST) 0.
* Coordinates *sx* and *sy* [GET (graphics statement)](GET-(graphics-statement)) the box area of the [_SOURCE](_SOURCE) image to transfer to the [_DEST](_DEST) image, page or [SCREEN](SCREEN):
  * sx1 = the column coordinate of the left-most pixel to include of the source. When omitted, the entire image is used
  * sy1 = the row coordinate of the upper-most pixel to include of the source. When omitted, the entire image is used
  * sx2 = the column coordinate of the right-most pixel to include of the source. Can be omitted to get rest of image.
  * sy2 = the row coordinate of the bottom-most pixel to include of the source. Can be omitted to get rest of image.
* *_SMOOTH* applies linear filtering.

**Note: The [PUT (graphics statement)](PUT-(graphics-statement)) options PSET, PRESET, AND, OR and XOR are not available with _PUTIMAGE. QB64 can use [_ALPHA](_ALPHA) of colors to achieve the same results.**

## Description

* _PUTIMAGE can be used without any handle parameters if the [_SOURCE](_SOURCE) and/or [_DEST](_DEST) are already defined.
* If the area of the source is bigger or smaller than the area of the destination then the image is adjusted to fit that area.
* Supports 32 bit alpha blending, color key transparency, true type fonts, stretching, mirroring/flipping, and a variety of graphics file formats including gif, png, bmp & jpg. **32 bit screen surface backgrounds (black) have zero [_ALPHA](_ALPHA) and are transparent when placed over other surfaces.** Use [CLS](CLS) or [_DONTBLEND](_DONTBLEND) to make a new surface background [_ALPHA](_ALPHA) 255 or opaque.
* All graphical surfaces, including screen pages, can be acted upon in the same manner, and are referred to as "images".
* **Hardware images** (created using mode **33** via [_LOADIMAGE](_LOADIMAGE) or [_COPYIMAGE](_COPYIMAGE)) can be used as the source or destination.
* [Handle](Handle)s are used to identify graphical surfaces. Positive values are used to refer to screen pages. -1 (negative one) indicates an invalid surface. It is recommended to store image handles in [LONG](LONG) variables. Passing an invalid handle generates an [ERROR Codes](ERROR-Codes) error.
* When handles are not passed (or cannot be passed) to subs/functions then the default destination image or source image is referenced. These are set to the active page when the SCREEN statement is called, but can be changed to any image. So it is possible to read from one image using [POINT](POINT) and write to a different one with [PSET](PSET).
* **[PRINT](PRINT)ed text cannot be transferred and positioned accurately.** Use [_PRINTSTRING](_PRINTSTRING) for graphical text or font placement.
* **Images are not deallocated when the [SUB](SUB) or [FUNCTION](FUNCTION) they are created in ends. Free them with [_FREEIMAGE](_FREEIMAGE).**
* **It is important to free discarded or unused images with [_FREEIMAGE](_FREEIMAGE) to prevent CPU memory overflow errors.**

## Example(s)

```vb

 SCREEN 13
 a& = _NEWIMAGE(640, 200, 13) ' creates a 640 * 200 image with the LONG handle a&
 _DEST a& ' makes image a& the default drawing output.
 LINE (10, 10)-(100, 100), 12, BF ' draws a filled box (BF) into destination
 _PUTIMAGE (0, 0)-(320, 200), a&, 0, (0, 0)-(320, 200) 

```

> *Explanation:* 

> 1) A graphics mode is set by using [SCREEN (statement)](SCREEN-(statement)) 13 which can use up to 256 colors. 
> 2) A new image is created that is 640 X 200 and uses the palette compatible with SCREEN 13 (256 colors).
> 3) [_DEST](_DEST) a& makes the image with handle 'a&' the default image to draw on instead of the screen (which is [_DEST](_DEST) 0).
> 4) Next a filled box (BF) is drawn from 10, 10 to 100, 100 with red color (12) to the destination image (set by [_DEST](_DEST) a&)
> 5) Now we put the image from 0, 0 to 320, 200 from the image with the handle 'a&' to the screen (always handle 0) and puts this image into the coordinates 0, 0 to 320, 200. If we want to stretch the image we can alter these coordinates.

> **Note:** All arguments are optional. If you want to simply put the whole image of the source to the whole image of the destination then you omit the area (x, y)-(x2, y2) on both sides, the last line of the example can be replaced by [_PUTIMAGE](_PUTIMAGE) , a&, 0 which indeed will stretch the image since image a& is bigger than the screen (the screen is 320 * 200 and a& is 640 * 200)

* You don't need to do anything special to use a .PNG image with alpha/transparency. Here's a simple example:

```vb

SCREEN _NEWIMAGE(640, 480, 32)
CLS , _RGB(0, 255, 0)
i = _LOADIMAGE(**"QB64.PNG"**)
_PUTIMAGE (0, 0), i ' places image at upper left corner of window w/o stretching it 

```

Flipping and enlarging an image with _PUTIMAGE by swapping or increasing the desination coordinates.

```vb

DEFLNG A-Z
dest_handle = _NEWIMAGE(640, 480, 32)
SCREEN dest_handle  '32 bit Screen 12 dimensions
source_handle = _LOADIMAGE(**"QB64.PNG"**, 32)
dx1 = 0: dy1 = 0
dx2 = _WIDTH(source_handle) - 1: dy2 = _HEIGHT(source_handle) - 1 'image dimensions - 1
LOCATE 29, 33: PRINT "Press any Key!";
'normal image coordinate values based on the dimensions of the image:
_PUTIMAGE (dx1, dy1)-(dx2, dy2), source_handle, dest_handle
LOCATE 20, 34: PRINT "Normal layout"
LOCATE 24, 10: PRINT "_PUTIMAGE (dx1, dy1)-(dx2, dy2), source_handle, dest_handle"
K$ = INPUT$(1)
'to flip the image on the x axis, swap the dx coordinate values:
_PUTIMAGE (dx2, dy1)-(dx1, dy2), source_handle, dest_handle
LOCATE 20, 34: PRINT "Flip by X axis"
LOCATE 24, 10: PRINT "_PUTIMAGE (dx2, dy1)-(dx1, dy2), source_handle, dest_handle"
K$ = INPUT$(1)
'to flip image on y axis, swap the dy coordinate values:
_PUTIMAGE (dx1, dy2)-(dx2, dy1), source_handle, dest_handle
LOCATE 20, 34: PRINT "Flip by Y axis"
LOCATE 24, 10: PRINT "_PUTIMAGE (dx1, dy2)-(dx2, dy1), source_handle, dest_handle "
K$ = INPUT$(1)
'to flip both, swap both the dx and dy coordinate values:
_PUTIMAGE (dx2, dy2)-(dx1, dy1), source_handle, dest_handle
LOCATE 20, 34: PRINT "Flip on both axis"
LOCATE 24, 10: PRINT "_PUTIMAGE (dx2, dy2)-(dx1, dy1), source_handle, dest_handle"
K$ = INPUT$(1)
'to enlarge, double the second set of values plus any offset of the first coordinates:
_PUTIMAGE (dx1, dy1)-((2 * dx2) + dx1, (2 * dy2) + dy1), source_handle, dest_handle
LOCATE 20, 34: PRINT "Double image size"
LOCATE 24, 2: 
PRINT "_PUTIMAGE (dx1, dy1)-((2 * dx2) + dx1, (2 * dy2) + dy1), s_handle, d_handle 
END 

```

Using _PUTIMAGE to scroll a larger image created on a separate [_NEWIMAGE](_NEWIMAGE) screen page with QB64.

```vb

RANDOMIZE TIMER
ws& = _NEWIMAGE(2560, 1440, 32) 'large image page
s& = _NEWIMAGE(1280, 720, 32)' program screen

_DEST ws& 'create large image of random filled circles
FOR i = 1 TO 50
    x = RND(1) * 2560
    y = RND(1) * 1440
    clr& = _RGB32(RND(1) * 255, RND(1) * 255, RND(1) * 255)
    CIRCLE (x, y), RND(1) * 300, clr&
    PAINT (x, y), clr&
NEXT
PRINT "This is a demo of some screen scrolling.   Use the number pad keys to scroll.  4 goes left, 6 goes right.  8 up, 2 down. ESC key will close this program."
x = 0: y = 0
SCREEN s&

DO
    CLS
    _PUTIMAGE (0, 0), ws&, 0, (x, y)-(x + 1279, y + 719)
    a$ = INKEY$
    SELECT CASE a$
        CASE "4": x = x - 10: IF x < 0 THEN x = 0
        CASE "6": x = x + 10: IF x > 1280 THEN x = 1280
        CASE "8": y = y - 10: IF y < 0 THEN y = 0
        CASE "2": y = y + 10: IF y > 720 THEN y = 720
        CASE CHR$(27): SYSTEM
    END SELECT
    _DISPLAY
LOOP 

```

_PUTIMAGE can be used with no parameters at all if the [_SOURCE](_SOURCE) and [_DEST](_DEST) are already set.

```vb

SCREEN 13
h& = _NEWIMAGE(640, 480, 256)
_DEST h&
_PRINTSTRING (10, 10), "This _PUTIMAGE used no parameters!"
_SOURCE h&
_DEST 0
_PUTIMAGE
END 

```

### More examples

* [Bitmaps](Bitmaps) (Bitmap Screenshots)
* [SAVEIMAGE](SAVEIMAGE) (Converts Images to Bitmaps)

## See Also

* [_LOADIMAGE](_LOADIMAGE), [_NEWIMAGE](_NEWIMAGE)
* [_COPYIMAGE](_COPYIMAGE), [_SCREENIMAGE](_SCREENIMAGE)
* [_MAPTRIANGLE](_MAPTRIANGLE), [STEP](STEP)
* [_DEST](_DEST), [_SOURCE](_SOURCE), [_FREEIMAGE](_FREEIMAGE)
* [Hardware images](Hardware-images)
