**Bitmaps** are image files with the .BMP file name extension.

* Bitmaps can use 1, 4, 8 or 24/32 bits per pixel(BPP) color palettes.
* Unlike QBasic, QB64 is capable of working with 24 bit per pixel color(16 million) bitmaps and can create 32 bit screens to use them with the [_NEWIMAGE](_NEWIMAGE) function.
* Text SCREEN mode 0 cannot be screen saved in QBasic or QB64.
* The structure of the Bitmap header can be placed in a [TYPE](TYPE) definition as below. This information can be used to find out the bitmap's **Width** and **Height** dimensions, **Bits Per Pixel** used and the **offset** of the actual image pixel data.  
* It should be noted that **QB64's** [_LOADIMAGE](_LOADIMAGE) function can load bitmaps and other type of images directly into a program and be placed simply by using [_PUTIMAGE](_PUTIMAGE). [_NEWIMAGE](_NEWIMAGE) can create 256 or 32 bit [SCREEN (statement)](SCREEN-(statement)) modes to display those images.

## Bitmap Header

```vb

'Bitmap.BI can be included at start of program

TYPE BMPEntry              **' Description                          Bytes    QB64 Function** 
   ID AS STRING * 2        ' File ID("BM" text or 19778 AS Integer) 2      CVI("BM")
   Size AS LONG            ' Total Size of the file                 4      LOF
   Res1 AS INTEGER         ' Reserved 1 always 0                    2 
   Res2 AS INTEGER         ' Reserved 2 always 0                    2 
   Offset AS LONG          ' Start offset of image pixel data       4      (add one for GET)
END TYPE                   '                                 Total 14

TYPE BMPHeader          'BMP header also used in Icon and Cursor files(.ICO and .CUR)
   Hsize AS LONG           ' Info header size (always 40)           4 
   PWidth AS LONG          ' Image width                            4      _WIDTH(handle&)
   PDepth AS LONG          ' Image height (doubled in icons)        4      _HEIGHT(handle&)
   Planes AS INTEGER       ' Number of planes (normally 1)          2 
   BPP AS INTEGER          ' Bits per pixel(palette 1, 4, 8, 24)    2      _PIXELSIZE(handle&)
   Compression AS LONG     ' Compression type(normally 0)           4
   ImageBytes AS LONG      ' (Width + padder) * Height              4
   Xres AS LONG            ' Width in PELS per metre(normally 0)    4
   Yres AS LONG            ' Depth in PELS per metre(normally 0)    4
   NumColors AS LONG       ' Number of Colors(normally 0)           4       2 ^ BPP 
   SigColors AS LONG       ' Significant Colors(normally 0)         4
END TYPE                   '                 Total Header bytes =  40 

```

```vb

'$INCLUDE: 'Bitmap.BI'  'use only when including a BI file 
 
DIM SHARED ENT AS BMPEntry
DIM SHARED BMP AS BMPHeader 
LINE INPUT "Enter a bitmap file name: ", file$ '<<<< enter a bitmap file name

OPEN file$ FOR BINARY AS #1
GET #1, 1, ENT   'get entry header(1 is first file byte in QB64 and Qbasic)
GET #1, , BMP    'get bitmap header information 

PRINT "Size:"; ENT.Size; "bytes, Offset:"; ENT.Offset
PRINT BMP.PWidth; "X"; BMP.PDepth
PRINT "BPP ="; BMP.BPP 
CLOSE #1 

```

> *Explanation:* Use two [GET](GET)s to read all of the header information from the start of the bitmap file opened FOR [BINARY](BINARY). It reads all 54 bytes as [STRING](STRING), [INTEGER](INTEGER) and [LONG](LONG) type DOT variable values. [TYPE](TYPE) DOT variables do not require type suffixes!

*Snippet:* Use the DOT variable name values like this [GET (graphics statement)](GET-(graphics-statement)) after you load the bitmap image to the screen:

```vb

GET (0, 0)-(BMP.PWidth - 1, BMP.PDepth - 1), Image(48) 'index after 16 * 3 RGB palette colors(0 to 47) 

```

The bitmap image is now stored in an [Arrays](Arrays) to [BSAVE](BSAVE) to a file. The RGB color information follows the file header as [ASCII](ASCII) character values read using [ASC](ASC). The color values could be indexed at the start of the Array with the image being offset to: index = NumberOfColors * 3. As determined by the [SCREEN (statement)](SCREEN-(statement)) mode used. In SCREEN 13(256 colors) the index would be 768.

