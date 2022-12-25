The [CLEAR](CLEAR) statement clears all variable and array element values in a program.

## Syntax

> [CLEAR](CLEAR) [, ignored& , ignored&]

## Description

* All parameters are optional and ignored by **QB64**.
* Normally used to clear all program variable and [Arrays](Arrays) values where numerical values become zero and string values become empty ("").
* It does not clear [CONST](CONST) values.
* Closes all opened files.
* [$DYNAMIC]($DYNAMIC) or [REDIM](REDIM) arrays will need to be [REDIM](REDIM) or an [ERROR Codes](ERROR-Codes) will occur when referenced because they are removed.

## Example(s)

Using CLEAR to clear array elements from [STATIC](STATIC) arrays or arrays created using [DIM](DIM).

```vb

CLS
DIM array(10)   'create a $STATIC array
array(5) = 23

PRINT array(5)

CLEAR

PRINT array(5) 

```

> *Note:* If you change DIM to REDIM a "Subscript out of range" error will occur because a [$DYNAMIC]($DYNAMIC) array is removed by CLEAR.

## See Also

* [ERASE](ERASE)
* [REDIM](REDIM), [_PRESERVE](_PRESERVE)
* [Arrays](Arrays), [&B](&B)
