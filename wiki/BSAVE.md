[BSAVE](BSAVE) saves the contents of an image array to a [BINARY](BINARY) file.

## Legacy Support

* QB64 can save larger arrays directly to binary files using [PUT](PUT) # and [GET](GET) # without [BSAVE](BSAVE). For that reason, use of [BSAVE](BSAVE) is no longer recommended practice but is supported to maintain compatibility with legacy code.

## Syntax

> [BSAVE](BSAVE) saveFile$, [VARPTR](VARPTR)(array(index)), fileSize&

## Parameter(s)

* saveFile$ is the STRING file name of the file designated to be created.
* array(index) is the image [arrays](arrays) that already holds the [GET (graphics statement)](GET-(graphics-statement)) image data.
* fileSize& must be a bit over twice the size of the elements used in an [INTEGER](INTEGER) [Arrays](Arrays).

## Description

* To place image data into the array, use [GET (graphics statement)](GET-(graphics-statement)) to store a box area image of the screen.
* [SCREEN](SCREEN) 12 can only GET 1/3 of the screen image at one time using a 26K array. 
* Image arrays are [DIM](DIM)ensioned as [INTEGER](INTEGER). Use [DEFINT](DEFINT) when working with large graphic arrays.
* Any arrays can be saved, but image arrays are most common.
* [DEF SEG](DEF-SEG) = [VARSEG](VARSEG) must be used to designate the array segment position in memory.
* [VARPTR](VARPTR) returns the array index offset of the memory segment. Array sizes are limited to 32767 Integer elements due to the use of [VARPTR](VARPTR) in QBasic and **QB64**'s emulated conventional memory.
* [BSAVE](BSAVE) files can later be opened with [BLOAD](BLOAD).

## Example(s)

Saving array data to a file quickly.

```vb

LB% = LBOUND(Array)
bytes% = LEN(Array(LB%))
filesize& = ((UBOUND(Array) - LB%) + 1) * bytes% 
DEF SEG = VARSEG(Array(0))
BSAVE filename$, VARPTR(Array(LB%)), filesize&  ' changeable index
DEF SEG 

```

> *Explanation:* Procedure determines the filesize from the array size automatically. [LBOUND](LBOUND) is used with [UBOUND](UBOUND) to determine array size and byte size. Works with any type of array except variable-length strings. Used for saving program data fast.

[BSAVE](BSAVE)ing a bitmap and calculating the file size

```vb

 DEF SEG = VARSEG(Image(0))
 PSET(BMPHead.PWidth - 1, BMPHead.PDepth - 1)  'color lower right corner if black
 GET (0, 0)-(BMPHead.PWidth - 1, BMPHead.PDepth - 1), Image(NColors * 3) ' for 16 or 256 colors
 FOR a& = 26000 TO 0 STEP -1
   IF Image(a&) THEN ArraySize& = a&: EXIT FOR
 NEXT
 BSAVE SaveName$, VARPTR(Image(0)), (2 * ArraySize&) + 200 'file size
 DEF SEG 

```

> *Explanation:* The [FOR...NEXT](FOR...NEXT) loop reads backwards through the image array until it finds a value not 0. The [LONG](LONG) ArraySize& value is doubled and 200 is added. BMPhead.PWidth and BMPhead.PDepth are found by reading the bitmap's information header using a [TYPE](TYPE) definition. See [Bitmaps](Bitmaps).

Using [PUT](PUT) and [GET](GET) to write and read array data from a file without using BSAVE or [BLOAD](BLOAD):

```vb

KILL "example2.BIN" 'removes old image file!

SCREEN 13
OPTION BASE 0
REDIM Graphic%(1001) 'REDIM makes array resize-able later

LINE (0, 0)-(10, 10), 12, B 'create image
GET(0, 0)-STEP(10, 10), Graphic%() 'get image to array

FOR i% = 1000 TO 0 STEP -1 'reverse read array for size needed
    IF Graphic%(i%) <> 0 THEN EXIT FOR 'find image color not black
NEXT
size% = i% + 4 'size plus 2 integers(4  bytes) for dimensions 
REDIM _PRESERVE Graphic%(size%) 'resize existing array in QB64 only!

OPEN "example2.BIN" FOR BINARY AS #1 ' PUT to a file
PUT #1, , Graphic%()
CLOSE

OPEN "example2.BIN" FOR BINARY AS #2 'GET array and PUT to screen
DIM CopyBin%(LOF(2) \ 2) 'create new array sized by half of file size
GET #2, , CopyBin%()
PUT(100, 100), CopyBin%(), PSET
fsize% = LOF(2)
CLOSE

K$ = INPUT$(1) 'Press any key 
FOR i = 0 TO 20 'read all 3 arrays
    PRINT Graphic%(i); CopyBin%(i)
NEXT
PRINT "Array:"; size%, "File:"; fsize%

```

> *Explanation:* A 10 by 10 pixel box is saved to an array using the [GET (graphics statement)](GET-(graphics-statement)) and written to a BINARY file using [PUT](PUT) #1. Then [GET](GET) #1 places the file contents into another INTEGER array and places it on the screen with the [PUT (graphics statement)](PUT-(graphics-statement)).

>  The array contents: 88 is the width in the GET array for [SCREEN](SCREEN) 13 which needs divided by 8 in that mode only. The area is actually 11 X 11. The array size needed can be found by looping backwards through the array until a color value is found. **IF array(i) <> 0 THEN EXIT FOR** (66 integers) or by dividing the created BINARY file size in half (134 bytes) when known to be array sized already.

## See Also

* [GET (graphics statement)](GET-(graphics-statement)), [PUT (graphics statement)](PUT-(graphics-statement))
* [BLOAD](BLOAD), [OPEN](OPEN), [BINARY](BINARY)
* [GET](GET), [PUT](PUT) (file statements)
* [VARSEG](VARSEG), [VARPTR](VARPTR)
* [DEF SEG](DEF-SEG), [TYPE](TYPE)
* [Text Using Graphics](Text-Using-Graphics)
