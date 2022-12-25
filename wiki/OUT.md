[OUT](OUT) writes values to register and port hardware addresses.

## Syntax

> [OUT](OUT) registerAddress%, value%

## Parameter(s)

* registerAddress% is a value expressed as a decimal [INTEGER](INTEGER) or [&H](&H).
* The [INTEGER](INTEGER) value% sent is normally only 0 to 255 per byte register (8 bit) address.

## Description

* **QB64 has limited access to registers. VGA memory and registers are emulated.**
* OUT can be used to change color port and a limited number of other port settings in QB64.
* Some settings may be set in a specific order to gain access to settings and [INP](INP) reads.
* [SCREEN](SCREEN) modes determine the number of available color palette attributes from 2 to 256 in SCREEN 13.
* Windows NT may block access to Parallel printer and Serial ports. See [Port Access Libraries](Port-Access-Libraries) or other DLLs.
* [_PALETTECOLOR](_PALETTECOLOR) can also be used to set RGB intensity values using [_RGB32](_RGB32) values.
* OUT can toggle the blinking attribute of SCREEN 0 color 16-31 for legacy code. [_BLINK](_BLINK) is the preferred method. (starting with build 20170816/61).

## Color Port Palette access using OUT

> `OUT &H3C7, attribute` : Set port to read RGB settings for start attribute

> `[INP](INP) &H3C9, colorIntensity` : Reads RGB color intensity settings in order

> `OUT &H3C8, attribute` : Set port to write RGB settings for start attribute

> `OUT &H3C9, colorIntensity` : Writes RGB color intensity settings in order

  * Every 3 reads or writes, changes to next color attribute without a set
  * Color setting is Red, Green and Blue attribute intensities in order. 
  * Color attribute intensity values range from 0 to 63.
  * Some [DAC](DAC) color attribute intensities cannot be changed using OUT.

## QBasic

* In DOS, OUT accesses memory and hardware directly, unlike [POKE](POKE), and could cause PC damage.

## Example(s)

Reading the default RGB color settings of color attribute 15.

```vb

OUT &H3C7, 15      'set color port attribute 15 for a read
red% = INP(&H3C9)
green% = INP(&H3C9)
blue% = INP(&H3C9)
PRINT red%, green%, blue% 

```

```text

 63       63       63

```

Changing the color intensity settings of the [SCREEN](SCREEN) background [COLOR](COLOR) 0 to bright white.

```vb

OUT &H3C8, 0  'attribute number. 0 for black screen background
OUT &H3C9, 63 'red
OUT &H3C9, 63 'green
OUT &H3C9, 63 'blue 

```

> *Explanation:* In [SCREEN](SCREEN) 0 this is one way to make high intensity background colors. `[COLOR](COLOR) ,15` is actually grey (7).

Toggling blinking colors in SCREEN beginning with build 20170816/61

```vb

OUT &H3C0, &H10  'disables blinking and enables high intensity backgrounds (colors 16-31)
OUT &H3C0, 2 ^ 3 'reenables blinking and disables high intensity backgrounds  (colors 16-31)

```

> Note: In QB64, the recommended practice is to use the [_BLINK](_BLINK) {ON|OFF} statement.

Restoring colors to a bitmap from the Red, Green and Blue [BSAVE](BSAVE)d indexed array of color values.

```vb

 SCREEN 12
 OUT &H3C8, 0 ' set color port for output at attribute 0
 FOR i = 0 TO 47 ' 48 RGB values is (3 * 16) -1 color attributes from 0 in screen 12
   OUT &H3C9, Image%(i) ' changes to next attribute after 3 RGB loops
 NEXT
 PUT(clm, row), Image(48) PSET 

```

> *Explanation:* The color RGB intensity settings were imported from a file to the Image array using [BLOAD](BLOAD). The color attribute advances to the next one every 3 writes using OUT. The color information was indexed to the start of the array. The image is after the color settings at index 48. Index 48 is the [GET (graphics statement)](GET-(graphics-statement)) image width and 49 is the height.

## See Also

* [PALETTE](PALETTE), [_PALETTECOLOR](_PALETTECOLOR)
* [INP](INP) (read register)
* [PEEK](PEEK) (read memory) 
* [POKE](POKE) (write to memory)
* [COLOR](COLOR), [SCREEN](SCREEN) 
* [BSAVE](BSAVE), [BLOAD](BLOAD)
* [_BLINK](_BLINK), [_BLINK (function)](_BLINK-(function))
* [Port Access Libraries](Port-Access-Libraries) (COM or LPT registers)

### External Links

* [PC I/O base address device assignments](http://en.wikipedia.org/wiki/Input/output_base_address#Common_I.2FO_base_address_device_assignments_in_IBM_PC_compatible_computers)
