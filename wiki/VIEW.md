The **VIEW** statement creates a graphics view port area by defining the coordinate limits to be viewed.

## Syntax

> **VIEW** [SCREEN] (column1, row1)-(column2, row2)[, color][, border](SCREEN] (column1, row1)-(column2, row2)[, color][, border)]

* When the SCREEN option is used, all coordinates are absolute and only graphics within the viewport area are plotted.
* When the SCREEN option is not used, all coordinates are relative to the view port with the values of column1 and row1 being automatically added before plotting the point.
* Coordinate values are for the top left and bottom right values of a box area of the screen mode used. 
* The color parameter specifies a background fill color for the area. None when omitted.
* Border requires any valid color attribute to draw a line around the VIEW area if there is room for it.
* VIEW without any parameters disables the previous viewport. [RUN](RUN) and [SCREEN](SCREEN) can also disable any VIEW port.
* [CLS](CLS) or [CLS](CLS) clears the active graphics VIEW port area only. Disable a viewport before attempting to clear the entire screen!
* **Note: QB64 [RUN](RUN) statements will not close [VIEW PRINT](VIEW-PRINT), [VIEW](VIEW) or [WINDOW](WINDOW) view ports presently!**

## Example(s)

Using SCREEN option with absolute screen coordinates.

```vb

 SCREEN 12
 VIEW SCREEN (200, 200)-(400, 400), 1, 9 ' blue BG with light blue border
 CIRCLE (220, 220), 20, 11 ' using the actual screen coordinates

```

Using coordinates relative to the viewport box area.

```vb

 SCREEN 12
 VIEW (200, 200)-(400, 400), 1, 9 
 CIRCLE (20, 20), 20, 11 ' using coordinates inside of the viewport

```

> *Explanation:* The relative coordinates are automatically adjusted to place the object correctly. Any values outside of the box's area will not be displayed. Both examples should display the same screen image.

## See Also

* [VIEW PRINT](VIEW-PRINT) (text view port)
* [WINDOW](WINDOW) (window view port)
* [SCREEN](SCREEN), [CLS](CLS) 
