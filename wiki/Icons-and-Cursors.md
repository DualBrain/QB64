**Icons** and **Cursors** are image files with ICO or CUR filename extensions.

* Both can use 1 BPP(B & W), 4 BPP(16), 8 BPP(256) or 24/32 BPP(16 million) colors.
* They are formatted similar to bitmaps, but each file can hold more than one image.
* Images can be different sizes and use different color palettes. The image width and depth are usually the same and multiples of 16 up to 128. Use [_UNSIGNED](_UNSIGNED) [_BYTE](_BYTE) values in the Entry header.
* Normal Icon and Cursor sizes are multiples of 16 such as 16 X 16, 32 X 32, 48 X 48 and 64 X 64.
* Each image has an XOR and an AND image mask to allow background transparency in the white pixel areas. Change background areas to white in the [AND](AND) mask for irregular shapes.
* The [XOR](XOR) mask is normally different colors while the [AND](AND) mask is 1 BPP where black is translucent(solid) and white transparent.
* The AND image mask is placed on a background using a process like [PUT (graphics statement)](PUT-(graphics-statement)) with the AND action by the Operating System.
* Then the [XOR](XOR) mask is placed on top of the blackened areas to display the image colors.
* The resulting image can allow any background to be seen through the [AND](AND) mask parts of the image that are white.

## Icon Headers

```vb

' ******************* ICONCUR.BI
' INCLUDE this BI file at the start of a program
'
TYPE ICONTYPE            'Icon or cursor file header
  Reserved AS INTEGER    'Reserved (always 0)
  ID AS INTEGER          'Resource ID (Icon = 1, Cursor = 2)
  Count AS INTEGER       'Number of icon bitmaps in Directory of icon entries array
END TYPE '6 bytes

TYPE ICONENTRY           'or unanimated Cursor entry (ANI are animated cursors)
  PWidth AS _UNSIGNED _BYTE 'Width of icon in pixels (USE THIS)
  PDepth AS _UNSIGNED _BYTE 'Height of icon in pixels (USE THIS)
  NumColors AS _BYTE     'Maximum number of colors. (2, 8 or 16 colors. 256 or 24/32 bit = 0)
  RES2 AS _BYTE          'Reserved. Not used (always 0)
  HotSpotX AS INTEGER    'Icon: NumberPlanes(normally 0), Cursor: hotspot pixels from left
  HotSpotY AS INTEGER    'Icon: BitsPerPixel(normally 0), Cursor: hotspot pixels from top
  DataSize AS LONG       'Length of image data in bytes minus Icon and Entry headers (USE THIS)
  DataOffset AS LONG     'Start Offset byte position of icon bitmap header(add 1 if [TYPE](TYPE) GET)
END TYPE '16 bytes      ** 'BMP header and image data follow ALL entry data(after 22, 38, 54, etc.)**

TYPE BMPHEADER           'Bitmap type header found using entry DataOffset + 1
  IconHSize AS LONG      'size of ICON header (always 40 bytes)
  ICONWidth AS LONG      'bitmap width in pixels (signed integer).
  ICONDepth AS LONG      'Total map height in pixels (signed integer is 2 times image height)
  NumPlanes AS INTEGER   'number of color planes. Must be set to 1.
  BPP AS INTEGER         'bits per pixel  1, 4, 8, 16, 24 or 32.(USE THIS)
  Compress AS LONG       'compression method should always be 0.
  RAWSize AS LONG        'size of the raw ICON image data(may only be XOR mask size).
  Hres AS LONG           'horizontal resolution of the image(not normally used)
  Vres AS LONG           'vertical resolution of the image(not normally used)
  NumColors AS LONG      'number of colors in the color palette(not normally used)
  SigColors AS LONG      'number of important colors used(not normally used)
END TYPE '40 bytes     **  'palette and/or image data immediately follow this header! **

```

```vb

DIM ICO AS ICONTYPE
items% = ICO.Count
DIM SHARED Entry(items%) AS ICONENTRY
DIM SHARED BMP(items%) AS BMPHEADER 

```

**ICON File Header Information**

* The Icon header is only six bytes. The first [INTEGER](INTEGER) value is reserved and is always 0.
* The second [INTEGER](INTEGER) indicates the type of file:
  - 1 indicates that the file is an ICO Icon file which may hold more than one image.
  - 2 indicates that the file is a CUR Cursor file which may hold more than one image.
