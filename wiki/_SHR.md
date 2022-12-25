The [_SHR](_SHR) function is used to shift the bits of a numerical value to the right.

## Syntax

> result = [_SHR](_SHR)(numericalVariable, numericalValue)

## Parameter(s)

* numericalVariable is the variable to shift the bits of and can be of the following types: [INTEGER](INTEGER), [LONG](LONG), [_INTEGER64](_INTEGER64), or [_BYTE](_BYTE).
* Integer values can be signed or [_UNSIGNED](_UNSIGNED).
* numericalValue the number of places to shift the bits.
* While 0 is a valid value it will have no affect on the variable being shifted.

## Description

* Allows for division of a value by 2 faster than normal division (see example 2 below).
* Bits that reach the end of a variables bit count are dropped.
* The type of variable used to store the results should match the type of the variable being shifted.
* NOTE: When dealing with SIGNED variables, shifting the bits right will leave the sign bit set. This is due to how C++ deals with bit shifting under the hood. 

## Availability

* Version 1.3 and up.

## Example(s)

```vb

A~%% = 128 'set left most bit of an_UNSIGNED _BYTE
PRINT A~%%
PRINT _SHR(A~%%,7)
PRINT _SHR(A~%%,8) 'shift the bit off the right 'edge'

```

```text

 128
 1
 0

```

```vb

A~%% = 128
FOR I%% = 0 TO 8
    PRINT _SHR(A~%%, I%%)
NEXT I%%

```

```text

 128
  64
  32
  16
  8
  4
  2
  1
  0

```

## See Also

* [_SHL](_SHL), [INTEGER](INTEGER), [LONG](LONG)
* [_BYTE](_BYTE), [_INTEGER64](_INTEGER64)
