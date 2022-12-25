The [_ASIN](_ASIN) function returns the angle measured in radians based on an input [SIN](SIN)e value ranging from -1 to 1.

## Syntax

> radian_angle! = [_ASIN](_ASIN)(sine_value!)

## Description

* The sine_value! must be measured >= -1 and <= 1, or else it will generate a return value of **-1.#IND**, which is basically QB64's way of telling us that the number doesn't exist. 
* ARCSINE is the inverse function of [SIN](SIN)e, and turns a [SIN](SIN)e value back into an angle.
* Note: Due to rounding with floating point math, the [_ASIN](_ASIN) may not always give a perfect match for the [SIN](SIN) angle which generated this. You can reduce the number of rounding errors by increasing the precision of your calculations by using [DOUBLE](DOUBLE) or [_FLOAT](_FLOAT) precision variables instead of [SINGLE](SINGLE).

## Availability

* Version 1.000 and up.

## Example(s)

Converting a radian angle to its SINe and using that value to find the angle in degrees again using _ASIN:

```vb

DEFDBL A-Z

INPUT "Give me an Angle (in Degrees) => "; Angle
PRINT
C = SIN(_D2R(Angle)) '_D2R is the command to convert Degrees to Radians, which is what SIN expects
PRINT "The SINE of the Angle is: "; C
A = _ASIN(C)
PRINT "The ASIN of "; C; " is: "; A
PRINT "Notice, A is the Angle in Radians.  If we convert it to degrees, the value is "; _R2D(A) 

```

```text

Give me an Angle (in Degrees) => ? 60

The SINE of the Angle is:  .8660254037844386
The ACOS of   .8660254037844386  is:   1.047197551196598
Notice, A is the Angle in Radians.  If we convert it to degrees, we discover the value is  60

```

## See Also

* [_D2G](_D2G) (degree to gradient, [_D2R](_D2R) (degree to radian)
* [_G2D](_G2D) (gradient to degree), [_G2R](_G2R) (gradient to degree
* [_R2D](_R2D) (radian to degree), [_R2G](_R2G) (radian to gradient
* [COS](COS) (cosine), [SIN](SIN) (sine), [TAN](TAN) (tangent)
* [_ACOS](_ACOS) (arc cosine), [ATN](ATN) (arc tangent)
* [_ACOSH](_ACOSH) (arc hyperbolic  cosine), [_ASINH](_ASINH) (arc hyperbolic  sine), [_ATANH](_ATANH) (arc hyperbolic  tangent)
* [_ATAN2](_ATAN2) (Compute arc tangent with two parameters)
* [_HYPOT](_HYPOT) (hypotenuse)
*[Mathematical Operations](Mathematical-Operations)
