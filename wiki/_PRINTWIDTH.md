The [_PRINTWIDTH](_PRINTWIDTH) function returns the width in pixels of the text [STRING](STRING) specified.

## Syntax

> pixelWidth% = [_PRINTWIDTH](_PRINTWIDTH)(textToPrint$[, destinationHandle&])

## Description

* textToPrint$ is any literal or variable [STRING](STRING) value.
* If the destinationHandle& is omitted, the current destination image or screen page is used.
* Useful to find the width of the font print [STRING](STRING) before actually printing it.
* Can be used with variable-width fonts or built-in fonts, unlike [_FONTWIDTH](_FONTWIDTH) which requires a MONOSPACE font handle.
* In SCREEN 0, _PRINTWIDTH returns the character length of a text string, exactly as [LEN](LEN)(textToPrint$) (**version 1.000 and up**).

## Example(s)

SUB returns font or screen mode's text block size using _PRINTWIDTH and [_FONTHEIGHT](_FONTHEIGHT) without a handle parameter.

```vb

DO
  INPUT "Enter Screen mode 1, 2 or 7 to 13: ", scr$
  mode% = VAL(scr$)
LOOP UNTIL mode% > 0 
SCREEN mode%
INPUT "Enter first name of TTF font to use or hit enter for text size: ", TTFont$
IF LEN(TTFont$) THEN INPUT "Enter font height: ", hi$
height& = VAL(hi$)
IF height& > 0 THEN _FONT _LOADFONT("C:\Windows\Fonts\" + TTFont$ + ".ttf", height&, style$)

TextSize wide&, high&       'get the font or current screen mode's text block pixel size

_PRINTSTRING (20, 100), CHR$(1) + STR$(wide&) + " X" + STR$(high&) + " " + CHR$(2)

END

SUB TextSize (TextWidth&, TextHeight&)
TextWidth& = _PRINTWIDTH("W")     'measure width of one font or text character
TextHeight& = _FONTHEIGHT         'can measure normal text block heights also   
END SUB 

```

**Note:** The SUB procedure does not need the font handle for font sizes after [_FONT](_FONT) enables one.

## See Also

* [_FONTWIDTH](_FONTWIDTH), [_FONTHEIGHT](_FONTHEIGHT)
* [_NEWIMAGE](_NEWIMAGE), [_LOADFONT](_LOADFONT)
* [_PRINTSTRING](_PRINTSTRING), [_FONT](_FONT)
* [Text Using Graphics](Text-Using-Graphics)
