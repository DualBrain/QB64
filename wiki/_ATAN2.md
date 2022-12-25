The [_ATAN2](_ATAN2) function returns the radian angle between the positive x-axis of a plane and the point given by the coordinates (x, y).

## Syntax

> angle! = [_ATAN2](_ATAN2)(y, x)

## Parameter(s)

* y is the vertical axis position (row) as a positive, zero or negative floating point value.
* x is the horizontal axis position (column) as a positive, zero or negative floating point value. 

## Description

* The [DOUBLE](DOUBLE) radian angle returned is **positive** for upper row values where y > 0.
  * _ATAN2(y, x) = [ATN](ATN)(y# / x#) when x > 0
  * _ATAN2(y, x) = [ATN](ATN)(y# / x#) + [_PI](_PI) when x < 0
  * _ATAN2(y, x) = [_PI](_PI) / 2 when x = 0
* The [DOUBLE](DOUBLE) radian angle returned is 0 when x > 0 and [_PI](_PI) when x < 0 where y = 0 
* The [DOUBLE](DOUBLE) radian angle returned is **negative** for lower row values where y < 0.
  * _ATAN2(y, x) = [ATN](ATN)(y# / x#) when x > 0
  * _ATAN2(y, x) = [ATN](ATN)(y# / x#) - [_PI](_PI) when x < 0
  * _ATAN2(y, x) = -[_PI](_PI) / 2 when x = 0
* _ATAN2(0, 0) is undefined and the function returns 0 instead of a division error.

## Error(s)

* With [ATN](ATN)(y / x), x can never be 0 as that would create a Division by Zero [ERROR Codes](ERROR-Codes) 11 or #IND.

## See Also

* [ATN](ATN) (arctangent)
* [_PI](_PI) (QB64 function)
* [Mathematical Operations](Mathematical-Operations)
* [Atan2 reference](https://en.wikipedia.org/wiki/Atan2)
