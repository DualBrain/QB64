The [$STATIC]($STATIC) [Metacommand](Metacommand) allows the creation of static (unresizable) arrays.

## Syntax

> {[REM](REM) | ['](apostrophe) } [$STATIC]($STATIC)

## Description

* QBasic [Metacommand](Metacommand)s require a REM or apostrophy (') before them and are normally placed at the start of the main module.
* Static arrays cannot be resized. If a variable is used to size any array, it becomes [$DYNAMIC]($DYNAMIC).
* A [REDIM](REDIM) statement has no effect on [$STATIC]($STATIC) arrays except perhaps a [ERROR Codes](ERROR-Codes) at the [REDIM](REDIM) statement.
* The array's type cannot be changed once [DIM](DIM) and a literal value sets the dimensions and element size.
* [$STATIC]($STATIC) defined program [arrays](arrays) cannot be [REDIM](REDIM) or use [_PRESERVE](_PRESERVE).

## Example(s)

 When a variable is used, the array can be resized despite $STATIC. The array becomes [$DYNAMIC]($DYNAMIC).

```vb

'$STATIC

INPUT "Enter array size: ", size
DIM array(size)   'using an actual number instead of the variable will create an error!

REDIM array(2 * size)

PRINT UBOUND(array) 

```

>  *Note:* [DIM](DIM) using a literal numerical size will create a Duplicate definition error.

## See Also
 
* [$DYNAMIC]($DYNAMIC), [STATIC](STATIC)
* [Arrays](Arrays), [Metacommand](Metacommand)
