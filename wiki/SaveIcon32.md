The following Icon creation procedure was adapted from Galleon's [SAVEIMAGE](SAVEIMAGE) sup-procedure that creates 8 BPP or 32 bit bitmaps:

**NOTE: QB64 can use .ico files natively for Windows executables with [$EXEICON]($EXEICON).**

```vb

DO
  LINE INPUT "Use 8 bit(256 colors) or 32 bit image? ", bit$
  clrmode% = VAL(bit$)
LOOP UNTIL clrmode% = 8 OR clrmode% = 32
IF clrmode% = 8 THEN clrmode% = 256
LOCATE 10, 10: PRINT "Do you wish to make black transparent? (Y/N) ";
K$ = INPUT$(1): PRINT K$
IF UCASE$(K$) = "Y" THEN mode% = 1
_DELAY 1
SCREEN _NEWIMAGE(640, 480, clrmode%)
DO
  LOCATE 10, 10: LINE INPUT "Enter the icon size to use(multiple of 16): ", sz$
  size& = VAL(sz$)
LOOP UNTIL size& MOD 16 = 0 AND size& >= 16 AND size& <= 128
DO
  LOCATE 10, 10: LINE INPUT "Enter the image file name to convert to an icon: ", BMP$
  CLS
LOOP UNTIL _FILEEXISTS(BMP$)
img& = _LOADIMAGE(BMP$)
IF img& = -1 OR img& = 0 THEN LOCATE 15, 25: PRINT "Image failed to load!": END

IF mode% = 0 THEN CLS , _RGB(255, 255, 255)
IF clrmode% = 256 THEN _COPYPALETTE (img&)
_PUTIMAGE (0, 0)-(size& - 1, size& - 1), img&, 0 '(31, 31), img&, 0  '<<<<<<<<<<<

LOCATE 20, 10: PRINT "Do you want to make an icon out of the image? (Y/N) ";
K$ = INPUT$(1): PRINT K$
IF UCASE$(K$) <> "Y" THEN END
SaveFile$ = LEFT$(BMP$, INSTR(BMP$, ".")) + "ico"
SaveIcon32 img&, size&, mode%, SaveFile$

END 
'             ---------------------------------------------------------

SUB SaveIcon32 (image AS LONG, size AS LONG, mode AS INTEGER, filename AS STRING)
bytesperpixel& = _PIXELSIZE(image&)
IF bytesperpixel& = 0 THEN PRINT "Text modes unsupported!": END
IF bytesperpixel& = 1 THEN bpp& = 8 ELSE bpp& = 24 '256 or 32 bit color
IF size& MOD 16 OR size& < 16 OR size& > 128 THEN PRINT "Size not supported!": END
x& = size& 'supports sizes from 16 to 128 only!
y& = size&
'Headers:   icon    count   width    depth    colors          cursor hotspots  size - offset
b$= MKI$(0)+MKI$(1)+MKI$(1)+CHR$(x&)+CHR$(y&)+CHR$(0)+CHR$(0)+MKI$(0)+MKI$(0)+"????"+MKL$(22) _
 +MKL$(40)+MKL$(x&)+MKL$(2 * y&)+MKI$(1)+MKI$(bpp&)+MKL$(0)+"????" + STRING$(16, 0)
'BMP size  width   double height  plane     BPP             raw size
IF bytesperpixel& = 1 THEN
  FOR c& = 0 TO 255 ' read BGR color settings from image + 1 byte spacer(CHR$(0))
    cv& = _PALETTECOLOR(c&, image&) ' color attribute to read.
    b$ = b$ + CHR$(_BLUE32(cv&)) + CHR$(_GREEN32(cv&)) + CHR$(_RED32(cv&)) + CHR$(0) 'spacer
  NEXT
END IF
lastsource& = _SOURCE
_SOURCE 0 'set source as program screen. Do NOT use loaded image handle as size has changed!
IF ((x& * 3) MOD 4) THEN padder$ = STRING$(4 - ((x& * 3) MOD 4), 0)
FOR py& = y& - 1 TO 0 STEP -1 ' read target image pixel color data
  r$ = ""
  FOR px& = 0 TO x& - 1
    c& = POINT(px&, py&)
    IF bytesperpixel& = 1 THEN r$ = r$ + CHR$(c&) ELSE r$ = r$ + LEFT$(MKL$(c&), 3)
  NEXT px&
  d$ = d$ + r$ + padder$
NEXT py&
IF (x& MOD 32) THEN bitpad& = 32 - (x& MOD 32) 'padder bits when not multiples of 32
IF mode% THEN 'make black pixels white in AND mask so they become transparent
  FOR py& = y& - 1 TO 0 STEP -1 'read image to find black pixels
    px& = 0
    DO: byte% = 0
      FOR bit% = 7 TO 0 STEP -1 'change transparent color to suit your needs
        byte% = 2 * byte% - (POINT(px&, py&) = _RGB(0, 0, 0)) 'bitpacking adds 1 when true
        px& = px& + 1
      NEXT
      a$ = a$ + CHR$(byte%)
    LOOP WHILE px& < x& - 1
    IF bitpad& THEN a$ = a$ + STRING$((bitpad& + 7) \ 8, 0) 'add padder at end of row when necessary
  NEXT
ELSE a$ = STRING$(y& * ((x& + bitpad& + 7) \ 8), 0) 'totally black AND mask
END IF
d$ = d$ + a$
_SOURCE lastsource&
MID$(b$, 43, 4) = MKL$(LEN(d$)) 'raw image size with AND mask
b$ = b$ + d$ ' total file data bytes to create file
MID$(b$, 15, 4) = MKL$(LEN(b$) - 22) ' size of data file minus Entry header offset
IF LCASE$(RIGHT$(filename$, 4)) <> ".ico" THEN ext$ = ".ico"
f& = FREEFILE
OPEN filename$ + ext$ FOR OUTPUT AS #f&: CLOSE #f& ' erases an existing file
OPEN filename$ + ext$ FOR BINARY AS #f&
PUT #f&, , b$
CLOSE #f&
END SUB 

```
<sub>Code by Ted Weissgerber</sub>

> *Explanation:* The icons created can have a full black [AND](AND) mask for a solid square image when mode% is zero. If mode% is a value other than 0, the AND mask routine looks for black pixels and sets the background pixel on for transparency. Icons with dimensions that are not a multiple of 32 would require padding. In the header, ???? is later replaced with size data. If the image is 24/32 BPP, the size of the [XOR](XOR) image data will triple because each pixel uses 3 bytes for red, green and blue values up to 255.

> To create **.CUR** cursor files change the second value from 1 to 2 and set the 2 cursor click hotspot offset [INTEGER](INTEGER) values.

> Icons that are 16 X 16 or 48 X 48 require 2 padder bytes to be added at the end of each row increasing data size by 32 and 96.

## See Also

*[_ICON](_ICON), [$EXEICON]($EXEICON)
*[SAVEIMAGE](SAVEIMAGE)
*[Icons and Cursors](Icons-and-Cursors)
*[Resource Table extraction](Resource-Table-extraction)
*[Bitmaps](Bitmaps)
*[GIF Images](GIF-Images)
