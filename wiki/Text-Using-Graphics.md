While QB64 offers [_FONT](_FONT) and [Unicode](Unicode) text options, QBasic was limited in what it could offer. This shortfall could be overcome in various ways including using sprite pictures. Thanks to QB64, we can have the best in both worlds without creating them yourself!

> 1) The characters can be loaded in a file for QBasic.
> 2) Text fonts can be sized without re-loading them.
> 3) Data files are smaller than [BSAVE](BSAVE) image files.
> 4} Proper character spacing is already done for you.

## Bit Packing Pixel Data

In QBasic, text blocks were always 8 pixels wide no matter what screen mode was used. This allowed the total data value of a row to be set by reading 8 pixels using [POINT](POINT). The value can be stored in one [_BYTE](_BYTE)(8 bits) of data using [ASCII](ASCII) string characters.

<sub>Qbasic concept by Artelius</sub>

```text

SCREEN 12             'text characters are 8 X 16 pixel blocks
DIM SHARED Char(0 TO 255, 0 TO 15) AS STRING * 1  'store data by character row byte values
TextSave                     'call to SUB at start of program

SUB TextSave
OUT &H3C8, 1: OUT &H3C9, 0: OUT &H3C9, 0: OUT &H3C9, 0 'print text as background color
COLOR 1 'hide the character printing
FOR ascii% = 0 TO 255 'Draw map of each character
   IF ascii% = 7 THEN ascii% = 8              'eliminate beep character sound when printed
   LOCATE 1, 1: PRINT CHR$(ascii%)            'PRINT ASCII characters to top left corner
   FOR row% = 0 TO 15                         'read 16 row byte values
      byte = 0                                'reset value every row
      FOR col% = 7 TO 0 STEP -1               'read 8 pixels from right to left
         byte = byte * 2 - (POINT(col%, row%) > 0)  'bit-packing with 2 ^ bit
      NEXT
      Char(ascii%, row%) = CHR$(byte)         'convert row byte value to ASCII character
   NEXT
   LOCATE CSRLIN, POS(0) - 1: PRINT SPACE$(1) 'erase previous character anywhere
NEXT
PALETTE  'restore all palette colors
END SUB 

```

> Above [ASCII](ASCII) Characters 7, 9, 10, 11, 12, 13, 28, 29, 30, and 31 won't print in QBasic! **QB64** can print them with [_PRINTSTRING](_PRINTSTRING) or by using [PRINT](PRINT) after [_CONTROLCHR](_CONTROLCHR) OFF is set.

**Bit Packing**

```vb

  FOR col% = 7 TO 0 STEP -1                     'read pixels from right to left
      byte = byte * 2 - (POINT(col%, row%) > 0)  'bit-packing with 2 ^ bit
  NEXT

```

> Bit packing is done by doubling the current byte value and adding one for each bit where a pixel is not colored black.

> The [boolean](boolean) statement `(POINT(col%, row%) > 0)` evaluates to -1(true) when a pixel is on or 0(false) when a pixel is off. This effectively adds 1 to the byte value. Each loop that byte value is doubled as [POINT](POINT) goes from right to left. If the left-most pixel is on, it will only add one to the byte value as expected. This makes the total sum of the bit values or the byte value equal to 255 if all of the pixels are on as shown below:

```text

 **               Bit\Column #:  0   1   2   3   4   5   6   7   TOTAL **
                Exponent 2 ^:  0   1   2   3   4   5   6   7
                Bit Value On:  1   2   4   8  16  32  64  128   255

```

> Alpha-numeric text byte values will never be close to 255 because the first and last columns will normally be 0 as they are used to space text characters. Some characters, such as [CHR$](CHR$)(219) can have byte totals of 255 and have a value every row however.

## Example(s)

*Example Code:* Displays the 16 one byte row values saved as [ASCII](ASCII) characters in the [STRING](STRING) array using [_PRINTSTRING](_PRINTSTRING).

