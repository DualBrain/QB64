The [_MEMEXISTS](_MEMEXISTS) function returns true (-1) if the memory block variable name specified exists in memory and false (0) if it does not.

## Syntax

> result = [_MEMEXISTS](_MEMEXISTS)(memBlock)

## Description

* The memBlock variable name must have been created using [DIM](DIM) memBlock [AS](AS) [_MEM](_MEM) type ([DIM](DIM)).
* The function verifies that the memory variable exists in memory before using a passed block, to avoid generating QB64 errors.
* Typically, this function is used by a [DECLARE LIBRARY](DECLARE-LIBRARY) [SUB](SUB) or [FUNCTION](FUNCTION) which accepts a [_MEM](_MEM) structure as input, to avoid an error.

## See Also

* [_MEM (function)](_MEM-(function))
* [_MEMELEMENT](_MEMELEMENT), [_MEMCOPY](_MEMCOPY)
* [_MEMIMAGE](_MEMIMAGE), [_MEMNEW](_MEMNEW)
* [_MEMGET](_MEMGET), [_MEMPUT](_MEMPUT)
* [_MEMFILL](_MEMFILL), [_MEMFREE](_MEMFREE)
