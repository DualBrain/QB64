The [_MOUSEY](_MOUSEY) function returns the current vertical (row) mouse cursor position when read after [_MOUSEINPUT](_MOUSEINPUT).

## Syntax

> pixelRow% = [_MOUSEY](_MOUSEY)

## Description

* [SCREEN](SCREEN) 0 returns the [INTEGER](INTEGER) vertical text row position (from build 20170817/62 onward); older versions return a [SINGLE](SINGLE) vertical text row position. Use [INTEGER](INTEGER) variables to avoid floating decimal returns.
* Graphic screen modes 1, 2 and 7 to 13 and [_NEWIMAGE](_NEWIMAGE) 32 bit return the [INTEGER](INTEGER) pixel columns.
* To calculate text rows in graphic modes divide the return by 16 or the [_FONTHEIGHT](_FONTHEIGHT) of [_FONT](_FONT) characters.
* [_MOUSEINPUT](_MOUSEINPUT) must be used to detect any changes in the mouse position and is **required** for any coordinate returns.

## QBasic

* In [SCREEN](SCREEN) 0, QBasic's [ABSOLUTE](ABSOLUTE) returned graphic coordinates. QB64 mouse functions return the text coordinates.

## Example(s)

Highlighting a row of text in Screen 0.

```vb

minX = 20: maxX = 60: minY = 10: maxY = 24
selection = 0 'the screen Y coordinate of the previously highlighted item
FOR i% = 1 TO 25: LOCATE i%, 40: PRINT i%;: NEXT
DO: _LIMIT 100
  IF _MOUSEINPUT THEN
    'Un-highlight any selected row
    IF selection THEN selectRow selection, minX, maxX, 0
    x = _MOUSEX
    y = _MOUSEY
    IF x >= minX AND x <= maxX AND y >= minY AND y <= maxY THEN
      selection = y
    ELSE
      selection = 0
    END IF
    'Highlight any selected row
    IF selection THEN SelectRow selection, minX, maxX, 2 
    IF _MOUSEBUTTON(1) THEN LOCATE 1, 2: PRINT x, y, selection 
  END IF
LOOP UNTIL INKEY$ <> ""

SUB SelectRow (y, x1, x2, col)
DEF SEG = &HB800
addr& = (x1 - 1 + (y - 1) * _WIDTH) * 2 + 1
FOR x = x1 TO x2
  oldCol = PEEK(addr&) AND &B10001111   ' Mask foreground color and blink bit
  POKE addr&, oldCol OR ((col AND &B111) * &B10000) ' Apply background color
  addr& = addr& + 2
NEXT
END SUB 

```

## See Also

* [_MOUSEX](_MOUSEX), [_MOUSEBUTTON](_MOUSEBUTTON), [_MOUSEWHEEL](_MOUSEWHEEL)
* [_MOUSEINPUT](_MOUSEINPUT), [_MOUSEMOVE](_MOUSEMOVE)
* [_MOUSESHOW](_MOUSESHOW), [_MOUSEHIDE](_MOUSEHIDE)
* [_MOUSEMOVEMENTX](_MOUSEMOVEMENTX), [_MOUSEMOVEMENTY](_MOUSEMOVEMENTY) (relative pointer moves) 
* [Controller Devices](Controller-Devices)
