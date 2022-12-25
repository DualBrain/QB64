The [DIM](DIM) statement is used to declare a variable or a list of variables as a specified data type or to dimension [$STATIC]($STATIC) or [$DYNAMIC]($DYNAMIC) [Arrays](Arrays).

## Syntax

 *To declare variables:*
>
> [DIM](DIM) [SHARED] *variable*[{suffix|[AS](AS) [[_UNSIGNED](_UNSIGNED)] *type*}] [, *variable2*...]]
>
 *To declare arrays:*
>
> [DIM](DIM) [SHARED] *array([lowest% [TO](TO)] highest%])*[{suffix|[AS](AS) [[_UNSIGNED](_UNSIGNED)] *type*}] [, *variable2*...]
>
 QB64 *Alternative Syntax:*
>
> [DIM](DIM) [SHARED] [AS](AS) [[_UNSIGNED](_UNSIGNED)] *typevariable*  [, *variable2*...]
>
> [DIM](DIM) [SHARED] [AS](AS) [[_UNSIGNED](_UNSIGNED)] *typearray([lowest% [TO](TO)] highest%])* [, *array2(elements)*...]

## Description

* Sets the [INTEGER](INTEGER) range of elements (indices) of a [STATIC](STATIC) array. If only one number is used, the [LBOUND](LBOUND) is 0 by default. 
* When used before an array is dimensioned, **[OPTION BASE](OPTION-BASE) 1** can set the default [LBOUND](LBOUND) of arrays to 1.
* DIM [SHARED](SHARED) shares variable values with sub-procedures without passing the value in a parameter.
* Use the [AS](AS) keyword to define a variable or array *type* [AS](AS)...
  * [INTEGER](INTEGER) (or use variable suffix **%**)
  * [LONG](LONG) (or use variable suffix **&**)
  * [SINGLE](SINGLE) (or use variable suffix **!** or no suffix by default)
  * [DOUBLE](DOUBLE) (or use variable suffix **#**)
  * [STRING](STRING) (or use variable suffix **$**). An AS multiplier can set the string [LEN](LEN). Ex: `DIM *variable* AS STRING * 8`
* **QB64** variable types: 
  * [_BIT](_BIT) (or use variable suffix **\`**). An AS multiplier can be used for multiple bits. Ex: `DIM *variable* AS _BIT * 8`
  * [_BYTE](_BYTE) (or use variable suffix **%%**)
  * [_INTEGER64](_INTEGER64) (or use variable suffix **&&**)
  * [_FLOAT](_FLOAT) (or use variable suffix **##**)
  * [_OFFSET](_OFFSET) (or use variable suffix **%&**)
  * DIM [AS](AS) [_MEM](_MEM) (the _MEM type has no type suffix).
* **Note: When a variable has not been defined or has no type suffix, the type defaults to [SINGLE](SINGLE).**
* When using the **[AS](AS) type variable-list** syntax, type symbols cannot be used.
* When the [$DYNAMIC]($DYNAMIC) metacommand or [REDIM](REDIM) is used, array element sizes are changeable (not [$STATIC]($STATIC)).
* Use [REDIM](REDIM) instead of DIM to dimension arrays as dynamic without the $DYNAMIC metacommand.
* Use [REDIM](REDIM) [_PRESERVE](_PRESERVE) in **QB64** to retain previous array values when changing the size of an array. 
* [REDIM](REDIM) [_PRESERVE](_PRESERVE) cannot change the number of array dimensions. An [ERROR Codes](ERROR-Codes) will occur.
* [$DYNAMIC]($DYNAMIC) arrays MUST be [REDIM](REDIM)ensioned if [ERASE](ERASE) or [CLEAR](CLEAR) are used, as the arrays are completely removed.
* All numerical variable types **except** SINGLE, DOUBLE and _FLOAT can be dimensioned as [_UNSIGNED](_UNSIGNED) (suffix ~) or positive only.
* **NOTE:** Many QBasic keyword variable names can be used with a [STRING](STRING) suffix ($). You cannot use them without the suffix, use a numerical suffix or use *DIM, [REDIM](REDIM), [_DEFINE](_DEFINE), [BYVAL](BYVAL) or [TYPE](TYPE) variable [AS](AS)* statements. **Although possible, it's recommended to avoid using reserved names.**
* **Warning: Do not use negative array upper bound index values, or OS access or "Out of Memory" [ERROR Codes](ERROR-Codes) will occur.**

## Example(s)

Defines Qt variable as a one byte fixed length string.

```vb

DIM Qt AS STRING * 1 

```

Dimensions and types an array.

```vb

DIM Image(2000) AS INTEGER

```

Dimensions array with an [INTEGER](INTEGER) type suffix.

```vb

DIM Image%(2000)  

```

Dimensions a range of [Arrays](Arrays) elements as [SHARED](SHARED) integers.

```vb

DIM SHARED Image(1 TO 1000) AS INTEGER 

```

Dimensions variable as an [Arrays](Arrays) of 8 elements of the type [UNSIGNED](UNSIGNED) BIT.

```vb

DIM bit(8) AS _UNSIGNED _BIT 

```

QB64 is more flexible than QBasic when it comes to "Duplicate Definition" errors. The following code does not error:

```vb

x = 1 'x is a SINGLE variable
PRINT x
DIM x AS LONG
PRINT x 

```

> *Explanation:* The [SINGLE](SINGLE) variable can be differentiated from the [LONG](LONG) x variable by using suffixes like x! or x& in later code.

The following code will create a "Name already in use" **status error** in QB64 when the variable types are the same.

```vb

x = 1 'x is a SINGLE variable
PRINT x
DIM x AS SINGLE
PRINT x 

```

> *Explanation:* QB64 gives an error because the creation of the new variable would make referring to the existing one impossible.

Using QB64's alternative syntax to declare multiple variables/arrays of the same type.

```vb

DIM AS LONG w, h, id, weight, index 'all of these variables are created as type LONG
DIM AS SINGLE x, y, z               'all of these variables are created as type SINGLE

```

## See Also

* [_DEFINE](_DEFINE), [_PRESERVE](_PRESERVE)
* [REDIM](REDIM), [TYPE](TYPE)
* [ERASE](ERASE), [CLEAR](CLEAR)
* [DEFINT](DEFINT), [DEFSNG](DEFSNG), [DEFLNG](DEFLNG), [DEFDBL](DEFDBL), [DEFSTR](DEFSTR)
* [Mathematical Operations](Mathematical-Operations), [Arrays](Arrays)
* [Variable Types](Variable-Types)
* [OPTION _EXPLICIT](OPTION--EXPLICIT)
