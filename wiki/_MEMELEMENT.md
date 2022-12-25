The [_MEMELEMENT](_MEMELEMENT) function returns a [_MEM](_MEM) block referring to a variable's memory, but not past it.

## Syntax

> memoryBlock = [_MEMELEMENT](_MEMELEMENT)(referenceVariable)

* The referenceVariable parameter designates the existing variable name using the memory block.
* _MEMELEMENT is the same as [_MEM](_MEM) but in an array it returns the specifications of an element, not the entire array.
* All values created by memory functions MUST be freed using [_MEMFREE](_MEMFREE) with a valid [_MEM](_MEM) variable type.
* The _MEMELEMENT type contains the following **read-only** elements where *name* is the variable name:
  * *name***.OFFSET** is the beginning offset of the memory block AS [_OFFSET](_OFFSET)
  * *name***.SIZE** returns the largest available region of memory of the ELEMENT in bytes AS [_OFFSET](_OFFSET)
  * *name***.ELEMENTSIZE** is the [_BYTE](_BYTE) size of the elements within the block AS [_OFFSET](_OFFSET)

    * 2 = [INTEGER](INTEGER) values have an element size of 2 bytes
    * 4 = [LONG](LONG) integer and [SINGLE](SINGLE) float values have an element size of 4 bytes
    * 8 = [DOUBLE](DOUBLE) float and [_INTEGER64](_INTEGER64) values have an element size of 8 bytes
    * 32 = [_FLOAT](_FLOAT) values have an element size of 32 bytes
    * [LEN](LEN) = [STRING](STRING) or [_OFFSET](_OFFSET) byte sizes vary so use [LEN](LEN)(variable) for the number of bytes.
  * *name***.TYPE** is the type (represented as bits combined to form a value) AS [LONG](LONG) (see below).

### .TYPE values (version 1.000 and up)

* 0 = UDT ([TYPE](TYPE)) or memory created by [_MEMNEW](_MEMNEW)
* 1 = 1 bit. ELEMENT.SIZE=1 *Only used along with specific types (currently integers or floats)*
* 2 = 2 bit. ELEMENT.SIZE=2
* 4 = 4 bit. ELEMENT.SIZE=4
* 8 = 8 bit. ELEMENT.SIZE=8 
* 16 = 16 bit. ELEMENT.SIZE=16
* 32 = 32 bit. ELEMENT.SIZE=32
* 64 = 64 bit. ELEMENT.SIZE=64
* 128 = 128 bit. ELEMENT.SIZE=128
* 256 = 256 bit. ELEMENT.SIZE=256
* 512(+ bit*) = integer types only(ie. whole numbers)
* 1024(+ bit*) = floating point types only(ie. numbers that can have a decimal point)
* 2048 = [STRING](STRING) type only
* 4096(+ 512 + bit*) = [_UNSIGNED](_UNSIGNED) integer type only
* 8192 = [_MEM](_MEM) type only
* 16384(+ 512 + bit*)= [_OFFSET](_OFFSET) type only

*Note: If a future integer, float or other type doesn't have a size that is 1,2,4,8,16,32,64,128 or 256 it won't have a size-bit set.*

#### Versions prior to 1.000

* 1 = Integer types such as [_BYTE](_BYTE), [INTEGER](INTEGER), [LONG](LONG), [_INTEGER64](_INTEGER64) or [_OFFSET](_OFFSET)
* 2 = [_UNSIGNED](_UNSIGNED) variable types. Value must be added to the variable type value.(2 cannot be used by itself)
* 3 = ALL [_UNSIGNED](_UNSIGNED) [INTEGER](INTEGER) type values.(add 1 + 2)
* 4 = Floating point types such as [SINGLE](SINGLE), [DOUBLE](DOUBLE) or [_FLOAT](_FLOAT)
* 8 = [STRING](STRING) 
* 0 = unknown(eg. created with [_MEMNEW](_MEMNEW)) or [TYPE](TYPE)

**Note: [_MEM](_MEM) and [_OFFSET](_OFFSET) values cannot be cast to other variable types.**

## Example(s)

Comparing the specifications returned by [_MEM](_MEM) and _MEMELEMENT from an array.

```vb

DIM a(1 TO 100) AS _UNSIGNED _BYTE

DIM m1 AS _MEM
DIM m2 AS _MEM

m1 = _MEM(a(50)) 'function returns information about array up to specific element
PRINT m1.OFFSET, m1.SIZE, m1.TYPE, m1.ELEMENTSIZE

m2 = _MEMELEMENT(a(50)) 'function returns information about the specific element
PRINT m2.OFFSET, m2.SIZE, m2.TYPE, m2.ELEMENTSIZE

END 

```

> Output using VERSION .954 ONLY .TYPE values: 1 (integer) + 2 (unsigned)

```text

28377205        51        3        1
28377205        1         3        1 

```

> *Explanation:* [_MEM](_MEM) returns the info about the array to that element while _MEMELEMENT returns info about that element only.

  * [_MEM](_MEM) value returns the available array .SIZE as 51 bytes from the designated array element.
  * [_MEMELEMENT](_MEMELEMENT) value returns the available element .SIZE as one byte.

## See Also

* [_MEM](_MEM)
* [_MEMNEW](_MEMNEW)
* [_MEMGET](_MEMGET), [_MEMPUT](_MEMPUT)
* [_MEMFREE](_MEMFREE)
