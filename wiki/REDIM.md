A REDIM statement can re-dimension one [$DYNAMIC]($DYNAMIC)(flexible) [Arrays](Arrays) or a [comma](comma) separated list of arrays.

## Syntax

> [**REDIM**](REDIM) [[**_PRESERVE**](_PRESERVE)] [[**SHARED**](SHARED)] ArrayName[[*type_suffix*](Variable-Types)] ({*max_element* | *low_element*[[**TO**](TO) *upper_element*, ...]}) [[**AS**](AS) Type]
>
> [**REDIM**](REDIM) [[**_PRESERVE**](_PRESERVE)] [[**SHARED**](SHARED)] [[**AS**](AS) Type] ArrayName({*max_element* | *low_element*[[**TO**](TO) *upper_element*, ...]})

## Description

* Can change the number of elements in an array (the present array data is lost unless [_PRESERVE](_PRESERVE) is used).
* Dynamic array elements can also be sized or resized by a program user's entry.
* The [_PRESERVE](_PRESERVE) option also allows the *element* range values to be moved upward or downward.
* Array is the name of the array to be dimensioned or re-dimensioned.
* elements is the number of elements the array should hold. Use the optional [TO](TO) elements2 to set a range.
* **Always use the same array [TYPE](TYPE) suffix ([AS](AS) type) or a new array type with the same name may be created.**
* REDIM cannot change [$STATIC]($STATIC) arrays created with a [DIM](DIM) statement unless the [$DYNAMIC]($DYNAMIC) [metacommand](metacommand) is used.
* To create a dynamic array use the [$DYNAMIC]($DYNAMIC) metacommand or use [REDIM](REDIM) rather than [DIM](DIM) when first creating the array.
* Use REDIM [_PRESERVE](_PRESERVE) to change the range or number of array elements without losing the remaining elements. Data may move up or down to accommodate those boundary changes.  
* **REDIM [_PRESERVE](_PRESERVE) cannot change the number of array dimensions or type.**
* [$DYNAMIC]($DYNAMIC) arrays MUST be [REDIM](REDIM)ensioned if [ERASE](ERASE) or [CLEAR](CLEAR) are used to clear the arrays as they no longer exist. 
* When [AS](AS) is used to declare the type, use [AS](AS) to retain that type or it will change to [SINGLE](SINGLE)!
* **Warning! Do not use negative array upper bound index values as OS access or "Out of Memory" [ERROR Codes](ERROR-Codes) will occur.**
* When using the **AS type variable-list** syntax, type symbols cannot be used.

## Example(s)

The [$DYNAMIC]($DYNAMIC) metacommand allows an array to be re-sized using [DIM](DIM) and REDIM.

```vb

'$DYNAMIC

INPUT "Enter array size: ", size 
DIM Array(size)

REDIM Array(2 * size)

PRINT UBOUND(Array) 

```

Shows the difference between REDIM and REDIM [_PRESERVE](_PRESERVE).

```vb

REDIM array(20)
array(10) = 24

PRINT array(10)

REDIM _PRESERVE array(30)
PRINT array(10)

REDIM array(15)
PRINT array(10) 

```

```text

 24
 24
 0

```

> *Explanation:* REDIM without _PRESERVE erases the array data and cannot change the number of dimensions.

## See Also

* [Arrays](Arrays) 
* [DIM](DIM), [SHARED](SHARED)
* [_PRESERVE](_PRESERVE), [ERASE](ERASE)
* [$DYNAMIC]($DYNAMIC), [$STATIC]($STATIC)
