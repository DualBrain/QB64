 **Creating Screenshot Bitmaps inside of your Programs**

## Syntax

> EightBit Minimum_Column%, Minimum_Row%, Maximum_Column%, Maximum_Row%, NewFileName$

* The values of x1%, y%1, x2% and y2% can be any ON SCREEN area coordinates in the screen mode used.
* You MUST subtract one when using the **QB64**  FULL SCREEN [_WIDTH](_WIDTH) and [_HEIGHT](_HEIGHT) values! Otherwise [POINT](POINT) will return an [ERROR Codes](ERROR-Codes)! The maximum is one pixel less than the [SCREEN (statement)](SCREEN-(statement)) resolution or the screen dimensions.
* Both [SUB](SUB)s can be used in **QB64** or QBasic! The FourBit SUB takes about 8 seconds in QB.
* FourBit SUB creates 4 BPP(16 color) and EightBit SUB creates 8 BPP(256 color) bitmaps.

**QB64 Custom Screens**

* See the [ThirtyTwoBit SUB](ThirtyTwoBit-SUB) routine to create QB64 screenshots of [_NEWIMAGE](_NEWIMAGE) screen pages or copy images loaded using  [_LOADIMAGE](_LOADIMAGE). Creates 256 or 24/32 bit color bitmaps using the QB64 image and page handles.

```vb

'----------------- Freeware by Bob Seguin 2003 -- (TheBOB) --------------------------|
'|                                                                                   |
'|   ---- Decreased POINT time of 4 bit fullscreen to 8 seconds in QBasic ----       |
'|                     by Ted Weissgerber July, 2008                                 |
'|     - Add a special keypress to a game program to create a Screenshot -           |
'|                                                                                   |
'--------------------------------- DEMO CODE -----------------------------------------

DECLARE SUB FourBIT (x1%, y1%, x2%, y2%, Filename$)  '12 or 13 using 16 colors
DECLARE SUB EightBIT (x1%, y1%, x2%, y2%, Filename$) '13 using 256 colors

DO: CLS
INPUT "ENTER Screen Mode 12 or 13 (0 quits): ", scrn%

IF scrn% = 13 THEN
  SCREEN 13              '8 bit (256 colors) only
  LINE (0, 0)-(319, 199), 13, BF
  CIRCLE (160, 100), 50, 11
  PAINT STEP(0, 0), 9, 11
  Start! = TIMER
  EightBIT 0, 0, 319, 199, "Purple8"

ELSEIF scrn% = 12 THEN
  SCREEN 12              '4 bit(16 colors) only
  LINE (0, 0)-(639, 479), 13, BF
  LINE (100, 100)-(500, 400), 12, BF
  CIRCLE (320, 240), 100, 11
  PAINT STEP(0, 0), 9, 11
  Start! = TIMER
  FourBIT 0, 0, 639, 479, "Purple4"  '469, 239
ELSE : SYSTEM
END IF

Finish! = TIMER  'elapsed times valid for QB only
PRINT "Elapsed time ="; Finish! - Start!; "secs."; "Press Escape to quit!"
DO: K$ = INKEY$: LOOP UNTIL K$ <> ""
LOOP UNTIL K$ = CHR$(27)
SYSTEM      

            '****************  End DEMO code ***********************

```

```vb
 
SUB EightBit (x1%, y1%, x2%, y2%, Filename$)   'SCREEN 13(256 color) bitmap maker
'NOTE: Adjust x2% = 319 and y2% = 199 for legal POINTs when fullscreen in SCREEN 13 
DIM FileCOLORS%(1 TO 768)
DIM Colors8%(255)
IF x1% > x2% THEN SWAP x1%, x2%
IF y1% > y2% THEN SWAP y1%, y2%
IF INSTR(Filename$, ".BMP") = 0 THEN
Filename$ = RTRIM$(LEFT$(Filename$, 8)) + ".BMP"
END IF

FileTYPE$ = "BM"
Reserved1% = 0
Reserved2% = 0
OffsetBITS& = 1078
InfoHEADER& = 40
PictureWIDTH& = (x2% - x1%) + 1
PictureDEPTH& = (y2% - y1%) + 1
NumPLANES% = 1
BPP% = 8
Compression& = 0
WidthPELS& = 3780
DepthPELS& = 3780
NumCOLORS& = 256

IF (PictureWIDTH& AND 3) THEN ZeroPAD$ = SPACE$(4 - (x& AND 3))

ImageSIZE& = (PictureWIDTH& + LEN(ZeroPAD$)) * PictureDEPTH&
FileSize& = ImageSIZE& + OffsetBITS&

OUT &H3C7, 0
FOR n = 1 TO 768 STEP 3
  FileCOLORS%(n) = INP(&H3C9)
  FileCOLORS%(n + 1) = INP(&H3C9)
  FileCOLORS%(n + 2) = INP(&H3C9)
NEXT n
f% = FREEFILE
OPEN Filename$ FOR BINARY AS #f%

PUT #f%, , FileTYPE$
PUT #f%, , FileSize&
PUT #f%, , Reserved1% 'should be zero
PUT #f%, , Reserved2% 'should be zero
PUT #f%, , OffsetBITS&
PUT #f%, , InfoHEADER&
PUT #f%, , PictureWIDTH&
PUT #f%, , PictureDEPTH&
PUT #f%, , NumPLANES%
PUT #f%, , BPP%
PUT #f%, , Compression&
PUT #f%, , ImageSIZE&
PUT #f%, , WidthPELS&
PUT #f%, , DepthPELS&
PUT #f%, , NumCOLORS&
PUT #f%, , SigCOLORS&     '51 to 54

u$ = " "
FOR n% = 1 TO 768 STEP 3  'PUT as BGR order colors
  Colr$ = CHR$(FileCOLORS%(n% + 2) * 4)
  PUT #f%, , Colr$
  Colr$ = CHR$(FileCOLORS%(n% + 1) * 4)
  PUT #f%, , Colr$
  Colr$ = CHR$(FileCOLORS%(n%) * 4)
  PUT #f%, , Colr$
  PUT #f%, , u$ 'Unused byte
NEXT n%

FOR y = y2% TO y1% STEP -1   'place bottom up
  FOR x = x1% TO x2%
    a$ = CHR$(POINT(x, y))
    Colors8%(ASC(a$)) = 1
    PUT #f%, , a$
  NEXT x
  PUT #f%, , ZeroPAD$
NEXT y

FOR n = 0 TO 255
  IF Colors8%(n) = 1 THEN SigCOLORS& = SigCOLORS& + 1
NEXT n

PUT #f%, 51, SigCOLORS&
CLOSE #f%
END SUB    

```

