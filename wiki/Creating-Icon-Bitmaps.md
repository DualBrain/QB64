## Icon Viewer and Bitmap Creator

The following program can be used to view Icon or Cursor images and save them as Bitmaps. When you answer Y the bitmap is saved with a black background so that it can be PUT using [XOR](XOR) on to the [AND](AND) image. The AND image will be black and white if the image is irregularly shaped(not a full box image). It is placed first using [PUT (graphics statement)](PUT-(graphics-statement)) with the AND action or can be placed using [_PUTIMAGE](_PUTIMAGE) with the color white [_ALPHA](_ALPHA) being set to 0. In that case, try just placing the XOR image with the color black 0 [_ALPHA](_ALPHA) with [_SETALPHA](_SETALPHA).

<sub>Code by Ted Weissgerber</sub>

```vb

'********************************* IconType.BI INCLUDE FILE ********************************

TYPE IconType            'Icon or cursor file header
  Reserved AS INTEGER    'Reserved (always 0)
  ID AS INTEGER          'Resource ID (Icon = 1, Cursor = 2)
  Count AS INTEGER       'Number of icon bitmaps in Directory of icon entries array
END TYPE '6 bytes

TYPE ICONENTRY           'or unanimated Cursor entry (see ANI for animated cursors)
  PWidth AS _BYTE        'Width of icon in pixels (USE THIS)
  PDepth AS _BYTE        'Height of icon in pixels (USE THIS)
  NumColors AS _BYTE     'Maximum number of colors: (2 or 16 colors. 256 or 24/32 bit = 0}
  RES2 AS _BYTE          'Reserved. Not used (always 0)
  HotSpotX AS INTEGER    'Icon: NumberPlanes(normally 0), Cursor: hotspot pixels from left
  HotSpotY AS INTEGER    'Icon: BitsPerPixel(normally 0), Cursor: hotspot pixels from top
  DataSize AS LONG       'Length of icon bitmap in bytes (USE THIS)
  DataOffset AS LONG     'Offset byte position of icon bitmap data header in file(add 1)
END TYPE '16 bytes

TYPE ICONHEADER          'Bitmap type header found using entry DataOffset + 1
  IconHSize AS LONG      'size of ICON header (always 40 bytes) 
  ICONWidth AS LONG      'bitmap width in pixels. (width and double height may be missing)
  ICONDepth AS LONG      'Total map height in pixels (TWO TIMES the image height).
  NumPlanes AS INTEGER   'number of color planes. Must be set to 1.
  BPP AS INTEGER         'bits per pixel  1, 4, 8, 16, 24 or 32.(USE THIS for BPP)
  Compress AS LONG       'compression method should always be 0.
  RAWSize AS LONG        'size of the raw ICON image data(may only be XOR mask size).
  Hres AS LONG           'horizontal resolution of the image(not normally used)
  Vres AS LONG           'vertical resolution of the image(not normally used)
  NumColors AS LONG      'number of colors in the color palette(not normally used)
  SigColors AS LONG      'number of important colors used(not normally used)
END TYPE '40 byte


```

