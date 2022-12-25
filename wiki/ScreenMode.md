**Screen Mode Detection Function**

```vb

DO
  PRINT
  PRINT
  PRINT "  Screen    W      H     Colors "
  PRINT "    0     80/40   (25)     16 "
  PRINT "    1     (320)  (200)      4 "
  PRINT "    2     (640)   200       2 "
  PRINT "    ........................  "
  PRINT "    7      320    200      16 "
  PRINT "    8      640    200      16 "
  PRINT "    9     (640)   350      16 "
  PRINT "   10     (640)   350       4 "
  PRINT "   11     (640)   480       2 "
  PRINT "   12     (640)   480      16 "
  PRINT "   13      320    200     256 "
  PRINT "  QB64 _NEWIMAGE screens      "
  PRINT "   14     (600, 600, 32)   32 bit"
  PRINT "   15     (800, 600, 256) 256 "
  PRINT "   16     (900, 600, 13)  256 " 'simulate screen 13
  PRINT "   17     (900, 600, 10)    4 " 'simulate screen 10
  PRINT
  PRINT "SCREEN ="; scr&; "mode ="; ScreenMode&; "Colors ="; colors
  PRINT "_DEST ="; _DEST

  IF ScreenMode& THEN CIRCLE (200, 100), 50, 3
  INPUT "Enter a SCREEN mode 0 to 17(18 quits): ", scrn$

  scr& = VAL(scrn$)
  IF (scr& < 3 OR scr& > 6) AND scr& < 14 THEN SCREEN scr&
  IF scr& = 14 THEN handle& = _NEWIMAGE(600, 600, 32): SCREEN handle&
  IF scr& = 15 THEN handle& = _NEWIMAGE(800, 600, 256): SCREEN handle&
  IF scr& = 16 THEN handle& = _NEWIMAGE(900, 600, 13): SCREEN handle&
  IF scr& = 17 THEN handle& = _NEWIMAGE(900, 600, 10): SCREEN handle&

LOOP UNTIL scr& > 17

FUNCTION ScreenMode&
SHARED colors 'share number of colors with main program
mode& = -1
_DEST 0 'destination zero always current screen mode
OUT &H3C7, 1 'set attribute to read
FOR colors = 1 TO 18 'get RGB color settings
  red = INP(&H3C9): grn = INP(&H3C9): blu = INP(&H3C9)
  IF red + grn + blu = 0 AND colors <> 16 THEN EXIT FOR
NEXT
wide& = _WIDTH: deep& = _HEIGHT 'get screen dimension
IF colors = 4 THEN mode& = 1
IF colors = 2 AND deep& = 200 THEN mode& = 2
IF colors = 17 AND wide& = 320 AND deep& = 200 THEN mode& = 7
IF colors = 17 AND wide& = 640 AND deep& = 200 THEN mode& = 8
IF colors = 17 AND deep& = 350 THEN mode& = 9
IF colors = 1 AND wide& = 640 AND deep& = 350 THEN mode& = 10
IF colors = 2 AND deep& = 480 THEN mode& = 11
IF colors = 17 AND deep& = 480 THEN mode& = 12
IF colors > 17 AND wide& = 320 AND deep& = 200 THEN mode& = 13
IF _PIXELSIZE = 0 THEN mode& = 0 'screen 0 any size
IF mode& = -1 THEN mode& = _DEST 'must be a QB64 screen
IF colors = 1 THEN colors = 4
IF colors = 17 THEN colors = 16
IF colors > 17 THEN colors = 256
IF _PIXELSIZE = 4 THEN colors = 32
ScreenMode& = mode&
END FUNCTION 

```
<sub>Code by Ted Weissgerber</sub>

> *Note:* Function returns the negative handle value with up to 256 colors or 32 for 32 bit in QB64 [_NEWIMAGE](_NEWIMAGE) screens.

## See Also

* [SCREEN](SCREEN)
* [SCREEN (function)](SCREEN-(function))
* [_NEWIMAGE](_NEWIMAGE)
* [_PIXELSIZE](_PIXELSIZE)
