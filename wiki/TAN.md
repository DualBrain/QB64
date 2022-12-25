The [TAN](TAN) function returns the ratio of [SIN](SIN)e to [COS](COS)ine or tangent value of an angle measured in radians.

## Syntax

> tangent! = **TAN(***radian_angle!***)**

## Parameter(s)

* The *radian_angle* must be measured in radians. 

## Description

* To convert from degrees to radians, multiply degrees * π/180.
* TANGENT is the gradient or slope of the circle or arc at [SIN](SIN)(&theta;) / [COS](COS)(&theta;). Do not use division when the [COS](COS) = 0 to avoid [ERROR Codes](ERROR-Codes).

## Example(s)

Spiraling text using the [SIN](SIN) and [TAN](TAN) functions.

```vb

DIM SHARED text AS STRING
text$ = "S P I R A L"
DIM SHARED word(1 TO LEN(text$) * 8, 1 TO 16)

CALL analyse
CLS
CALL redraw

SUB analyse
CLS
SCREEN 12
COLOR 2: LOCATE 1, 1: PRINT text$
DIM px AS INTEGER, py AS INTEGER, cnt AS INTEGER, ltrcnt AS INTEGER
px = 1: py = 1
DO
  word(px, py) = POINT(px, py)
  PSET (px, py), 1
  px = px + 1
  IF px = LEN(text$) * 8 THEN
    px = 1
    py = py + 1
  END IF
LOOP UNTIL py = 16
END SUB

SUB redraw
CLS
DIM row AS INTEGER, cnt AS INTEGER, cstart AS SINGLE, cend AS SINGLE
DIM xrot AS INTEGER, yrot AS INTEGER, SCALE AS INTEGER, pan AS INTEGER
cstart = 0: cend = 6.2
xrot = 6: yrot = 6: SCALE = 3: pan = 30
OUT &H3C8, 1: OUT &H3C9, 10: OUT &H3C9, 10: OUT &H3C9, 60
DO
  row = 2
  DO
    DO
      FOR i = cend TO cstart STEP -.03
        x = (SCALE * 60 - (row * xrot / 4)) * TAN(COS(i))
        y = SIN(SCALE * 60 - (row * yrot)) * TAN(SIN(i)) * pan
        cnt = cnt + 1
        IF word(cnt, row) > 0 THEN 
          CIRCLE (x + 320, y + 220), SCALE + 1, 1              'circled letters
          'LINE (x + 320, y + 220)-STEP(12, 12), 1, BF  'boxed letters
        END IF
        IF cnt = LEN(text$) * 8 THEN cnt = 0: EXIT DO
      NEXT
    LOOP
    row = row + 1
  LOOP UNTIL row = 16
  cend = cend + .1
  cstart = cstart + .1
  now! = TIMER
  DO
    newnow! = TIMER
  LOOP UNTIL newnow! - now! >= .15
  LINE (1, 100)-(639, 280), 0, BF
LOOP UNTIL INKEY$ = CHR$(27)
END SUB 

```

## See Also

* [_PI](_PI) (QB64 function)
* [SIN](SIN), [COS](COS)
* [ATN](ATN) (arctangent)
* [Mathematical Operations](Mathematical-Operations)
* [Text Using Graphics](Text-Using-Graphics)
* [Mathematical Operations](Mathematical-Operations)
