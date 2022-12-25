The [COLOR](COLOR) statement is used to change the foreground and background colors for printing text.

## Syntax

> [COLOR](COLOR) [foreground&][, background&]

## Description

* background& colors are available in all QB64 color SCREEN modes. 
* [SCREEN](SCREEN) mode 10 has only 3 white foreground attributes including flashing. 
* To change the background& color only, use a comma and the desired color. Ex: [COLOR](COLOR) , background&
* Graphic drawing statements like [PSET](PSET), [PRESET](PRESET), [LINE](LINE), etc, also use the colors set by the [COLOR](COLOR) statement if no color is passed when they are called.
* The [$COLOR]($COLOR) metacommand adds named color constants for both text and 32-bit modes.
* [COLOR](COLOR) works when outputting text to [$CONSOLE]($CONSOLE).
  * On macOS, colors in console mode will not match the VGA palette. See [https://en.wikipedia.org/wiki/ANSI_escape_code#8-bit 8-bit ANSI colors]

## Screen Mode Attributes

* **SCREEN 0** background& colors 0 to 7 can be changed each text character without affecting other text. Use [CLS](CLS) after a background color statement to create a fullscreen background color. 64 [DAC](DAC) hues with 16 high intensity blinking foreground (16 to 31) color attributes. See [_BLINK](_BLINK).
  * See example 7 below for more SCREEN 0 background colors.
* **SCREEN 1** has **4 background color attributes**: 0 = black, 1 = blue, 2 = green, 3 = grey. White foreground color only.
* **SCREEN 2** is **monochrome** with white forecolor and black background.
* **SCREEN 7** can use 16 ([DAC](DAC)) colors with background colors. RGB settings can be changed in colors 0 to 7 using [_PALETTECOLOR](_PALETTECOLOR). 
* **SCREEN 8** has 16 color attributes with 16 background colors. 
* **SCREEN 9** can use up to 64 [DAC](DAC) color hues in 16 color attributes with background colors assigned to attribute 0 with a [_PALETTECOLOR](_PALETTECOLOR) swap. RGB settings can be changed in colors 0 to 5 and 7 using [_PALETTECOLOR](_PALETTECOLOR).
* **SCREEN 10** has **only 4 color attributes** with black background. COLOR 0 = black, 1 = grey, 2 = flash white and 3 = bright white.
* **SCREEN 11** is **monochrome** with white forecolor and a black background.
* **SCREEN 12** can use 16 color attributes with a black background. 256K possible RGB color hues. Background colors can be used with QB64.
* **SCREEN 13** can use 256 color attributes with a black background. 256K possible RGB hues.
* [PALETTE](PALETTE) swaps can be made in SCREEN 7 and 9 only. Those screens were [DAC](DAC) screen modes in QBasic.
* [_DEST](_DEST) can be used to set the destination page or image to color using **QB64**.
* [_DEFAULTCOLOR](_DEFAULTCOLOR) returns the current color being used on an image or screen page handle.

### 24/32-Bit colors using QB64

* Pixel color intensities for red, green, blue and alpha range from 0 to 255 when used with [_RGB](_RGB), [_RGBA](_RGBA), [_RGB32](_RGB32) and [RGBA32](RGBA32).
* Combined RGB function values returned are [LONG](LONG) values. **Blue intensity values may be cut off using [SINGLE](SINGLE) variables.**
* [_ALPHA](_ALPHA) transparency values can range from 0 as transparent up to 255 which is fully opaque. 
* [_CLEARCOLOR](_CLEARCOLOR) can also be used to set a color as transparent.
* Colors can be mixed by using [_BLEND](_BLEND) (default) in 32-bit screen modes. [_DONTBLEND](_DONTBLEND) disables blending.
* **NOTE: Default 32-bit backgrounds are clear black or [_RGBA](_RGBA)(0, 0, 0, 0). Use [CLS](CLS) to make the black opaque.**

## RGB Palette Intensities

RGB intensity values can be converted to hexadecimal values to create the [LONG](LONG) [_PALETTECOLOR](_PALETTECOLOR) value in non-32-bit screens:

```vb

SCREEN 12
alpha$ = "FF" 'solid alpha colors only
OUT &H3C8, 0: OUT &H3C9, 0: OUT &H3C9, 0: OUT &H3C9, 20 'set black background to dark blue
PRINT "Attribute = Hex value      Red          Green         Blue "
PRINT
COLOR 7 
FOR attribute = 0 TO 15
  OUT &H3C7, attribute 'set color attribute to read
  red$ = HEX$(INP(&H3C9) * 4) 'convert port setting to 32 bit values
  grn$ = HEX$(INP(&H3C9) * 4)
  blu$ = HEX$(INP(&H3C9) * 4)
  IF LEN(red$) = 1 THEN red$ = "0" + red$ '2 hex digits required
  IF LEN(grn$) = 1 THEN grn$ = "0" + grn$ 'for low or zero hex values
  IF LEN(blu$) = 1 THEN blu$ = "0" + blu$
  hex32$ = "&H" + alpha$ + red$ + grn$ + blu$
  _PALETTECOLOR attribute, VAL(hex32$) 'VAL converts hex string to a LONG 32 bit value
  IF attribute THEN COLOR attribute 'exclude black color print
  PRINT "COLOR" + STR$(attribute) + " = " + hex32$, red$, grn$, blu$ 'returns closest attribute
NEXT

```

```text

Attribute  Hex value      Red        Green       Blue 

COLOR 0 = &HFF000050       00         00         50
COLOR 1 = &HFF0000A8       00         00         A8
COLOR 2 = &HFF00A800       00         A8         00
COLOR 3 = &HFF00A8A8       00         A8         A8
COLOR 4 = &HFFA80000       A8         00         00
COLOR 5 = &HFFA800A8       A8         00         A8
COLOR 6 = &HFFA85400       A8         54         00
COLOR 7 = &HFFA8A8A8       A8         A8         A8
COLOR 8 = &HFF545454       54         54         54
COLOR 9 = &HFF5454FC       54         54         FC
COLOR 10 = &HFF54FC54      54         FC         54
COLOR 11 = &HFF5454FC      54         FC         FC
COLOR 12 = &HFFFC5454      FC         54         54
COLOR 13 = &HFFFC54FC      FC         54         FC
COLOR 14 = &HFFFCFC54      FC         FC         54
COLOR 15 = &HFFFCFCFC      FC         FC         FC

```

> *Explanation:* The RGB intensity values are multiplied by 4 to get the [_RGB](_RGB) intensity values as [HEX$](HEX$) values. The individual 2 digit [HEX$](HEX$) intensity values can be added to "&HFF" to make up the 32-bit hexadecimal string value necessary for [VAL](VAL) to return to [_PALETTECOLOR](_PALETTECOLOR). The statement is only included in the example to show how that can be done with any 32-bit color value.
> **Note:** Black has a blue hex value of 50 due to the [OUT](OUT) background color setting which makes it dark blue.

### Reading and setting color port intensities using [INP](INP) and [OUT](OUT)

* Legacy code may use [INP](INP) and [OUT](OUT) to read or set color port intensities. **QB64** emulates VGA memory to maintain compatibility.
* The same can be achieved using [_PALETTECOLOR](_PALETTECOLOR) (**recommended practice**).

> **OUT &H3C7, attribute** 'Set port to read RGB settings with:

> **color_intensity = INP(&H3C9)** 'reads present intensity setting
 
> **OUT &H3C8, attribute** 'Set port to write RGB settings with:

> **OUT &H3C9, color_intensity** 'writes new intensity setting

* After every 3 reads or writes, changes to next higher color attribute. Loops can be used to set more than one attribute's intensities.
* Color port setting of red, green and blue intensities can be done in ascending order.
* Color port attribute intensity values range from 0 to 63 (1/4 of the 32-bit values) in QBasic's legacy 4 and 8 bit screen modes.

## Example(s)

Reading the default RGB color settings of color attribute 15.

```vb

OUT &H3C7, 15
red% = INP(&H3C9)
green% = INP(&H3C9)
blue% = INP(&H3C9)
PRINT red%, green%, blue% 

```

```text

 63       63       63

```

Changing the color settings of attribute 0 (the background) to dark blue in [SCREEN](SCREEN)s 12 or 13.

```vb

SCREEN 12
OUT &H3C8, 0          'set color port attribute to write
OUT &H3C9, 0          'red intensity
OUT &H3C9, 0          'green intensity
OUT &H3C9, 30         'blue intensity

OUT &H3C7, 0
PRINT INP(&H3C9); INP(&H3C9); INP(&H3C9)
END

```

```text

 0  0  30 

```

Printing in fullscreen SCREEN 0 mode with a color background under the text only.

```vb

SCREEN 0: _FULLSCREEN ' used for fullscreen instead of window
COLOR 30, 6: LOCATE 12, 4: PRINT "Hello!"

```

> *Result:* Hello! is printed in flashing high intensity yellow with brown background behind text only when in QBasic [_FULLSCREEN](_FULLSCREEN).

Using [CLS](CLS) after setting the background color in SCREEN 0 to make the color cover the entire screen.

```vb

SCREEN 0: _FULLSCREEN
COLOR , 7: CLS
COLOR 9: PRINT "Hello" 

```

```text

Hello

```

> *Result:* The blue word Hello is printed to a totally grey background in [_FULLSCREEN](_FULLSCREEN).

Using a different foreground color for each letter:

```vb

SCREEN 0
COLOR 1: PRINT "H";
COLOR 3: PRINT "E";
COLOR 4: PRINT "L";
COLOR 5: PRINT "L";
COLOR 6: PRINT "O"
COLOR 9: PRINT "W";
COLOR 11: PRINT "O";
COLOR 12: PRINT "R";
COLOR 13: PRINT "L";
COLOR 14: PRINT "D" 

```

```text

HELLO
WORLD

```

Doing the same as Example 5 but in only a few lines:

```vb

SCREEN 0
text$ = "HelloWorld"
FOR textpos = 1 TO LEN(text$)
  COLOR textpos
  IF textpos <> 5 THEN PRINT MID$(text$, textpos, 1);
  IF textpos = 5 THEN PRINT MID$(text$, textpos, 1)    'start print on next row
NEXT


```

```text

Hello
World

```

> *Explanation:*Semicolon(;) means that the next PRINT happens on the same line, we don't want that when it comes to position 5 so when it is at position 5 the next PRINT will move to the next line (when it isn't at position 5 we want it to continue printing the letter side-by-side on the same line though).

