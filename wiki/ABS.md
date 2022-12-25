The [ABS](ABS) function returns the unsigned numerical value of a variable or literal value.

## Syntax

> positive = [ABS](ABS)(numericalValue)

## Description

* [ABS](ABS) always returns positive numerical values. The value can be any numerical type.
* Often used to keep a value positive when necessary in a program. 
* Use [SGN](SGN) to determine a value's sign when necessary.
* **QB64** allows programs to return only positive [_UNSIGNED](_UNSIGNED) variable values using a [DIM](DIM) or [_DEFINE](_DEFINE) statement.

## Example(s)

Finding the absolute value of positive and negative numerical values.

```vb

a = -6
b = -7
c = 8
IF a < 0 THEN a = ABS(a)
b = ABS(b)
c = ABS(c)
PRINT a, b, c 

```

```text

 6        7        8

```

## See Also

* [SGN](SGN), [DIM](DIM)
* [_UNSIGNED](_UNSIGNED)
* [_DEFINE](_DEFINE)
* [Mathematical Operations](Mathematical-Operations)
