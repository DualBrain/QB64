The [$DYNAMIC]($DYNAMIC) [Metacommand](Metacommand) allows the creation of dynamic (resizable) arrays.

## Syntax
 
> {[REM](REM) | ['](apostrophe) } [$DYNAMIC]($DYNAMIC)

## Description

* QBasic [Metacommand](Metacommand) require [REM](REM) or [Apostrophe](Apostrophe) (') before them and are normally placed at the start of the main module.
* Dynamic arrays can be resized using [REDIM](REDIM). The array's type cannot be changed.
* All data in the array will be lost when [REDIM](REDIM)ensioned except when [_PRESERVE](_PRESERVE) is used.
* [REDIM](REDIM) [_PRESERVE](_PRESERVE) can preserve and may move the previous array data when the array boundaries change.
* [_PRESERVE](_PRESERVE) allows the [UBOUND](UBOUND) and [LBOUND](LBOUND) boundaries of an array to be changed. The number of dimensions cannot change.
* [$DYNAMIC]($DYNAMIC) arrays must be [REDIM](REDIM)ensioned if [ERASE](ERASE) or [CLEAR](CLEAR) are used as the arrays are removed completely.

## Example(s)

[REDIM](REDIM)ing a $DYNAMIC array using [_PRESERVE](_PRESERVE) to retain previous array values.

```vb

REM $DYNAMIC             'create dynamic arrays only
DIM array(10)            'create array with 11 elements
FOR i = 0 TO 10
  array(i) = i: PRINT array(i); 'set and display element values
NEXT
PRINT
REDIM _PRESERVE array(10 TO 20)
FOR i = 10 TO 20
  PRINT array(i);
NEXT
END 

```

```text

0  1  2  3  4  5  6  7  8  9  10

0  1  2  3  4  5  6  7  8  9  10

```

## See Also

* [$STATIC]($STATIC), [$INCLUDE]($INCLUDE)
* [DIM](DIM), [REDIM](REDIM), [_DEFINE](_DEFINE)
* [STATIC](STATIC)
* [ERASE](ERASE), [CLEAR](CLEAR)
* [Arrays](Arrays), [Metacommand](Metacommand)