Since SCREEN 0 only uses background colors 0 to 7 by default, use [_PALETTECOLOR](_PALETTECOLOR) to change color intensities of color 0.

```vb

_PALETTECOLOR 0, _RGB32(255, 255, 255) 'change color 0 intensity
_PALETTECOLOR 8, _RGB32(0, 0, 0) 'change color 8 intensity

COLOR 8: PRINT "Black on bright white!"

```

```text

Black on bright white!

```

----

> *Explanation:* Since QB64 does not have [DAC](DAC) [SCREEN](SCREEN) 0 limitations, changing color intensities for custom background colors is possible.

Changing light gray text in [SCREEN](SCREEN) 0 to a 32 bit custom color using a [LONG](LONG) HTML hexadecimal value:

```vb

COLOR 7
PRINT "Color 7 is gray"
K$ = INPUT$(1)
_PALETTECOLOR 7, &HFFDAA520 ' FF alpha makes the color translucent
PRINT "Color 7 is now Goldenrod in SCREEN 0!

```

```text

Color 7 is gray
Color 7 is now Goldenrod in SCREEN 0!

```

> *Explanation:* [_RGB32](_RGB32) could be used to make custom 32 bit colors or HTML values could be used after &HFF for solid colors.

## See Also

* [$COLOR]($COLOR) (metacommand)
* [_RGB](_RGB), [_RGBA](_RGBA), [_RGB32](_RGB32), [RGBA32](RGBA32).
* [_RED](_RED), [_GREEN](_GREEN), [_BLUE](_BLUE)
* [_RED32](_RED32), [_GREEN32](_GREEN32), [_BLUE32](_BLUE32)
* [_ALPHA](_ALPHA), [_ALPHA32](_ALPHA32), [_CLEARCOLOR](_CLEARCOLOR)
* [PRINT](PRINT), [LOCATE](LOCATE), [SCREEN](SCREEN)
* [POINT](POINT), [SCREEN (function)](SCREEN-(function))
* [OUT](OUT), [INP](INP), [PALETTE](PALETTE)
* [_BLINK](_BLINK)
* [_DEFAULTCOLOR](_DEFAULTCOLOR)
* [_BACKGROUNDCOLOR](_BACKGROUNDCOLOR)
* [_PALETTECOLOR](_PALETTECOLOR)
* [Windows Libraries](Windows-Libraries)
* [Hexadecimal Color Values](http://www.w3schools.com/html/html_colornames.asp)
