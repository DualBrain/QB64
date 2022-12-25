The [_MOUSEX](_MOUSEX) function returns the current horizontal (column) mouse cursor position when read after [_MOUSEINPUT](_MOUSEINPUT).

## Syntax

> pixelColumn% = [_MOUSEX](_MOUSEX)

## Description

* [SCREEN](SCREEN) 0 returns the [INTEGER](INTEGER) horizontal text column position (from build 20170817/62 onward); older versions return a [SINGLE](SINGLE) horizontal text column position. Use [INTEGER](INTEGER) variables to avoid floating decimal returns.
* Graphic screen modes 1, 2 and 7 to 13 and [_NEWIMAGE](_NEWIMAGE) 32 bit return the [INTEGER](INTEGER) pixel columns.
* To calculate text columns in graphic modes, divide the return by 8 or the [_FONTWIDTH](_FONTWIDTH) of [_FONT](_FONT) characters.
* [_MOUSEINPUT](_MOUSEINPUT) must be used to detect any changes in the mouse position and is **required** for any coordinate returns.

## QBasic

* In [SCREEN](SCREEN) 0, QBasic's [ABSOLUTE](ABSOLUTE) returned graphic coordinates. QB64 mouse functions return the text coordinates.

## Example(s)

A simple mouse drawing board using [_MOUSEX](_MOUSEX) and [_MOUSEY](_MOUSEY) coordinate values. 

```vb

SCREEN 12
LINE (99, 9)-(601, 401), 7, BF
LINE (101, 11)-(599, 399), 8, BF
tm$ = " Column = ###  Row = ###  Button1 = ##  Button2 = ##  Button3 = ##"
LOCATE 29, 20: PRINT "LeftButton = draw - RightButton = Erase";
DO: K$ = INKEY$
  DO WHILE _MOUSEINPUT
    X = _MOUSEX: Y = _MOUSEY
    IF X > 100 AND X < 600 AND PX > 100 AND PX < 600 THEN
      IF Y > 10 AND Y < 400 AND PY > 10 AND PY < 400 THEN
        IF _MOUSEBUTTON(1) THEN LINE (PX, PY)-(X, Y), 15
        IF _MOUSEBUTTON(2) THEN LINE (101, 11)-(599, 399), 8, BF
      END IF
    END IF
    PX = X: PY = Y
    LOCATE 28, 10: PRINT USING tm$; X; Y; _MOUSEBUTTON(1); _MOUSEBUTTON(2); _MOUSEBUTTON(3)
  LOOP
LOOP UNTIL K$ = CHR$(27)
SYSTEM 

```

## See Also

* [_MOUSEY](_MOUSEY)
* [_MOUSEBUTTON](_MOUSEBUTTON), [_MOUSEWHEEL](_MOUSEWHEEL)
* [_MOUSEINPUT](_MOUSEINPUT), [_MOUSEMOVE](_MOUSEMOVE)
* [_MOUSESHOW](_MOUSESHOW), [_MOUSEHIDE](_MOUSEHIDE)
* [_MOUSEMOVEMENTX](_MOUSEMOVEMENTX), [_MOUSEMOVEMENTY](_MOUSEMOVEMENTY) (relative pointer moves) 
* [Controller Devices](Controller-Devices)
