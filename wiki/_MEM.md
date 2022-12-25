The [_MEM](_MEM) variable type can be used when working with memory blocks. It has no variable [Variable Types](Variable-Types) suffix.

## Syntax

> [DIM](DIM) m [AS](AS) [_MEM](_MEM)

## Description

* The _MEM type contains the following **read-only** elements where *name* is the _MEM variable name:
  * *name*.**OFFSET** is the current start position in the memory block [AS](AS) [_OFFSET](_OFFSET). Add bytes to change position.
  * *name*.**SIZE** is the remaining size of the block at current position in bytes [AS](AS) [_OFFSET](_OFFSET)
  * *name*.**TYPE** is the type (represented as bits combined to form a value) [AS](AS) [LONG](LONG):

* Memory DOT values are actually part of the built in memory variable [Variable Types](Variable-Types) in QB64. The following [TYPE](TYPE) is built in:


```vb

TYPE memory_type
  OFFSET AS _OFFSET       'start location of block(changes with byte position)
  SIZE AS _OFFSET         'size of block remaining at offset(changes with position)
  TYPE AS LONG            'type description of variable used(never changes)
  ELEMENTSIZE AS _OFFSET  'byte size of values inside the block(never changes)
  IMAGE AS LONG           'the image handle used when _MEMIMAGE(handle) is used
  SOUND AS LONG           'the sound handle used when _MEMSOUND(handle) is used
END TYPE
```

The above [TYPE](TYPE) is for clarification purposes only. It **doesn't need** to be pasted in a program to use _MEM.

**IMPORTANT NOTE:** As of Build 20170802/57 onward, _mem.TYPE_ has been changed to be an [_OFFSET](_OFFSET), just as _mem.SIZE_ and _mem.ELEMENTSIZE_.

    
### TYPE values (version 1.000 and up)
      
* 0 = UDT ([TYPE](TYPE)) or memory created by [_MEMNEW](_MEMNEW)
* 1 = 1 bit   ELEMENT.SIZE=1   * Only used along with specific types (currently integers or floats)
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

### Versions prior to 1.000
     
* 1 = Integer types such as [_BYTE](_BYTE), [INTEGER](INTEGER), [LONG](LONG), [_INTEGER64](_INTEGER64) or [_OFFSET](_OFFSET)
* 2 = [_UNSIGNED](_UNSIGNED) variable types. Value must be added to the variable type value.(2 cannot be used by itself)
* 3 = ALL [_UNSIGNED](_UNSIGNED) [INTEGER](INTEGER) type values.(add 1 + 2)
* 4 = Floating point types such as [SINGLE](SINGLE), [DOUBLE](DOUBLE) or [_FLOAT](_FLOAT)
* 8 = [STRING](STRING) 
* 0 = unknown(eg. created with [_MEMNEW](_MEMNEW)) or [TYPE](TYPE)

* **Note: [_OFFSET](_OFFSET) values cannot be cast to other variable [Variable Types](Variable-Types)s reliably. _MEM is a reserved custom variable [Variable Types](Variable-Types).**
* **[_MEM (function)](_MEM-(function)) cannot reference variable length [STRING](STRING) variable values. String values must be designated as a fixed-[LEN](LEN) string.**

## Example(s)

Demonstration of .IMAGE to determine an image's dimensions, .TYPE to verify the type and [_MEMEXISTS](_MEMEXISTS) to check image has not been freed

```vb

SCREEN _NEWIMAGE(500, 500, 32)
i = _LOADIMAGE("qb64_trans.png", 32)
_PUTIMAGE (0, 0), i
DIM m AS _MEM
m = _MEMIMAGE(i)
'try uncommenting the following line and see what happens
'_MEMFREE m
t = m.TYPE
IF t AND 2048 THEN
  PRINT "this is/was an image"
  IF _MEMEXISTS(m) THEN 'check if memory m is still available
    PRINT t AND 7; "bytes per pixel"
    PRINT "image handle "; m.IMAGE
    PRINT "image width"; _WIDTH(m.IMAGE)
    PRINT "image height"; _HEIGHT(m.IMAGE)
  ELSE PRINT "Memory already freed!"
  END IF
END IF 

```

Converts the current [_DEST](_DEST) [SCREEN](SCREEN) 13 image memory altered by [PSET](PSET) to a [STRING](STRING) value. SCREEN 13 only.

```vb

SCREEN 13
PSET (0, 0), ASC("H") 'top left corner of screen
PSET (1, 0), ASC("E")
PSET (2, 0), ASC("L")
PSET (3, 0), ASC("L")
PSET (4, 0), ASC("O")

DIM m AS _MEM
m = _MEMIMAGE(0)  'copy the screen memory to m
x1$ = _MEMGET(m, m.OFFSET, STRING * 5) 'get at block start position
LOCATE 2, 1:PRINT LEN(x1$) 'prints 5 bytes as size is STRING * 5
PRINT x1$ 'prints HELLO as ASCII character values
PRINT m.OFFSET; m.SIZE; m.ELEMENTSIZE
_MEMFREE m 

```

```text

 5
HELLO
 5448320  6400  1

```

> *Explanation:* When a numerical [_BYTE](_BYTE) value is converted to a [STRING](STRING), each byte is converted to an [ASCII](ASCII) character. The QB64 IDE will capitalize _MEM dot values.

```text

                                        m.SIZE = 320 * 200 = 6400 bytes
                                        m.ELEMENTSIZE = 1 byte

```

Using _MEM to convert _OFFSET to _INTEGER64.

```vb

DIM x AS INTEGER
DIM m AS _MEM
m = _MEM(x)
PRINT m.OFFSET
PRINT ConvertOffset(m.OFFSET)

FUNCTION ConvertOffset&& (value AS _OFFSET)
$CHECKING:OFF
DIM m AS _MEM 'Define a memblock
m = _MEM(value) 'Point it to use value
$IF 64BIT THEN
    'On 64 bit OSes, an OFFSET is 8 bytes in size.  We can put it directly into an Integer64
    _MEMGET m, m.OFFSET, ConvertOffset&& 'Get the contents of the memblock and put the values there directly into ConvertOffset&&
$ELSE
    'However, on 32 bit OSes, an OFFSET is only 4 bytes.  We need to put it into a LONG variable first
    _MEMGET m, m.OFFSET, temp& 'Like this
    ConvertOffset&& = temp& 'And then assign that long value to ConvertOffset&&
$END IF
_MEMFREE m 'Free the memblock
$CHECKING:ON
END FUNCTION

```

*Explanation:* The above will print two numbers which should match.  These numbers will vary, as they're representations of where X is stored in memory, and that position is going to vary every time the program is run.  What it should illustrate, however, is a way to convert _OFFSET to _INTEGER64 values, which can sometimes be useful when trying to run calculations involving mem.SIZE, mem.TYPE, or mem.ELEMENTSIZE.

## See Also

* [_MEM (function)](_MEM-(function))
* [_MEMELEMENT](_MEMELEMENT), [_MEMCOPY](_MEMCOPY)
* [_MEMIMAGE](_MEMIMAGE), [_MEMNEW](_MEMNEW)
* [_MEMSOUND](_MEMSOUND)
* [_MEMGET](_MEMGET), [_MEMPUT](_MEMPUT)
* [_MEMFILL](_MEMFILL), [_MEMFREE](_MEMFREE)