```text

                               **BITMAP COMPRESSION METHODS**

**Value	Identified by	Compression method	Comments**
  0	BI_RGB	            none	       Most common
  1	BI_RLE8	        * RLE 8-bit/pixel      Used only with 8-bit/pixel bitmaps
  2	BI_RLE4	        * RLE 4-bit/pixel      Used only with 4-bit/pixel bitmaps
  3	BI_BITFIELDS	  Bit field            Used only with 16 and 32-bit/pixel bitmaps.
  4	BI_JPEG	          JPEG	               Bitmap contains a JPEG image
  5	BI_PNG	          PNG	               Bitmap contains a PNG image
      
      * RLE stands for *Run Length Encoding* which counts the number of consecutive pixels 
        that are of the same color instead of assigning each pixel color separately. 

```

## Image Data

```text

                                     **Windows/OS2 Bitmaps**

                                         ┌─────────┐
                                         │BMP Entry│
                                         │ 14 Byte │
                                         │─────────│
                                         │ Bitmap  │   
                                         │ Header  │
                                         │ 40 Byte │
                                         └────┬────┘
                               ┌─────────┬────┴────┬─────────┐
                               │     ┌───┴───┐ ┌───┴───┐     │
                               │     │ 4 BPP │ │ 8 BPP │     │ 
                               │     │Palette│ │Palette│     │
                               │     │64 Byte│ │1024 B │     │
                           ┌───┴───┐ └───┬───┘ └───┬───┘ ┌───┴───┐      
                           │ 1 BPP │ ┌───┴───┐ ┌───┴───┐ │24 BPP │
                           │ IMAGE │ │ IMAGE │ │ IMAGE │ │ IMAGE │
                           │ DATA  │ │ DATA  │ │ DATA  │ │ DATA  │
                           │(W*H)\8│ │(W*H)\2│ │(W*H)*1│ │(W*H)*3│
                           │ bytes │ │ bytes │ │ bytes │ │ bytes │
                           └───────┘ └───────┘ └───────┘ └───────┘

```
 
**Bits Per Pixel (BPP)**

BPP returns **1 bit**(Black and white), **4 bit**(16 colors), **8 bit**(256 colors) or **24 bit**(16 million colors) for each pixel. In QBasic 24 bit can only be in greyscale, but QB64 can display them as True Color. 24 bit is also often referred to as 32 bit, but each pixel uses three bytes of information for the Red, Green and Blue color intensity settings. Intensity settings are read as [ASCII](ASCII) characters using [ASC](ASC).


**Palette Data (4 and 8 Bit Only)**

* **Attribute** color intensities for **4** and **8 BPP** are set by the bitmap itself using the **Palette data** immediately following the bitmap header. The data is read as Blue, Green and Red color intensities with a one byte padder following each BGR setting. This is true for ALL Windows/OS2 bitmap color intensities including 24 bit, which reads the intensities directly from the **image pixel data**!
**The Four Bit Palette is 64 bytes and the Eight Bit is 1024 bytes. One Bit and 24/32 Bit have no palette data!**

Note: [_COPYPALETTE](_COPYPALETTE) may be required to adapt the [SCREEN](SCREEN) palette to the custom colors of the bitmap.

> Why BGR instead of RGB? Because the [LONG](LONG) [_RGBA32](_RGBA32) value with 0 [_ALPHA](_ALPHA) is written to a file as 4 [MKL$](MKL$) [ASCII](ASCII) characters.

```vb

SCREEN 13 '8 bit, 256 color screen mode
Q$ = CHR$(34)
INPUT "Enter a color number 1 to 255: ", colour
PRINT
OUT &H3C7, colour
red = INP(&H3C9) * 4
green = INP(&H3C9) * 4
blue = INP(&H3C9) * 4
alpha = 0 'alpha values > 127 in _RGBA or _RGBA32 should use _UNSIGNED LONG

COLOR _RGB(red, green, blue) 'returns closest attribute in 4 or 8 bit screen modes
rgba~& = _RGBA32(red, green, blue, alpha) 'alpha is actually highest byte
PRINT "RGBA ="; red; green; blue; alpha
PRINT "_RGBA32 ="; rgba~&; " &H"; HEX$(rgba~&)

_PRINTSTRING (40, 40), "BGR0 = " + Q$ + MKL$(rgba~&) + Q$ 'rightmost always CHR$(0) spacer

END 

```

> *Note:* 16 colors at 4 bytes each = 64 bytes. 256 colors at 4 bytes each = 1024 bytes in the palette data with [CHR$](CHR$)(0) spacers.

