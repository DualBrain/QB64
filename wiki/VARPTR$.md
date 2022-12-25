**VARPTR$** is a memory function that returns a [STRING](STRING) representation of a variable's memory address value for use in a [DRAW](DRAW) or [PLAY](PLAY) statement.

## Syntax

> string_value$ = VARPTR$(*variable*)

* Can use any [STRING](STRING) or numerical variable reference **existing** in memory.
* If the parameter value is from an array it must be dimensioned already. Cannot use fixed length string arrays.
* When using **numerical** *variable* values in [DRAW](DRAW) strings, use an = sign after the function letter. "TA=" + VARPTR$(*variable%*)
* Always use variable X as in "X" + VARPTR$(*string_variable$*) to [DRAW](DRAW) or [PLAY](PLAY) another [STRING](STRING) value.
* DRAW relative Moves use a + or - before the equal sign. EX: DRAW "M+=" + VARPTR$(x%) + ",-=" + VARPTR$(y%)

## Example(s)

How VARPTR$ reads consecutive values from memory.

```vb

SCREEN 2
CLS
WIND$ = "r10 d7 l10 u7 br20"   'create draw string to be read by function
ROW$ = "x"+VARPTR$(WIND$)+"x"+VARPTR$(WIND$)+"x"+VARPTR$(WIND$)+" x"+VARPTR$(WIND$)+"bl80 bd11"
LINE (100, 50)-(200, 160), , B
DRAW "bm 115,52"
FOR I = 1 TO 10
    DRAW "x" + VARPTR$(ROW$)
NEXT 

```

> *NOTE:'GWBasic** allows **semicolons** to be used in the ROW$ definition, but QBasic and **QB64** MUST use **+** concatenation.

Using the function to change a Turn Angle value using DRAW.

```vb

SCREEN 12
                           'Demonstrates how string DRAW angles are used with TA
FOR i = 0 TO 360 STEP 30           'mark clock hours every 30 degrees
  angle$ = STR$(i)                 'change degree value i to a string   
  PSET (175, 250), 6               'clock center
  DRAW "TA" + angle$ + "BU100"     'add string angle to Turn Angle and draw blind up
  CIRCLE STEP(0, 0), 5, 12         'place a circle at end of Up line
  DRAW "P9, 12"
  _DELAY .5           
NEXT
                            'Demonstrates how VARPTR$ is used with TA= 
DO: sec$ = RIGHT$(TIME$, 2)        'get current second value from time
  degree = VAL(sec$) * -6          'use a negative value to Turn Angle clockwise
  PSET (175, 250), 9               'clock center
  DRAW "TA=" + VARPTR$(degree) + "U90"  'VARPTR$ value requires = in DRAW
  DO: _LIMIT 30: LOOP UNTIL RIGHT$(TIME$, 2) <> sec$  'loop until seconds value changes
  IF INKEY$ <> "" THEN EXIT DO
  PSET (175, 250), 0
  DRAW "TA=" + VARPTR$(degree) + "U90"  'erase previous second hand draw
LOOP 

```

> *Explanation:* When the VARPTR$ value is used in DRAW, **=** MUST be used to pass the value to the draw! Negative Turn Angle values move clockwise and each second moves the hand 6 degrees. **TA** uses actual degree angles starting at 0 or noon.

Comparing DRAW moves using VARPTR$ and [STR$](STR$) values.

```vb

SCREEN 12
PSET (200, 200), 12
CIRCLE STEP(0, 0), 5, 10
A = 100: B = 100
DRAW "M+=" + VARPTR$(A) + ",-=" + VARPTR$(B)

PSET (400, 400), 10
CIRCLE STEP(0, 0), 5, 12
C = 100: D = -100
DRAW "M+" + STR$(C) + "," + STR$(D) 'must add + for positive relative moves
END 

```

> *Explanation:* A negative STR$ value will move the DRAW relatively where VARPTR$ won't without the sign before the equal.

## See Also

* [VARPTR](VARPTR), [STR$](STR$) 
* [DRAW](DRAW), [PLAY](PLAY)
