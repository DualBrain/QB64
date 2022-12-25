[LONG](LONG) [HEX$](HEX$) values can be used to set a [_PALETTECOLOR](_PALETTECOLOR) instead of using [_RGB32](_RGB32) or [_RGBA32](_RGBA32) values.

* Hexadecimal digits can  be represented as any number or letter up to F: **0 1 2 3 4 5 6 7 8 9 A B C D E F**
* [_BYTE](_BYTE) values up to 255 can represented by two hexadecimal digits such as 1C, 23, FA, etc.
* The [HEX$](HEX$) value for bright white(attribute 15) is &HFFFFFFFF or:
  - [_ALPHA](_ALPHA) = FF (255), Red = FF (255), Green = FF (255), Blue = FF (255)
* [_RGB](_RGB) will return an alpha value of 255 for fully opaque 32 bit colors only. Values range from &HFF000000 to &HFFFFFFFF.
* [_RGB32](_RGB32) will return an alpha value of 255 for fully opaque colors only. Values range from &HFF000000 to &HFFFFFFFF.
* [_RGBA](_RGBA) can set the transparency so hexadecimal values range from &H000000 (zero alpha) to &HFFFFFFFF (full alpha).
* [_RGBA32](_RGBA32) can set the transparency so hexadecimal values range from &H000000 (zero alpha) to &HFFFFFFFF (full alpha).
* So expanding on the principle above allows us to easily make up our own hex color values:
  - _PALETTECOLOR 1, **&HFFFF0000** 'COLOR 1 is full red
  - _PALETTECOLOR 2, **&HFFFF00FF** 'COLOR 2 is purple
  - _PALETTECOLOR 3, **&HFFFFFF00** 'COLOR 3 is brown

> Where **FF** is the fully opaque [_ALPHA](_ALPHA) and the 3 hex color values can range from **00** to **FF** (0 to 255) each.

## Example(s)

Converting the color port RGB intensity palette values 0 to 63 to 32 bit hexadecimal [STRING](STRING) values. 

```vb

SCREEN 12
DIM hex32$(15)
alpha$ = "FF"                              'solid alpha colors only
OUT &H3C8, 0: OUT &H3C9, 0: OUT &H3C9, 0: OUT &H3C9, 20 'set black background to dark blue

FOR attribute = 0 TO 15
  OUT &H3C7, attribute                     'set color attribute to read
  red$ = HEX$(INP(&H3C9) * 4)              'convert port setting to 32 bit values
  grn$ = HEX$(INP(&H3C9) * 4)
  blu$ = HEX$(INP(&H3C9) * 4)
  IF LEN(red$) = 1 THEN red$ = "0" + red$  'necessary for low or zero color intensities
  IF LEN(grn$) = 1 THEN grn$ = "0" + grn$
  IF LEN(blu$) = 1 THEN blu$ = "0" + blu$
  hex32$(attribute) = "&H" + alpha$ + red$ + grn$ + blu$
NEXT
PRINT "COLOR 0 = " + hex32$(0)
FOR i = 1 TO 15
  _PALETTECOLOR i, VAL(hex32$(i))
  COLOR i
  PRINT "COLOR" + STR$(i) + " = " + hex32$(i) 'returns closest attribute
NEXT 

```
<sub>Code by Ted Weissgerber</sub>

> *Explanation:* [VAL](VAL) is used to convert the [HEX$](HEX$) [STRING](STRING) values to valid 32 bit color values for [_PALETTECOLOR](_PALETTECOLOR).

> No VAL conversion is necessary if the [LONG](LONG) [&H](&H) hexadecimal values are entered into the program directly by the programmer.

## See Also

* [_PALETTECOLOR](_PALETTECOLOR)
* [_RGB32](_RGB32), [_RGBA32](_RGBA32)
* [_RGB](_RGB), [_RGBA](_RGBA) (when used in 32 bit only)
* [COLOR](COLOR), [SCREEN](SCREEN), [POINT](POINT)
* [HTML Color Table HEX Values and Names](https://en.wikipedia.org/wiki/Web_colors#Basic_colors)
