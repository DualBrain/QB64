The [_FREEFONT](_FREEFONT) statement frees a font handle that was created by [_LOADFONT](_LOADFONT).

## Syntax

> [_FREEFONT](_FREEFONT) (fontHandle&)

## Description

* Unloads fonts that are no longer in use or needed in order to free program memory and resources.
* You cannot free a font which is in use. Change the font to a QB64 default font size before freeing the handle (see example below).
* Predefined **QB64** font handle numbers can be used before freeing a font:
  * **_FONT 8** - default font for [SCREEN (statement)](SCREEN-(statement)) 1, 2, 7, 8 or 13
  * **_FONT 14** - default font for [SCREEN (statement)](SCREEN-(statement)) 9 or 10
  * **_FONT 16** - default font for [SCREEN (statement)](SCREEN-(statement)) 0 ([WIDTH](WIDTH) 80, 25 text only), 11 or 12
  * **_FONT 9, 15** and **17** are the double width versions of 8, 14 and 16 respectively in text **SCREEN 0**.
* If the font handle is invalid (equals -1 or 0), an [ERROR Codes](ERROR-Codes) will occur. **Check handle values before using or freeing them.**
* You cannot free inbuilt/default QB64 fonts nor do they ever need freed. 

## Example(s)

Previews and creates a file list of valid MONOSPACE TTF fonts by checking the [_LOADFONT](_LOADFONT) handle values.

```vb

SCREEN 12
path$ = "C:\WINDOWS\Fonts\"                  'path to the font folder
SHELL _HIDE "DIR /b " + path$ + "\*.ttf > TTFonts.INF"  
style$ = "monospace"                         'set style to MONOSPACE
OPEN "TTFonts.INF" FOR INPUT AS #1           'list of TTF fonts only
OPEN "TTFMono.INF" FOR OUTPUT AS #2          'will hold list of valid MONOSPACE fonts

DO UNTIL EOF(1): found = found + 1
  LINE INPUT #1, font$          
  f& =_LOADFONT(path$ + font$, 30, style$)   
  IF f& > 0 THEN                  'check for valid handle values > 0
    OK = OK + 1
    PRINT #2, font$
    _FONT f&                      'will create error if handle is invalid!
    PRINT "Hello World!"    
    PRINT: PRINT: PRINT font$; f& 
    PRINT "Press any key."   
    K$ = INPUT$(1)
    _FONT 16                      'use QB64 default font to free tested font
    _FREEFONT f&                  'returns an error if handle <= 0! 
    CLS  
  END IF     
  PRINT
IF K$ = CHR$(27) THEN EXIT DO
LOOP
CLOSE
PRINT: PRINT: PRINT "Found"; found; "TTF files,"; OK; "can use Monospace,"
END 

```

```text

Found 106 TTF files, 13 can use Monospace.

```

Using a _FREEFONT sub-procedure. 

```vb

fontpath$ = ENVIRON$("SYSTEMROOT") + "\fonts\lucon.ttf" 
style$ = "MONOSPACE, ITALIC, BOLD"
fontsize% = 20

_FONT 16
PRINT
PRINT "This is the QB64 default _FONT 16! To change, press any key!"
DO: SLEEP: LOOP UNTIL INKEY$ <> ""

GOSUB ClearFont  'call will not free anything if font& = 0

font& = _LOADFONT(fontpath$, fontsize%, style$)
IF font > 0 THEN _FONT font&  'NEVER try to load a font value less than 1!
PRINT
PRINT "A NEW _FONT style. To change to default, press any key!"
DO: SLEEP: LOOP UNTIL INKEY$ <> ""

GOSUB ClearFont  'call will free a valid font handle from memory

END

ClearFont: 
IF font& > 0 THEN
    _FONT 16   'change used font to the QB64 8x16 default font
    _FREEFONT font&
    PRINT: PRINT "The previous font was freed with _FREEFONT!"
ELSE : PRINT: PRINT "_FREEFONT was not used!"
END IF
RETURN 

```

## See Also

* [_FONT](_FONT)
* [_LOADFONT](_LOADFONT)