**Warning! Use [_UNSIGNED](_UNSIGNED) [LONG](LONG) when comparing [_RGB](_RGB) or [_RGB32](_RGB32) full [_ALPHA](_ALPHA) values with [POINT](POINT) values!**

**Image Data**

* **Image data** starts immediately after the bitmap header with **One Bit** and **24 Bit** colors. Immediately after the palette data with **4 Bit** and **8 Bit** colors. Image pixel data is read starting with the data from the **BOTTOM** row of the image. This is another idiosyncrasy of the Windows/OS2 bitmap. The pixel columns thankfully are read left to right. You may notice the image being drawn from the bottom up in QBasic. The size of the data in a 24 Bit bitmap is almost triple the size of an 8 Bit one!

**NOTE: The header Offset sets the position as the byte preceding the image data!**

**Image Data Padding Prevents Image Skewing**

* Image data is **byte padded** for odd bitmap widths and a minimum pixel byte width as set below:
  - **1 BPP:** minimum pixel widths of multiples of 32 (32 bits = 4 bytes) per row. Use: Padder bytes = 32 - (width MOD 32)
  - **4 BPP:** minimum pixel widths of multiples of 8 (32 bits = 4 bytes) per row. Padder bytes = (8 - (width MOD 8)) \ 2
  - **8 BPP:** minimum pixel widths of multiples of 4 (4 bytes) per row. Padder bytes = 4 - (width MOD 4)
  - **24 BPP:** minimum pixel widths of multiples of 4 (3 bytes/pixel = 12 bytes) per row. Padder bytes = 4 - ((width * 3) MOD 4)

## One Bit:##  

Since the pixel value is either on(white) or off(black), eight pixels can be stored in one byte of information. The total byte value determines which pixels are on or off. The **MSB**(highest)value is to the left and each pixel's on value decreases by an exponent of two down to a value of 1 for the **LSB**. However a minimum of 4 bytes of data must be used for each row of data, so a padder is used for other widths. The padder can be determined before the data is read using the following routine:

```vb
 
SUB OneBit          'Any Screen as Black and White        
BitsOver = BMP.PWidth MOD 32  'check bitmap width for 4 byte or odd width
IF BitsOver THEN ZeroPAD$ = SPACE$((32 - BitsOver) \ 8) '16 and 48 wide have 2 byte padder
y = BMPHead.PDepth - 1: o$ = " "
GET #1, BMP.Offset, o$  ' offset is last byte of BMP header data (NO Palette)
a$ = " "       'define a one byte string to read ASCII characters
DO
x = 0
    DO
      GET #1, , a$
      CharVAL = ASC(a$)        'ASCII value cannot use _BYTE
      Bit = 128                   'start at MSB 
      FOR BitCOUNT = 1 TO 8
        IF CharVAL AND Bit THEN 
          PSET (x, y), _RGB(255, 255, 255) '_RGB works in 1, 4, 8 or 32 bit screen mode
        ELSE PSET (x, y), _RGB(0, 0, 0) 'set pixels on as white
        END IF
        Bit = Bit / 2            'decrease exponent of 2 bit value 
        x = x + 1                'move one pixel to the right
      NEXT BitCOUNT
    LOOP WHILE x < BMP.PWidth  
    GET #1, , ZeroPAD$             'skip the padder bytes if any
    y = y - 1                      'move up one row from bottom
LOOP UNTIL y = -1
END SUB * *   

```
<sub>Code by Bob Seguin</sub>

> One bit pixels are also used to create [AND](AND) masks that can blend with a background for icons or cursors which are another form of bitmap. In fact, icons and cursors use a partial (40 byte) bitmap header! They just don't have the first 14 bytes of information. [PSET](PSET) can also use the B&W color values [_RGB](_RGB)(255, 255, 255) and [_RGB](_RGB)(0, 0, 0) when working in 4, 8 or 32 bit screen modes.

## Four Bit:##  

Pixels can use 16 colors in QBasic legacy [SCREEN (statement)](SCREEN-(statement)) modes 7, 8, 9, 12 and 13. After the bitmap header, the color **palette** is read to set the color intensities as explained above. Then the individual pixel attributes are read from the **image data**. Each **pixel** uses half a byte of color **attribute** information. To determine the pixel's attribute, each "nibble" is read by dividing the byte's [ASCII](ASCII) value by 16 for the first pixel's value while the second pixel's value is found using [AND](AND) 15 as shown below: 

