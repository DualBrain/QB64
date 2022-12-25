The [COS](COS) function returns the horizontal component or the cosine of an angle measured in radians.

## Syntax
 
> value! = [COS](COS)(radianAngle!)

## Parameter(s)

* The radianAngle! must be measured in radians. 

## Description

* To convert from degrees to radians, multiply degrees * &pi; / 180.
* [COS](COS)INE is the horizontal component of a unit vector in the direction theta (&theta;).
* COS(x) can be calculated in either [SINGLE](SINGLE) or [DOUBLE](DOUBLE) precision depending on its argument.  
> COS(4) = -.6536436 ...... COS(4#) = -.6536436208636119

## Example(s)

Converting degree angles to radians for QBasic's trig functions and drawing the line at the angle.

```vb

SCREEN 12
PI = 4 * ATN(1)
PRINT "PI = 4 * ATN(1) ="; PI
PRINT "COS(PI) = "; COS(PI)
PRINT "SIN(PI) = "; SIN(PI)
DO
  PRINT
  INPUT "Enter the degree angle (0 quits): ", DEGREES%
  RADIANS = DEGREES% * PI / 180
  PRINT "RADIANS = DEGREES% * PI / 180 = "; RADIANS
  PRINT "X = COS(RADIANS) = "; COS(RADIANS)
  PRINT "Y = SIN(RADIANS) = "; SIN(RADIANS)
  CIRCLE (400, 240), 2, 12
  LINE (400, 240)-(400 + (50 * SIN(RADIANS)), 240 + (50 * COS(RADIANS))), 11
  DEGREES% = RADIANS * 180 / PI
  PRINT "DEGREES% = RADIANS * 180 / PI ="; DEGREES%
LOOP UNTIL DEGREES% = 0 

```

```text

PI = 4 * ATN(1) = 3.141593
COS(PI) = -1
SIN(PI) = -8.742278E-08

Enter the degree angle (0 quits): 45
RADIANS = DEGREES% * PI / 180 = .7853982
X = COS(RADIANS) = .7071068
Y = SIN(RADIANS) = .7071068
DEGREES% = RADIANS * 180 / PI = 45

```

> *Explanation:* When 8.742278E-08(.00000008742278) is returned by [SIN](SIN) or COS the value  is essentially zero.

Creating 12 analog clock hour points using [CIRCLE](CIRCLE)s and [PAINT](PAINT)

```vb

 PI2 = 8 * ATN(1)                  '2 * π
 arc! = PI2 / 12                          'arc interval between hour circles
 SCREEN 12
 FOR t! = 0 TO PI2 STEP arc!
   cx% = CINT(COS(t!) * 70) ' pixel columns (circular radius = 70)
   cy% = CINT(SIN(t!) * 70) ' pixel rows
   CIRCLE (cx% + 320, cy% + 240), 3, 12
   PAINT STEP(0, 0), 9, 12
 NEXT 

```

*Explanation:* The 12 circles are placed at radian angles that are 1/12 of 6.28318 or .523598 radians apart.

Creating a rotating spiral with COS and [SIN](SIN).

```vb

SCREEN _NEWIMAGE(640, 480, 32)

DO
  LINE (0, 0)-(640, 480), _RGB(0, 0, 0), BF
  j = j + 1
  PSET (320, 240)
  FOR i = 0 TO 100 STEP .1
    LINE -(.05 * i * i * COS(j + i) + 320, .05 * i * i * SIN(j + i) + 240)
  NEXT
  PSET (320, 240)
  FOR i = 0 TO 100 STEP .1
    LINE -(.05 * i * i * COS(j + i + 10) + 320, .05 * i * i * SIN(j + i + 10) + 240)
  NEXT
  PSET (320, 240)
  FOR i = 0 TO 100 STEP .1
    PAINT (.05 * i * i * COS(j + i + 5) + 320, .05 * i * i * SIN(j + i + 5) + 240)
  NEXT

  _DISPLAY
  _LIMIT 30
LOOP UNTIL INP(&H60) = 1 'escape exit 

```

## See Also

* [_PI](_PI) (QB64 function)
* [SIN](SIN) (sine)
* [ATN](ATN) (arctangent)
* [TAN](TAN) (tangent)
*[Mathematical Operations](Mathematical-Operations)
* [Mathematical Operations](Mathematical-Operations)
