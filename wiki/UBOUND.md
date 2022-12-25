The UBOUND function returns the largest valid index (upper bound) of an array dimension.

## Syntax

> *result%* = UBOUND(arrayName[, dimension%])

## Description

* arrayName specifies the name of the array.

* dimension% specifies the dimension number, starting with 1 for the first dimension.
  * If omitted, dimension% is assumed to be 1.
  * If dimension% is less than 1 or is greater than the number of dimensions, a [ERROR Codes](ERROR-Codes) error occurs.

* UBOUND, along with LBOUND, is used to determine the range of valid indexes of an array.

## Example(s)

```vb

DIM myArray(5) AS INTEGER
DIM myOtherArray(1 to 2, 3 to 4) AS INTEGER

PRINT UBOUND(myArray)
PRINT UBOUND(myOtherArray, 2)

```

```text

 5
 4

```

## See Also

* [Arrays](Arrays), [LBOUND](LBOUND)
* [DIM](DIM), [COMMON](COMMON), [STATIC](STATIC), [SHARED](SHARED)
