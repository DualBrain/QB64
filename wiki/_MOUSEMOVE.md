The [_MOUSEMOVE](_MOUSEMOVE) statement moves the mouse pointer to a new position on the screen as determined by the column and row coordinates.

## Syntax
 
> [_MOUSEMOVE](_MOUSEMOVE) column%, row%

## Parameter(s)

* column% is the horizontal pixel coordinate to place the mouse pointer and can be any value from 0 to [_WIDTH (function)](_WIDTH-(function))(0) - 1.
* row% is the vertical pixel position to place the mouse pointer and can be any value from 0 to [_HEIGHT](_HEIGHT)(0) - 1

## Description

* Maximum coordinate values are based on a program's current [SCREEN](SCREEN) mode resolution or the pixel size set by [_NEWIMAGE](_NEWIMAGE).
* [SCREEN](SCREEN) 0 uses text block coordinates. **Coordinates off the screen area will create an "Illegal Function Call" [ERROR Codes](ERROR-Codes)**
* Can be used to position the pointer to a default dialog button or move the cursor away from a button so it is not clicked twice.
* Does not require [_MOUSEINPUT](_MOUSEINPUT) to be used, but all moves will be remembered and can be read by mouse functions.

## Availability

* Versions prior to 1.000 (Version 1.000 had this function disabled for compatibility reasons).
* Version 1.1 and up.

## Example(s)

How to move the mouse cursor using remembered mouse movements. Press any key to quit.

```vb

SCREEN 12
i = _MOUSEINPUT 'start reading mouse events before INPUT to hold in memory
PRINT
INPUT "Move the mouse pointer and make a few clicks, then press Enter!", dummy$
_MOUSEMOVE 1, 1
DO: _LIMIT 30
    count = count + 1
    i = _MOUSEINPUT
    x = _MOUSEX: y = _MOUSEY
    b = _MOUSEBUTTON(1)
    PRINT count, x, y, b
    _MOUSEMOVE x, y
LOOP UNTIL i = 0 OR INKEY$ > ""
PRINT "Done!" 

```

> *Explanation:* The [_MOUSEINPUT](_MOUSEINPUT) function will hold previous and _MOUSEMOVE events so press any key when you want to quit.

> **Note: [INPUT](INPUT), [INPUT$](INPUT$) and [LINE INPUT](LINE-INPUT) will allow continued reading of mouse events while awaiting program user input!**
> It is recommended that a [WHILE](WHILE) [_MOUSEINPUT](_MOUSEINPUT): [WEND](WEND) loop be used immediately after to clear stored mouse events.

## See Also

* [_MOUSEX](_MOUSEX), [_MOUSEY](_MOUSEY)
* [_NEWIMAGE](_NEWIMAGE), [_SCREENIMAGE](_SCREENIMAGE)