```vb

SCREEN 12 'text characters are 8 X 16 pixel blocks
DIM SHARED Char(0 TO 255, 0 TO 15) AS STRING * 1 'store data by character row byte values
TextSave 'call to SUB at start of program

DO
  COLOR 11: LOCATE 10, 10: INPUT "Enter keypress or an ASCII code 1 to 255: ", cod$
  CLS: code = VAL(cod$)
  IF (code <= 0 AND LEN(cod$) > 0) OR code > 255 THEN code = ASC(cod$)
  COLOR 14: _PRINTSTRING (0, 50), LTRIM$(STR$(code))
  FOR n = 0 TO 15
    ch$ = Char(code, n)
    _PRINTSTRING (n * 30 + 40, 50), ch$ + ","
  NEXT
  _PRINTSTRING (600, 50), CHR$(code)
LOOP UNTIL LEN(cod$) = 0
END

SUB TextSave
OUT &H3C8, 1: OUT &H3C9, 0: OUT &H3C9, 0: OUT &H3C9, 0 'print text as background color
COLOR 1 'hide the character printing
FOR ascii% = 0 TO 255 'Draw map of each character
  _PRINTSTRING (0, 0), CHR$(ascii%) 'PRINT ASCII characters to top left corner
  FOR row% = 0 TO 15 'read 16 row byte values
    byte = 0 'reset value every row
    FOR col% = 7 TO 0 STEP -1 'read 8 pixels from right to left
      byte = byte * 2 - (POINT(col%, row%) > 0) 'bit-packing with 2 ^ bit
    NEXT
    Char(ascii%, row%) = CHR$(byte) 'convert row byte value to ASCII character
  NEXT
NEXT
PALETTE 'restore all palette colors
END SUB

```

> *Note:* [ASCII](ASCII) character values of [CHR$](CHR$)(0), [CHR$](CHR$)(32) and [CHR$](CHR$)(255) will only display an empty space!

> The [ASCII](ASCII) character data in the array can also be saved to a comma separated file with [WRITE](WRITE) for later use. In fact, the data can be read and displayed by QBasic programs later using special [_LOADFONT](_LOADFONT) or [Unicode](Unicode)! Wider characters will require larger values than [_BYTE](_BYTE).

## Displaying Text Characters

Once the data is saved, we need something to convert the data back into text characters. There are several ways to do this simply by using [PSET](PSET) for normal sizes or [CIRCLE](CIRCLE) or [LINE](LINE) to amplify the displayed character sizes. Use a normal [FOR...NEXT](FOR...NEXT) 0 TO 7 loop to read:

**[ASCII](ASCII) 8 X 16 Text character size increased using [CIRCLE](CIRCLE)**

```vb

SCREEN 12 'text characters are 8 X 16 pixel blocks
DIM SHARED Char(0 TO 255, 0 TO 15) AS STRING * 1 'store data by character row byte values
TextSave 'call to SUB at start of program

ch = 1 'character 1
DO: rowy = 0
  COLOR 14: LOCATE 26, 5
  FOR yy = 100 TO 220 STEP 8
    rowval = ASC(Char$(ch, rowy)) 'pixel row value
    SELECT CASE ch
      CASE 8, 10, 178, 182, 185, 186, 199, 204, 206, 215, 219, 222
        PRINT STR$(rowval); 'compact the values
      CASE ELSE: PRINT rowval;
    END SELECT
    SetCHR 25, POS(0) - 2, 11, rowval
    colx = 0
    FOR xx = 300 TO 356 STEP 8   
      IF (rowval AND 2 ^ colx) > 0 THEN
        CIRCLE (xx, yy), 4, 7   'display text character as full white circles
        PAINT STEP(0, 0), 15, 7
        ' LINE (xx - 4, yy - 4)-(xx + 3, yy + 3), 15, BF
      ELSE:
        CIRCLE (xx, yy), 4, 1   'display background as full blue circles
        PAINT STEP(0, 0), 1
        '  LINE (xx - 4, yy - 4)-(xx + 3, yy + 3), 1, BF
      END IF
      colx = colx + 1
    NEXT
    _DELAY .2
    rowy = rowy + 1
  NEXT
  LOCATE 22, 40: PRINT SPACE$(39)
  LOCATE 22, 5: COLOR 13: LINE INPUT "Enter ASCII code(1 to 255) or press key character (Enter quits): ", ch$
  LOCATE 23, 2: PRINT SPACE$(78)
  LOCATE 25, 4: PRINT SPACE$(75)
  LOCATE 26, 4: PRINT SPACE$(75)
  ch = VAL(ch$)
  IF ch = 0 AND LEN(ch$) THEN ch = ASC(ch$)
LOOP UNTIL ch = 0 OR ch > 255
END

SUB SetCHR (Trow, Tcol, FG, ASCode)    'displays ASCII character value from array
Srow = 16 * (Trow - 1): Scol = 8 * (Tcol - 1) 'convert text to graphic coordinates
FOR y = 0 TO 15
  ybyte$ = Char$(ASCode, y): yval = ASC(ybyte$)
  FOR x = 0 TO 7
    IF (yval AND 2 ^ x) > 0 THEN PSET (Scol + x, Srow + y), FG
  NEXT
NEXT
END SUB

SUB TextSave
OUT &H3C8, 1: OUT &H3C9, 0: OUT &H3C9, 0: OUT &H3C9, 0 'print text as background color
COLOR 1 'hide the character printing
FOR ascii% = 0 TO 255 'Draw map of each character
  _PRINTSTRING (0, 0), CHR$(ascii%) 'PRINT ASCII characters to top left corner
  FOR row% = 0 TO 15 'read 16 row byte values
    byte = 0 'reset value every row
    FOR col% = 7 TO 0 STEP -1 'read 8 pixels from right to left
      byte = byte * 2 - (POINT(col%, row%) > 0) 'bit-packing with 2 ^ bit
    NEXT
    Char(ascii%, row%) = CHR$(byte) 'convert row byte value to ASCII character
  NEXT
NEXT
PALETTE 'restore all palette colors
END SUB 

```
<sub>Code by Ted Weissgerber</sub>

