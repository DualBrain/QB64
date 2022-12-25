**DAC** stands for the QBasic Digital to Analog Converter color attributes used in screens 0, 7 and 9.

> ** IMPORTANT: QB64 screens do not use the DAC index!**

* DAC colors are preset and cannot be changed in QBasic easily(see example).
* DAC color attribute settings cannot be changed using [PALETTE](PALETTE) or [OUT](OUT) RGB statements.
* Screen 0 and 9 can use up to 64 DAC color hues. Only attributes 0 to 5 and 7 can have RGB values altered using [OUT](OUT).
* [PALETTE](PALETTE) swap statements can assign one attribute's DAC color setting to another attribute color in [SCREEN](SCREEN)s 0 to 9.
* Screen attributes 0 to 5 and 7 can have their RGB settings altered using OUT as shown in **Bold** below: 

```text

            ***SCREEN 0 or 9                     SCREEN 7***
        Attribute = DAC setting         Attribute = DAC setting
          ** 0 to 5 = 0 to 5                 0 to 5 = 0 to 5**
                6 = 20                       **   6 = 6**
                7 = 7                           7 = 7**
                8 = 56                          8 = 16
                9 = 57                          9 = 17
               10 = 58                         10 = 18
               11 = 59                         11 = 19
               12 = 60                         12 = 20
               13 = 61                         13 = 21
               14 = 62                         14 = 22
               15 = 63                         15 = 23

    **OUT can change RGB intensities where the DAC value matches the attribute value.**

```

Changing the DAC attributes to use [OUT](OUT) for custom colors.

```vb

SCREEN 9   'use 0, 7 or 9 only"
InitDAC% = INP(&H3DA)    ' prepare DAC port for access
FOR attribute% = 6 TO 15 ' attributes 0 to 5 are already non-DAC
   OUT &H3C0, attribute% ' send attribute to change
   OUT &H3C0, attribute% ' change DAC value to normal number
NEXT attribute%"
OUT &H3C0, 32            ' close port access

```

> *Explanation:* The procedure is a MUST to import 4 BPP bitmap colors in SCREEN 7 or 9. The InitDAC% value is not used, but that code line opens the DAC color port. Now all color attributes 0 to 15 can be used for custom or imported bitmap RGB color settings. 

Disabling blinking colors in fullscreen SCREEN 0 mode enabling high intensity only. ([DAC](DAC))

```vb

D = INP(&H3DA)    'prepares port for access
OUT &H3C0, &H30 
OUT &H3C0, 4 

```

> *Explanation:* Make attributes 8-15 available to both foreground AND background colors. In other words it will make fullscreen behave like windowed mode. For the same effect in QB64, use [_BLINK](_BLINK) OFF.

*Enabling:* The following code disables above code and returns SCREEN 0 blinking to normal.

```vb

D = INP(&H3DA)    'prepares port for access
OUT &H3C0, &H30 
OUT &H3C0, 12 

```
> **NOTE: QB64** allows blinking mode in both fullscreen and windowed modes **without** using the code above. To reenable blinking in QB64 after using [_BLINK](_BLINK) OFF, use [_BLINK](_BLINK) ON.

## See Also

* [SCREEN (statement)](SCREEN-(statement)), [COLOR](COLOR) 
* [PALETTE](PALETTE)
