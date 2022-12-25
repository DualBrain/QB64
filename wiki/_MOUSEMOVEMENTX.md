The [_MOUSEMOVEMENTX](_MOUSEMOVEMENTX) function returns the relative horizontal position of the mouse cursor as positive or negative values.  

## Syntax
 
> *horizontalMove* = [_MOUSEMOVEMENTX](_MOUSEMOVEMENTX)

* Returns the relative horizontal cursor pixel position compared to the previous cursor position. Negative values are moves to the left.
* Can also be used to check for any mouse movements to enable a program or close [Screen Saver Programs](Screen-Saver-Programs). 
* On Windows only, [_MOUSEMOVEMENTX](_MOUSEMOVEMENTX) will continue to track the mouse when it is outside the program window.

## Example(s)

Since values returned are relative to the last position, the returns can be positive or negative.

```vb

SCREEN 12
PX = 320: PY = 240 'center position
DO: _LIMIT 200
  DO WHILE _MOUSEINPUT
    PX = PX + _MOUSEMOVEMENTX
    PY = PY + _MOUSEMOVEMENTY
  LOOP
  CLS
  CIRCLE (PX, PY), 10, 10
  LOCATE 1, 1: PRINT PX, PY
LOOP UNTIL INKEY$ = CHR$(27) 'escape key exit 

```

MOD is used to keep horizontal movement of the circle and cursor inside of the SCREEN 13 window(320). 

```vb

SCREEN 13, , 1, 0
DO: _LIMIT 200
  DO WHILE _MOUSEINPUT
    x = x + _MOUSEMOVEMENTX
    y = y + _MOUSEMOVEMENTY
  LOOP
  x = (x + 320) MOD 320 'keeps object on screen
  y = (y + 200) MOD 200 'remove if off screen moves are desired
  CLS
  CIRCLE (x, y), 20
  PCOPY 1, 0
LOOP UNTIL INKEY$ <> "" 'press any key to exit 

```

> **NOTE:** When using the function this way, give the user a keypress exit option. Make sure the user has some way to exit that is not dependent on clicking the X button.

## See Also

* [_MOUSEMOVEMENTY](_MOUSEMOVEMENTY)
* [_MOUSEINPUT](_MOUSEINPUT), [_MOUSEX](_MOUSEX)
* [_DEVICES](_DEVICES), [_DEVICEINPUT](_DEVICEINPUT)
* [_WHEEL](_WHEEL), [_LASTWHEEL](_LASTWHEEL)
* [_AXIS](_AXIS), [_LASTAXIS](_LASTAXIS) 
* [_MOUSESHOW](_MOUSESHOW), [_MOUSEHIDE](_MOUSEHIDE)
* [Screen Saver Programs](Screen-Saver-Programs)
