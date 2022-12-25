**Fast Bitmap Export routine using memory for use with 32-bit color images ONLY**

```vb

PRINT "This program will create a 32 bit bitmap of the desktop!"
PRINT "                 IN 2 SECONDS..."
_DELAY 2

picture& = _SCREENIMAGE
x1% = 0: y1% = 0
x2% = _WIDTH(picture&) - 1
y2% = _HEIGHT(picture&) - 1

SaveBMP32 x1%, x2%, y1%, y2%, picture&, "ScreenShot.bmp" 

```

```text
  
SUB SaveBMP32 (x1%, x2%, y1%, y2%, image&, Filename$)

TYPE BMPFormat ' Description                          Bytes    QB64 Function
    ID AS STRING * 2 'File ID("BM" or 19778 AS Integer) 2  CVI("BM")
    Size AS LONG ' Total Size of the file               4  LOF
    Blank AS LONG ' Reserved                            4
    Offset AS LONG ' Start offset of image pixel data   4 (add one for GET)
    Hsize AS LONG ' Info header size (always 40)        4
    PWidth AS LONG ' Image width                        4  _WIDTH(handle&)
    PDepth AS LONG ' Image height (doubled in icons)    4  _HEIGHT(handle&)
    Planes AS INTEGER ' Number of planes (normally 1)   2
    BPP AS INTEGER 'Bits per pixel(palette 1, 4, 8, 24) 2  _PIXELSIZE(handle&)
    Compression AS LONG ' Compression type(normally 0)  4
    ImageBytes AS LONG ' (Width + padder) * Height      4
    Xres AS LONG ' Width in PELS per metre(normally 0)  4
    Yres AS LONG ' Depth in PELS per metre(normally 0)  4
    NumColors AS LONG ' Number of Colors(normally 0)    4    2 ^ BPP
    SigColors AS LONG ' Significant Colors(normally 0)  4
END TYPE '                     ' Total Header bytes =  54

DIM BMP AS BMPFormat
DIM x AS LONG, y AS LONG
DIM temp AS STRING * 3
DIM m AS _MEM, n AS _MEM
DIM o AS _OFFSET
m = _MEMIMAGE(image&) 'get image information from memory handle
DIM Colors8%(255)

IF x1% > x2% THEN SWAP x1%, x2%
IF y1% > y2% THEN SWAP y1%, y2%
_SOURCE image&
pixelbytes& = 4
OffsetBITS& = 54 'no palette in 24/32 bit
BPP% = 24
NumColors& = 0 '24/32 bit say zero
BMP.PWidth = (x2% - x1%) + 1
BMP.PDepth = (y2% - y1%) + 1

ImageSize& = BMP.PWidth * BMP.PDepth

BMP.ID = "BM"
BMP.Size = ImageSize& * 3 + 54
BMP.Blank = 0
BMP.Offset = 54
BMP.Hsize = 40
BMP.Planes = 1
BMP.BPP = 24
BMP.Compression = 0
BMP.ImageBytes = ImageSize&
BMP.Xres = 3780
BMP.Yres = 3780
BMP.NumColors = 0
BMP.SigColors = 0

Compression& = 0
WidthPELS& = 3780
DepthPELS& = 3780
SigColors& = 0
f = FREEFILE
n = _MEMNEW(BMP.Size) 'allocate memory for file data
_MEMPUT n, n.OFFSET, BMP 'place bitmap header in memory
o = n.OFFSET + 54   'offset after header for RGB color data
'                   'run memory reads without error checking!
$CHECKING:OFF
y = y2% + 1
w& = _WIDTH(image&)
DO
    y = y - 1: x = x1% - 1
    DO
        x = x + 1
        _MEMGET m, m.OFFSET + (w& * y + x) * 4, temp 'read 3 color bytes
        _MEMPUT n, o, temp  'place into n memory after o offset
        o = o + 3  'increase offset 3 bytes per loop
    LOOP UNTIL x = x2%
LOOP UNTIL y = y1%
$CHECKING:ON
_MEMFREE m
OPEN Filename$ FOR BINARY AS #f
t$ = SPACE$(BMP.Size)
_MEMGET n, n.OFFSET, t$
PUT #f, , t$
_MEMFREE n
CLOSE #f
END SUB

```
<sub>Code by Steve McNeill</sub>

**SUB for 32 BIT COLOR IMAGES ONLY!**

## See Also

* [SAVEIMAGE](SAVEIMAGE) (QB64 Image to Bitmap SUB by Galleon)
* [Program ScreenShots](Program-ScreenShots) (Member program for legacy screen modes)
* [ThirtyTwoBit SUB](ThirtyTwoBit-SUB) (QB64 Image area to bitmap)
