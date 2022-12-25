The [_ALPHA32](_ALPHA32) function returns the alpha transparency level of a 32 bit color value.

## Syntax

> alpha& = [_ALPHA32](_ALPHA32)(color32~&)**

## Parameter(s)

* color32& is the [_UNSIGNED](_UNSIGNED) [LONG](LONG) 32 bit color value used to retrieve the alpha level.
  * Color values that are set as a [_CLEARCOLOR](_CLEARCOLOR) always have an alpha level of 0 (transparent).
  * [_SETALPHA](_SETALPHA) can set any alpha level from 0 (or fully transparent) to 255 (or opaque).
  * Normal color values that are set by [_RGB](_RGB) or [_RGB32](_RGB32) always have an alpha level of 255 (opaque).

## Description

* In 4-bit (16 colors) or 8-bit (256 colors) palette screens the function will return 0.
* [_RED32](_RED32), [_GREEN32](_GREEN32), [_BLUE32](_BLUE32) and [_ALPHA32](_ALPHA32) are all equivalent to [_RED](_RED), [_GREEN](_GREEN), [_BLUE](_BLUE) and [_ALPHA](_ALPHA) but they are highly optimized and only accept a 32-bit color (RGBA) value. Using these in your code (opposed to dividing then ANDing 32-bit color values) makes code easy to read.
* **NOTE: 32 bit [_NEWIMAGE](_NEWIMAGE) screen page backgrounds are transparent black or [_ALPHA](_ALPHA) 0. Use [_DONTBLEND](_DONTBLEND) or [CLS](CLS) for opaque!**

## Example(s)

Finding the alpha transparency level in a 32 bit screen using an [_RGBA](_RGBA) [_UNSIGNED](_UNSIGNED) [LONG](LONG) color value.

```vb

SCREEN _NEWIMAGE(640, 480, 32)

clr~& = _RGBA(255, 0, 255, 192)
PRINT "Color:"; clr~&

COLOR clr~&
PRINT "Alpha32:"; _ALPHA32(clr~&)

END 

```

```text

Color: 3237937407
Alpha32: 192

```

> *Notes:* The color value is equivalent to [&H](&H) &HC0FF00FF where &HC0 equals 192. [_RGB](_RGB) alphas are always &HFF(255).

## See Also

* [_ALPHA](_ALPHA), [_SETALPHA](_SETALPHA)
* [_RGBA](_RGBA), [_RGBA32](_RGBA32) (set color with alpha)
* [_RED](_RED), [_GREEN](_GREEN), [_BLUE](_BLUE)
* [_RED32](_RED32), [_GREEN32](_GREEN32). [_BLUE32](_BLUE32)
* [_CLEARCOLOR](_CLEARCOLOR), [_CLEARCOLOR (function)](_CLEARCOLOR-(function))
* [Images](Images)