* The third [INTEGER](INTEGER) value indicates the number of images contained in the file. This will also tell you the number of Icon Entry information headers follow. A [TYPE](TYPE) array can be used to reference the entry and BMP header information later when there is more than one image. The start of all bitmap header and image data information is after 6 + (count * 16) bytes.

**ICON Entry Information**

The Entry header information for all icon images contained in the icon file follow the icon header. No image data will be found until after all of the Entry information. Each entry  contains the dimensions, size of data and the location of the start of image data.

* The image width and height are [_BYTE](_BYTE) numerical values or [ASC](ASC) [ASCII](ASCII) code [STRING](STRING) values.
* The number of colors is a [_BYTE](_BYTE) value which may be zero. Use the Bitmap header's BPP value instead.
* The reserved [_BYTE](_BYTE) value is always zero.
* The 2 Hotspot [INTEGER](INTEGER) values are always 0 unless the file is a CUR cursor file. Cursor files position the click spot.
* The [LONG](LONG) Data Size value should indicate the size of the image data including bitmap header, palette and pixel data.
* The [LONG](LONG) Data Offset value will indicate the byte position of the image bitmap header. Add one byte in QB and QB64.

**Bitmap Header Information**

The Bitmap header information is located one byte after the Data Offset position because QBasic sets the first byte of a file as 1 instead of zero. This bitmap image information is identical to a bitmap image header's last 40 bytes, but the height is doubled.

* The [LONG](LONG) header size is always 40 bytes. This can be used to verify the start position of the header.
* The [LONG](LONG) image width should be the same as the Entry header width.
* The [LONG](LONG) image height should be **2 times** the actual image height as read in the Entry header.
* The number of planes [INTEGER](INTEGER) value should always be 1.
* The BPP [INTEGER](INTEGER) value is always used to find the number of colors, palette size(if any) and pixel byte size.
  - 1 indicates a black and white(2 ^ 1) color, one bit(on or off) per pixel image with no palette. Each bit on is white.
  - 4 indicates a 16(2 ^ 4) color, 4 bits(attributes 0 to 15) per pixel image with a 64 byte palette.
  - 8 indicates a 256(2 ^ 8) color, one byte(attributes 0 to 255) per pixel image with a 1024 byte palette.
  - 24 or 32 indicates a 16 million(2 ^ 24) color, 3 bytes(BGR intensities 0 to 255) per pixel image with no palette.
* The [LONG](LONG) compression value should always be zero.
* The [LONG](LONG) Raw data size should indicate the image data size, but it is unreliable. Calculate it when necessary.
* The four remaining [LONG](LONG) bitmap header values can be ignored as they will normally be zero.

## XOR Image Data