```vb

REM $INCLUDE: 'IconType.BI' 
DEFINT A-Z
DIM Icon AS IconType
DIM SHARED Item, BPP
DIM SHARED wide&, deep&, bmp&, bmpStretch&
DIM Image(26000)
dst& = _NEWIMAGE(800, 600, 32)
SCREEN dst&

hdr$ = " & File  ID = #  ## Image(s) in file  #######, bytes "
ico$ = "              Size = ## X ##   Colors = ##        Planes = #   BPP = ## "
cur$ = "              Size = ## X ##   Colors = ##   HotSpot X = ##      Y = ## "
dat$ = "              DATA Size = #####, bytes        DATA Offset =  ######,    "
bm1$ = "              HeaderSize = ## MaskArea = ## X ##  Planes = #   BPP = ## "
bm2$ = "              Compression = #   RAW Data Size = ######, bytes         "

LOCATE 20, 20: LINE INPUT "Enter an ICOn or CURsor file name: ", IconName$
L = LEN(IconName$) 
IF L = 0 THEN SOUND 400, 4: SYSTEM
dot = INSTR(IconName$, ".")
IF dot = 0 THEN 
   Save$ = IconName$: IconName$ = IconName$ + ".ICO" 
ELSE Save$ = LEFT$(IconName$, dot - 1)
END IF   
OPEN IconName$ FOR BINARY AS #1
length& = LOF(1)
PRINT 
IF length& THEN
  GET #1, 1, Icon
  SELECT CASE Icon.ID
    CASE 1: IC$ = "Icon": ent$ = ico$
    CASE 2: IC$ = "Cursor": ent$ = cur$
    CASE ELSE: IC$ = "Bitmap?"
  END SELECT
  LOCATE 22, 20: PRINT USING hdr$; IC$; Icon.ID; Icon.Count; length&
  IF Icon.Count THEN
    count = Icon.Count
    DIM SHARED Entry(count) AS ICONENTRY
    DIM SHARED Header(count) AS ICONHEADER
    FOR Item = 1 TO count                            '16 bytes each entry
      GET #1, , Entry(Item)
    NEXT
    VIEW PRINT 24 TO 32
    FOR Item = 1 TO count
      GET #1, Entry(Item).DataOffset + 1, Header(Item) 'ADD 1 to offsets!
      COLOR _RGB(255, 255, 0): LOCATE 24, 30
      IF count > 1 THEN PRINT " IMAGE ENTRY #"; Item ELSE PRINT " IMAGE ENTRY"
      COLOR _RGB(50, 200, 255)
      PRINT USING ent$; Entry(Item).PWidth; Entry(Item).PDepth; Entry(Item).NumColors; Entry(Item).HotSpotX; Entry(Item).HotSpotY
      PRINT USING dat$; Entry(Item).DataSize; Entry(Item).DataOffset
      PRINT USING bm1$; Header(Item).IconHSize; Header(Item).ICONWidth; Header(Item).ICONDepth, Header(Item).NumPlanes; Header(Item).BPP
      PRINT USING bm2$; Header(Item).Compress; Header(Item).RAWSize
      PRINT 
      k$ = INPUT$(1) 'Palette(4 or 8BPP) and/or XOR mask starts immediately after an ICONHEADER
      wide& = Entry(Item).PWidth: deep& = Entry(Item).PDepth: BPP = Header(Item).BPP
      IF BPP > 8 THEN BitColor = 32 ELSE BitColor = 256  'assign for proper colors
      bmpStretch& = _NEWIMAGE(4 * wide&, 4 * deep&, BitColor) 'set either 256 or 32
      bmp& = _NEWIMAGE(wide&, deep&, BitColor) 'don't bother with _FREEIMAGE, reuse them!
      SELECT CASE BPP
        CASE 1: OneBit
        CASE 4: FourBIT
        CASE 8: EightBIT
        CASE IS > 8: TrueCOLOR
      END SELECT
      IF BPP < 24 THEN _COPYPALETTE bmp&, bmpStretch&
      _PUTIMAGE , bmp&, bmpStretch&
      _DEST 0: _PUTIMAGE (100, 0), bmpStretch&
      SOUND 600, 3
      COLOR _RGB(255, 0, 255): LOCATE CSRLIN, 30: PRINT "Save as Bitmap? (Y/N)";
      k$ = INPUT$(1)
      k$ = UCASE$(k$)
      PRINT k$ + SPACE$(1);
      IF k$ = "Y" THEN 
          SaveFile$ = Save$ + LTRIM$(STR$(Item)) + ".BMP"
          ThirtyTwoBit 0, 0, wide& - 1, deep& - 1, bmp&, SaveFile$
      END IF 
      IF k$ = "Y" THEN PRINT "Saved!" ELSE PRINT "Not saved"
      ANDMask
      IF BPP < 24 THEN _COPYPALETTE bmp&, bmpStretch&
      _PUTIMAGE , bmp&, bmpStretch&
      _DEST 0: _PUTIMAGE (400, 0), bmpStretch&
      IF k$ = "Y" THEN 
          ANDFile$ = Save$ + LTRIM$(STR$(Item)) + "BG.BMP"
          ThirtyTwoBit 0, 0, wide& - 1, deep& - 1, bmp&, ANDFile$
      END IF 
      k$ = INPUT$(1)
      CLS
    NEXT
    VIEW PRINT
  ELSE SOUND 400, 4: CLOSE #1: PRINT "No images entries found!": END
  END IF
ELSE: CLOSE #1: SOUND 400, 4: KILL IconName$: END
END IF
CLOSE #1
END

SUB OneBit 'adapted from TheBob's Winbit 'B & W monochrome images ONLY (NO PALETTE data)
BitsOver = wide& MOD 32
IF BitsOver THEN ZeroPAD$ = SPACE$((32 - BitsOver) \ 8) 
_DEST bmp&
y = deep& - 1: p$ = " "
DO
  x = 0
  DO
    GET #1, , p$
    ByteVAL = ASC(p$)
    FOR Bit% = 7 TO 0 STEP -1 'read bits left to right
      IF ByteVAL AND 2 ^ Bit% THEN PSET (x, y), 15 ELSE PSET (x, y), 0
      x = x + 1
    NEXT Bit%
  LOOP WHILE x < wide&
  GET #1, , ZeroPAD$  '         'prevents odd width image skewing  
  y = y - 1 '            
LOOP UNTIL y = -1
END SUB

SUB EightBIT 'adapted from TheBob's Winbit      '256 palette data Colors (8 BPP)
IF wide& MOD 4 THEN ZeroPAD$ = SPACE$(4 - (wide& MOD 4)) 
_DEST bmp&
a$ = " ": u$ = " "
OUT &H3C8, 0
FOR Colr = 0 TO 255
  GET #1, , a$: Blu = ASC(a$) \ 4
  GET #1, , a$: Grn = ASC(a$) \ 4
  GET #1, , a$: Red = ASC(a$) \ 4
  OUT &H3C9, Red
  OUT &H3C9, Grn
  OUT &H3C9, Blu
  GET #1, , u$ '--- unused byte
NEXT Colr
y = deep& - 1: p$ = " "
DO: x = 0
  DO
    GET #1, , p$
    PSET (x, y), ASC(p$)
    x = x + 1
  LOOP WHILE x < wide&
  GET #1, , ZeroPAD$  '           'prevents odd width image skewing
  y = y - 1
LOOP UNTIL y = -1
END SUB

SUB FourBIT 'adapted from TheBob's Winbit  '16 palette data colors (4 BPP = 8 or 16 color) 
_DEST bmp&
IF wide& MOD 8 THEN ZeroPAD$ = SPACE$((8 - wide& MOD 8) \ 2) 'prevents odd width image skewing
a$ = " ": u$ = " "
FOR Colr = 0 TO 15
  OUT &H3C8, Colr
  GET #1, , a$: Blu = ASC(a$) \ 4
  GET #1, , a$: Grn = ASC(a$) \ 4
  GET #1, , a$: Red = ASC(a$) \ 4
  OUT &H3C9, Red
  OUT &H3C9, Grn
  OUT &H3C9, Blu
  GET #1, , u$ '--- unused byte
NEXT Colr
y = deep& - 1: p$ = " "
DO
  x = 0
  DO
    GET #1, , p$
    HiNIBBLE = ASC(p$) \ &H10
    LoNIBBLE = ASC(p$) AND &HF
    PSET (x, y), HiNIBBLE
    x = x + 1
    PSET (x, y), LoNIBBLE
    x = x + 1
  LOOP WHILE x < wide&
  GET #1, , ZeroPAD$  '              'prevents odd width image skewing
  y = y - 1
LOOP UNTIL y = -1
END SUB

SUB ANDMask '   'AND MASK is B & W. Black area holds XOR colors, white displays background
BitsOver = wide& MOD 32
IF BitsOver THEN ZeroPAD$ = SPACE$((32 - BitsOver) \ 8) 'look for sizes not multiples of 32 bits
_DEST bmp&
IF BPP < 24 THEN PALETTE '        'remove for a PUT using previous XOR mask palette data
y = deep& - 1: a$ = " ": p$ = " "
DO
  x = 0
  DO
    GET #1, , a$
    ByteVAL = ASC(a$) 'MSBit is left when calculating 16 X 16 cursor map 2 byte integer
    FOR Bit% = 7 TO 0 STEP -1 'values despite M$ documentation that says otherwise!
      IF ByteVAL AND 2 ^ Bit% THEN 'LONG values cannot be used in a cursor file!
        IF BPP > 8 THEN PSET (x, y), _RGB32(255, 255, 255) ELSE PSET (x, y), 15
      ELSE: IF BPP > 8 THEN PSET (x, y), _RGB32(0, 0, 0) ELSE PSET (x, y), 0
      END IF
      x = x + 1        '16 X 16 = 32 bytes, 32 X 32 = 128 bytes AND MASK SIZES
    NEXT Bit%          '48 X 48 = 288 bytes, 64 X 64 = 512 bytes, 128 X 128 = 2048 bytes
  LOOP WHILE x < wide&  
  GET #1, , ZeroPAD$   '16 X 16 and 48 X 48 = 2 byte end padder per row in the AND MASK
  y = y - 1            'adds 32 and 96 bytes respectively to the raw data size!
LOOP UNTIL y = -1
END SUB

SUB TrueCOLOR '     ' 16 Million colors. NO PALETTE! Colored by pixels (24 or 32 BPP)
_DEST bmp&
IF ((BMP.PWidth * 3) MOD 4) <> 0 THEN        '3 byte pixels
ZeroPAD$ = SPACE$((4 - ((BMP.PWidth * 3) MOD 4)))
END IF
R$ = " ": G$ = " ": B$ = " "
y = deep& - 1
DO
  x = 0
  DO
    GET #1, , B$            '3 bytes set RGB color intensities
    GET #1, , G$
    GET #1, , R$
    red& = ASC(R$)
    green& = ASC(G$)
    blue& = ASC(B$)
    PSET (x, y), _RGB(red&, green&, blue&) 'returns closest attribute in 4 or 8 bit
    x = x + 1
  LOOP WHILE x < wide&
  GET #1, , ZeroPAD$  '     'prevents odd width image skewing       
  y = y - 1
LOOP UNTIL y = -1
END SUB 
REM $INCLUDE: '32BitSUB.BM'

```

