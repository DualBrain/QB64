The [_TOGGLEBIT](_TOGGLEBIT) function is used to toggle a specified bit of a numerical value.

## Syntax

> result = [_TOGGLEBIT](_TOGGLEBIT)(numericalVariable, numericalValue)

## Parameter(s)

* numericalVariable is the variable to toggle the bit of and can be of the following types: [_BYTE](_BYTE), [INTEGER](INTEGER), [LONG](LONG), or [_INTEGER64](_INTEGER64).
* Integer values can be signed or [_UNSIGNED](_UNSIGNED).
* numericalValue the number of the bit to be set.

## Description

* Can be used to manually manipulate individual bits of an integer value by toggling their state.
* A bit set to 1 is changed to 0 and a bit set to 0 is changed to 1.
* Bits start at 0 (so a [_BYTE](_BYTE) has bits 0 to 7, [INTEGER](INTEGER) 0 to 15, and so on)

## Availability

* Version 1.4 and up.

## Example(s)

*Example 1:*

```vb

A~%% = 0 '_UNSIGNED _BYTE
PRINT A~%%
A~%% = _TOGGLEBIT(A~%%,4) 'toggle the fourth bit of A~%%
PRINT A~%%
A~%% = _TOGGLEBIT(A~%%,4) 'toggle the fourth bit of A~%%
PRINT A~%%

```

```text

 0
 16
 0

```

## See Also

* [_SHL](_SHL), [_SHR](_SHR), [INTEGER](INTEGER), [LONG](LONG)
* [_SETBIT](_SETBIT), [_BYTE](_BYTE), [_INTEGER64](_INTEGER64)
* [_RESETBIT](_RESETBIT), [_READBIT](_READBIT)