```vb

SUB FourBIT  ' 4 bit(16 color) Screens 7, 8, 9, 12 or 13 
IF BMP.PWidth MOD 8 THEN ZeroPAD$ = SPACE$((8 - BMP.PWidth MOD 8) \ 2)
a$ = " "   
OUT &H3C8, 0                         'start at attribute 0 
FOR Colr = 0 TO 15        'read palette data for intensities    
    GET #1, , a$: Blu = ASC(a$) \ 4  'intensity is divided by 4 to use OUT
    GET #1, , a$: Grn = ASC(a$) \ 4
    GET #1, , a$: Red = ASC(a$) \ 4
    OUT &H3C9, Red          'NOTE: RGB settings could also be sent directly to an
    OUT &H3C9, Grn          'array when the data is to be stored by a file using 
    OUT &H3C9, Blu          'BSAVE or with one PUT # to a BINARY file in QB64
    GET #1, , a$          '--- skip unused spacer byte
NEXT Colr
o$ = " "
GET #1, BMP.Offset, o$    'Offset is the last byte of palette data
y = BMP.PDepth - 1: a$ = " "
DO
  x = 0                             'image placed at left side of screen
  DO   
    GET #1, , a$
    HiNIBBLE = ASC(a$) \ &H10       'ASCII value divided by 16 colors
    LoNIBBLE = ASC(a$) AND &HF      'ASCII value AND 15
    PSET (x, y), HiNIBBLE   
    x = x + 1
    PSET (x, y), LoNIBBLE
    x = x + 1
  LOOP WHILE x < BMPHead.PWidth
    GET #1, , ZeroPAD$           'skip padder bytes if any
    y = y - 1                    'move up one row from bottom
LOOP UNTIL y = -1
END SUB 

```
<sub>Code by Bob Seguin</sub>

**How Nibble values are read**

Each half of a byte of image pixel data stores a color attribute value from 0 to 15 or from 0000 to 1111 in binary with 1 designating that the bit is on. So when the two halves are added the [Binary](Binary) byte value for two white pixels totals 111111111 binary or 255. 

* To get the high nibble, divide the byte value by 16(&H10) using integer division: HiNibble = 255 \ 16 = 15
* To get the low nibble, use the byte value [AND](AND) 15(&HF) to get all set bit values up to 15: LoNibble = 255 AND 15 = 15

> [AND](AND) 15 will return any lower byte value while integer division by 16 will return any byte value over 15 as attributes 0 to 15.

> **QB64** can [GET (graphics statement)](GET-(graphics-statement)) a full Screen 12 image into one [BINARY](BINARY) file with [PUT](PUT) using an 80K [INTEGER](INTEGER) array instead of using 3 in QBasic!

## Eight Bit:

Pixels can use 256 colors in QBasic legacy [SCREEN (statement)](SCREEN-(statement)) mode 13 or a [_NEWIMAGE](_NEWIMAGE) Screen using 256 or "borrowing" screen 13. **Image data** is immediately after the 1024 bytes of **palette data** BGR intensity settings. Pixel **attributes** are each set by reading the byte's [ASCII](ASCII) value directly.  

```vb

SUB EightBIT   ' 8 Bit (256 color) Screen 13 Only  
IF BMP.PWidth MOD 4 THEN ZeroPAD$ = SPACE$(4 - (BMP.PWidth MOD 4)) 'check for padder
a$ = " "
OUT &H3C8, 0                           'start at attribute 0 
FOR Colr = 0 TO 255
    GET #1, , a$: Blu = ASC(a$) \ 4
    GET #1, , a$: Grn = ASC(a$) \ 4
    GET #1, , a$: Red = ASC(a$) \ 4
    OUT &H3C9, Red
    OUT &H3C9, Grn
    OUT &H3C9, Blu
    GET #1, , a$                        '--- skip unused spacer byte
NEXT Colr
y = BMP.PDepth - 1: o$ = " "
GET #1, BMP.Offset, o$   'Offset is last byte of palette data.
p$ = " "
DO: x = 0
  DO
    GET #1, , p$
    PSET (x, y), ASC(p$)
    x = x + 1
  LOOP WHILE x < BMP.PWidth
  GET #1, , ZeroPAD$                  'skip padder if any
  y = y - 1                            'move up one row from bottom
LOOP UNTIL y = -1
END SUB 

```
<sub>Code by Bob Seguin</sub>

## Twenty Four Bit:

