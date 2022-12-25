The [PAINT](PAINT) statement is used to fill a delimited area in a graphic screen mode with color.

## Syntax

>  [PAINT](PAINT) [**STEP**] (column%, row%), fillColor[, borderColor%]

## Parameter(s)

* Can use the [STEP](STEP) keyword for relative coordinate placements. See example 1 below.
* fillColor is an [INTEGER](INTEGER) or [LONG](LONG) 32-bit value to paint the inside of an object. Colors are limited to the [SCREEN](SCREEN) mode used.
* Optional [INTEGER](INTEGER) or [LONG](LONG) 32-bit borderColor% is the color of the border of the shape to be filled when this is different from the fill color. 
* fillColor can be a string made up of a sequence of [CHR$](CHR$) values, each representing a tiling pattern to fill the shape. See Example 3 below.

## Description

* Graphic column% and row% [INTEGER](INTEGER) pixel coordinates should be inside of a fully closed "shape", whether it's a rectangle, circle or custom-drawn shape using [DRAW](DRAW).
* If the coordinates passed to the [PAINT](PAINT) statement are on a pixel that matches the border colors, no filling will occur.
* If the shape's border isn't continuous, the "paint" will "leak". 
* If the shape is not totally closed, every color except the border color may be painted over.
* [DRAW](DRAW) shapes can be filled using the string "P fillColor, borderColor". Use a "B" blind move to offset from the shape's border.

## Example(s)

Painting a [CIRCLE](CIRCLE) immediately after it is drawn using [STEP](STEP)(0, 0) to paint from the circle's center point.

```vb

SCREEN 12
x = 200: y = 200
CIRCLE (x, y), 100, 10
PAINT STEP(0, 0), 2, 10 

```

> *Results:* A circle located at x and y with a bright green border filled in dark green. The last coordinate used was the circle's center point and PAINT used it also with the [STEP](STEP) relative coordinates being zero.

Routine to check a [DRAW](DRAW) string to make sure that the drawn shape is fully closed so that a PAINT does not "leak".

```vb

SCREEN 12
drw$ = "C15S20R9D4R6U3R3D3R7U5H3U2R9D3G2D6F1D3F5L10D1G1L4H2L7G2L3H2L3U8L2U5R1BF4"

FOR i = 1 TO LEN(drw$)
  tmp$ = UCASE$(MID$(drw$, i, 1))
  check = 1
  SELECT CASE tmp$
    CASE "U": ver = -1: hor = 0
    CASE "D": ver = 1: hor = 0
    CASE "E": ver = -1: hor = 1
    CASE "F": ver = 1: hor = 1
    CASE "G": ver = 1: hor = -1
    CASE "H": ver = -1: hor = -1
    CASE "L": ver = 0: hor = -1
    CASE "R": ver = 0: hor = 1
    CASE ELSE: check = 0
  END SELECT
  IF check THEN
    snum$ = ""
    FOR j = i + 1 TO i + 4 'set for up to 4 digits and spaces
      IF j > LEN(drw$) THEN EXIT FOR
      n$ = MID$(drw$, j, 1)
      num = ASC(n$)
      IF (num > 47 AND num < 58) OR num = 32 THEN
        snum$ = snum$ + n$
      ELSE: EXIT FOR
      END IF
    NEXT
    vertical = vertical + (ver * VAL(snum$))
    horizont = horizont + (hor * VAL(snum$))
  END IF
  PRINT tmp$, horizont, vertical
  'SLEEP
NEXT
PSET (300, 300): DRAW drw$ 

```

> *Explanation:* If the [DRAW](DRAW) string is fully closed, the end values should each be 0. In the example, the proper result should be 4, 4 as there is a BF4 offset for PAINT which cannot be on a border. The result is 4, 5 because the shape is not completely closed.

Tiling using PAINT to create a red brick pattern inside a yellow border:

```vb

DIM Row$(1 TO 8) 
SCREEN 12
 
   'make red-brick wall
    Row$(1) = CHR$(&H0) + CHR$(&H0) + CHR$(&HFE) + CHR$(&HFE)
    Row$(2) = Row$(1)
    Row$(3) = Row$(1)
    Row$(4) = CHR$(&H0) + CHR$(&H0) + CHR$(&H0) + CHR$(&H0)
    Row$(5) = CHR$(&H0) + CHR$(&H0) + CHR$(&HEF) + CHR$(&HEF)
    Row$(6) = Row$(5)
    Row$(7) = Row$(5)
    Row$(8) = Row$(4)
    Tile$ = Row$(1) + Row$(2) + Row$(3) + Row$(4) + Row$(5) + Row$(6) + Row$(7) + Row$(8)
 
    LINE (59, 124)-(581, 336), 14, B 'yellow box border to paint inside
    PAINT (320, 240), Tile$, 14 'paints brick tiles within yellow border

```

Generating a tiling pattern for PAINT from [DATA](DATA) statements:

```vb

ptndata:
DATA "c4444444"
DATA "c4444444"
DATA "cccccccc"
DATA "444c4444"
DATA "444c4444"
DATA "444c4444"
DATA "cccccccc"
DATA "c4444444"
DATA ---

RESTORE ptndata: ptn$ = loadpattern$

SCREEN 7
DRAW "c15l15f10g10r30g10f10l50u80r100m160,100"
PAINT (160, 90), ptn$, 15

FUNCTION loadpattern$
    DIM quad(0 TO 3) AS INTEGER
    res$ = ""
    DO
        READ row$
        IF LEFT$(row$, 3) = "---" THEN EXIT DO
        FOR x = 0 TO 7
            pixel = VAL("&h" + MID$(row$, x + 1, 1))
            FOR bit = 0 TO 3
                IF pixel AND 2 ^ bit THEN
                    quad(bit) = quad(bit) OR (2 ^ (7 - x))
                END IF
            NEXT
        NEXT
        FOR i = 0 TO 3
            res$ = res$ + CHR$(quad(i))
            quad(i) = 0
        NEXT
    LOOP
    loadpattern$ = res$
END FUNCTION

```

## See Also

* [PSET](PSET), [PRESET](PRESET)
* [CIRCLE](CIRCLE), [LINE](LINE), [DRAW](DRAW)
* [SCREEN](SCREEN), [CHR$](CHR$)
