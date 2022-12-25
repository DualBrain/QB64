**GIF File Creator**

The following routine can be used with QBasic or QB64 to create a Graphic Information File image of a program screen.  

* Accommodates [_NEWIMAGE](_NEWIMAGE) screen pages with up to 256 colors and image files loaded with [_LOADIMAGE](_LOADIMAGE). 
* The maximum screen coordinates are always one pixel LESS than the screen mode's resolution! (SCREEN 13's are 319 and 199)
* The [$INCLUDE]($INCLUDE) text file can be created using Notepad and is REQUIRED when the program is compiled with QB64 ONLY!

```vb

 '*********************************** DEMO CODE **********************************
'Save code as a BAS file! Includes the GIFcreate.BI and BM text files. Demo by CodeGuy
DEFINT A-Z
SCREEN 13
RANDOMIZE TIMER

FOR A = 1 TO 40
    x = RND * 320
    y = RND * 200
    c = RND * 256
    CIRCLE (x, y), RND * 80, c
    PAINT (x, y), RND * 256, c
NEXT

MakeGIF "GIFtemp.gif", 0, 0, _WIDTH - 1, _HEIGHT - 1, 256  'use 319 and 199 in QBasic
'Use the include file in QB64 only! Hard code the SUB in QBasic.
'$INCLUDE: 'GIFcreate.BM' 

'************************************ END DEMO *********************************

```

*GIFcreate.BM text [$INCLUDE]($INCLUDE) file:*

