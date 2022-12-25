The [ERASE](ERASE) statement is used to clear all data from an array. [$STATIC]($STATIC) [Arrays](Arrays) dimensions are not affected.

## Syntax

> ERASE *arrayName* [, *arrayName2*...]

## Description

* All string array elements become null strings ("") and all numerical array elements become 0.
* Multiple arrays can be erased using commas between the array names.
* [$DYNAMIC]($DYNAMIC) arrays must be [REDIM](REDIM)ensioned if they are referenced after erased. 
* Dimension subprocedure arrays as [STATIC](STATIC) to use [ERASE](ERASE) and not have to REDIM.
* You do not have to include array brackets in an [ERASE](ERASE) call.

## See Also

* [DIM](DIM), [REDIM](REDIM)
* [CLEAR](CLEAR)
* [STATIC](STATIC)
* [$DYNAMIC]($DYNAMIC)
* [Arrays](Arrays)
