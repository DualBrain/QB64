The [_SETBIT](_SETBIT) function is used to set a specified bit of a numerical value to 1 (on state).

## Syntax

> result = [_SETBIT](_SETBIT)(numericalVariable, numericalValue)

## Parameter(s)

* numericalVariable is the variable to set the bit of and can be of the following types: [_BYTE](_BYTE), [INTEGER](INTEGER), [LONG](LONG), or [_INTEGER64](_INTEGER64).
* Integer values can be signed or [_UNSIGNED](_UNSIGNED).
* numericalValue the number of the bit to be set.

## Description

* Can be used to manually manipulate individual bits of an integer value by setting them to 1 (on state).
* Setting a bit that is already set to 1 will have no effect.
* Bits start at 0 (so a [_BYTE](_BYTE) has bits 0 to 7, [INTEGER](INTEGER) 0 to 15, and so on)

## Availability

* Version 1.4 and up.

## Example(s)

```vb

A~%% = 0 '_UNSIGNED _BYTE
PRINT A~%%
A~%% = _SETBIT(A~%%,6) 'set the seventh bit of A~%%
PRINT A~%%

```

```text

 0
 64

```

## See Also

* [_SHL](_SHL), [_SHR](_SHR), [INTEGER](INTEGER), [LONG](LONG)
* [_READBIT](_READBIT), [_BYTE](_BYTE), [_INTEGER64](_INTEGER64)
* [_RESETBIT](_RESETBIT), [_TOGGLEBIT](_TOGGLEBIT)
