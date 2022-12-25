The [_MEMFREE](_MEMFREE) statement frees the designated memory block [_MEM](_MEM) value and must be used with all memory functions. 

## Syntax

> [_MEMFREE](_MEMFREE) memoryVariable

## Parameter(s)

* ALL designated [_MEM](_MEM) type memoryVariable values must be freed to conserve memory when they are no longer used or needed.

## Description

* Since [_MEM](_MEM) type variables cannot use a suffix, use [DIM](DIM) memoryVariable [AS](AS) [_MEM](_MEM) to create memory handle variables.
* All values created by memory functions must be freed using [_MEMFREE](_MEMFREE) with a valid [_MEM](_MEM) variable.

## See Also

* [_MEM](_MEM) (variable type)
* [_MEM (function)](_MEM-(function))
* [_MEMNEW](_MEMNEW) (function)
* [_MEMIMAGE](_MEMIMAGE) (function)
* [_MEMELEMENT](_MEMELEMENT) (function)
* [_MEMGET (function)](_MEMGET-(function))
