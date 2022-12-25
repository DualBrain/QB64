The [_FONT](_FONT) statement sets the current [_LOADFONT](_LOADFONT) function font handle to be used by [PRINT](PRINT). 

## Syntax

> [_FONT](_FONT) fontHandle&[, imageHandle&]

## Parameter(s)

* fontHandle& is the handle retrieved from [_LOADFONT](_LOADFONT) function, the [_FONT (function)](_FONT-(function)) function, or a predefined handle.
* If the image handle is omitted the current image [_DEST](_DEST)ination is used. Zero can designate the current program [SCREEN](SCREEN).

## Description

* Predefined **QB64** font handle numbers can be used before freeing a font:
  * **_FONT 8** - default font for [SCREEN (statement)](SCREEN-(statement)) 1, 2, 7, 8 or 13
  * **_FONT 14** - default font for [SCREEN (statement)](SCREEN-(statement)) 9 or 10
  * **_FONT 16** - default font for [SCREEN (statement)](SCREEN-(statement)) 0 ([WIDTH](WIDTH) 80, 25 text only), 11 or 12
  * **_FONT 9, 15** and **17** are the double width versions of 8, 14 and 16 respectively in text **SCREEN 0 only**.
* [Unicode](Unicode) characters can be assigned to a monospace font that contains those unicode characters using the [_MAPUNICODE](_MAPUNICODE) TO [ASCII](ASCII) mapping statement. The optional **IME cyberbit.ttf** font included with QB64 can also be used.
* Can alpha blend a font with a background screen created by [_NEWIMAGE](_NEWIMAGE) in 32 bit color.
* **Check for valid handle values greater than 0 before using or freeing font handles.**
* Free **unused** font handles with [_FREEFONT](_FREEFONT). Freeing invalid handles will create an [ERROR Codes](ERROR-Codes) error.
* **NOTE: SCREEN 0 can only use one font type and style per viewed SCREEN page. Font size may also affect the window size.**

## Example(s)

Previewing a font in SCREEN 0. A different true type font can be substituted below. 

```vb

fontpath$ = ENVIRON$("SYSTEMROOT") + "\fonts\lucon.ttf" 'Find Windows Folder Path.
DO: CLS
  DO
    style$ = "MONOSPACE"
    PRINT
    INPUT "Enter A FONT Size 8 TO 25: ", fontsize%
  LOOP UNTIL fontsize% > 7 and fontsize% < 26
  DO
    PRINT
    INPUT "Enter (0) for REGULAR OR (1) for ITALIC FONT: ", italic%
  LOOP UNTIL italic% = 0 or italic% = 1
  DO
    PRINT
    INPUT "Enter (0) for REGULAR OR (1) for BOLD FONT: ", bold%
  LOOP UNTIL italic% = 0 or italic% = 1
  IF italic% = 1 THEN style$ = style$ + ", ITALIC"
  IF bold% = 1 then style$ = style$ + ", BOLD"

  GOSUB ClearFont
  font& = _LOADFONT(fontpath$, fontsize%, style$)
  _FONT font&  
  PRINT
  PRINT "This is your LUCON font! Want to try another STYLE?(Y/N): "; 
  DO: SLEEP: K$ = UCASE$(INKEY$): LOOP UNTIL K$ = "Y" OR K$ = "N"
LOOP UNTIL K$ = "N"
GOSUB ClearFont

PRINT "This is the QB64 default _FONT 16!"
END

ClearFont: 
IF font& > 0 THEN
    _FONT 16   'select inbuilt 8x16 default font
    _FREEFONT font&
END IF
RETURN

```

**NOTE:** [ENVIRON$](ENVIRON$)("SYSTEMROOT") returns a string value of: "C:\WINDOWS". Add the "\FONTS\" folder and the **.TTF** font file name.

## See Also

* [_FONT (function)](_FONT-(function))
* [_LOADFONT](_LOADFONT), [_FREEFONT](_FREEFONT)
* [Unicode](Unicode), [_MAPUNICODE](_MAPUNICODE)
* [Windows Libraries](Windows-Libraries)
