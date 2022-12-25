The [_FONTHEIGHT](_FONTHEIGHT) function returns the font height of a font handle created by [_LOADFONT](_LOADFONT).

## Syntax

> pixelHeight% = [_FONTHEIGHT](_FONTHEIGHT)[(fontHandle&)] 

## Description

* Returns the height of the last font used if a handle is not designated.
* If no font is set it returns the current screen mode's text block height.

## Example(s)

Finding the [_FONT](_FONT) or text block size of printed [STRING](STRING) characters in graphic [SCREEN](SCREEN) modes.

```vb

DO
  INPUT "Enter Screen mode 1, 2 or 7 to 13 or 256, 32 for _NEWIMAGE: ", scr$
  mode% = VAL(scr$)
LOOP UNTIL mode% > 0
SELECT CASE mode%
  CASE 1, 2, 7 TO 13: SCREEN mode%
  CASE 256, 32: SCREEN _NEWIMAGE(800, 600, mode%)
  CASE ELSE: PRINT "Invalid mode selected!": END
END SELECT

INPUT "Enter first name of TTF font to use or hit enter for text block size: ", TTFont$
IF LEN(TTFont$) THEN INPUT "Enter font height: ", hi$
height& = VAL(hi$)
IF height& > 0 THEN
  fnt& = _LOADFONT("C:\Windows\Fonts\" + TTFont$ + ".ttf", height&, style$)
  IF fnt& <= 0 THEN PRINT "Invalid Font handle!": END
  _FONT fnt&
END IF

TextSize wide&, high& 'get the font or current screen mode's text block pixel size

_PRINTSTRING (20, 100), "Block size = " + CHR$(1) + STR$(wide&) + " X" + STR$(high&) + " " + CHR$(2)

END

SUB TextSize (TextWidth&, TextHeight&)
TextWidth& = _PRINTWIDTH("W") 'measure width of one font or text character
TextHeight& = _FONTHEIGHT 'can measure normal text block heights also
END SUB 

```

## See Also

* [_FONTWIDTH](_FONTWIDTH), [_FONT](_FONT)
* [_PRINTWIDTH](_PRINTWIDTH), [_PRINTSTRING](_PRINTSTRING)
* [SCREEN](SCREEN), [_LOADFONT](_LOADFONT)
* [Text Using Graphics](Text-Using-Graphics) (Demo)