```vb

'*********************************** 32BitSUB.BM INCLUDE FILE *******************************

SUB ThirtyTwoBit (x1%, y1%, x2%, y2%, image&, Filename$)                           
  DIM Colors8%(255)
  IF x1% > x2% THEN SWAP x1%, x2%
  IF y1% > y2% THEN SWAP y1%, y2%

  _SOURCE image& 
  pixelbytes& = _PIXELSIZE(image&)
  IF pixelbytes& = 0 THEN BEEP: EXIT SUB 'no text screens

  FileType$ = "BM"
  QB64$ = "QB64"           'free advertiising in reserved bytes
  IF pixelbytes& = 1 THEN OffsetBITS& = 1078 ELSE OffsetBITS& = 54 'no palette in 24/32 bit
  InfoHEADER& = 40
  PictureWidth& = (x2% - x1%) + 1  ' don't exceed maximum screen resolutions!
  PictureDepth& = (y2% - y1%) + 1   
  NumPLANES% = 1
  IF pixelbytes& = 1 THEN BPP% = 8 ELSE BPP% = 24
  Compression& = 0
  WidthPELS& = 3780
  DepthPELS& = 3780
  IF pixelbytes& = 1 THEN NumColors& = 256    '24/32 bit say none

  IF (PictureWidth& AND 3) THEN ZeroPAD$ = SPACE$(4 - (PictureWidth& AND 3))

  ImageSize& = (PictureWidth& + LEN(ZeroPAD$)) * PictureDepth&
  FileSize& = ImageSIZE& + OffsetBITS&  
  f = FREEFILE
  OPEN Filename$ FOR BINARY AS #f
   
  PUT #f, , FileType$
  PUT #f, , FileSize&
  PUT #f, , QB64$
  PUT #f, , OffsetBITS&
  PUT #f, , InfoHEADER&
  PUT #f, , PictureWidth&
  PUT #f, , PictureDepth&
  PUT #f, , NumPLANES%
  PUT #f, , BPP%
  PUT #f, , Compression&
  PUT #f, , ImageSize&
  PUT #f, , WidthPELS&
  PUT #f, , DepthPELS&
  PUT #f, , NumColors&
  PUT #f, , SigColors&     '51 offset

  IF pixelbytes& = 1 THEN     '4 or 8 BPP Palettes set for 256 colors
    u$ = CHR$(0)
    FOR c& = 0 TO 255  'PUT as BGR order colors
      cv& = _PALLETTECOLOR(c&, image&)
      Colr$ = CHR$(_BLUE32(cv&))                       
      PUT #f, , Colr$
      Colr$ = CHR$(_GREEN32(cv&))
      PUT #f, , Colr$
      Colr$ = CHR$(_RED32(cv&))
      PUT #f, , Colr$
      PUT #f, , u$  'Unused byte
    NEXT
  END IF
 
  FOR y% = y2% TO y1% STEP -1   'place bottom up
    FOR x% = x1% TO x2% 
     c& = POINT(x%, y%) 
     IF pixelbytes& = 1 THEN 
       a$ = CHR$(c&) 
       Colors8%(ASC(a$)) = 1
     ELSE : a$ = LEFT$(MKL$(c&), 3)
     END IF            
     PUT #f, , a$
    NEXT 
    PUT #f, , ZeroPAD$
  NEXT 

  FOR n = 0 TO 255
    IF Colors8%(n) = 1 THEN SigColors& = SigColors& + 1
  NEXT n
  PUT #f, 51, SigColors&
  CLOSE #f
END SUB 

```

