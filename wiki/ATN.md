The [ATN](ATN) or arctangent function returns the angle in radians of a numerical [TAN](TAN) value.

## Syntax

> radianAngle = [ATN](ATN)(tangent!)

## Parameter(s)

* The return is the tangent!'s angle in **radians**.
* tangent! [SINGLE](SINGLE) or [DOUBLE](DOUBLE) values are used by the function. EX:**Pi = 4 * ATN(1)**

## Description

* To convert from radians to degrees, multiply radians * (180 / �).
* The *tangent* value would be equal to the tangent value of an angle. Ex: **[TAN](TAN)(ATN(1)) = 1**
* The function return value is between -� / 2 and � / 2.

## Example(s)

When the [TAN](TAN)gent value equals 1, the line is drawn at a 45 degree angle (.7853982 radians) where [SIN](SIN) / [COS](COS) = 1.

```vb

SCREEN 12
x = 100 * COS(ATN(1))
y = 100 * SIN(ATN(1))
LINE (200, 200)-(200 + x, 200 + y) 

```

[ATN](ATN) can be used to define &pi; in [SINGLE](SINGLE) or [DOUBLE](DOUBLE) precision. The calculation cannot be used as a [CONST](CONST)ant.

```vb

Pi = 4 * ATN(1)   'SINGLE precision
Pi# = 4 * ATN(1#) 'DOUBLE precision
PRINT Pi, Pi# 

```

> *Note:* You can use QB64's native [_PI](_PI) function.

Finds the angle from the center point to the mouse pointer.

```vb

SCREEN _NEWIMAGE(640, 480, 32)
x1! = 320
y1! = 240

DO
  PRESET (x1!, y1!), _RGB(255, 255, 255)
  dummy% = _MOUSEINPUT
  x2! = _MOUSEX
  y2! = _MOUSEY
  LINE (x1, y1)-(x2, y2), _RGB(255, 0, 0)
  LOCATE 1, 1: PRINT getangle(x1!, y1!, x2!, y2!)
  _DISPLAY
  _LIMIT 200
  CLS
LOOP UNTIL INKEY$ <> ""
END

FUNCTION getangle# (x1#, y1#, x2#, y2#) 'returns 0-359.99...
IF y2# = y1# THEN
  IF x1# = x2# THEN EXIT FUNCTION
  IF x2# > x1# THEN getangle# = 90 ELSE getangle# = 270
  EXIT FUNCTION
END IF
IF x2# = x1# THEN
  IF y2# > y1# THEN getangle# = 180
  EXIT FUNCTION
END IF
IF y2# < y1# THEN
  IF x2# > x1# THEN
    getangle# = ATN((x2# - x1#) / (y2# - y1#)) * -57.2957795131
  ELSE
    getangle# = ATN((x2# - x1#) / (y2# - y1#)) * -57.2957795131 + 360
  END IF
ELSE
  getangle# = ATN((x2# - x1#) / (y2# - y1#)) * -57.2957795131 + 180
END IF
END FUNCTION 

```

## See Also

* [_PI](_PI) (QB64 function)
* [TAN](TAN) (tangent function)
* [SIN](SIN), [COS](COS)
* [Mathematical Operations](Mathematical-Operations)
* [Mathematical Operations](Mathematical-Operations)
