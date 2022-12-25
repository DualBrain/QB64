The [_RESETBIT](_RESETBIT) function is used to set a specified bit of a numerical value to 0 (OFF state).

## Syntax

> result = [_RESETBIT](_RESETBIT)(numericalVariable, numericalValue)

## Parameter(s)

* numericalVariable is the variable to set the bit of and can be of the following types: [_BYTE](_BYTE), [INTEGER](INTEGER), [LONG](LONG), or [_INTEGER64](_INTEGER64).
* Integer values can be signed or [_UNSIGNED](_UNSIGNED).
* numericalValue the number of the bit to be set.

## Description

* Can be used to manually manipulate individual bits of an integer value by setting them to 0 (OFF state).
* Resetting a bit that is already set to 0 will have no effect.
* Bits start at 0 (so a [_BYTE](_BYTE) has bits 0 to 7, [INTEGER](INTEGER) 0 to 15, and so on)

## Availability

* Version 1.4 and up.

## Example(s)

```vb

A~%% = 0 '_UNSIGNED _BYTE
PRINT A~%%
A~%% = _SETBIT(A~%%,6) 'set the seventh bit of A~%%
PRINT A~%%
A~%% = _RESETBIT(A~%%,6) 'Reset the seventh bit of A~%%
PRINT A~%%

```

```text

 0
 64
 0

```

## See Also

* [_SHL](_SHL), [_SHR](_SHR), [INTEGER](INTEGER), [LONG](LONG)
* [_SETBIT](_SETBIT), [_BYTE](_BYTE), [_INTEGER64](_INTEGER64)
* [_READBIT](_READBIT), [_TOGGLEBIT](_TOGGLEBIT)
