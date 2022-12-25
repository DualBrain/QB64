The [_READBIT](_READBIT) function is used to check the state of a specified bit of a integer value.

## Syntax

> result = [_READBIT](_READBIT)(numericalVariable, numericalValue)

## Parameter(s)

* numericalVariable is the variable to read the state of a bit of and can be of the following types: [_BYTE](_BYTE), [INTEGER](INTEGER), [LONG](LONG), or [_INTEGER64](_INTEGER64).
* Integer values can be signed or [_UNSIGNED](_UNSIGNED).
* numericalValue the number of the bit to be read.

## Description

* Used to check the current state of a bit in an integer value.
* Returns -1 if the bit is set(1), otherwise returns 0 if the bit is not set(0)
* Bits start at 0 (so a [_BYTE](_BYTE) has bits 0 to 7, [INTEGER](INTEGER) 0 to 15, and so on)

## Availability

* Version 1.4 and up.

## Example(s)

```vb

A~%% = _SETBIT(A~%%,4)
PRINT "Bit 4 is currently ";
IF _READBIT(A~%%,4) = -1 THEN PRINT "ON" ELSE PRINT "OFF"
PRINT "And bit 2 is currently ";
IF _READBIT(A~%%,2) = -1 THEN PRINT "ON" ELSE PRINT "OFF"

```

```text

Bit 4 is currently ON
And bit 2 is currently OFF

```

```vb

B& = 12589575
PRINT "B& ="; B&
FOR I%% = 31 TO 0 STEP -1 '32 bits for a LONG value
 Binary$ = Binary$ + LTRIM$(STR$(ABS(_READBIT(B&, I%%))))
NEXT I%%
PRINT "B& in binary is: "; Binary$

```

```text

B& = 12589575
B& in binary is: 00000000110000000001101000000111

```

## See Also

* [_SHL](_SHL), [_SHR](_SHR), [INTEGER](INTEGER), [LONG](LONG)
* [_SETBIT](_SETBIT), [_BYTE](_BYTE), [_INTEGER64](_INTEGER64)
* [_RESETBIT](_RESETBIT), [_TOGGLEBIT](_TOGGLEBIT)
