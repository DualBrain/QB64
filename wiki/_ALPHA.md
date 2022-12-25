The [_ALPHA](_ALPHA) function returns the alpha channel transparency level of a color value used on a screen page or image.

## Syntax

> result& = [_ALPHA](_ALPHA)(color~& [, imageHandle&])

## Description

* If imageHandle& is omitted, it is assumed to be the current write page. Invalid handles will create [ERROR Codes](ERROR-Codes) errors.
* [_NEWIMAGE](_NEWIMAGE) 32 bit [SCREEN](SCREEN) modes will always use an [_UNSIGNED](_UNSIGNED) [LONG](LONG) *color~&* value.
  * Color values that are set as a [_CLEARCOLOR](_CLEARCOLOR) always have an alpha level of 0 (transparent).
  * [_SETALPHA](_SETALPHA) can set any alpha level from 0 (or fully transparent) to 255 (or opaque).
  * Normal color values that are set by [_RGB](_RGB) or [_RGB32](_RGB32) always have an alpha level of 255(opaque).
* In 4 (16 color) or 8 (256 color) bit palette screens the function will always return 255.
*[_RED32](_RED32), [_GREEN32](_GREEN32), [_BLUE32](_BLUE32) and [_ALPHA32](_ALPHA32) are all equivalent to [_RED](_RED), [_GREEN](_GREEN), [_BLUE](_BLUE) and [_ALPHA](_ALPHA) but they are highly optimized and only accept a 32-bit color (B8:G8:R8:A8). Using them (opposed to dividing then ANDing 32-bit color values manually) makes code easy to read.
* **NOTE: 32 bit [_NEWIMAGE](_NEWIMAGE) screen page backgrounds are transparent black or [_ALPHA](_ALPHA) 0. Use [_DONTBLEND](_DONTBLEND) or [CLS](CLS) for opaque.**

## Example(s)

Alpha transparency levels are always 255 in 4 or 8 bit screen modes.

```vb

SCREEN 13

clr~& = _RGBA(255, 0, 255, 192) 'returns closest palette color attribute 
PRINT "Color:"; clr~&

COLOR clr~&
PRINT "Alpha:"; _ALPHA(clr~&)

END

```

```text

Color 36
Alpha: 255

```

>  *Explanation:* [_RGBA](_RGBA) cannot change the [_ALPHA](_ALPHA) level. [_ALPHA32](_ALPHA32) would return 0 on any non-32 bit image or page.

Finding the transparency of a 32 bit screen mode's background before and after [CLS](CLS).

```vb

SCREEN _NEWIMAGE(640, 480, 32)
BG& = POINT(1, 1)
PRINT "Alpha ="; _ALPHA(BG&); "Press a key to use CLS!"
K$ = INPUT$(1)                   
CLS
BG& = POINT(1, 1)
PRINT "CLS Alpha ="; _ALPHA(BG&) 

```

```text

CLS Alpha = 255   

```

>  *Explanation:* Set the ALPHA value to 255 using [CLS](CLS) to make the background opaque when overlaying pages.

## See Also

* [_ALPHA32](_ALPHA32), [_SETALPHA](_SETALPHA)
* [_RGBA](_RGBA), [_RGBA32](_RGBA32) (set color with alpha)
* [_CLEARCOLOR](_CLEARCOLOR), [_CLEARCOLOR (function)](_CLEARCOLOR-(function))
* [_RED](_RED), [_GREEN](_GREEN), [_BLUE](_BLUE)
* [_RED32](_RED32), [_GREEN32](_GREEN32). [_BLUE32](_BLUE32)
* [CLS](CLS), [COLOR](COLOR), [Images](Images)
