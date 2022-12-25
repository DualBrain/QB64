The [_PRINTSTRING](_PRINTSTRING) statement prints text [STRING](STRING) using graphic column and row coordinate positions.

## Syntax

> [_PRINTSTRING](_PRINTSTRING)(column, row), textExpression$[, imageHandle&] 

## Parameter(s)

* column and row are [INTEGER](INTEGER) or [LONG](LONG) starting PIXEL (graphic) column and row coordinates to set text or custom fonts.
* textExpression$ is any literal or variable [STRING](STRING) value of text to be displayed.
* imageHandle& is the optional image or destination to use. Zero designates current [SCREEN (statement)](SCREEN-(statement)) page.

## Description

* The starting coordinate sets the top left corner of the text to be printed. Use [_FONTHEIGHT](_FONTHEIGHT) to calculate that text or [_FONT](_FONT) position
* The [_FONT](_FONT) size can affect the [SCREEN (statement)](SCREEN-(statement)) and row heights.
  * Custom fonts are not required. [_PRINTSTRING](_PRINTSTRING) can print all [ASCII](ASCII) characters.
* [_PRINTWIDTH](_PRINTWIDTH) can be used to determine how wide a text print will be so that the screen width is not exceeded.
* If the imageHandle& is omitted, the current image, page or screen destination is used.
* Can use the current font alpha blending with a designated image background. See the [_RGBA](_RGBA) function example.
* Use the [_PRINTMODE](_PRINTMODE) statement before printing to set how the background is rendered.
  * Use the [_PRINTMODE (function)](_PRINTMODE-(function)) to find the current _PRINTMODE setting.
* In SCREEN 0 (text only), [_PRINTSTRING](_PRINTSTRING) works as one-line replacement for **LOCATE x, y: PRINT text$**, without changing the current cursor position.

## Availability

* In versions of QB64 prior to 1.000 _PRINTSTRING can only be used in graphic, 256 color or 32 bit screen modes, not SCREEN 0.*

## Example(s)

Printing those unprintable [ASCII](ASCII) control characters is no longer a problem.

```vb

SCREEN _NEWIMAGE(800, 600, 256)

FOR code = 0 TO 31
  chrstr$ = chrstr$ + CHR$(code) + SPACE$(1)
NEXT

_FONT _LOADFONT("C:\Windows\Fonts\Cour.ttf", 20, "MONOSPACE") 'select monospace font

_PRINTSTRING (0, 16), chrstr$

END 

```

```text

  ☺ ☻ ♥ ♦ ♣ ♠ • ◘ ○ ◙ ♂ ♀ ♪ ♫ ☼ ► ◄ ↕ ‼ ¶ § ▬ ↨ ↑ ↓ → ← ∟ ↔ ▲ ▼

```

Making any **QB64 program window** larger using a SUB that easily converts PRINT to [_PRINTSTRING](_PRINTSTRING). 

```vb

Scr13& = _NEWIMAGE(320, 200, 13)  'this is the old SCREEN 13 image page to set the image
Big13& = _NEWIMAGE(640, 480, 256) 'use 4 X 3 aspect ratio that QBasic used when full screen

SCREEN Big13&
_DEST Scr13&
image1& = _LOADIMAGE("Howie.BMP", 256)
image2& = _LOADIMAGE("Howie2.BMP", 256)
_PUTIMAGE (10, 20), image1&, Scr13&
_PUTIMAGE (160, 20), image2&, Scr13&
_COPYPALETTE image1&, Scr13&
COLOR 151: LOCATE 2, 4: PRINTS "Screen 13 Height Reduction to 83%" 
LOCATE 22, 22: PRINTS CHR$(24) + " 4 X 3 Proportion"  'use concatenation
LOCATE 24, 21: PRINTS CHR$(27) + " Stretched at 100%" 'instead of a semicolon!
_COPYPALETTE Scr13&, Big13&  'required when imported image colors are used
_PUTIMAGE , Scr13&, Big13&   'stretches the screen to double the size
K$ = INPUT$(1)
END

SUB PRINTS (Text$)
row% = (CSRLIN - 1) * _FONTHEIGHT      'finds current screen page text or font row height
col% = (POS(0) - 1) * _PRINTWIDTH("W") 'finds current page text or font column width
_PRINTSTRING (col%, row%), Text$
END SUB 

```

> *Explanation:* The procedure above creates a larger version of a SCREEN 13 window by stretching it with [_PUTIMAGE](_PUTIMAGE). It cannot stretch PRINTed text so [_PRINTSTRING](_PRINTSTRING) must be used instead. [LOCATE](LOCATE) sets the PRINT cursor position for [CSRLIN](CSRLIN) and [POS](POS)(0) to read. The SUB then converts the coordinates to graphical ones. Then **change** [PRINT](PRINT) to PRINTS using the IDE **Search Menu**.
[Download of Example 2 Bitmap images](https://www.dropbox.com/s/tcdik1ajegbeiz4/HOWIE.zip?dl=0)

Rotating a text string around a graphic object.

```vb

SCREEN 12 
DIM row AS INTEGER, cnt AS INTEGER, cstart AS SINGLE, cend AS SINGLE
DIM xrot AS INTEGER, yrot AS INTEGER, scale AS INTEGER
' _FULLSCREEN                       'full screen optional
cstart = 0: cend = 8 * ATN(1)
xrot = 6: yrot = 60: scale = 4 
row = 1
CIRCLE (320, 240), 15, 9: PAINT STEP(0, 0), 9
DO
  FOR i = cstart TO cend STEP .04
    x = 300 + (scale * 40 - (row * xrot)) * COS(i)
    y = 200 + (scale * 40 - (row * yrot)) * SIN(i)
    cnt = cnt + 1
    COLOR 7: _PRINTSTRING (x, y), "HELLO WORLD!", 0  'display 
    IF cnt = LEN(text$) * 8 THEN cnt = 0: EXIT DO
    _DISPLAY
    COLOR 0: _PRINTSTRING (x, y), "HELLO WORLD!", 0  'erase 
    _DELAY 0.02    
  NEXT
LOOP UNTIL INKEY$ = CHR$(27) 'escape key exit
COLOR 15 
END 

```

## See Also

* [_NEWIMAGE](_NEWIMAGE), [_PRINTWIDTH](_PRINTWIDTH), [_PRINTMODE](_PRINTMODE)
* [_CONTROLCHR](_CONTROLCHR) (turns [ASCII](ASCII) control characters OFF or ON)
* [_FONT](_FONT), [_LOADFONT](_LOADFONT), [_FONTHEIGHT](_FONTHEIGHT), [_FONTWIDTH](_FONTWIDTH)
* [_SCREENIMAGE](_SCREENIMAGE), [_SCREENPRINT](_SCREENPRINT)
* [Text Using Graphics](Text-Using-Graphics)
