The [_MEM](_MEM) function returns a _MEM block referring to the largest possible continuous memory region beginning at a variable's offset.

## Syntax

> memoryBlock = [_MEM](_MEM)(referenceVariable)

### Unsecure syntax

> memoryBlock = [_MEM](_MEM)(offset, byteSize)

## Parameter(s)

* The memoryBlock created will hold the referenceVariable or [arrays](arrays) value(s), type and byte size in a separate memory area.
* The secure syntax referenceVariable is an existing variable's referenced memory block.
* The unsecure syntax's designated offset and byteSize cannot be guaranteed. **Avoid if possible.**

## Description

* The memoryBlock [_MEM](_MEM) type variable holds the following read-only elements: OFFSET, SIZE, TYPE and ELEMENTSIZE.
* All values created by memory functions MUST be freed using [_MEMFREE](_MEMFREE) with a valid [_MEM](_MEM) variable type.
* **_MEM function cannot reference variable length [STRING](STRING) variable values. String values must be designated as a fixed-[LEN](LEN) string.**

## Example(s)

Assigning values to reference variables in memory.

```vb

DIM SHARED m(3) AS _MEM
DIM SHARED Saved(3)

m(1) = _MEM(x)
m(2) = _MEM(y)
m(3) = _MEM(z)

x = 3: y = 5: z = 8
PRINT x, y, z
Save x, y, z
x = 30: y = 50: z = 80
PRINT x, y, z

RestoreIt
PRINT x, y, z

_MEMFREE m(1)
_MEMFREE m(2)
_MEMFREE m(3)
END

SUB Save (n1, n2, n3)
Saved(1) = n1
Saved(2) = n2
Saved(3) = n3
END SUB

SUB RestoreIt
_MEMPUT m(1), m(1).OFFSET, Saved(1)
_MEMPUT m(2), m(2).OFFSET, Saved(2)
_MEMPUT m(3), m(3).OFFSET, Saved(3)
END SUB 

```

## See Also

* [_MEM](_MEM) (variable type)
* [_MEMNEW](_MEMNEW), [_MEMCOPY](_MEMCOPY)
* [_MEMGET](_MEMGET), [_MEMPUT](_MEMPUT)
* [_MEMFILL](_MEMFILL), [_MEMIMAGE](_MEMIMAGE)
* [_MEMFREE](_MEMFREE)