> The program above shows each array [_BYTE](_BYTE) character value and character. [PRINT](PRINT) will not print some characters in QB64 or QB.

Use **[_CONTROLCHR](_CONTROLCHR) OFF** to [PRINT](PRINT) control characters in QB64!

**[ASCII](ASCII) 8 X 16 Text Character size increased using [LINE](LINE)**

```vb

SUB DisplayText (Xpos, Ypos, FG, BG, Xsize, Ysize, text$)
x = Xpos: y = Ypos: Xoff = (8 * Xsize): L = LEN(text$)
IF BG THEN                                 'set BackGround if not 0
LINE (x - (2 * Xsize), y - Ysize)-(x + (L * Xoff), y + (16 * Ysize)), BG, BF
END IF
FOR character = 1 TO L                     'go through text chars
  tx = ASC(MID$(text$, character, 1))      'get ASCII value
  FOR r = 0 TO 15                          'current row of 16
    FOR c = 0 TO 7 '                       'cycle through 8 bit values
      IF ASC(Char(tx, r)) AND 2 ^ c THEN      'if bit is on
        LINE (x, y)-(x + Xsize - 1, y + Ysize - 1), FG, BF
      END IF  'adapted from code by TerryRitchie @ www.QB64.net
      x = x + Xsize                        'move x position
    NEXT c                                 'next bit
    y = y + Ysize                          'move y position
    x = Xpos                               'reset column position
  NEXT r
  y = Ypos                                 'reset y position
  Xpos = Xpos + Xoff                       'set to next character column
NEXT character                             'next character
END SUB 

```
<sub>Adapted from code by Terry Ritchie</sub>

> **NOTE: This procedure requires Char [STRING](STRING) array data created by the TextSave [SUB](SUB) from above to be run first!**

> * *Xpos* and *Ypos* parameters set the top left graphic start position coordinate of the text string. [LOCATE](LOCATE) cannot be used. 
> * *FG* and *BG* determine the text foreground and background colors respectively. If BG is 0, then no background color is used.
> * *Xsize* and *Ysize* determines the size multiple increase of the letters. One is normal size, two is double size etc.
> * *text$* is the text [STRING](STRING) that is to be printed. There will not be an error or screen roll if text goes out of the screen area!

## Font and Unicode Conversion

To convert different sized [_FONT](_FONT) or [Unicode](Unicode) characters, first determine the text block size to find how much data is required:

