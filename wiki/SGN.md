The **SGN** function returns the sign of a number value.

## Syntax

> sign% = SGN(value)

* Returns -1 when a sign is negative, 0 when a value is zero, or 1 when a value is positive.
* Function is used to store the original sign of a number.
* **QB64** allows programs to return only [_UNSIGNED](_UNSIGNED) variable values using a [_DEFINE](_DEFINE) statement.

## Example(s)

Checking and changing negative values to positive ones.

```vb

n = -100
IF SGN(n) = -1 THEN n = ABS(n)
PRINT n 

```

```text

 100

```

## See Also
 
* [ABS](ABS)
* [_DEFINE](_DEFINE), [_UNSIGNED](_UNSIGNED) 
* [Mathematical Operations](Mathematical-Operations)
