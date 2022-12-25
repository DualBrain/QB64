The [_PI](_PI) function returns **�** as a [_FLOAT](_FLOAT) value with an optional multiplier parameter.

## Syntax

> circumference = [_PI](_PI)[(multiplier)] 

## Parameter(s)

* Optional multiplier (*2 * radius* in above syntax) allows multiplication of the π value.

## Description

* Function can be used in to supply π or multiples in a program.
* Accuracy is determined by the return variable type [AS](AS) [SINGLE](SINGLE), [DOUBLE](DOUBLE) or [_FLOAT](_FLOAT).
* The � value can also be derived using 4 * [ATN](ATN)(1) for a [SINGLE](SINGLE) value.

## Example(s)

Calculating the area of a circle using a [SINGLE](SINGLE) variable in this case.

```vb

radius = 5
circlearea = _PI(radius ^ 2)
PRINT circlearea

``` 

```text

 78.53982

```

## See Also

* [_ATAN2](_ATAN2), [TAN](TAN)
* [ATN](ATN) (arctangent)
* [SIN](SIN), [COS](COS)