```vb
                           'Code must be run in QB64 ONLY! 
DEFINT A-Z
DIM SHARED high%  'value is shared with both SUB procedures!
DO
  INPUT "Enter Screen mode 1, 2 or 7 to 13 or 256 for _NEWIMAGE: ", scr$
  mode% = VAL(scr$)
LOOP UNTIL mode% > 0
SELECT CASE mode%
  CASE 1, 2, 7 TO 13: SCREEN mode%
  CASE 256: SCREEN _NEWIMAGE(800, 600, mode%)
  CASE ELSE: PRINT "Invalid screen mode selected!": END
END SELECT

INPUT "Enter first name of TTF font to use or hit Enter for block size: ", TTFont$
IF LEN(TTFont$) THEN INPUT "Enter font height: ", hi$
height% = VAL(hi$)
IF height% > 0 THEN
  fnt& = _LOADFONT("C:\Windows\Fonts\" + TTFont$ + ".ttf", height%, style$)
  IF fnt& <= 0 THEN PRINT "Invalid Font handle!": END
  _FONT fnt&
END IF

  'add Unicode Code Page data using _MAPUNICODE here:

high% = _FONTHEIGHT: wid% = _PRINTWIDTH("W")
DIM SHARED Char(0 TO 255, 0 TO high%) AS INTEGER 'size for integer MKI$ strings up to 16 wide
TextSave 'create character pixel data

DisplayText 10, 20, 15, 2, 2, "This is a graphic test of font!"

_PRINTSTRING (10, 120), "Actual text or font size =" + STR$(wid%) + " X" + STR$(high%)

Char(0, 0) = high%  'place font height at start of array and file. Other dimension always 255
ff = FREEFILE
OPEN "FontText.bin" FOR OUTPUT AS #ff 'erase previous data
CLOSE #ff
OPEN "FontText.bin" FOR BINARY AS #ff
PUT #ff, , Char()                'PUT the entire array into a BINARY file
CLOSE #ff

END

SUB DisplayText (Xpos, Ypos, FG, Xsize, Ysize, text$)
x = Xpos: y = Ypos: L = LEN(text$)
FOR character = 1 TO L 'go through text chars
  tx = ASC(MID$(text$, character, 1))               'get each letter's ASCII value
  wide% = Char(tx, high%): Xoff = wide% * Xsize     'get font width from high row
  FOR r% = 0 TO high% - 1                           'current row value
    value% = Char(tx, r%)                           'row byte value
    FOR c% = 0 TO wide% - 1                         'cycle through bit values
      IF value% AND 2 ^ c% THEN 'if bit is on
        LINE (x, y)-(x + Xsize - 1, y + Ysize - 1), FG, BF
      END IF               'adapted from code by TerryRitchie @ www.QB64.net
      x = x + Xsize                      'move x position
    NEXT c%                              'next column bit
    y = y + Ysize                        'move y position
    x = Xpos                             'reset column position
  NEXT r%
  y = Ypos                               'reset y position
  Xpos = Xpos + Xoff                     'set to next character column
NEXT character
END SUB

SUB TextSave
OUT &H3C8, 15: OUT &H3C9, 0: OUT &H3C9, 0: OUT &H3C9, 0 'print text as background color
FOR ascii% = 0 TO 255 'Draw map of each character
  CLS
  _PRINTSTRING (0, 0), CHR$(ascii%) 'PRINT ASCII characters to top left corner
  wide% = _PRINTWIDTH(CHR$(ascii%))
  FOR row% = 0 TO high% - 1 'read row byte values
    byte% = 0 'reset value every row
    FOR col% = wide% - 1 TO 0 STEP -1 'read pixels from right to left
      byte% = byte% * 2 - (POINT(col%, row%) > 0) 'bit-packing with 2 ^ bit
    NEXT
    Char(ascii%, row%) = byte% 'convert row byte value to 2 byte MKI$ character
  NEXT
  Char(ascii%, high%) = wide%  'place individual font widths into array high row
NEXT
PALETTE 'restore all palette colors
END SUB 

```
<sub>Code by Ted Weissgerber</sub>

> *Explanation:* [_PRINTWIDTH](_PRINTWIDTH) can read the pixel width of one character and can be used to measure non-monospace fonts.

> If the character width is wider than 8 pixels, we can no longer store the exponent of two values in one [_BYTE](_BYTE) or represent that byte as an [ASCII](ASCII) character so we can use an [INTEGER](INTEGER) or [LONG](LONG) array to hold the values, which can be saved to file with [PUT](PUT).

**Variable font widths**

> Some fonts vary in width for every character so we can store *wide&* as a [HEX$](HEX$) value in the *high&* array row value as we use 0 through *high&* - 1 to store the bit totals. Save the  *high&* [_FONTHEIGHT](_FONTHEIGHT) value for the sub-procedures and to dimension an array!

> **This allows the use of DisplayText [SUB](SUB) in a QBasic program to read the data when you save the array data to a file.**

## Reading the Data File

**Reading the file data in a QB64 program only**

