The following program can create a single icon from square bitmaps up to 128 X 128. Best to use sizes 32 X 32 or 64 X 64.

```vb

CONST dat = 14~&
DIM Dword AS _UNSIGNED LONG
DIM size AS _UNSIGNED LONG
DIM wide AS _UNSIGNED LONG
DIM high AS _UNSIGNED LONG
DIM Word AS _UNSIGNED INTEGER
DIM Byte AS _UNSIGNED _BYTE
DO
  LINE INPUT "Enter existing BMP file name to convert to icon: ", BMP$
LOOP UNTIL _FILEEXISTS(BMP$)
DO
  LINE INPUT "Enter ICO file name to create (must not exist): ", ICO$
LOOP UNTIL _FILEEXISTS(ICO$) = 0

OPEN BMP$ FOR BINARY ACCESS READ AS 1 'BITMAP name
OPEN ICO$ FOR OUTPUT AS 2 'destination icon name
CLOSE 2
OPEN ICO$ FOR BINARY AS 2
GET 1, 1 + 2, size 'skip "BM" in bitmap
size = size - 14 '14 bytes not used

Word = 0
PUT 2, 1, Word 'reserved
Word = 1
PUT 2, , Word 'resource id 1 as icon, 2 as cursor
PUT 2, , Word 'icon count in resource
GET 1, 1 + dat + 4, wide 'skip header size in BMP
SELECT CASE wide
  CASE IS < &H100: Byte = wide '< 256
  CASE &H100: Byte = 0
  CASE ELSE: PRINT "bitmap is larger than 256 pixels.": END
END SELECT
PUT 2, , Byte 'width
GET 1, , high
SELECT CASE high
  CASE IS < &H100: Byte = high '< 256
  CASE &H100: Byte = 0 '256 = 0
  CASE ELSE: PRINT "bitmap is larger than 256 pixels.": END
END SELECT
PUT 2, , Byte 'height
Byte = 0
GET 1, 1 + dat + 14, Word 'number of colors from BPP
IF Word < 8 THEN Byte = 2 ^ Word ELSE Byte = 0 '256 colors = 0, 4BPP = 16
PUT 2, , Byte 'num of colors
Byte = 0
Dword = 0
PUT 2, , Byte 'reserved as byte
PUT 2, , Dword 'reserved 2 hotspots = 0
Dword = size + (((wide * high) + 7) \ 8)
PUT 2, , Dword 'size of data
Dword = 22 '6 byte header + 16
PUT 2, , Dword 'offset

'copy bitmap header down 14 bytes, palette and image info, but double height
SEEK 1, 1 + dat 'BMP info header size
FOR Dword = 1 TO size 'actual BMP data from Header size on
  GET 1, , Byte
  IF Dword = 1 + 8 THEN
    Word = high * 2 ' 2 times height
    PUT 2, , Word
    Dword = Dword + 1
    GET 1, , Byte
  ELSE
    PUT 2, , Byte
  END IF
NEXT

'add null AND bitmask for full square image
Byte = 0
BitsOver& = wide MOD 32  'pad the AND mask for minimum of 4 byte width
IF BitsOver& THEN ANDpad& = (32 - BitsOver&) ELSE ANDpad& = 0
FOR Dword = 1 TO high * (wide + ANDpad&) \ 8
  PUT 2, , Byte
NEXT
CLOSE
SYSTEM

```
<sub>Adapted from code by Michael Calkins, Public domain, November 2011</sub>

## See Also

* [_ICON](_ICON), [$EXEICON]($EXEICON)
* [SaveIcon32](SaveIcon32) (saves any image to icon)
* [Icons and Cursors](Icons-and-Cursors)
* [Bitmaps](Bitmaps)
