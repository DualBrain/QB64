The **POINT** function returns the pixel [COLOR](COLOR) attribute at a specified graphics coordinate or the current graphic cursor position.

## Syntax

*Color* 

> color_attribute% = **POINT (***column%, row%***)**

*Graphic cursor position*
 
> pointer_coordinate% = **POINT(**{0|1|2|3}**)**

## Parameter(s)

Graphic Color syntax:

* The [INTEGER](INTEGER) *column* and *row* coordinates designate the pixel position color on the screen to read.
* The return value is an [INTEGER](INTEGER) palette attribute value or an [_UNSIGNED](_UNSIGNED) [LONG](LONG) [_RGBA](_RGBA) 32 bit value in QB64.

Graphic cursor position syntax: 

* The [INTEGER](INTEGER) position number can be 0 to 3 depending on the cursor position desired:
  * POINT(0) returns the current graphic cursor [SCREEN](SCREEN) column pixel coordinate.
  * POINT(1) returns the current graphic cursor [SCREEN](SCREEN) row pixel coordinate.
  * POINT(2) returns the current graphic cursor [WINDOW](WINDOW) column position.
  * POINT(3) returns the current graphic cursor [WINDOW](WINDOW) row position.
* If a [WINDOW](WINDOW) view port has not been established, the coordinate returned will be the [SCREEN](SCREEN) cursor pixel position.
* The return value is the current graphic cursor *column* or *row* pixel position on the [SCREEN](SCREEN) or [WINDOW](WINDOW).
* Graphic cursor positions returned will be the last ones used in a graphic shape such as a [CIRCLE](CIRCLE) center point.

## Usage

* Use **[_SOURCE](_SOURCE)** first to set the image handle that POINT should read or QB64 will assume the current source image.
> **_SOURCE 0** 'sets POINT to read the current SCREEN image after reading a previous source image
* **POINT cannot be used in SCREEN 0!** Use the [SCREEN (function)](SCREEN-(function)) function to point text character codes and colors in SCREEN 0.

**POINT in QBasic Legacy Graphic SCREEN Modes:**

* The [INTEGER](INTEGER) color attributes returned are limited by the number of colors in the legacy SCREEN mode used.
* *Column* and *row* [INTEGER](INTEGER) parameters denote the graphic pixel coordinate to read.
* In **QB64** the offscreen or off image value returned is -1. Use IF POINT(x, y) <> -1 THEN...
* In QBasic the coordinates MUST be on the screen or an [ERROR Codes](ERROR-Codes) will occur. 

**POINT in QB64 32 Bit Graphic [_NEWIMAGE](_NEWIMAGE) or [_LOADIMAGE](_LOADIMAGE) Modes:**

* Returns [_UNSIGNED](_UNSIGNED) [LONG](LONG) 32 bit color values. Use [_UNSIGNED](_UNSIGNED) values when you don't want negative values.
* **[_UNSIGNED](_UNSIGNED) [LONG](LONG) variables should be used when comparing POINT returns with [_RGB](_RGB) or [_RGB32](_RGB32) [_ALPHA](_ALPHA) bit values**
* Convert 32 bit color values to RGB intensities(0 to 255) using the [_RED32](_RED32), [_GREEN32](_GREEN32) and [_BLUE32](_BLUE32) functions.
* To convert color intensities to OUT &H3C9 color port palette intensity values divide the values of 0 to 255 by 4.
* Use the [_PALETTECOLOR (function)](_PALETTECOLOR-(function)) to convert color port palette intensities in 32 bit modes.

## Example(s)

How [_RGB](_RGB) 32 bit values return [DOUBLE](DOUBLE) or [_UNSIGNED](_UNSIGNED) [LONG](LONG) values in QB64.

```vb

DIM clr AS LONG 'DO NOT use LONG in older versions of QB64 (V .936 down)
SCREEN _NEWIMAGE(640, 480, 32)
CLS , _RGB(255, 255, 255)  'makes the background opaque white

PRINT "POINT(100, 100) ="; POINT(100, 100)
clr = POINT(100, 100)
PRINT "Variable clr = ";  clr
IF clr = _RGB(255, 255, 255) THEN PRINT "Long OK"
IF POINT(100, 100) = _RGB(255, 255, 255) THEN PRINT "_RGB OK"
IF POINT(100, 100) = clr THEN PRINT "Type OK" 'will not print with a LONG variable type

```