```text

                                 **Single Image Icon or Cursor**

              ┌──────┐   ┌─────┐    ┌──────┐    ┌───────┐     ┌───────┐     ┌───────┐
              │ ICON │   │Entry│    │BMP[1]│    │PALETTE│     │  XOR  │     │  AND  │
              │Header├─6─┤ [1] ├─22─┤Header├─62─┤ 4 BPP ├─126─┤ 4 BPP ├─638─┤ 1 BPP │
              │  6B  │   │16 B │    │ 40 B │    │½ byte │     │32*32*½│     │32*32\8│
              └──────┘   └─────┘    └──────┘    │ 64 B  │     │ 512 B │     │ 128 B │
                                                └───────┘     └───────┘     └───────┘

                                     **Multiple Image (3)**

                  ┌──────┐   ┌───────┐    ┌───────┐    ┌───────┐
                  │ ICON │   │ Entry │    │ Entry │    │ Entry │
                  │Header├─6─┤  [1]  ├─22─┤  [2]  ├─38─┤  [3]  ├─54─┐ Entry precedes all data
                  │  6B  │   │ 16 B  │    │ 16 B  │    │ 16 B  │    │
                  └──────┘   └───────┘    └───────┘    └───────┘    │
                                 ┌───◄ GET Offset + 1 = 55◄─────────┘
                             ┌───┴───┐    ┌───────┐    ┌───────┐
                             │ BMP[1]│    │ BMP[2]│    │ BMP[3]│
                             │Header │  ┌─┤Header │  ┌─┤Header │  Image settings
                             │ 40 B  │  │ │ 40 B  │  │ │ 40 B  │
                             └───┬───┘  │ └───┬───┘  │ └───┬───┘
                             ┌───┴───┐  ▲ ┌───┴───┐  ▲     │
                             │PALETTE│  O │PALETTE│  O     │
                             │ 4 BPP │  f │ 8 BPP │  f   24 BPP   RGB color intensities
                             │½ byte │  f │1 byte │  f   3 byte
                             │ 64 B  │  s │1024 B │  s     │
                             └───┬───┘  e └───┬───┘  e     │
                             ┌───┴───┐  t ┌───┴───┐  t ┌───┴───┐
                             │  XOR  │  + │  XOR  │  + │  XOR  │
                             │16*16*½│  1 │32*32*1│  1 │48*48*3│  Image color data
                             │ 128 B │  ▲ │1024 B │  ▲ │6912 B │
                             └───┬───┘  │ └───┬───┘  │ └───┬───┘
                            ┌────┴───┐  │ ┌───┴───┐  │ ┌───┴────┐
                            │   AND  │  │ │  AND  │  │ │  AND   │
                            │ 1 BPP  ├──┘ │ 1 BPP ├──┘ │ 1 BPP  │ B & W mask
                            │16*(2+2)│    │32*32\8│    │48*(6+2)│
                            │  64 B  │    │ 128 B │    │ 384 B  │
                            └────────┘    └───────┘    └────────┘

      Add one to Offset position when using one TYPE definition GET for the BMP Header data!
                       BPP = bits per pixel B = bytes +2 = padder bytes

```

**Palette Data**

The Palette is only used in **4 BPP** and **8 BPP** Icons or Cursors. It is exactly the same format as a bitmap. The number of available colors determines the size of palette data. The data is read as blue, green, red [_BYTE](_BYTE)s with a zero([CHR$](CHR$)(0)) spacer so the palette size is 4 times the number of available colors: 4 BPP = 4 * (2 ^ 4) = 64 bytes and 8 BPP = 4 * (2 ^ 8) = 1024 bytes.

The palette sets the Blue, Green and Red color intensities before each color attribute value is read in the image's pixel data.

**XOR Mask Image Data**

The [XOR](XOR) mask is found after the Palette in 4 BPP or 8 BPP or immediately after the icon BMP Header if 1 BPP or 24 BPP colors. The XOR data is also read the same as a bitmap. The BPP determines the size of the data as bits per pixel:

* 1 BPP is one bit per pixel (on white or off black) or bytes = (width * height) / 8 bits
* 4 BPP is four bits per pixel attribute or bytes = (4 * width * height) / 8 bits
* 8 BPP is one byte per pixel attribute or bytes = (8 * width * height) /8 bits
* 24 BPP is 3 bytes per pixel (blue, green, red) or bytes = (24 * width * height) / 8 bits

All color settings use 4 byte padding to prevent image skewing although most icons use multiples of 8 pixels and won't need it.

The color intensity of each 24 bit pixel is read as blue, green and red bytes. See the [Bitmaps](Bitmaps) page for more information.

## AND Mask Data

The AND mask is read as a **one BPP** black and white image with each [_BIT](_BIT) being on(white) or off(black). It is white where the background may show and black where the colors (including black) from the XOR mask will show. It is placed using the AND action by Windows first. Then the XOR mask is placed on top using an XOR action. The following SUB procedure can adapt to 24 bit colors so that colors will not be affected. Make sure that the BPP value is [SHARED](SHARED) or pass it using a parameter!

A [CHR$](CHR$) byte or [SPACE$](SPACE$) padder is used in the AND mask for image widths that are not multiples of 4 bytes(32 pixels).

