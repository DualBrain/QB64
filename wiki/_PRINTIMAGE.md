The [_PRINTIMAGE](_PRINTIMAGE) statement prints a colored image on the printer, stretching it to full paper size first.

## Syntax
 
> [_PRINTIMAGE](_PRINTIMAGE) imageHandle&

* imageHandle& is created by the [_LOADIMAGE](_LOADIMAGE), [_NEWIMAGE](_NEWIMAGE) or [_COPYIMAGE](_COPYIMAGE) functions.
* Use a white background to save ink. `[CLS](CLS) , _RGB(255, 255, 255)` can be used to set the white background in any [SCREEN](SCREEN) mode.
* The image may be stretched disproportionately using normal screen sizes. To compensate, use a [_NEWIMAGE](_NEWIMAGE) screen that is proportional to the paper size. *e.g.* A 640 X 900 SCREEN page is roughly the same as 3 times a 210mm X 297mm paper size.
* [_NEWIMAGE](_NEWIMAGE) or graphic screen pages can use [_PRINTSTRING](_PRINTSTRING) to print different sized text [_FONT](_FONT)s.
* [Keywords currently not supported](Keywords-currently-not-supported-by-QB64)

## Example(s)

Shows how to transfer custom font text on screen pages to the printer in Windows. Change the font path for other OS's.

```vb

PageScale = 10
PageHeight = 297 * PageScale 'A4 paper size is 210 X 297 mm
PageWidth = 210 * PageScale
Page& = _NEWIMAGE(PageWidth, PageHeight, 32)
_DEST Page&: CLS , _RGB(255, 255, 255): _DEST 0  'make background white to save ink!
CursorPosY = 0

'example text to print
PointSize = 12
text$ = "The rain in Spain falls mainly on the plain."
GOSUB PrintText  

PointSize = 50
text$ = "BUT!"
GOSUB PrintText

PointSize = 12
text$ = "In Hartford, Hereford, and Hampshire, hurricanes hardly happen."
GOSUB PrintText

INPUT "Preview (Y/N)?", i$                      'print preview of screen (optional)
IF UCASE$(i$) = "Y" THEN
  Prev& = _NEWIMAGE(600, 900, 32)               'print preview smaller image
  _PUTIMAGE Page&, Prev&
  SCREEN Prev&
  DO: LOOP UNTIL INKEY$ <> ""
  SCREEN 0
END IF

INPUT "Print on printer (Y/N)?", i$             'print screen page on printer
IF UCASE$(i$) = "Y" THEN
  _PRINTIMAGE Page&
END IF

END

PrintText:
FontHeight = INT(PointSize * 0.3527 * PageScale)
FontHandle = _LOADFONT("c:\windows\fonts\times.ttf", FontHeight)
_DEST Page&
_FONT FontHandle
COLOR _RGB(255, 0, 0), _RGBA(0, 0, 0, 0)        'RED text on clear black background
_PRINTSTRING (0, CursorPosY), text$
_FONT 16                               'change to the QB64 default font to free it
_FREEFONT FontHandle
_DEST 0
CursorPosY = CursorPosY + FontHeight            'adjust print position down 
RETURN 

```

> *Explanation:* CLS with the color white makes sure that the background is not printed a color. The PrintText [GOSUB](GOSUB) sets the [COLOR](COLOR) of the text to red with a transparent background using [_RGBA](_RGBA) to set the [_ALPHA](_ALPHA) transparency to zero or clear black.

Printing an old SCREEN 12 [ASCII](ASCII) table using a deeper sized page to prevent stretching by [_PRINTIMAGE](_PRINTIMAGE).

