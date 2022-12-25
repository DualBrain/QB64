The SIN function returns the vertical component or sine of an angle measured in radians.

## Syntax

> value! = **SIN(***radian_angle!***)**

## Parameter(s)

* The *radian_angle* must be measured in radians from 0 to 2 * Pi. 

## Description

* To convert from degrees to radians, multiply degrees * π/180.
* [SIN](SIN)E is the vertical component of a unit vector in the direction theta (&theta;).
* Accuracy can be determined as [SINGLE](SINGLE) by default or [DOUBLE](DOUBLE) by following the parameter value with a # suffix.

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

>  *Explanation:* When 8.742278E-08(.00000008742278) is returned by SIN or [COS](COS) the value  is essentially zero.

Displays rotating gears made using SIN and [COS](COS) to place the teeth lines.

```vb

SCREEN 9
DIM SHARED Pi AS SINGLE
Pi = 4 * ATN(1)
DO
    FOR G = 0 TO Pi * 2 STEP Pi / 100
        CLS                                   'erase previous
        CALL GEARZ(160, 60, 40, 20, 4, G, 10)
        CALL GEARZ(240, 60, 40, 20, 4, -G, 11)
        CALL GEARZ(240, 140, 40, 20, 4, G, 12)
        CALL GEARZ(320, 140, 40, 20, 4, -G, 13)
        CALL GEARZ(320 + 57, 140 + 57, 40, 20, 4, G, 14)
        CALL GEARZ(320 + 100, 140 + 100, 20, 10, 4, -G * 2 - 15, 15)
        _DISPLAY 
        _LIMIT 20                 'regulates gear speed and CPU usage
    NEXT G
LOOP UNTIL INKEY$ <> ""
END

SUB GEARZ (XP, YP, RAD, Teeth, TH, G, CLR)
t = 0
x = XP + (RAD + TH * SIN(0)) * COS(0)
y = YP + (RAD + TH * SIN(0)) * SIN(0)
PRESET (x, y)
m = Teeth * G
FOR t = -Pi / 70 TO 2 * Pi STEP Pi / 70
    x = XP + (RAD + TH * SIN((Teeth * t + m)) ^ 3) * COS(t)
    y = YP + (RAD + TH * SIN((Teeth * t + m)) ^ 3) * SIN(t)
    LINE -(x, y), CLR
    IF INKEY$ <> "" THEN END
NEXT t
PAINT (XP, YP), CLR            'gear colors optional      
END SUB 

```


Displaying the current seconds for an analog clock. See [COS](COS) for the clock face hour markers.

```vb

SCREEN 12
Pi2! = 8 * ATN(1): sec! = Pi2! / 60  ' (2 * pi) / 60 movements per rotation 
CIRCLE (320, 240), 80, 1
DO
  LOCATE 1, 1: PRINT TIME$
  Seconds% = VAL(RIGHT$(TIME$, 2)) - 15 ' update seconds
  S! = Seconds% * sec! ' radian from the TIME$ value
  Sx% = CINT(COS(S!) * 60)   ' pixel columns (60 = circular radius) 
  Sy% = CINT(SIN(S!) * 60)   ' pixel rows
  LINE (320, 240)-(Sx% + 320, Sy% + 240), 12
  DO: Check% = VAL(RIGHT$(TIME$, 2)) - 15: LOOP UNTIL Check% <> Seconds%  ' wait loop
  LINE (320, 240)-(Sx% + 320, Sy% + 240), 0 ' erase previous line
LOOP UNTIL INKEY$ = CHR$(27) ' escape keypress exits

```


The value of 2 &pi; is used to determine the sec! multiplier that determines the radian value as S! The value is divided by 60 second movements. To calculate the seconds the [TIME$](TIME$) function is used and that value is subtracted 15 seconds because the 0 value of pi is actually the 3 hour of the clock (15 seconds fast). SIN and COS will work with negative values the same as positive ones! Then the column and row coordinates for one end of the line are determined using SIN and [COS](COS) multiplied by the radius of the circular line movements. The minute and hour hands could use similar procedures to read different parts of TIME$.

## See Also

* [_PI](_PI) (QB64 function)
* [COS](COS) (cosine)
* [ATN](ATN) (arctangent)
* [TAN](TAN) (tangent)
* [Mathematical Operations](Mathematical-Operations)
* [Mathematical Operations](Mathematical-Operations)
