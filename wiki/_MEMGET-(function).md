The [_MEMGET](_MEMGET) function returns a value from a specific memory block name at the specified OFFSET using a certain variable type.

## Syntax

>  returnValue = [_MEMGET](_MEMGET)(memoryBlock, bytePosition, variableType)

## Parameter(s)

* Returns a value of the variableType designated. The holding variable must match that [TYPE](TYPE).
* memoryBlock is a [_MEM](_MEM) variable type memory block name created by [_MEMNEW](_MEMNEW) or the [_MEM (function)](_MEM-(function)) function.
* bytePosition is the memoryBlock.[OFFSET](OFFSET) memory start position plus any bytes to move into the block. 
* variableType is a variable [TYPE](TYPE) like [_BYTE](_BYTE), [INTEGER](INTEGER), [SINGLE](SINGLE), [DOUBLE](DOUBLE), etc.

## Description

* memoryBlock.[OFFSET](OFFSET) returns the starting byte position of the block. Add bytes to move into the block.
* The variable type held in the memory block can determine the next bytePosition to read. 
* [LEN](LEN) can be used to determine the byte size of numerical or user defined variable [Variable Types](Variable-Types)s regardless of the value held.
* [STRING](STRING) values should be of a defined length. Variable length strings can actually move around in memory and not be found.
* **_MEMGET variable values that are assigned a variable [Variable Types](Variable-Types) other than a memory type do not need to be freed.**

## Example(s)

[DEF SEG](DEF-SEG) and [VARPTR](VARPTR) are no longer necessary to do things in memory just like [POKE](POKE) and [PEEK](PEEK) do.

```vb

DIM o AS _MEM
o = _MEM(d&) 'OLD... o% = VARPTR(d&)
_MEMPUT o, o.OFFSET + 1, 3 AS _UNSIGNED _BYTE 'a POKE
v = _MEMGET(o, o.OFFSET + 1, _UNSIGNED _BYTE) 'a PEEK
PRINT v     'prints 3
PRINT d&    'prints 768 because the 2nd byte of d& has been set to 3 or 3 * 256
_MEMFREE o

```

> *Explanation:* The memory block and OFFSET are given by [_MEMPUT](_MEMPUT) and the _MEMGET function, with the designated type.

## See Also

* [_MEM](_MEM), [MEM (function)](MEM-(function))
* [_MEMGET](_MEMGET), [_MEMPUT](_MEMPUT)
* [_MEMNEW](_MEMNEW), [_MEMFILL](_MEMFILL)
* [_MEMCOPY](_MEMCOPY)