```vb

SUB ANDMask   'MASK is B & W. Black area holds XOR colors, white displays background
BitsOver = Entry(i).PWidth& MOD 32
IF BitsOver THEN ZeroPAD$ = SPACE$((32 - BitsOver) \ 8) 'look for sizes not multiples of 32 bits
_DEST bmp&  'destination handle if used
y = Entry(i).PDepth - 1: a$ = " ": p$ = " "
DO
  x = 0
  DO
    GET #1, , a$   'position is immediately AFTER XOR mask data
    ByteVAL = ASC(a$)   'MSBit is left when calculating 16 X 16 cursor map 2 byte integer
    FOR Bit% = 7 TO 0 STEP -1   'values despite M$ documentation that says otherwise!
      IF ByteVAL AND 2 ^ Bit% THEN
        PSET (x, y), _RGB(255, 255, 255) '_RGB can be used in 1, 4, 8 or 24/32 BPP
      ELSE: PSET (x, y), _RGB(0, 0, 0)
      END IF
      x = x + 1        '16 X 16 = 32 bytes, 32 X 32 = 128 bytes AND MASK SIZES
    NEXT Bit%          '48 X 48 = 288 bytes, 64 X 64 = 512 bytes, 128 X 128 = 2048 bytes
  LOOP WHILE x < Entry(i).PWidth
  GET #1, , ZeroPAD$   '16 X 16 and 48 X 48 = 2 byte end padder per row in the AND MASK
  y = y - 1            'adds 32 and 96 bytes respectively to the raw data size!
LOOP UNTIL y = -1
END SUB 

```

> *Note:* Icon widths that are not multiples of 32, such as 16 or 48, are padded 2 extra zero bytes to bring them to specifications.

## Calculating Data Size

The size of the data is based on the pixel size of the image, any bit padding and the BPP palette intensity data required.

```vb

Entry(item%).DataSize = DataSize&(item%) 'example function call

FUNCTION DataSize&(i AS INTEGER)
PixelBytes! = BMP(i)BPP / 8      '1 BPP = 1/8; 4 BPP = 1/2; 8 BPP = 1; 24 BPP = 3

SELECT CASE BPP
  CASE 1: PaletteBytes% = 0
    IF Entry(i).PWidth MOD 32 THEN Pad% = (32 - (Entry(i).PWidth MOD 32)) \ 8 ELSE Pad% = 0
  CASE 4: PaletteBytes% = 64
    IF Entry(i).PWidth MOD 8 THEN Pad% = (8 - (Entry(i).PWidth MOD 8)) \ 2 ELSE Pad% = 0
  CASE 8: PaletteBytes% = 1024
    IF Entry(i).PWidth MOD 4 THEN Pad% = 4 - (Entry(i).PWidth MOD 4) ELSE Pad% = 0
  CASE IS > 8: PaletteBytes% = 0
    IF ((PictureMOD 4) THEN
      Pad% = ((4 - ((Entry(i).PWidth * 3) MOD 4)))
    ELSE: Pad% = 0
    END IF
END SELECT

XORsize& = ((Entry(i).PWidth + Pad%) * Entry(i).PDepth) * PixelBytes!
IF Entry(i).PWidth MOD 32 THEN ANDpad% = (32 - (Entry(i).PWidth MOD 32)) ELSE ANDpad% = 0
ANDsize& = ((Entry(i).PWidth + ANDpad%) * Entry(i).PDepth) \ 8

DataSize& = XORsize& + ANDsize& + PaletteBytes% + 40  'header is always 40 bytes
END FUNCTION 

```

> *NOTE:* A 2 byte padder adds 32 bytes to 16 X 16 and 96 bytes to 48 X 48 AND mask data. 32 and 64 wide have no padders.

*Snippet:* Shows how bit padder is calculated and used to calculate the AND mask data size:

```vb

INPUT "Enter an icon width(multiples of 8 or 16 only): ", width

IF (width MOD 32) THEN bitpad = (32 - (width MOD 32))
bytes = (width + bitpad) * width \ 8 'dividing by 8 returns the byte size

PRINT "AND mask size:"; bytes; "bytes with a"; bitpad; "bit padder." 

```

```text

Enter an icon width(multiples of 8 or 16 only): 16
AND mask size: 64 bytes with a 16 bit padder.

```

## References

* [Creating Icon Bitmaps](Creating-Icon-Bitmaps)
* [Creating Icons from Bitmaps](Creating-Icons-from-Bitmaps)
* [SaveIcon32](SaveIcon32) (create icons from any image)

## See Also

* [$EXEICON]($EXEICON)
* [_ICON](_ICON)
* [Creating Sprite Masks](Creating-Sprite-Masks)
* [Bitmaps](Bitmaps), [GIF Images](GIF-Images)
* [Resource Table Extraction](Resource-Table-Extraction)
