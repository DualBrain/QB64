The [LINE](LINE) statement is used in graphic [SCREEN (statement)](SCREEN-(statement)) modes to create lines or boxes.

## Syntax

> [LINE](LINE) [**STEP**] [**(**_column1_**,** _row1_**)**]-**[STEP]** **(** _column2_, _row2_ **),** _color_[, [{B|BF}], style%]

## Parameter(s)

* The [STEP](STEP) keyword make *column* and *row* coordinates relative to the previously coordinates set by any graphic statement.
* The optional parameters (*column1*, *row1*) set the line's starting point.
* The dash and second coordinate parameters (*column2*, *row2*) must be designated to complete the line or box.
* The [INTEGER](INTEGER) *color* attribute or [LONG](LONG) [_RGB32](_RGB32) 32 bit color value sets the drawing color.  If omitted, the current [_DEST](_DEST) page's [_DEFAULTCOLOR](_DEFAULTCOLOR) is used.
* Optional **B** keyword creates a rectangle (**b**ox) using the start and end coordinates as diagonal corners. **BF** creates a **b**ox **f**illed. 
* The *style%* signed [INTEGER](INTEGER) value sets a dotted pattern to draw the line or rectangle outline.

## Description

* Creates a colored line between the given coordinates. Can be drawn partially off screen.
* **B** creates a box outline with each side parallel to the program screen sides. **BF** creates a filled box.
* style% can be used to create a dotted pattern to draw the line.
  * **B** can be used with a *style%* to draw the rectangle outline using the desired pattern.
  * **BF** ignores the style% parameter. See examples 2, 3 and 4 below.
* The graphic cursor is set to the center of the program window on program start. Using the [STEP](STEP) keyword makes the coordinates relative to the current graphic cursor.
* [LINE](LINE) **can be used in any graphic screen mode, but cannot be used in the default screen mode 0 as it is text only.** 

## Example(s)

Following one line with another by omitting the second line's first coordinate parameter bracket entirely:

```vb

SCREEN 12

LINE (100, 100)-(200, 200), 10    'creates a line
LINE -(400, 200), 12              'creates a second line from end of first

END 

```

> *Explanation:* The full equivalent LINE statement would be: **LINE(200, 200)-(400, 200), 12**

Creating styled lines and boxes with the LINE statement. Different style values create different dashed line spacing.

```vb

SCREEN 12

LINE (100, 100)-(300, 300), 10, , 63    'creates a styled line
LINE (100, 100)-(300, 300), 12, B, 255  'creates styled box shape

END 

```

> *Explanation:* The first diagonal dashed green line bisects the red dashed square from Top Left to Bottom Right Corners.

The *style* value sets each 16 pixel line section as the value's bits are set on or off:

```vb

SCREEN 13
_FULLSCREEN 'required in QB64 only
_DELAY 5
FOR i% = 1 TO 2 ^ 15 'use exponential value instead of -32768
    COLOR 15:LOCATE 10, 5: PRINT i%;
    LINE (10, 60)-(300, 60), 0 'erase previous lines
    LINE (10, 60)-(300, 60), 12, , i%
    tmp$ = ""
    FOR b% = 15 TO 0 STEP -1 'create binary text value showing bits on as █, off as space
        IF i% AND 2 ^ b% THEN tmp$ = tmp$ + CHR$(219) ELSE tmp$ = tmp$ + SPACE$(1)
    NEXT
    COLOR 12:LOCATE 10, 20: PRINT tmp$;
    IF INKEY$ <> "" THEN EXIT FOR 'any key exit
    _DELAY .001 'set delay time as required
NEXT 

```

> *Explanation:* The *style* value's Most Significant Bit (MSB) is set to the left with LSB on right as 16 text blocks are set on or off.

Using [&B](&B) to design a style pattern:

```vb

SCREEN 12

LINE (100, 100)-(300, 100), 10, , &B0000111100001111 '16-bits
LINE (100, 110)-(300, 110), 11, , &B0011001100110011
LINE (100, 120)-(300, 120), 12, , &B0101010101010101
LINE (100, 130)-(300, 130), 13, , &B1000100010001000

```

> *Explanation:* The binary pattern created with 0s and 1s using the [&B](&B) number prefix define the pattern to draw the colored lines.

## See Also

* [SCREEN (statement)](SCREEN-(statement)), [COLOR](COLOR) 
* [DRAW](DRAW), [CIRCLE](CIRCLE), [STEP](STEP)
* [PSET](PSET), [PRESET](PRESET)
* [AND](AND), [OR](OR) (logical operators)
