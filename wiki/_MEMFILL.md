The [_MEMFILL](_MEMFILL) statement converts a value to a specified type, then fills memory with that type including any non-whole remainder.

## Syntax

> [_MEMFILL](_MEMFILL) memoryBlock, memoryBlock.OFFSET, fillBytes, value [AS variableType]

## Parameter(s)

* The memoryBlock [_MEM](_MEM) memory block is the block referenced to be filled.
* memoryBlock.OFFSET is the starting offset of the above referenced memory block.
* The fillBytes is the number of bytes to fill the memory block.
* The value is the value to place in the memory block at the designated OFFSET position. 
* A literal or variable value can be optionally set [AS](AS) a variable [Variable Types](Variable-Types) appropriate for the memory block.

## Description

* To clear previous data from a [_MEMNEW](_MEMNEW) memory block, use _MEMFILL with a value of 0.

## Example(s)

Filling array values quickly using FOR loops or a simple memory fill.

```vb

DIM a(100, 100) AS LONG
DIM b(100, 100) AS LONG

'filling array a with value 13
FOR i1 = 0 TO 100
    FOR i2 = 0 TO 100
        a(i1, i2) = 13
    NEXT
NEXT

'filling array b with value 13
DIM mema AS _MEM
mema = _MEM(b())
_MEMFILL mema, mema.OFFSET, mema.SIZE, 13 AS LONG
_MEMFREE mema 

```

## See Also

* [_MEM](_MEM), [_MEM (function)](_MEM-(function))
* [_MEMIMAGE](_MEMIMAGE), [_MEMNEW](_MEMNEW)
* [_MEMGET](_MEMGET), [_MEMPUT](_MEMPUT)
