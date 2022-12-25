The [_PALETTECOLOR](_PALETTECOLOR) statement sets the color value of a palette entry of an image using 256 color modes or less (4 or 8 BPP).

## Syntax

> [_PALETTECOLOR](_PALETTECOLOR) attribute%, newColor&[, destHandle&]

## Description

* The attribute% is the palette index number of the color to set, ranging from 0 to 15 (4 bit) or 0 to 255 (8 bit) color modes.
* The [LONG](LONG) newColor& is the new color value to set using [_RGB32](_RGB32) or [_RGBA32](_RGBA32) values or using [HEX$ 32 Bit Values](HEX$-32-Bit-Values).
* If destHandle& is omitted, [_DEST](_DEST) is assumed to be the current write page or screen surface.
* If attribute% is outside of image or [SCREEN](SCREEN) mode attribute range (0 to 15 or 0 to 255), an [ERROR Codes](ERROR-Codes) error will occur.
* If destHandle& does not use a palette, an [ERROR Codes](ERROR-Codes) error occurs. **Will not work in 24/32 bit color palette modes.**
* If destHandle& is an invalid handle value, an [ERROR Codes](ERROR-Codes) error occurs.

**Basic's 16 Default Color Attributes (non-[DAC](DAC))**

```text

     Attribute        Description     Red   Green   Blue   32 HEX    HTML Name 
         0            Black            0      0       0    000000    Black
         1            Dark Blue        0      0      42    00008B    DarkBlue   
         2            Dark Green       0     42       0    006400    DarkGreen  
         3            Dark Cyan        0     42      42    008B8B    DarkCyan
         4            Dark Red        42      0       0    8B0000    DarkRed
         5            Dark Magenta    42      0      42    8B008B    DarkMagenta
         6            Dark Yellow     42     21       0    DAA520    GoldenRod
         7            Light Grey      42     42      42    D3D3D3    LightGrey
         8            Dark Grey       21     21      21    696969    DimGray
         9            Blue            21     21      63    0000FF    Blue
        10            Green           21     63      21    15FF15    Lime
        11            Cyan            21     63      63    15FFFF    Cyan
        12            Red             63     21      21    FF1515    Red
        13            Magenta         63     21      63    FF15FF    Magenta
        14            Yellow          63     63      21    FFFF00    Yellow
        15            White           63     63      63    FFFFFF    White 

```

[HTML Color Table Values and Names](http://www.w3schools.com/html/html_colornames.asp) or [Other RGB colors](http://www.tayloredmktg.com/rgb/#OR)
  * *Note:* **QB64** 32 bit color intensity values from 0 to 255 can be found by multiplying above values by 4.

*Summary:* The red, green, and blue intensity values can be changed using [OUT](OUT) or [PALETTE](PALETTE) statements. Some **QBasic** RGB color attribute values can be changed in [DAC](DAC) [SCREEN (statement)](SCREEN-(statement)) modes and the [DAC](DAC) RGB intensity settings may be different. 

## Example(s)

Creating custom background colors in SCREEN 0 that follow the text. [CLS](CLS) makes entire background one color.

```vb

_PALETTECOLOR 1, _RGB32(255, 255, 255) ' white.
_PALETTECOLOR 2, _RGB32(255, 170, 170) ' lighter red.
_PALETTECOLOR 3, _RGB32(255, 85, 85) ' light red.
_PALETTECOLOR 4, _RGB32(255, 0, 0) ' red.
_PALETTECOLOR 5, _RGB32(170, 0, 0) ' dark red.
_PALETTECOLOR 6, _RGB32(85, 0, 0) ' darker red.

COLOR 0, 1: PRINT "black on white."
COLOR 0, 2: PRINT "black on lighter red."
COLOR 0, 3: PRINT "black on light red."
COLOR 0, 4: PRINT "black on red."
COLOR 0, 5: PRINT "black on dark red."
COLOR 0, 6: PRINT "black on darker red. 

COLOR 1, 6: PRINT "white on darker red"
COLOR 2, 6: PRINT "ligher red on darker red" 

```

> *Note:* [_PALETTECOLOR](_PALETTECOLOR) expects [LONG](LONG) [_RGB32](_RGB32) or [_RGBA32](_RGBA32) 32 bit color values, not [_RGB](_RGB) or [_RGBA](_RGBA) palette attribute values.

## See Also

* [COLOR](COLOR), [_RGB32](_RGB32), [_RGBA32](_RGBA32)
* [_PALETTECOLOR (function)](_PALETTECOLOR-(function))
* [PALETTE](PALETTE), [OUT](OUT), [INP](INP)
* [Images](Images)
* [HEX$ 32 Bit Values](HEX$-32-Bit-Values)
