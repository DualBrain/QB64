The [_MEMGET](_MEMGET) statement reads a portion of a memory block at an OFFSET position into a variable, array or user defined type.

## Syntax

> [_MEMGET](_MEMGET) memoryBlock, bytePosition, destinationVariable

* memoryBlock is a [_MEM](_MEM) variable type memory block name created by [_MEMNEW](_MEMNEW) or the [_MEM (function)](_MEM-(function)) function.
* bytePosition is the memoryBlock.[OFFSET](OFFSET) memory start position plus any bytes to move into the block. 
* destinationVariable is the variable assigned to hold the data. The number of bytes read is determined by the variable [Variable Types](Variable-Types) used.

## Description

* The [_MEMGET](_MEMGET) statement is similar to the [GET](GET) statement used in files, but the position is required.
* The memory block name.[OFFSET](OFFSET) returns the starting byte position of the block. Add bytes to move into the block.
* The variable type held in the memory block can determine the next bytePosition to read. 
* [LEN](LEN) can be used to determine the byte size of numerical or user defined variable [Variable Types](Variable-Types)s regardless of the value held.
* [STRING](STRING) values should be of a defined length. Variable length strings can actually move around in memory and not be found.

## Example(s)

Shows how to read the PSET color values from a program's [SCREEN](SCREEN) memory to an array.

```vb

SCREEN 13
PSET (0, 0), 123
PSET (1, 0), 222 'create screen image

'here is an array
DIM screen_array(319, 199) AS _UNSIGNED _BYTE 'use screen dimensions from 0

'here's how we can copy the screen to our array
DIM m AS _MEM
m = _MEMIMAGE  '0 or no handle necessary when accessing the current program screen
_MEMGET m, m.OFFSET, screen_array()

'here's the proof
PRINT screen_array(0, 0) 'print 123
PRINT screen_array(1, 0) 'print 222 
END 

```

## See Also

* [_MEMGET (function)](_MEMGET-(function))
* [_MEMPUT](_MEMPUT)
* [_MEM](_MEM)
* [_MEMIMAGE](_MEMIMAGE)
* [_MEMFREE](_MEMFREE)
