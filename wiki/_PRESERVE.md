The [_PRESERVE](_PRESERVE) [REDIM](REDIM) action preserves the current contents of [$DYNAMIC]($DYNAMIC) [arrays](arrays), when resizing or changing indices.

## Syntax
 
> [REDIM](REDIM) [_PRESERVE](_PRESERVE) array(newLowerIndex& [[TO](TO) newUpperIndex&]) [[AS](AS) variabletype]

## Description

* [REDIM](REDIM) or the [$DYNAMIC]($DYNAMIC) metacommand must be used when the array is first created to be able to resize and preserve.
* If [_PRESERVE](_PRESERVE) is not used, the current contents of the array are cleared by [REDIM](REDIM).
  * All element values of an array are preserved if the array size is increased.
  * The remaining elements of the array are preserved if the array size is decreased.
  * If the new index range is different from the original, all values will be moved to the new corresponding indices.
* **REDIM [_PRESERVE](_PRESERVE) cannot change the number of array dimensions, but can change the number of elements.**
* **Always use the same array [TYPE](TYPE) suffix ([AS](AS) type) or a new array type with the same name may be created.**

## Error(s)

* [SUB](SUB) or [FUNCTION](FUNCTION) arrays created using [REDIM](REDIM) require that they be recreated to be used after arrays are [ERASE](ERASE)d.
* **Warning:** Do not use negative upper array index values as an "Out of Memory" [ERROR Codes](ERROR-Codes) (or global Operating System errors) will occur.**
* Use [_PRESERVE](_PRESERVE) before [SHARED](SHARED) or an "invalid variable name" error will occur.

## Example(s)

Changing the upper and lower array bounds

```vb

REDIM a(5 TO 10) ' create array as dynamic using REDIM
a(5) = 123
REDIM _PRESERVE a(20 TO 40) 
PRINT a(20)

```

> *Explanation:* a(20) is now the 123 value a(5) was. The upper or lower bounds of arrays can be changed, but the type cannot. New array indices like a(40) are null(0) or empty strings. If the array element count is not reduced, all of the data will be preserved.

Sizing an array while storing file data.

```vb

REDIM Array$(1)                'create a dynamic string array
filename$ = "Readme.txt"       'Qb64 information text file
OPEN filename$ FOR INPUT AS #1
DO UNTIL EOF(1)
  count = count + 1
  IF count > UBOUND(Array$) THEN
    REDIM _PRESERVE Array$(count * 3 / 2)'increase array's size by 50% without losing data
  END IF

  LINE INPUT #1, textline$
  Array$(count) = textline$
LOOP
CLOSE #1 
FOR c = 1 TO count
PRINT Array$(c)
IF c MOD 20 = 0 THEN k$ = INPUT$(1)
NEXT 
END 

```

## See Also

* [REDIM](REDIM)
* [$DYNAMIC]($DYNAMIC)
* [Arrays](Arrays)