```vb

_TITLE "Print Preview ASCII Table"
SCREEN _NEWIMAGE(640, 900, 256)  'size is proportional to 210mm X 297mm(8-1/2 X 11) paper

OUT &H3C8, 0: OUT &H3C9, 63: OUT &H3C9, 63: OUT &H3C9, 63 'white background saves ink! 

Align 8, 2, "ASCII and Extended Character Code Table using CHR$(n%)"
PRINT STRING$(80, 223)
COLOR 40 
PRINT " ";
FOR i% = 0 TO 13
  PRINT i%;: SetCHR CSRLIN, POS(0), 40, i%
  LOCATE CSRLIN, POS(0) + 1
NEXT i%
FOR i% = 14 TO 16
  PRINT i%; CHR$(i%);
NEXT
LOCATE CSRLIN + 1, 2
FOR i = 17 TO 27
  PRINT i; CHR$(i);
NEXT
FOR i% = 28 TO 31
  PRINT i%;: SetCHR CSRLIN, POS(0), 40, i%
  LOCATE CSRLIN, POS(0) + 1
NEXT i%
LOCATE CSRLIN + 1, 2
COLOR 2: PRINT 32; CHR$(32);
FOR i% = 33 TO 255
  SELECT CASE i%
    CASE 45, 58, 71, 84: LOCATE CSRLIN + 1, 1
    CASE IS > 96: IF (i% - 97) MOD 11 = 0 THEN LOCATE CSRLIN + 1, 1
  END SELECT
  SELECT CASE i%
    CASE 48 TO 57: COLOR 9 'denotes number keys 48 to 57
    CASE 65 TO 90: COLOR 5 ' A to Z keys 65 to 90
    CASE 97 TO 122: COLOR 36 'a to z keys 97 to 122
    CASE 127 TO 175: COLOR 42
    CASE 176 TO 223: COLOR 6 'drawing characters 176 to 223
    CASE IS > 223: COLOR 42
    CASE ELSE: COLOR 2
  END SELECT
  IF i% = 98 OR i% = 99 OR i% = 100 THEN PRINT SPACE$(1);
  PRINT " "; i%; CHR$(i%);
NEXT i%
COLOR 3: PRINT "= NBSP(Non-Breaking Space)"
COLOR 8: PRINT STRING$(80, CHR$(220))
Border 8
COLOR 4: LOCATE 27, 4: PRINT "7) BELL, 8) Backspace, 9) Tab, 10) LineFeed(printer), 12) FormFeed(printer)"
LOCATE 28, 4: PRINT "  13) Return, 26) End Of File, 27) Escape  30) Line up, 31) Line down "

Align 13, 29, "Press Ctrl + P to PRINT!"

DO: SLEEP: K$ = INKEY$: LOOP UNTIL K$ <> ""
Align 13, 29, SPACE$(50)
IF K$ = CHR$(16) THEN
  _PRINTIMAGE 0              '<<<<<<<<<<<< to PRINTER
  Align 11, 29, "Use the ASCII Table for a reference of the codes!"
  SOUND 700, 4
END IF
K$ = INPUT$(1)
SYSTEM

SUB Align (Tclr, Trow, txt$)
Tcol = 41 - (LEN(txt$) \ 2)
COLOR Tclr: LOCATE Trow, Tcol: PRINT txt$;
END SUB

SUB Border (clr%)
COLOR clr%
FOR row = 1 TO 30
  LOCATE row, 1: PRINT CHR$(179);
  LOCATE row, 80: PRINT CHR$(179);
NEXT row
LOCATE 1, 1: PRINT STRING$(80, 196);
LOCATE 30, 1: PRINT STRING$(80, 196);
LOCATE 1, 1: PRINT CHR$(218);
LOCATE 1, 80: PRINT CHR$(191);
LOCATE 30, 1: PRINT CHR$(192);
LOCATE 30, 80: PRINT CHR$(217);
END SUB

SUB SetCHR (Trow, Tcol, FG, ASCode)
Srow = 16 * (Trow - 1): Scol = 8 * (Tcol - 1) 'convert text to graphic coordinates
COLOR FG: _PRINTSTRING (Scol, Srow), CHR$(ASCode)
END SUB 

```

> *Explanation:* The [ASCII](ASCII) character table was originally made in [SCREEN](SCREEN) 12 (640 X 480) and was adapted to 256 colors.

## See Also

* [_LOADIMAGE](_LOADIMAGE), [_NEWIMAGE](_NEWIMAGE)
* [_COPYIMAGE](_COPYIMAGE)
* [LPRINT](LPRINT)
* [Windows Printer Settings](Windows-Printer-Settings)
