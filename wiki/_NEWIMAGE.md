The [_NEWIMAGE](_NEWIMAGE) function prepares a window image surface and returns the [LONG](LONG) [handle](handle) value.

## Syntax

> handle& = [_NEWIMAGE](_NEWIMAGE)(width&, height&[, {*0*|*1*|*2*|*7*|*8*|*9*|*10*|*11*|*12*|*13*|*256*|*32*}])

## Parameter(s)

* Minimum [LONG](LONG) screen dimensions are width& >= 1, height& >= 1 measured in pixels as [INTEGER](INTEGER) or [LONG](LONG) values.
  * For mode 0 (text), width& and height& are measured in character blocks, not pixels.
* Mode is either a QBasic type [SCREEN](SCREEN) mode (0 to 2 or 7 to 13), 256 colors or 32 bit (16 million colors) compatible.

## Description

* If the mode is omitted, an image will be created with the same BPP mode, font (which may block freeing of that font), palette, selected colors, transparent color, blend state and print method settings as the current [_DEST](_DEST)ination image/[SCREEN](SCREEN) page.
* Valid [LONG](LONG) [handle](handle) returns are less than -1. Invalid handles equal -1 and a zero or positive value is also invalid.
* You can create any sized window (limited by the OS) in any emulated [SCREEN](SCREEN) mode or 32 bit using this function.
* Default text block size in emulated [SCREEN](SCREEN) modes 1, 2, 7, 8 and 13 is 8 X 8; 9 and 10 is 8 X 14; 11, 12, 256 and 32 bit is 8 X 16. The text block pixel size will allow you to calculate the available text rows and columns in a custom sized screen.
* To view the image page, just use [SCREEN](SCREEN) handle&. Even if another procedure changes the screen mode and clears the screen, the image can be restored later by using the same SCREEN handle mode.
* Use the [_COPYIMAGE](_COPYIMAGE) function to preserve a SCREEN handle value when changing to another screen mode to restore it later.
* **32 bit screen surface backgrounds (black) have zero [_ALPHA](_ALPHA) so that they are transparent when placed over other surfaces.**

> Use [CLS](CLS) or [_DONTBLEND](_DONTBLEND) to make a new surface background [_ALPHA](_ALPHA) 255 or opague.

* **Images are not deallocated when the [SUB](SUB) or [FUNCTION](FUNCTION) they are created in ends. Free them with [_FREEIMAGE](_FREEIMAGE).**
* **It is important to free unused or uneeded images with [_FREEIMAGE](_FREEIMAGE) to prevent CPU [ERROR_Codes](ERROR-Codes).**
* **Do not try to free image handles currently being used as the active [SCREEN](SCREEN). Change screen modes first.**

## Example(s)

Shrinking a SCREEN 0 text window's size:

```vb

SCREEN _NEWIMAGE(28, 25, 0) 

```

Creating an 800 by 600 window version of SCREEN 12 with 256 colors (text 37 X 100):

```vb

handle& = _NEWIMAGE(800, 600, 256) 
SCREEN handle& 

```

Setting up a 32 bit SCREEN with _NEWIMAGE for page flipping in QB64.

```vb

SCREEN _NEWIMAGE(640, 480, 32), , 1, 0 

```

> *Note:* [_DISPLAY](_DISPLAY) may be used as a substitute for page flipping or [PCOPY](PCOPY).

Switching between two different SCREEN modes

```vb

_TITLE "Switching SCREEN modes"
SCREEN _NEWIMAGE (800, 600, 256)
mode1& = _DEST               'get current screen mode handle
mode2& = _NEWIMAGE (300, 200, 13)

_DEST mode2&                  'prepare small window
COLOR 10: LOCATE 10, 13: PRINT "mode2& = "; mode2&
COLOR 13: LOCATE 16, 16: PRINT "First"

_DEST mode1&  'work in main window
LOCATE 5
FOR c = 1 TO 248 
   Color c: PRINT c;
NEXT 
COLOR 12: LOCATE 20, 44: PRINT "mode1& = "; mode1&
COLOR 11: LOCATE 30, 34: PRINT "Press a key to goto Pop-up Window"
DO: SLEEP: LOOP UNTIL INKEY$ <> ""

SCREEN mode2&  'switch to small window
DO: SLEEP: LOOP UNTIL INKEY$ <> ""

SCREEN mode1&  'back to main window
COLOR 12: LOCATE 37, 43: PRINT "One more time!"
DO: SLEEP: LOOP UNTIL INKEY$ <> ""

SCREEN mode2&  'back to small window
COLOR 14: LOCATE 16, 16: PRINT "LAST " 

```

> *Explanation:* The [_DEST (function)](_DEST-(function)) function can determine the present screen mode destination handle. The second _NEWIMAGE  handle is created using a SCREEN 13 palette(256 colors also). Each SCREEN is worked on after changing the destination with [_DEST](_DEST) *handle&* statement. Images can be created before viewing them. When a key is pressed the second SCREEN created is displayed and so on. 

> **Legacy SCREEN modes can also return a _DEST value, but the value will create a handle error.** To restore legacy screens get the[_COPYIMAGE](_COPYIMAGE) function value before changing screens. Then restore it using SCREEN oldmode&.

### More examples

* [SAVEIMAGE](SAVEIMAGE) (Bitmap creation)
* [_FILE$](_FILE$) (restoring previous screen)
* [_PIXELSIZE](_PIXELSIZE) (GetImage function example)

## See Also

* [_COPYIMAGE](_COPYIMAGE)
* [_LOADIMAGE](_LOADIMAGE)
* [_FREEIMAGE](_FREEIMAGE)
* [_PUTIMAGE](_PUTIMAGE)
* [_SCREENIMAGE](_SCREENIMAGE)
* [_CLIPBOARDIMAGE (function)](_CLIPBOARDIMAGE-(function))
* [SCREEN](SCREEN)