<sub>Adapted from code by Bob Seguin</sub>

**NOTE: Black areas of an image may become "see through" unless another color attribute is used and set to black!**

>  This can be done by changing another color attribute's RGB settings to 0 or almost 0 and creating a mask after using it in solid black areas of a 4 or 8 BPP palette image. This can also be done using [_PUTIMAGE](_PUTIMAGE) with 32 bit [_CLEARCOLOR](_CLEARCOLOR) settings.

*See the following page:* [Creating Sprite Masks](Creating-Sprite-Masks)

## Icon to Bitmap Conversion Function

The following program uses a conversion function with the [TYPE](TYPE) definitions inside of the function to eliminate an [$INCLUDE]($INCLUDE) library file.

```vb

SCREEN _NEWIMAGE(640, 480, 256)
_TITLE "Icon Converter"
icon$ = "daphne.ico" '<<<<<<<<< change icon file name
bitmap$ = "tempfile.bmp"
indx% = 5 '1 minimum <<<<<<< higher values than count get highest entry image in icon file

IF Icon2BMP(icon$, bitmap$, indx%) THEN 
  img& = _LOADIMAGE(bitmap$)
  PRINT img&
  IF img& < -1 THEN '           check that handle value is good before loading
    _ICON img& '                place image in header
    _PUTIMAGE (300, 250), img& 'place image on screen
    _FREEIMAGE img& '           always free unused handles to save memory
    'KILL bitmap$ '              comment out and/or rename to save the bitmaps
  END IF
ELSE PRINT "Could not create bitmap!"
END IF
END
'                ----------------------------------------------------

FUNCTION Icon2BMP% (filein AS STRING, fileout AS STRING, index AS INTEGER)
TYPE ICONTYPE '              Icon or cursor file header
  Reserved AS INTEGER '         Reserved (always 0)
  ID AS INTEGER '               Resource ID (Icon = 1, Cursor = 2)
  Count AS INTEGER '            Number of icon bitmaps in Directory of icon entries array
END TYPE '6 bytes
TYPE ENTRYTYPE '             or unanimated Cursor entry (ANI are animated cursors)
  Wide AS _UNSIGNED _BYTE '     Width of icon in pixels (USE THIS) Use _UNSIGNED over 127
  High AS _UNSIGNED _BYTE '     Height of icon in pixels (USE THIS) Use _UNSIGNED over 127
  NumColors AS _BYTE '          Maximum number of colors. (2, 8 or 16 colors. 256 or 24/32 bit = 0)
  RES2 AS _BYTE '               Reserved. Not used (always 0)
  HotSpotX AS INTEGER '         Icon: NumberPlanes(normally 0), Cursor: hotspot pixels from left
  HotSpotY AS INTEGER '         Icon: BitsPerPixel(normally 0), Cursor: hotspot pixels from top
  DataSize AS LONG '            Length of image data in bytes minus Icon and Entry headers (USE THIS)
  Offset AS LONG '              Start Offset byte position of icon bitmap header(add 1 if TYPE GET)
END TYPE '16 bytes              
TYPE PREHEADER '             Bitmap information not in icon BM header
  BM AS INTEGER '               Integer value changed to "BM" by PUT
  Size AS LONG '                Size of the data file(LOF)
  Reser AS LONG'                2 reserved integers are zero automatically
  BOffset AS LONG '             Start offset of pixel data(next byte)
END TYPE '14 bytes
TYPE BMPHEADER '             Bitmap type header found using entry DataOffset + 1
  IconHSize AS LONG '           size of ICON header (always 40 bytes)
  PWidth AS LONG '              bitmap width in pixels (signed integer).
  PDepth AS LONG '              Total map height in pixels (signed integer is 2 times image height)
  NumPlanes AS INTEGER '        number of color planes. Must be set to 1.
  BPP AS INTEGER '              bits per pixel  1, 4, 8, 16, 24 or 32.(USE THIS)
  Compress AS LONG '            compression method should always be 0.
  RAWSize AS LONG '             size of the raw ICON image data(may only be XOR mask size).
  Hres AS LONG '                horizontal resolution of the image(not normally used)
  Vres AS LONG '                vertical resolution of the image(not normally used)
  NumColors AS LONG '           number of colors in the color palette(not normally used)
  SigColors AS LONG '           number of important colors used(not normally used)
END TYPE '40 bytes              palette and image data immediately follow this header!

DIM ICON AS ICONTYPE, ENT AS ENTRYTYPE, PRE AS PREHEADER, BMP AS BMPHEADER

rf = FREEFILE
IF LCASE$(RIGHT$(filein, 4)) = ".ico" THEN 'check file extension is ICO only
  OPEN filein FOR BINARY ACCESS READ AS rf
ELSE EXIT FUNCTION
END IF
GET rf, , ICON 'GET 6 byte icon header
IF ICON.ID <> 1 OR ICON.Count = 0 THEN CLOSE rf: EXIT FUNCTION
IF index > 0 AND index <= ICON.Count THEN entry = 16 * (index - 1) ELSE entry = 16 * (ICON.Count - 1)
PRINT ICON.Count, entry
SEEK rf, 1 + 6 + entry 'start of indexed Entry header selected
GET rf, , ENT 'GET 16 byte Entry Header set by index request or highest available

SEEK rf, 1 + ENT.Offset 'go to BMP header offset given in Entry header
GET rf, , BMP 'GET 40 byte icon bitmap header information
IF BMP.BPP <= 24 THEN pixelbytes = BMP.BPP / 8 ELSE pixelbytes = 3
IF BMP.BPP > 1 AND BMP.BPP <= 8 THEN palettebytes = 4 * (2 ^ BMP.BPP) ELSE palettebytes = 0
datasize& = (ENT.Wide * ENT.High * pixelbytes) + palettebytes 'no padder should be necessary
filesize& = datasize& + 14 + 40 '                      data and palette + header
bmpoffset& = palettebytes + 54 '                       data offset from start of bitmap
BMP.PWidth = ENT.Wide
BMP.PDepth = ENT.High
BMP.RAWSize = datasize& - palettebytes

PRE.BM = CVI("BM") 'integer value changes to "BM" in file
PRE.Size = filesize&
PRE.BOffset = bmpoffset& 'start of data after header and palette if used

wf = FREEFILE
OPEN fileout FOR BINARY AS wf
PUT wf, , PRE 'PUT 14 byte bitmap information
PUT wf, , BMP 'PUT 40 byte bitmap header information
SEEK rf, 1 + ENT.Offset + 40
dat$ = STRING$(datasize&, 0) 'create string variable the length of remaining image data
GET rf, , dat$ 'GET remaining palette and only the XOR image data after the indexed header
PUT wf, , dat$ 'PUT remaining data into new bitmap file
CLOSE rf, wf
Icon2BMP = ICON.Count 'function returns number of images available in icon file
END FUNCTION 

```
<sub>Code by Ted Weissgerber</sub>

> *Note:* The index selected or the highest numbered icon image less than the index value is the image displayed.

## See Also

* [Creating Icons from Bitmaps](Creating-Icons-from-Bitmaps)
* [Bitmaps](Bitmaps), [Icons and Cursors](Icons-and-Cursors)
* [_CLEARCOLOR](_CLEARCOLOR)
* [_ALPHA](_ALPHA), [_ICON](_ICON)
* [SaveIcon32](SaveIcon32) (create icons from any image)
