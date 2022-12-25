**SCREEN Memory Segments**

**Screen 0 Text Segment &HB800**

* The text video memory segment is located at hexadecimal memory address B800 or 47104 decimal.
* The normal [SCREEN](SCREEN) 0 [WIDTH](WIDTH) is 25 rows by 80 columns wide capable of up to 2000 text characters.
* Each text block memory offset consists of a text character byte followed by a color byte.
* Each [_UNSIGNED](_UNSIGNED) [_BYTE](_BYTE) can hold values from 0 to 255 only. [PEEK](PEEK) can read and [POKE](POKE) can write positive values to those bytes.
* Text ASCII code values range from 0 to 127 with the extended codes ranging from 128 to 255.
* Color values from 0 to 127 are the normal 16 text colors with background color attributes ranging from 0 to 7.
* Color values from 128 to 255 are the high intensity blinking color values with background color attributes ranging from 0 to 7.

## Example(s)

Printing text with blinking colors in [SCREEN](SCREEN) 0 only.

```vb

DIM s AS STRING
DIM i AS LONG
DIM j AS LONG
CLS
s = "Hello, World!"
DEF SEG = &HB800
FOR j = 1 TO 15
 FOR i = 1 TO LEN(s)
  POKE (j * 80 + (i - 1)) * 2, ASC(MID$(s$, i, 1))        'text characters
  POKE (j * 80 + (i - 1)) * 2 + 1, &H80 OR j 'blinking color
 NEXT
NEXT
DEF SEG 'restore to default segment
END 

```

Displaying and coloring the 256 [ASCII](ASCII) characters using [POKE](POKE) in [SCREEN](SCREEN) 0. 

```vb

SCREEN 12 'set full screen in QBasic only for flashing colors
SCREEN 0
OUT &H3C8, 0: OUT &H3C9, 0: OUT &H3C9, 0: OUT &H3C9, 20

_FONT _LOADFONT("C:\Windows\Fonts\Cour.ttf", 20, "MONOSPACE") 'select monospace font. QB64 only!

DEF SEG = &HB800                        'SCREEN 0 text ONLY!
FOR code = 0 TO 255
  POKE 640 + code * 4, code             'poke the even text offsets with space between
NEXT
COLOR 11: LOCATE 20, 27: PRINT "Press a key to add color!"
K$ = INPUT$(1)
FOR colr = 0 TO 255
  POKE 641 + colr * 4, colr             'poke the ODD color offsets(second byte)
NEXT
DEF SEG                                 'reset to default segment
END 

```
<sub>Code by Ted Weissgerber</sub>

> *Explanation:* To [POKE](POKE) text characters to the screen in SCREEN 0, DEF SEG sets the memory segment to &HB800. Text values are poked at the even segment offsets starting 640 bytes(4 rows * 80 columns wide * 2 bytes) from the upper left corner 0 offset of the screen memory segment. To space the text it skips an even offset by multiplying by 4 instead of 2. The odd offsets can be written to to set the color. Using the same 4 byte offsets, the text and background are colored using values up to 128. Values over 128 cause the text to flash and the background colors 0 to 7 are repeated. The background color is incremented every 16 values.

```text

                                **4000 byte Video Memory Segment**

Text block #:   1                  321     322     323     324     325     326     327             
Text position:  1, 1                5, 1    5, 2    5, 3    5, 4    5, 5    5, 6    5, 7
Byte offset:    0, 1               640     642     644     646     648     650     652
**Segment: (CHR$(0), COLOR 0),.......(0, 0), (0, 0), (1, 1), (0, 0), (2, 2), (0, 0), (3, 3),...**

            Row% = Offset% \ 160 + 1          Column% = (Offset% MOD 160) \ 2 + 1

                         Offset% = (160 * (Row% - 1)) + (2 * (Column% - 1))

```

**Graphic Screen Segment &HA000**

* The graphic video memory segment is located at hexadecimal memory address A000 or 40960 decimal.
* Legacy graphic screen modes include 1, 2, 7, 8, 9, 10, 11, 12 and 13 with varying pixel widths, heights and color attributes.
* **QB64** [_NEWIMAGE](_NEWIMAGE) or [_LOADIMAGE](_LOADIMAGE) screen modes can use the legacy modes above, 256 color or 32 bit color modes.

## See Also

* [PEEK](PEEK), [POKE](POKE)
* [DEF SEG = 0](DEF-SEG-=-0)
* [SCREEN](SCREEN)
* [SCREEN (function)](SCREEN-(function))
* [_NEWIMAGE](_NEWIMAGE) (screen pages)
* [_LOADIMAGE](_LOADIMAGE) (image files)
