The [CONST](CONST) statement globally defines one or more named numeric or string values which will not change while the program is running.

## Syntax

> [CONST](CONST) constantName = value[, ...]

## Parameter(s)

* constantName is the constant name or list of names assigned by the programmer.
* value is the value to initialize the global constant which cannot change once defined.
  * If constantName specifies a numeric type, value must be a numeric expression containing literals and other constants.
  * If constantName specifies a string type, the value must be a literal value.

## Description

* The constantName does not have to include a type suffix. The datatype is automatically infered by the compiler using the value.
* Constant values cannot reference a variable or [FUNCTION](FUNCTION) return values.
  * The exception to the above are the internal functions: [_PI](_PI), [_ACOS](_ACOS), [_ASIN](_ASIN), [_ARCSEC](_ARCSEC), [_ARCCSC](_ARCCSC), [_ARCCOT](_ARCCOT), [_SECH](_SECH), [_CSCH](_CSCH), [_COTH](_COTH), [COS](COS), [SIN](SIN), [TAN](TAN), [LOG](LOG), [EXP](EXP), [ATN](ATN), [_D2R](_D2R), [_D2G](_D2G), [_R2D](_R2D), [_R2G](_R2G), [_G2D](_G2D), [_G2R](_G2R), [ABS](ABS), [SGN](SGN), [INT](INT), [_ROUND](_ROUND), [_CEIL](_CEIL), [FIX](FIX), [_SEC](_SEC), [_CSC](_CSC), [_COT](_COT), [ASC](ASC), [_RGB32](_RGB32), [_RGBA32](_RGBA32), [_RGB](_RGB), [_RGBA](_RGBA), [_RED32](_RED32), [_GREEN32](_GREEN32), [_BLUE32](_BLUE32), [_ALPHA32](_ALPHA32), [_RED](_RED), [_GREEN](_GREEN), [_BLUE](_BLUE), [_ALPHA](_ALPHA) (See Example 2 below).
* Constants cannot be reassigned values. They retain the same value throughout all of the program procedures.
* Constants defined in module-level code have [SHARED](SHARED) scope, so they can also be used in [SUB](SUB) or [FUNCTION](FUNCTION) procedures.
* Constants defined in [SUB](SUB) or [FUNCTION](FUNCTION) procedures are local to those procedures.
* [CLEAR](CLEAR) will not affect or change constant values.

## Example(s)

Display the circumference and area of circles:

```vb

' Declare a numeric constant approximately equal to the ratio of a circle's
' circumference to its diameter:
CONST PI = 3.141593

' Declare some string constants:
CONST circumferenceText = "The circumference of the circle is"
CONST areaText = "The area of the circle is"

DO
    INPUT "Enter the radius of a circle or zero to quit"; radius
    IF radius = 0 THEN END
    PRINT circumferenceText; 2 * PI * radius 
    PRINT areaText; PI * radius * radius ' radius squared
    PRINT
LOOP

```

```text

Enter the radius of a circle or zero to quit? *10*
The circumference of the circle is 62.83186
The area of the circle is 314.1593

Enter the radius of a circle or zero to quit? *123.456*
The circumference of the circle is 775.697
The area of the circle is 47882.23

Enter the radius of a circle or zero to quit? *0*

```

>  *Explanation:* PI cannot change as it is a mathematical constant so it is fitting to define it as a constant. Trying to change PI will result in a calculation error.

*Example 2*: Using _RGB32 to set a constant's value.

```vb

CONST Red = _RGB32(255,0,0)

COLOR Red
PRINT "Hello World"

```

## See Also

* [DIM](DIM), [SHARED](SHARED)
* [STATIC](STATIC), [COMMON](COMMON)
* [_PI](_PI), [_RGB32](_RGB32), [_RGBA32](_RGBA32)
* [Windows 32 API constant values](http://doc.pcsoft.fr/en-US/?6510001)
