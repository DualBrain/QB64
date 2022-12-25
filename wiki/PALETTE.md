The [PALETTE](PALETTE) statement can swap color settings, set colors to default or set the red, green and blue color components of palette colors.

## Syntax

>  [PALETTE](PALETTE) [attribute%, *red%* + (*green%* * 256) + (*blue%* * 65536)]

>  [PALETTE](PALETTE) [existingAttribute%, newAttribute%]

## Description

* red%, green% and blue% values can range from 0 to 63. Many color shades are possible in non-[DAC](DAC) color attributes.
* If the red%, green% and blue% color intensity settings are all the same value the resulting color is a shade of grey.
* A swap is often used with [DAC](DAC) color attributes that cannot change RGB settings. Only the RGB color settings are swapped from original existingAttribute% to newAttribute%. Screens 0 thru 9 support swaps. Screen 10 supports up to attribute 8 only.
* PALETTE without any value sets any changed RGB settings back to the default color settings, including [DAC](DAC) colors.
* [PALETTE USING](PALETTE-USING) can be used when color intensity values are stored in an [Arrays](Arrays).
* QB64 implements the [_PALETTECOLOR](_PALETTECOLOR) statement to provide extended palette functionality.

## QBasic

* Screens 0, 7 and 9 ([DAC](DAC)) colors could not be changed using the first syntax, but the program could use [OUT](OUT) to change intensity settings of attributes 1 thru 5.

## Example(s)

Displaying all 64 DAC color hues as backgrounds in SCREEN 9 using a PALETTE swap.

```vb

  SCREEN 9 ' background is default black
  LOCATE 20, 33: PRINT "Press any Key!"  
  FOR i = 1 TO 64
   a$ = INPUT$(1) ' wait for a keypress
   PALETTE 0, i
  NEXT 

```

> *Note:* Other attributes (1 to 15) can also be swapped for DAC foreground colors.

## See Also

* [_PALETTECOLOR](_PALETTECOLOR)
* [PALETTE USING](PALETTE-USING)
* [COLOR](COLOR)
* [OUT](OUT), [INP](INP)
* [SCREEN](SCREEN)