```vb

SUB FourBit (x1%, y1%, x2%, y2%, Filename$)   ' SCREEN 12(16 color) bitmap maker
       'fullscreen takes about 8 seconds in QB
'NOTE: Adjust x2% = 639 and y2% = 479 for legal POINTs when fullscreen in SCREEN 12 
DIM FileCOLORS%(1 TO 48)
DIM Colors4%(0 TO 15)
IF x1% > x2% THEN SWAP x1%, x2%
IF y1% > y2% THEN SWAP y1%, y2%
IF INSTR(Filename$, ".BMP") = 0 THEN
    Filename$ = RTRIM$(LEFT$(Filename$, 8)) + ".BMP"
END IF
  
FileTYPE$ = "BM"
Reserved1% = 0
Reserved2% = 0
OffsetBITS& = 118
InfoHEADER& = 40
PictureWIDTH& = (x2% - x1%) + 1
PictureDEPTH& = (y2% - y1%) + 1
NumPLANES% = 1
BPP% = 4
Compression& = 0
WidthPELS& = 3780
DepthPELS& = 3780
NumCOLORS& = 16

IF PictureWIDTH& MOD 8 <> 0 THEN
   ZeroPAD$ = SPACE$((8 - PictureWIDTH& MOD 8) \ 2)
END IF

ImageSIZE& = (((PictureWIDTH& + LEN(ZeroPAD$)) * PictureDEPTH&) + .1) / 2
FileSize& = ImageSIZE& + OffsetBITS&
  
OUT &H3C7, 0                    'start at color 0
FOR n = 1 TO 48 STEP 3
  FileCOLORS%(n) = INP(&H3C9)
  FileCOLORS%(n + 1) = INP(&H3C9)
  FileCOLORS%(n + 2) = INP(&H3C9)
NEXT n
f% = FREEFILE
OPEN Filename$ FOR BINARY AS #f%
                                   'Header bytes
PUT #f%, , FileTYPE$                   '2 '1 to 2
PUT #f%, , FileSize&                   '4
PUT #f%, , Reserved1% 'should be zero  '2
PUT #f%, , Reserved2% 'should be zero  '2
PUT #f%, , OffsetBITS&                 '4
PUT #f%, , InfoHEADER&                 '4
PUT #f%, , PictureWIDTH&               '4
PUT #f%, , PictureDEPTH&               '4
PUT #f%, , NumPLANES%                  '2
PUT #f%, , BPP%                        '2
PUT #f%, , Compression&                '4
PUT #f%, , ImageSIZE&                  '4
PUT #f%, , WidthPELS&                  '4
PUT #f%, , DepthPELS&                  '4
PUT #f%, , NumCOLORS&                  '4
PUT #f%, , SigCOLORS&                  '4 '51 - 54

u$ = " "             'unused byte
FOR n% = 1 TO 46 STEP 3   'PUT as BGR order colors
  Colr$ = CHR$(FileCOLORS%(n% + 2) * 4)
  PUT #f%, , Colr$
  Colr$ = CHR$(FileCOLORS%(n% + 1) * 4)
  PUT #f%, , Colr$
  Colr$ = CHR$(FileCOLORS%(n%) * 4)
  PUT #f%, , Colr$
  PUT #f, , u$ 'add Unused byte
NEXT n%

FOR y = y2% TO y1% STEP -1    'Place from bottom up
  FOR x = x1% TO x2% STEP 2   'nibble steps
    HiX = POINT(x, y): Colors4%(HiX) = 1     'added here
    LoX = POINT(x + 1, y): Colors4%(LoX) = 1
    HiNIBBLE$ = HEX$(HiX)
    LoNIBBLE$ = HEX$(LoX)
    HexVAL$ = "&H" + HiNIBBLE$ + LoNIBBLE$
    a$ = CHR$(VAL(HexVAL$))
    PUT #f%, , a$
  NEXT x
  PUT #f%, , ZeroPAD$
NEXT y

FOR n = 0 TO 15
  IF Colors4%(n) = 1 THEN SigCOLORS& = SigCOLORS& + 1
NEXT n
PUT #f%, 51, SigCOLORS&     

CLOSE #f%
'BEEP         'optional sound not needed in QB64 as speed is fast
END SUB   

```

**If full code is not displayed, refresh your browser!**

## See Example(s)


* [SAVEIMAGE](SAVEIMAGE) (QB64 full screen Image to Bitmap SUB by Galleon)
* [ThirtyTwoBit SUB](ThirtyTwoBit-SUB) (QB64 saves partial Image area to bitmap)
* [Bitmaps](Bitmaps)

## See Also

* [_LOADIMAGE](_LOADIMAGE)
* [POINT](POINT), [PUT](PUT)