```vb

'-----------------------------------------------------------------------------
'             GIFcreate.BM Compression Routine v1.00 By Rich Geldreich 1992
'             Converted into one SUB Library routine by Ted Weissgerber 2011   
'-----------------------------------------------------------------------------
'                   For 1 BPP, 4 BPP or 8 BPP images only!
'file$       = save image output filename
'XStart      = <-left hand column of area to encode
'YStart      = <-upper row of area to encode
'Xend        = <-right hand column of area to encode
'Yend        = <-lowest row of area to encode                                       "
'NumColors   = # of colors on screen: 2(Black & White), 16(SCREEN 12), 256(SCREEN13)
'

SUB MakeGIF (file$, Xstart, YStart, Xend, Yend, NumColors)
CONST True = -1, False = 0
CONST Table.size = 7177   'hash table's size - must be a prime number!

DIM Prefix(Table.size - 1), Suffix(Table.size - 1), Code(Table.size - 1)
DIM Shift(7) AS LONG
FOR i = 0 TO 7: Shift(i) = 2 ^ i: NEXT 'create exponent array for speed.

PWidth% = ABS(Xend - Xstart) + 1
PDepth% = ABS(Yend - Ystart) + 1
'MinX, MinY, MaxX, MaxY are maximum and minimum image coordinates
IF Xstart > Xend THEN MaxX = Xstart: MinX = Xend ELSE MaxX = Xend: MinX = Xstart
IF Ystart > Xend THEN MaxY = Ystart: MinY = Yend ELSE MaxY = Yend: MinY = Ystart

'Open GIF output file
GIF = FREEFILE 'use next free file
OPEN file$ FOR BINARY AS #GIF

B$ = "GIF87a": PUT #GIF, , B$  'Put GIF87a header at beginning of file

SELECT CASE NumColors       'get color settings
  CASE 2            'monochrome (B&W) image
    BitsPixel = 1   '1 bit per pixel
    StartSize = 3   'first LZW code is 3 bits
    StartCode = 4   'first free code
    StartMax = 8    'maximum code in 3 bits
  CASE 16           '16 colors images SCREENS 7, 8, 9, 12, 13
    BitsPixel = 4   '4 bits per pixel
    StartSize = 5   'first LZW code is 5 bits
    StartCode = 16  'first free code
    StartMax = 32   'maximum code in 5 bits
  CASE 256   '256 color images SCREEN 13 or _NEWIMAGE 256 
    BitsPixel = 8   '8 bits per pixel
    StartSize = 9   'first LZW code is 9 bits
    StartCode = 256 'first free code
    StartMax = 512  'maximum code in 9 bits
END SELECT

'ColorBits = 2      'for EGA
ColorBits = 6       'VGA monitors ONLY 

PUT #GIF, , PWidth% 'put screen's dimensions
PUT #GIF, , PDepth%

CP = 128 + (ColorBits - 1) * 16 + (BitsPixel - 1) 'pack colorbits and bits per pixel
PUT #GIF, , CP

Zero$ = CHR$(0)     'PUT a zero into the GIF file
PUT #GIF, , Zero$

OUT &H3C7, 0                'start read at color 0
FOR c = 0 TO NumColors - 1  'Get the RGB palette from the screen and put into file
  R = (INP(&H3C9) * 65280) \ 16128 'C = R * 4.0476190(for 0-255)
  G = (INP(&H3C9) * 65280) \ 16128
  B = (INP(&H3C9) * 65280) \ 16128
  red$ = CHR$(R): PUT #GIF, , red$
  grn$ = CHR$(G): PUT #GIF, , grn$
  blu$ = CHR$(B): PUT #GIF, , blu$
NEXT
         'write out an image descriptor
sep$ = ","               'image separator
PUT #GIF, , sep$         'write it
PUT #GIF, , Minx         'image start locations
PUT #GIF, , MinY
PUT #GIF, , PWidth%      'store them into the file
PUT #GIF, , PDepth%
A$ = CHR$(BitsPixel - 1) '# bits per pixel in the image
PUT #GIF, , A$
A$ = CHR$(StartSize - 1) 'store the LZW minimum code size
PUT #GIF, , A$

CurrentBit = 0: Char& = 0   'Initialize the vars needed by PutCode

MaxCode = StartMax          'the current maximum code size
CodeSize = StartSize        'the current code size
ClearCode = StartCode       'ClearCode & EOF code are the
EOFCode = StartCode + 1     'first two entries
StartCode = StartCode + 2   'first free code that can be used
NextCode = StartCode        'the current code

OutBuffer$ = STRING$(5000, 32)    'output buffer; for speedy disk writes
Buff& = SADD(OutBuffer$)                  'find address of buffer
Buff& = Buff& - 65536 * (Buff& < 0)
Oseg = VARSEG(OutBuffer$) + (Buff& \ 16)  'get segment + offset >> 4
OAddress = Buff& AND 15                   'get address into segment
OEndAddress = OAddress + 5000             'end of disk buffer
OStartAddress = OAddress                  'current location in disk buffer
DEF SEG = Oseg

GOSUB ClearTree            'clear the tree & output a
PC = ClearCode: GOSUB PutCode          'clear code

x = Xstart: y = YStart     'X & Y have the current pixel
GOSUB GetByte: Prefix = GB           'the first pixel is a special case
Done = False               'True when image is complete

DO 'while there are more pixels to encode
  DO 'until we have a new string to put into the table
    IF Done THEN 'write out the last pixel, clear the disk buffer
'           'and fix up the last block so its count is correct

      PC = Prefix: GOSUB PutCode      'write last pixel
      PC = EOFCode: GOSUB PutCode     'send EOF code

      IF CurrentBit <> 0 THEN PC = 0: GOSUB PutCode    'flush out the last code...
      PB = 0: GOSUB PutByte
      OutBuffer$ = LEFT$(OutBuffer$, OAddress - OStartAddress)
      PUT #GIF, , OutBuffer$
      A$ = ";" + STRING$(8, &H1A)          'the 8 EOF chars is not standard,
      PUT #GIF, , A$
      A$ = CHR$(255 - BlockLength)         'correct the last block's count
      PUT #GIF, LastLoc&, A$
      CLOSE #GIF: EXIT SUB          '<<<<<<<<<<< End of procedure     
    ELSE     'get a pixel from the screen and find the new string in table
      GOSUB GetByte: Suffix = GB
      GOSUB Hash                                'is it in hash table?
      IF Found = True THEN Prefix = Code(Index) 'replace prefix:suffix string with code in table
    END IF
  LOOP WHILE Found             'don't stop unless we find a new string

  PC = Prefix: GOSUB PutCode               'output the prefix to the file
  Prefix(Index) = Prefix       'put the new string in the table
  Suffix(Index) = Suffix
  Code(Index) = NextCode       'we've got to keep track of code!

  Prefix = Suffix 'Prefix = the last pixel pulled from the screen

  NextCode = NextCode + 1          'get ready for the next code
  IF NextCode = MaxCode + 1 THEN   'increase the code size
    MaxCode = MaxCode * 2
    'Note: The GIF89a spec mentions something about a deferred clear code
    IF CodeSize = 12 THEN     'is the code size too big?
      PC = ClearCode: GOSUB PutCode      'yup; clear the table and
      GOSUB ClearTree         'start over
      NextCode = StartCode
      CodeSize = StartSize
      MaxCode = StartMax
    ELSE CodeSize = CodeSize + 1 'increase code size if not too high (not > 12)
    END IF 
  END IF
LOOP         'while we have more pixels

'                              'GOSUB ROUTINES
ClearTree:
FOR A = 0 TO Table.size - 1 'clears the hashing table
    Prefix(A) = -1 '-1 = invalid entry
    Suffix(A) = -1
    Code(A) = -1
NEXT
RETURN

Hash:   'hash the prefix & suffix(there are also many ways to do this...)
Index = ((Prefix * 256&) XOR Suffix) MOD Table.size

'        Note: the table size(7177 in this case) must be a prime number
'    Calculate an offset just in case we don't find what we want first try...
IF Index = 0 THEN          'cannot have Table.Size 0!
  Offset = 1
ELSE
  Offset = Table.size - Index
END IF

DO      'loop until we find an empty entry or find what we're lookin for
  IF Code(Index) = -1 THEN 'is this entry blank?
    Found = False ' didn't find the string
    RETURN
  ELSEIF Prefix(Index) = Prefix AND Suffix(Index) = Suffix THEN        
    Found = True  'found the string
    RETURN
  ELSE 'didn't find anything, must retry - this slows hashing down.
    Index = Index - Offset
    IF Index < 0 THEN 'too far down the table? wrap back the index to end of table
      Index = Index + Table.size
    END IF
  END IF
LOOP

PutByte:           'Puts a byte into the GIF file & also takes care of each block.
BlockLength = BlockLength - 1             'are we at the end of a block?
IF BlockLength <= 0 THEN                  'end of block
  BlockLength = 255                       'block length is now 255
  LastLoc& = LOC(GIF) + 1 + (OAddress - OStartAddress)  'remember the position
  BW = 255: GOSUB BufferWrite             'for later fixing
END IF
BW = PB: GOSUB BufferWrite 
RETURN

BufferWrite:                             'Puts a byte into the buffer
IF OAddress = OEndAddress THEN           'are we at the end of the buffer?
    PUT #GIF, , OutBuffer$               'write it out and
    OAddress = OStartAddress             'start all over
END IF
POKE OAddress, BW                        'put byte in buffer
OAddress = OAddress + 1                  'increment position
RETURN 

GetByte:                 'This routine gets one pixel from the display
GB = POINT(x, y)                         'get the "byte"
x = x + 1 'increment X coordinate
IF x > MaxX THEN                         'are we too far?
    x = Minx                             'go back to start
    y = y + 1                            'increment Y coordinate
    IF y > MaxY THEN Done = True         'flag if too far down
END IF
RETURN

PutCode:                 'Puts an LZW variable-bit code into the output file...
Char& = Char& + PC * Shift(CurrentBit)   'put the char were it belongs;
CurrentBit = CurrentBit + CodeSize       'shifting it to its proper place
DO WHILE CurrentBit > 7                  'do we have a least one full byte?
  PB = Char& AND 255: GOSUB PutByte      'mask it off and write it out
  Char& = Char& \ 256                    'shift the bit buffer right 8 bits
  CurrentBit = CurrentBit - 8            'now we have 8 less bits
LOOP                                     'loop until we don't have a full byte
RETURN
END SUB

```

## See Also

* [_LOADIMAGE](_LOADIMAGE)
* [Bitmaps](Bitmaps), [Icons and Cursors](Icons-and-Cursors)
