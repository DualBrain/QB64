The [_MOUSEMOVEMENTY](_MOUSEMOVEMENTY) function returns the relative vertical position of the mouse cursor as positive or negative values. 

## Syntax
 
> verticalMove = [_MOUSEMOVEMENTY](_MOUSEMOVEMENTY)

* Returns the relative vertical cursor pixel position compared to the previous cursor position. Negative values are up moves.
* Can also be used to check for any mouse movements to enable a program or close [Screen Saver Programs](Screen-Saver-Programs).
* On Windows only, [_MOUSEMOVEMENTY](_MOUSEMOVEMENTY) will continue to track the mouse when it is outside the program window.

## Example(s)

MOD is used to keep vertical movement of circle and cursor inside of the SCREEN 13 window(200). 

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

* [_MOUSEMOVEMENTX](_MOUSEMOVEMENTX)
* [_MOUSEINPUT](_MOUSEINPUT), [_MOUSEX](_MOUSEX)
* [_DEVICES](_DEVICES), [_DEVICEINPUT](_DEVICEINPUT)
* [_WHEEL](_WHEEL), [_LASTWHEEL](_LASTWHEEL)
* [_AXIS](_AXIS), [_LASTAXIS](_LASTAXIS) 
* [_MOUSESHOW](_MOUSESHOW), [_MOUSEHIDE](_MOUSEHIDE)
* [Screen Saver Programs](Screen-Saver-Programs)
