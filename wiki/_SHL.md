The [_SHL](_SHL) function is used to shift the bits of a numerical value to the left.

## Syntax

> result = [_SHL](_SHL)(numericalVariable, numericalValue)

## Parameter(s)

* numericalVariable is the variable to shift the bits of and can be of the following types: [INTEGER](INTEGER), [LONG](LONG),[_INTEGER64](_INTEGER64), or [_BYTE](_BYTE).
* Integer values can be signed or [_UNSIGNED](_UNSIGNED).
* numericalValue is the number of places to shift the bits.
* While 0 is a valid value it will have no affect on the variable being shifted.

## Description

* Allows for multiplication of a value by 2 faster than normal multiplication (see example 2 below).
* Bits that reach the end of a variable's bit count are dropped (when using a variable of the same type - otherwise they will carry over).
* The type of variable used to store the results should match the type of the variable being shifted.

## Availability

* Version 1.3 and up.

## Example(s)

```vb

A~%% = 1 'set right most bit of an_UNSIGNED _BYTE
PRINT A~%%
PRINT _SHL(A~%%,7)
B~%% = _SHL(A~%%,8) 'shift the bit off the left 'edge'
PRINT B~%%

```

```text

 1
 128
 0

```

```vb

A~%% = 1
FOR I%% = 0 TO 8
    PRINT _SHL(A~%%, I%%)
NEXT I%%

```

```text

   1
   2
   4
   8
  16
  32
  64
 128
 256

```

* Note: When directly [PRINT](PRINT)ing to screen, the result is calculated internally using a larger variable type so the left most bit is carried to the next value.
  * To avoid this store the result in a variable of the same type before printing.

## See Also

* [_SHR](_SHR), [INTEGER](INTEGER), [LONG](LONG)
* [_BYTE](_BYTE), [_INTEGER64](_INTEGER64)
