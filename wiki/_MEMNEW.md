The [_MEMNEW](_MEMNEW) function allocates new memory and returns a [_MEM](_MEM) memory block referring to it.

## Syntax

> memoryBlock = [_MEMNEW](_MEMNEW)(byteSize)

## Parameter(s)

* The byteSize parameter is the desired byte size of the memory block based on the variable [Variable Types](Variable-Types) it will hold.

## Description

* The memoryBlock value created holds the elements .OFFSET, .SIZE, .TYPE and .ELEMENTSIZE. 
* [_MEMNEW](_MEMNEW) does not clear the data previously in the memory block it allocates, for speed purposes.
* To clear previous data from a new memory block, use [_MEMFILL](_MEMFILL) with a byte value of 0.
* When a new memory block is created the memory .TYPE value will be 0.
* **If the read only memory block .SIZE is 0, the memory block was not created.**
* **All values created by memory functions must be freed using [_MEMFREE](_MEMFREE) with a valid [_MEM](_MEM) variable.**

## Example(s)

Shows how [SINGLE](SINGLE) numerical values can be passed, but non-fixed [STRING](STRING) lengths cannot get the value.

```vb

DIM m AS _MEM
DIM f AS STRING * 5
m = _MEMNEW(5) 'create new memory block of 5 bytes
a = 12345.6
_MEMPUT m, m.OFFSET, a 'put single value
_MEMGET m, m.OFFSET, b 'get single value
PRINT "b = "; b
c$ = "Doggy"
_MEMPUT m, m.OFFSET, c$ 'put 5 byte string value
_MEMGET m, m.OFFSET, d$ 'get unfixed length string value
_MEMGET m, m.OFFSET, f  'get 5 byte string value
e$ = _MEMGET(m, m.OFFSET, STRING * 5) 'get 5 byte string value
PRINT "d$ = "; d$; LEN(d$) 'prints empty string
PRINT "e$ = "; e$; LEN(e$)
PRINT "f = "; f; LEN(f) 

```

```text

b =  12345.6
d$ =  0
e$ = Doggy 5
f = Doggy 5 

```

## See Also

* [_MEM](_MEM), [_MEMPUT](_MEMPUT)
* [_MEMGET](_MEMGET), [_MEMGET (function)](_MEMGET-(function))
* [_MEMFILL](_MEMFILL), [_MEMFREE](_MEMFREE)
