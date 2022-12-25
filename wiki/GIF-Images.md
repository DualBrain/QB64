**Animated GIF File Decoder**

GIF files can be one frame or animated images made up of many frames that are displayed at a set frame rate. The following program allows you to view either kind of image or use them in a program. [_LOADIMAGE](_LOADIMAGE) can only return one frame of an animated image. 

```vb

'#######################################################################################
'# Animated GIF decoder v1.0                                                           #
'# By Zom-B                                                                            #
'#######################################################################################

DEFINT A-Z
'$DYNAMIC

DIM SHARED Dbg: Dbg = 0
DIM SHARED powerOf2&(11)
FOR a = 0 TO 11: powerOf2&(a) = 2 ^ a: NEXT a

TYPE GIFDATA
  file AS INTEGER
  sigver AS STRING * 6
  width AS _UNSIGNED INTEGER
  height AS _UNSIGNED INTEGER
  bpp AS _UNSIGNED _BYTE
  sortFlag AS _BYTE ' Unused
  colorRes AS _UNSIGNED _BYTE
  colorTableFlag AS _BYTE
  bgColor AS _UNSIGNED _BYTE
  aspect AS SINGLE ' Unused
  numColors AS _UNSIGNED INTEGER
  palette AS STRING * 768
END TYPE

TYPE FRAMEDATA
  addr AS LONG
  left AS _UNSIGNED INTEGER
  top AS _UNSIGNED INTEGER
  width AS _UNSIGNED INTEGER
  height AS _UNSIGNED INTEGER
  localColorTableFlag AS _BYTE
  interlacedFlag AS _BYTE
  sortFlag AS _BYTE ' Unused
  palBPP AS _UNSIGNED _BYTE
  minimumCodeSize AS _UNSIGNED _BYTE
  transparentFlag AS _BYTE 'GIF89a-specific (animation) values
  userInput AS _BYTE ' Unused
  disposalMethod AS _UNSIGNED _BYTE
  delay AS SINGLE
  transColor AS _UNSIGNED _BYTE
END TYPE

SCREEN _NEWIMAGE(640, 480, 32)

' Open gif file. This reads the headers and palette but not the image data.
' The array will be redimentioned to fit the exact number of frames in the file.

DIM gifData AS GIFDATA, frameData(0 TO 0) AS FRAMEDATA

filename$ = "mygif.gif"  '<<<<<<<<<<<< Enter a file name here!!!

IF LEN(filename$) = 0 THEN END
openGif filename$, gifData, frameData()

' Loop away.
frame = 0
DO
  ' Request a frame. If it has been requested before, it is re-used,
  ' otherwise it is read and decoded from the file.
  _PUTIMAGE (0, 0), getGifFrame&(gifData, frameData(), frame)
  _DELAY frameData(frame).delay
  frame = (frame + 1) MOD (UBOUND(framedata) + 1)
LOOP UNTIL LEN(INKEY$)

'Close the file and free the allocated frames.
codeGif gifData, frameData()
END

'########################################################################################

SUB openGif (filename$, gifData AS GIFDATA, frameData() AS FRAMEDATA) STATIC
file = FREEFILE: gifData.file = file
OPEN "B", gifData.file, filename$

GET file, , gifData.sigver
GET file, , gifData.width
GET file, , gifData.height
GET file, , byte~%%
gifData.bpp = (byte~%% AND 7) + 1
gifData.sortFlag = (byte~%% AND 8) > 0
gifData.colorRes = (byte~%% \ 16 AND 7) + 1
gifData.colorTableFlag = (byte~%% AND 128) > 0
gifData.numColors = 2 ^ gifData.bpp
GET file, , gifData.bgColor
GET file, , byte~%%
IF byte~%% = 0 THEN gifData.aspect = 0 ELSE gifData.aspect = (byte~%% + 15) / 64

IF gifData.sigver <> "GIF87a" AND gifData.sigver <> "GIF89a" THEN _DEST 0: PRINT "Invalid version": END
IF NOT gifData.colorTableFlag THEN _DEST 0: PRINT "No Color Table": END

palette$ = SPACE$(3 * gifData.numColors)
GET file, , palette$
gifData.palette = palette$
IF Dbg AND 1 THEN 
  PRINT "sigver         ="; gifData.sigver
  PRINT "width          ="; gifData.width
  PRINT "height         ="; gifData.height
  PRINT "bpp            ="; gifData.bpp
  PRINT "sortFlag       ="; gifData.sortFlag
  PRINT "colorRes       ="; gifData.colorRes
  PRINT "colorTableFlag ="; gifData.colorTableFlag
  PRINT "bgColor        ="; gifData.bgColor
  PRINT "aspect         ="; gifData.aspect
  PRINT "numColors      ="; gifData.numColors
  FOR i = 0 TO gifData.numColors - 1
    PRINT USING "pal(###) = "; i;
    PRINT HEX$(_RGB32(ASC(gifData.palette, i * 3 + 1), ASC(gifData.palette, i * 3 + 2), ASC(gifData.palette, i * 3 + 3)))
  NEXT
END IF
DO
  GET file, , byte~%%
  IF Dbg AND 2 THEN PRINT "Chunk: "; HEX$(byte~%%)
  SELECT CASE byte~%%
    CASE &H2C ' Image Descriptor
      IF frame > UBOUND(frameData) THEN
        REDIM _PRESERVE frameData(0 TO frame * 2 - 1) AS FRAMEDATA
      END IF

      GET file, , frameData(frame).left
      GET file, , frameData(frame).top
      GET file, , frameData(frame).width
      GET file, , frameData(frame).height
      GET file, , byte~%%
      frameData(frame).localColorTableFlag = (byte~%% AND 128) > 0
      frameData(frame).interlacedFlag = (byte~%% AND 64) > 0
      frameData(frame).sortFlag = (byte~%% AND 32) > 0
      frameData(frame).palBPP = (byte~%% AND 7) + 1
      frameData(frame).addr = LOC(file) + 1

      IF frameData(frame).localColorTableFlag THEN
        SEEK file, LOC(file) + 3 * 2 ^ frameData(frame).palBPP + 1
      END IF
      GET file, , frameData(frame).minimumCodeSize
      IF Dbg AND 2 THEN 
        PRINT "addr                ="; HEX$(frameData(frame).addr - 1)
        PRINT "left                ="; frameData(frame).left
        PRINT "top                 ="; frameData(frame).top
        PRINT "width               ="; frameData(frame).width
        PRINT "height              ="; frameData(frame).height
        PRINT "localColorTableFlag ="; frameData(frame).localColorTableFlag
        PRINT "interlacedFlag      ="; frameData(frame).interlacedFlag
        PRINT "sortFlag            ="; frameData(frame).sortFlag
        PRINT "palBPP              ="; frameData(frame).palBPP
        PRINT "minimumCodeSize     ="; frameData(frame).minimumCodeSize
      END IF
      IF localColors THEN _DEST 0: PRINT "Local color table": END
      IF frameData(frame).disposalMethod > 2 THEN PRINT "Unsupported disposalMethod: "; frameData(frame).disposalMethod: END
      skipBlocks file

      frame = frame + 1
    CASE &H3B ' Trailer
      EXIT DO
    CASE &H21 ' Extension Introducer
      GET file, , byte~%% ' Extension Label
      IF Dbg AND 2 THEN PRINT "Extension Introducer: "; HEX$(byte~%%)
      SELECT CASE byte~%%
        CASE &HFF, &HFE ' Application Extension, Comment Extension
          skipBlocks file
        CASE &HF9
          IF frame > UBOUND(frameData) THEN
            REDIM _PRESERVE frameData(0 TO frame * 2 - 1) AS FRAMEDATA
          END IF

          GET 1, , byte~%% ' Block Size (always 4)
          GET 1, , byte~%%
          frameData(frame).transparentFlag = (byte~%% AND 1) > 0
          frameData(frame).userInput = (byte~%% AND 2) > 0
          frameData(frame).disposalMethod = byte~%% \ 4 AND 7
          GET 1, , delay~%
          IF delay~% = 0 THEN frameData(frame).delay = 0.1 ELSE frameData(frame).delay = delay~% / 100
          GET 1, , frameData(frame).transColor
          IF Dbg AND 2 THEN 
            PRINT "frame           ="; frame
            PRINT "transparentFlag ="; frameData(frame).transparentFlag
            PRINT "userInput       ="; frameData(frame).userInput
            PRINT "disposalMethod  ="; frameData(frame).disposalMethod
            PRINT "delay           ="; frameData(frame).delay
            PRINT "transColor      ="; frameData(frame).transColor
          END IF
          skipBlocks file
        CASE ELSE
          PRINT "Unsupported extension Label: "; HEX$(byte~%%): END
      END SELECT
    CASE ELSE
      PRINT "Unsupported chunk: "; HEX$(byte~%%): END
  END SELECT
LOOP

REDIM _PRESERVE frameData(0 TO frame - 1) AS FRAMEDATA
END FUNCTION

SUB skipBlocks (file)
DO
  GET file, , byte~%% ' Block Size
  IF Dbg AND 2 THEN PRINT "block size ="; byte~%%
  SEEK file, LOC(file) + byte~%% + 1
LOOP WHILE byte~%%
END SUB

FUNCTION getGifFrame& (gifData AS GIFDATA, frameData() AS FRAMEDATA, frame)
IF frameData(frame).addr > 0 THEN
  IF Dbg AND 4 THEN
    PRINT "addr                ="; HEX$(frameData(frame).addr - 1)
    PRINT "left                ="; frameData(frame).left
    PRINT "top                 ="; frameData(frame).top
    PRINT "width               ="; frameData(frame).width
    PRINT "height              ="; frameData(frame).height
    PRINT "localColorTableFlag ="; frameData(frame).localColorTableFlag
    PRINT "interlacedFlag      ="; frameData(frame).interlacedFlag
    PRINT "sortFlag            ="; frameData(frame).sortFlag
    PRINT "palBPP              ="; frameData(frame).palBPP
    PRINT "minimumCodeSize     ="; frameData(frame).minimumCodeSize
    PRINT "transparentFlag     ="; frameData(frame).transparentFlag
    PRINT "userInput           ="; frameData(frame).userInput
    PRINT "disposalMethod      ="; frameData(frame).disposalMethod
    PRINT "delay               ="; frameData(frame).delay
    PRINT "transColor          ="; frameData(frame).transColor
  END IF
  w = frameData(frame).width
  h = frameData(frame).height
  img& = _NEWIMAGE(w, h, 256)
  frame& = _NEWIMAGE(gifData.width, gifData.height, 256)

  _DEST img&
  decodeFrame gifData, frameData(frame)

  _DEST frame&
  IF frameData(frame).localColorTableFlag THEN
    _COPYPALETTE img&
  ELSE
    FOR i = 0 TO gifData.numColors - 1
      _PALETTECOLOR i, _RGB32(ASC(gifData.palette, i * 3 + 1), ASC(gifData.palette, i * 3 + 2), ASC(gifData.palette, i * 3 + 3))
    NEXT
  END IF

  IF frame THEN
    SELECT CASE frameData(frame - 1).disposalMethod
      CASE 0, 1
        _PUTIMAGE , frameData(frame - 1).addr
      CASE 2
        CLS , gifData.bgColor
        _CLEARCOLOR gifData.bgColor
    END SELECT
  ELSE
    CLS , gifData.bgColor
  END IF

  IF frameData(frame).transparentFlag THEN
    _CLEARCOLOR frameData(frame).transColor, img&
  END IF
  _PUTIMAGE (frameData(frame).left, frameData(frame).top), img&
  _FREEIMAGE img&

  frameData(frame).addr = frame&
  _DEST 0
END IF

getGifFrame& = frameData(frame).addr
END FUNCTION


'############################################################################################

SUB decodeFrame (gifdata AS GIFDATA, framedata AS FRAMEDATA)
DIM byte AS _UNSIGNED _BYTE
DIM prefix(4095), suffix(4095), colorStack(4095)

startCodeSize = gifdata.bpp + 1
clearCode = 2 ^ gifdata.bpp
endCode = clearCode + 1
minCode = endCode + 1
startMaxCode = clearCode * 2 - 1
nvc = minCode
codeSize = startCodeSize
maxCode = startMaxCode

IF framedata.interlacedFlag THEN interlacedPass = 0: interlacedStep = 8
bitPointer = 0
blockSize = 0
blockPointer = 0
x = 0
y = 0

file = gifdata.file
SEEK file, framedata.addr

IF framedata.localColorTableFlag THEN
  palette$ = SPACE$(3 * 2 ^ framedata.palBPP)
  GET 1, , palette$

  FOR i = 0 TO gifdata.numColors - 1
    c& = _RGB32(ASC(palette$, i * 3 + 1), ASC(palette$, i * 3 + 2), ASC(palette$, i * 3 + 3))
    _PALETTECOLOR i, c&
  NEXT
END IF

GET file, , byte ' minimumCodeSize

DO
  GOSUB GetCode
  stackPointer = 0
  IF code = clearCode THEN 'Reset & Draw next color direct
    nvc = minCode '           \
    codeSize = startCodeSize ' Preset default codes
    maxCode = startMaxCode '  /

    GOSUB GetCode
    currentCode = code

    lastColor = code
    colorStack(stackPointer) = lastColor
    stackPointer = 1
  ELSEIF code <> endCode THEN 'Draw direct color or colors from suffix
    currentCode = code
    IF currentCode = nvc THEN 'Take last color too
      currentCode = oldCode
      colorStack(stackPointer) = lastColor
      stackPointer = stackPointer + 1
    END IF

    WHILE currentCode >= minCode 'Extract colors from suffix
      colorStack(stackPointer) = suffix(currentCode)
      stackPointer = stackPointer + 1
      currentCode = prefix(currentCode) 'Next color from suffix is described in
    WEND '                                 the prefix, else prefix is the last col.

    lastColor = currentCode '              Last color is equal to the
    colorStack(stackPointer) = lastColor ' last known code (direct, or from
    stackPointer = stackPointer + 1 '      Prefix)
    suffix(nvc) = lastColor 'Automatically, update suffix
    prefix(nvc) = oldCode 'Code from the session before (for extracting from suffix)
    nvc = nvc + 1

    IF nvc > maxCode AND codeSize < 12 THEN
      codeSize = codeSize + 1
      maxCode = maxCode * 2 + 1
    END IF
  END IF

  FOR i = stackPointer - 1 TO 0 STEP -1
    PSET (x, y), colorStack(i)
    x = x + 1
    IF x = framedata.width THEN
      x = 0
      IF framedata.interlacedFlag THEN
        y = y + interlacedStep
        IF y >= framedata.height THEN
          SELECT CASE interlacedPass
            CASE 0: interlacedPass = 1: y = 4
            CASE 1: interlacedPass = 2: y = 2
            CASE 2: interlacedPass = 3: y = 1
          END SELECT
          interlacedStep = 2 * y
        END IF
      ELSE
        y = y + 1
      END IF
    END IF
  NEXT

  oldCode = code
LOOP UNTIL code = endCode

GET file, , byte
EXIT SUB

GetCode:
IF bitPointer = 0 THEN GOSUB ReadByteFromBlock: bitPointer = 8
WorkCode& = LastChar \ powerOf2&(8 - bitPointer)
WHILE codeSize > bitPointer
  GOSUB ReadByteFromBlock

  WorkCode& = WorkCode& OR LastChar * powerOf2&(bitPointer)
  bitPointer = bitPointer + 8
WEND
bitPointer = bitPointer - codeSize
code = WorkCode& AND maxCode
RETURN

ReadByteFromBlock:
IF blockPointer = blockSize THEN
  GET file, , byte: blockSize = byte
  a$ = SPACE$(blockSize): GET file, , a$
  blockPointer = 0
END IF
blockPointer = blockPointer + 1
LastChar = ASC(MID$(a$, blockPointer, 1))
RETURN
END SUB


SUB codeGif (gifData AS GIFDATA, frameData() AS FRAMEDATA)
FOR i = 0 TO UBOUND(FRAMEDATA)
  IF frameData(i).addr < 0 THEN _FREEIMAGE frameData(i).addr
NEXT

CLOSE gifData.file
END SUB


```

NOTE: This has been reported to only work using 256-color images, and you need to keep the code loading into a 32-bit image destination as the source?

## See Also

* [GIF Creation](GIF-Creation), [Bitmaps](Bitmaps)
* [Icons and Cursors](Icons-and-Cursors)
* [_LOADIMAGE](_LOADIMAGE), [_PUTIMAGE](_PUTIMAGE)
* [FILELIST$ (function)](FILELIST$-(function)) (member file search routine)
* [SaveIcon32](SaveIcon32) (create icons from any image)
* [$EXEICON]($EXEICON) (Icon visible in Windows Explorer)