For screen modes created by [_NEWIMAGE](_NEWIMAGE) using 24 or 32 bit bitmaps. **Image data** starts immediately after the bitmap header. There is no palette data! Each BGR **color intensity** is one byte of the [ASCII](ASCII) code value directly. Values range from 0 to 255 using **QB64's** [_RGB](_RGB) or [_RGB32](_RGB32) functions to set the [PSET](PSET) colors as below:

```vb

SUB TrueCOLOR            '24/32 BIT               
IF ((BMP.PWidth * 3) MOD 4) <> 0 THEN        '3 byte pixels
ZeroPAD$ = SPACE$((4 - ((BMP.PWidth * 3) MOD 4)))
END IF
y = BMP.PDepth - 1: o$ = " "
GET #1, BMP.Offset, o$       'Offset is last byte of BMP header data
R$ = " "
G$ = " "
B$ = " "
DO
x = 0                               'place image to left side of screen
  DO
    GET #1, , B$             'intensities read in reverse order BGR like palette
    GET #1, , G$
    GET #1, , R$
    red& = ASC(R$)           'read ASCII code value 0 to 255 (or use _UNSIGNED _BYTE)
    green& = ASC(G$)
    blue& = ASC(B$)
    PSET (x, y), _RGB(red&, green&, blue&) 'legacy screens give closest 4 or 8 bit attribute
    x = x + 1
  LOOP WHILE x < BMP.PWidth
  GET #1, , ZeroPAD$         'skip padder if any
  y = y - 1                         'move up one row from bottom
LOOP UNTIL y = -1
END SUB    

```
<sub>Code by Ted Weissgerber</sub>

> Why BGR instead of RGB? Because the [_RGB](_RGB) [LONG](LONG) value without [_ALPHA](_ALPHA) is written to the file backwards as [LEFT$](LEFT$)([MKL$](MKL$), 3).

**Converting to Grey Scale or Black and White**

The palettes can be set to greyscale by ignoring the actual **palette data** and/or averaging the pixel's RGB **image data**.
 It may also be necessary when trying to view 24 BPP bitmaps in SCREEN 12 or 13.

*See:* [Grey Scale Bitmaps](Grey-Scale-Bitmaps)

## Creating Bitmaps

In [BINARY](BINARY) files, numerical data can also be converted to [ASCII](ASCII) characters by using [MKI$](MKI$) for [INTEGER](INTEGER)s or [MKL$](MKL$) for [LONG](LONG) values. [GET](GET) can convert [_MK$](_MK$) values to numerical values and [PUT](PUT) can convert numerical values to [STRING](STRING) values. When the [LONG](LONG) [MKL$](MKL$) color values are [PUT](PUT) into bitmaps the Red value is placed as the third [ASCII](ASCII) character and the blue becomes the first character. That not only happens to the BGR palette data, but the BGR 24 bit image color values [PUT](PUT) using the [LEFT$](LEFT$) 3 bytes.

```vb

  pixelcolor$ = LEFT$(MKL$(_RGB(red%, green%, blue%)), 3) 

```

After the header, the RGB **color intensity palette** settings for **16** and **256** color bitmaps are created using [MKL$](MKL$) [ASCII](ASCII) characters set backwards as Blue, Green, Red and [CHR$](CHR$)(0) as a spacer. Four and Eight BPP bitmaps require that format.

The actual 4 bit or 8 bit image is read as [ASCII](ASCII) color attributes from the image bottom to the top for proper bitmap formatting adding padder spacing when needed. 24/32 bit images use 3 color intensity values as [ASCII](ASCII) character bytes in BGR order.

*Bitmap creation SUB programs:*

* [SAVEIMAGE](SAVEIMAGE) (Galleon's Full Image Bitmap creator)
* [SaveIcon32](SaveIcon32) (Creates Icons from any image)
* [Program ScreenShots](Program-ScreenShots) (Member program for Qbasic's legacy screen modes)
* [ThirtyTwoBit SUB](ThirtyTwoBit-SUB) (QB64 32 bit Image area to bitmap)

## See Also

* [_LOADIMAGE](_LOADIMAGE), [_PUTIMAGE](_PUTIMAGE)
* [SCREEN (statement)](SCREEN-(statement))
* [TYPE](TYPE), [_ICON](_ICON)
* [Icons and Cursors](Icons-and-Cursors)
* [GIF Images](GIF-Images)
* [Resource Table Extraction](Resource-Table-Extraction)
* [$EXEICON]($EXEICON) (Icons viewed in Windows Explorer)
