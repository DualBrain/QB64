The **PMAP** statement returns the physical or [WINDOW](WINDOW) view port coordinates.

## Syntax

> PMAP (*coordinate*, *function_number%*)

* The *coordinate* is the coordinate point to be mapped. 
* The *function* can have one of four values:

> 0 = Maps view port coordinate to physical x screen coordinate
> 1 = Maps view port coordinate to physical y screen coordinate
> 2 = Maps physical screen coordinate to view port x coordinate
> 3 = Maps physical screen coordinate to view port y coordinate

* The four PMAP functions allow the user to find equal point locations between the view coordinates created with the [WINDOW](WINDOW) statement and the physical screen coordinates of the viewport as defined by the [VIEW](VIEW) statement.
* Mouse co-ordinates returned by [_MOUSEX](_MOUSEX) and [_MOUSEY](_MOUSEY) are the physical screen co-ordinates.

## Example(s)

Use PMAP to convert coordinate values from view to screen coordinates and from screen coordinates to view coordinates.

```vb

SCREEN 12
 'Coordinates of upper-left corner of the window is defined in following statement are (90,100) 
WINDOW SCREEN (90, 100)-(200, 200) 'coordinates of lower-right 'corner are 200, 200.

X = PMAP(90, 0)          ' X = 0
PRINT X
Y = PMAP(100, 1)         ' Y = 0
PRINT Y

'These statements return the screen coordinates equal to the view coordinates 200, 200.
X = PMAP(200, 0)         ' X = 639
PRINT X
Y = PMAP(200, 1)         ' Y = 479
PRINT Y

'These statements return the view coordinates equal to the screen coordinates 0, 0
X = PMAP(0, 0)
PRINT X
Y = PMAP(0, 0)
PRINT Y

'These statements return the view coordinates equal to the screen coordinates 639, 479.
X = PMAP(639, 2)         ' X = 200
PRINT X
Y = PMAP(479, 3)         ' Y = 200
PRINT Y

SLEEP                    ' pause before clearing view port
CLS 1                    ' clear grahic view port
WINDOW                   ' end graphic view port
END 

```

> *Note:* If physical screen coordinates are (0, 0) in the upper-left corner and (639, 479) in the lower-right corner, then the statements return the screen coordinate's equal to the view coordinates 90, 100.

## See Also
 
* [WINDOW](WINDOW), [VIEW](VIEW)
* [VIEW PRINT](VIEW-PRINT)