> **Note:** Change the DIM *clr* variable type to [LONG](LONG) to see how the last IF statement doesn't PRINT as shown in the output below:

```text

POINT(100, 100) = 4294967295
Variable clr = -1
Long OK
_RGB OK

```

Using a POINT mouse routine to get the 32 bit color values of an image.

```vb

SCREEN _NEWIMAGE(640, 480, 32)
_TITLE "Mouse POINTer 32"

'LINE INPUT "Enter an image file: ", image$  'use quotes around file names with spaces
image$ = "QB64bee.png" 'up to 320 X 240 with current _PUTIMAGE settings
i& = _LOADIMAGE(image$, 32)
IF i& >= -1 THEN BEEP: PRINT "Could NOT load image!": END
w& = _WIDTH(i&): h& = _HEIGHT(i&)

PRINT "Make background transparent?(Y\N)";
BG$ = UCASE$(INPUT$(1))
PRINT BG$
_DELAY 1

'CLS 'commented to keep background alpha 0

IF BG$ = "Y" THEN _CLEARCOLOR _RGB32(255, 255, 255), i& 'make white Background transparent
_PUTIMAGE (320 - w&, 240 - h&)-((2 * w&) + (320 - w&), (2 * h&) + (240 - h&)), i&, 0
_FREEIMAGE i&

_MOUSEMOVE 320, 240 'center mouse pointer on screen

DO: _LIMIT 100
  DO WHILE _MOUSEINPUT
    mx = _MOUSEX
    my = _MOUSEY
    c& = POINT(mx, my)
    r = _RED32(c&)
    g = _GREEN32(c&)
    b = _BLUE32(c&)
    a = _ALPHA32(c&)
    LOCATE 1, 1: PRINT mx; my, "R:"; r, "G:"; g, "B:"; b, "A:"; a; "  "
    LOCATE 2, 2: PRINT "HTML Color: &H" + RIGHT$(HEX$(c&), 6)
  LOOP
LOOP UNTIL INKEY$ > ""
END 

```

> *Explanation:* Use the mouse pointer to get the background RGB of the image to make it transparent with [_CLEARCOLOR](_CLEARCOLOR).

Creating an image mask to PUT an image over other colored backgrounds. See: [GET and PUT Demo](GET-and-PUT-Demo) to run code.

```vb

 FOR c = 0 TO 59    '60 X 60 area from 0 pixel
   FOR r = 0 TO 59
    IF POINT(c, r) = 0 THEN PSET (c, r), 15 ELSE PSET (c, r), 0
   NEXT r
 NEXT c
 GET(0, 0)-(60, 60), Image(1500) ' save mask in an array(indexed above original image).

```

> *Explanation:* In the procedure all black areas(background) are changed to white for a PUT using AND over other colored objects. The other image colors are changed to black for a PUT of the original image using XOR. The array images can be BSAVEd for later use. **QB64 can also** [PUT](PUT)** a full screen 12 image from an array directly into a** [BINARY](BINARY) **file.**

## See Example(s)

* [SAVEIMAGE](SAVEIMAGE) (QB64 Image to Bitmap SUB by Galleon)
* [Program ScreenShots](Program-ScreenShots) (Member program for legacy screen modes)
* [ThirtyTwoBit SUB](ThirtyTwoBit-SUB) (QB64 Image area to bitmap)
* [ThirtyTwoBit MEM SUB](ThirtyTwoBit-MEM-SUB) (Fast image area to Bitmap using [_MEM](_MEM))

## See Also
 
* [_NEWIMAGE](_NEWIMAGE), [_LOADIMAGE](_LOADIMAGE) (see 32 bit modes)
* [_MEMIMAGE](_MEMIMAGE), [_MEMGET](_MEMGET)
* [PSET](PSET), [PRESET](PRESET)
* [SCREEN](SCREEN), [SCREEN (function)](SCREEN-(function)) (text pointer function)
* [GET (graphics statement)](GET-(graphics-statement)), [PUT (graphics statement)](PUT-(graphics-statement))
* [Bitmaps](Bitmaps), [Creating Sprite Masks](Creating-Sprite-Masks), [Text Using Graphics](Text-Using-Graphics) (Demo)