```vb

DEFINT A-Z
DIM SHARED high% 'must share with DisplayText SUB!
SCREEN _NEWIMAGE(800, 600, 256)

f = FREEFILE
OPEN "FontText.bin" FOR BINARY AS #f
GET #f, , high%   'GET the first integer value as the second array dimension
SEEK #f, 1        'SEEK moves back to the beginning of the file
PRINT high%
REDIM SHARED Char(0 TO 255, 0 TO high%) AS INTEGER  'Dynamic array
GET #f, , Char()  'one GET moves all of the data back to the array once it is sized correctly
CLOSE #f
Char(0, 0) = 0

DisplayText 10, 100, 12, 4, 4, "This is the font from the BIN file!"

END

SUB DisplayText (Xpos, Ypos, FG, Xsize, Ysize, text$)
x = Xpos: y = Ypos: L = LEN(text$)
FOR character = 1 TO L                              'go through text chars
  tx = ASC(MID$(text$, character, 1))               'get ASCII value
  wide% = Char(tx, high%): Xoff = wide% * Xsize     'read variable font widths
  FOR r% = 0 TO high% - 1           'current row value
    value% = Char(tx, r%)
    FOR c% = 0 TO wide% - 1        'cycle through bit values
      IF value% AND 2 ^ c% THEN 'if bit is on
        LINE (x, y)-(x + Xsize - 1, y + Ysize - 1), FG, BF
      END IF                'adapted from code by TerryRitchie @ www.QB64.net
      x = x + Xsize                'move x position
    NEXT c%                        'next bit
    y = y + Ysize                  'move y position
    x = Xpos                       'reset column position
  NEXT r%
  y = Ypos                         'reset y position
  Xpos = Xpos + Xoff               'set to next character column
NEXT character
END SUB 

```

*Note:* Use empty parenthesis after the [Arrays](Arrays) name to [PUT](PUT) # or [GET](GET) # the entire array, even multi-dimensional ones.

**Reading the file data in a QBasic or QB64 program**

```vb

DEFINT A-Z
SCREEN 12
DIM SHARED high% 'must share with DisplayText SUB!

f = FREEFILE
OPEN "FontText.bin" FOR BINARY AS #f
GET #f, , high% 'GET the first integer value as the second array dimension

REDIM SHARED Char(0 TO 255, 0 TO high%) AS INTEGER  'Dynamic array
ReadData (f)

DisplayText 10, 100, 12, 4, 4, "This is the font from the BIN file!"

END

SUB ReadData (f)
SEEK #f, 1                'SEEK moves back to the beginning of the file
PRINT high%
DO
  FOR row = 0 TO high%    'read each row as a group of 256 values
    FOR code = 0 TO 255   'read the row value for each character
      GET #f, , valu%
      IF EOF(f) THEN EXIT DO 'prevents bad data
      Char(code, row) = valu%
  NEXT: NEXT
LOOP UNTIL 1 = 1 'one time DO loop if End Of File
CLOSE #f
Char(0, 0) = 0          'remove the high% value from CHR$(0) array data
END SUB

SUB DisplayText (Xpos, Ypos, FG, Xsize, Ysize, text$)
x = Xpos: y = Ypos: L = LEN(text$)
FOR character = 1 TO L                                    'go through text chars
  tx = ASC(MID$(text$, character, 1))                     'get ASCII value
  wide% = Char(tx, high%): Xoff = wide% * Xsize           'read variable font widths
  FOR r% = 0 TO high% - 1                                 'current row value
    value% = Char(tx, r%)
    FOR c% = 0 TO wide% - 1 'cycle through bit values
      IF value% AND 2 ^ c% THEN 'if bit is on
        LINE (x, y)-(x + Xsize - 1, y + Ysize - 1), FG, BF
      END IF               'adapted from code by TerryRitchie @ www.QB64.net
      x = x + Xsize               'move x position
    NEXT 'next bit
    y = y + Ysize 'move y position
    x = Xpos 'reset column position
  NEXT r%
  y = Ypos 'reset y position
  Xpos = Xpos + Xoff              'set to next character column
NEXT character
END SUB 

```

The QB64 [PUT](PUT) [BINARY](BINARY) file can be read to the array by reading the row values for all of the characters as above.

**The average font file with 256 characters is less than 20 KB in size!**

## See Also

* [_PRINTSTRING](_PRINTSTRING), [_PRINTWIDTH](_PRINTWIDTH)
* [_LOADFONT](_LOADFONT), [_FONTHEIGHT](_FONTHEIGHT)
* [_MAPUNICODE](_MAPUNICODE), [_CONTROLCHR](_CONTROLCHR)
* [Boolean](Boolean), [AND](AND) (logic operator)
* [ASCII](ASCII), [Unicode](Unicode), [Code Pages](Code-Pages)
