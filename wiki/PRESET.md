The **PRESET** graphic [SCREEN](SCREEN) statement turns a pixel at a coordinate to the background color or a designated color attribute.

## Syntax

> **PRESET** [STEP]**(***column%*, *row%***)**[, colorAttribute]

## Parameter(s)

* Can use [STEP](STEP) when relative graphics coordinates are required.
* *column* and *row* coordinates can be literal ot variable [INTEGER](INTEGER) values which can be offscreen. 
* If the *colorAttribute* is omitted, PRESET will use the current [_DEST](_DEST) page's [_BACKGROUNDCOLOR](_BACKGROUNDCOLOR).

## Usage

* Color attributes are limited to those available in the [SCREEN](SCREEN) mode used. [PSET](PSET) can be used to adopt previously used colors.
* Any color value other than 0 will be white in monochrome [SCREEN](SCREEN) modes 2 and 11 where the [COLOR](COLOR) statement cannot be used.
* PRESET can invisibly locate other graphics objects like [CIRCLE](CIRCLE)s and add color to subsequent graphic objects and [DRAW](DRAW) when used.
* The PRESET action can be used in a graphics [PUT (graphics statement)](PUT-(graphics-statement)) to produce a color inverted image on any background. See Example 2.
* The graphic cursor is set to the center of the program window on program start for [STEP](STEP) relative coordinates.
* **PRESET can be used in any graphic screen mode, but cannot be used in the default screen mode 0 as it is text only!** 

## Example(s)

Using PRESET to locate a [DRAW](DRAW) statement that draws a box that is bright red.

```vb

SCREEN 12
PRESET(100, 100)
DRAW "C12 U20 R20 D20 L20" 

```

> *Explanation:* The [DRAW](DRAW) string required a color designation as PRESET defaulted to the black background color. 

Displays the flags of countries that use simple horizontal or vertical color blocks with a highlighted arrow key menu.

```vb

DIM SHARED c$(21), x$(21), gg%(477)

ARRAY
SETUP
SELECTION
TERMINATE

END

SUB ARRAY
c$(1) = "Armenia H040914"
c$(2) = "Austria H041504"
c$(3) = "Belgium V001404"
c$(4) = "Bulgaria H150204"
c$(5) = "Chad V011404"
c$(6) = "C“te D'Ivoire V061502"
c$(7) = "Estonia H090015"
c$(8) = "France V011504"
c$(9) = "Germany H000414"
c$(10) = "Hungary H041502"
c$(11) = "Ireland V021506"
c$(12) = "Italy V021504"
c$(13) = "Lithuania H140204"
c$(14) = "Luxembourg H041509"
c$(15) = "Mali V021404"
c$(16) = "Netherlands H041501"
c$(17) = "Nigeria V021502"
c$(18) = "Romania V091404"
c$(19) = "Russia H150104"
c$(20) = "Sierra Leone H021509"
c$(21) = "Yemen H041500"
END SUB

SUB DISPLAY.FLAG (calc%)
f% = VAL(MID$(x$(calc%), 2, 2))
s% = VAL(MID$(x$(calc%), 4, 2))
t% = VAL(MID$(x$(calc%), 6, 2))

IF LEFT$(x$(calc%), 1) = "V" THEN
  LINE (120, 225)-(253, 465), f%, BF
  LINE (254, 225)-(385, 465), s%, BF
  LINE (386, 225)-(519, 465), t%, BF
END IF

IF LEFT$(x$(calc%), 1) = "H" THEN
  LINE (120, 225)-(519, 305), f%, BF
  LINE (120, 306)-(519, 386), s%, BF
  LINE (120, 387)-(519, 465), t%, BF
END IF
END SUB

SUB SELECTION 'menu selection using arrow keys
x% = 2: y% = 4

DO
  WHILE (x% <> prevx% OR y% <> prevy%) AND k$ <> CHR$(27)
    k$ = INKEY$
    x% = x% + (k$ = (CHR$(0) + "K") AND x% > 1) + ABS(k$ = (CHR$(0) + "M") AND x% < 3)
    y% = y% + (k$ = (CHR$(0) + "H") AND y% > 1) + ABS(k$ = (CHR$(0) + "P") AND y% < 7)
    calc% = (x% - 1) * 7 + y%: LOCATE 14, 18: PRINT c$(calc%); SPACE$(10)
    x1% = 140 + (x% - 1) * 128
    x2% = x1% + LEN(c$(calc%)) * 8 + 7
    y1% = 48 + y% * 16
    IF x1% <> prevx1% OR y1% <> prevy1% THEN
      IF g% THEN PUT(prevx1%, prevy1%), gg%(), PSET
      GET(x1%, y1%)-(x2%, y1% + 16), gg%(): g% = 1
      PUT(x1%, y1%), gg%(), PRESET
      prevx1% = x1%: prevx2% = x2%: prevy1% = y1%
      DISPLAY.FLAG calc%
    END IF
  WEND
LOOP UNTIL k$ = CHR$(27)
END SUB

SUB SETUP
SCREEN 12
COLOR 6
c% = 1

FOR x% = 11 TO 50 STEP 16
  FOR y% = 1 TO 7
    x$(c%) = RIGHT$(c$(c%), 7)
    c$(c%) = RTRIM$(LEFT$(c$(c%), LEN(c$(c%)) - 7))
    LOCATE y% + 4, x% + 8: PRINT c$(c%)
    c% = c% + 1
NEXT y%, x%

COLOR 11: LOCATE 3, 20: PRINT "Use the Cursor Keys to Select a Country:"
LINE (119, 224)-(520, 466), 7, B
END SUB

SUB TERMINATE
FOR c% = 1 TO 219
  LINE (116 + c%, 29 + c%)-(523 - c%, 469 - c%), 0, B
NEXT
END SUB

```

> *Explanation:* Using the [PUT (graphics statement)](PUT-(graphics-statement)) PRESET action highlights the menu selection in graphic screen modes by returning a negative image.
 
## See Also

* [PUT (graphics statement)](PUT-(graphics-statement))
* [GET (graphics statement)](GET-(graphics-statement))
* [CIRCLE](CIRCLE), [LINE](LINE), [PSET](PSET)
