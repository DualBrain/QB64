The [_SETALPHA](_SETALPHA) statement sets the alpha channel transparency level of some or all of the pixels of an image.

## Syntax

> [_SETALPHA](_SETALPHA) alpha&[, color1&][ [TO](TO) colour2&] [, imageHandle&]

## Parameter(s)

* alpha& is the new alpha level to set, ranging from 0 (transparent) to 255 (opaque).
* color1& designates the 32-bit [LONG](LONG) color value or range of color values color1& TO colour2& to set the transparency. 
* If no color value or range of colors is given, the entire image's alpha is changed, including any [_CLEARCOLOR](_CLEARCOLOR) settings.
* If imageHandle& is omitted, it is assumed to be the current write page or [_DEST](_DEST) image.

## Description

* In the first syntax, the alpha level of all pixels is set to alpha&.
* In the second syntax, the alpha level of all pixels matching the color color1& is set to alpha&.
* In the third syntax, the alpha level of all pixels with red, green, blue and alpha channels in the range [color1& TO color2&] are set.
* The [_ALPHA](_ALPHA) setting makes a 32-bit color transparent, opaque or something in between. Zero is clear and 255 totally blocks underlying images. Use it to see through backgrounds or image colors.
* If alpha& is outside that range, an [ERROR Codes](ERROR-Codes) error will occur.
* If the image specified by imageHandle& uses a palette, an [ERROR Codes](ERROR-Codes) error will occur.
* If imageHandle& is an invalid handle, an [ERROR Codes](ERROR-Codes) error will occur.
* **NOTE: 32-bit [_NEWIMAGE](_NEWIMAGE) screen page backgrounds are transparent black or [_ALPHA](_ALPHA) 0. Use [_DONTBLEND](_DONTBLEND) or [CLS](CLS) for opaque.**

## Example(s)

Using a _SETALPHA color range to fade an image in and out while not affecting the transparent white background.

```vb

main = _NEWIMAGE(640, 480, 32) 
SCREEN main
_SCREENMOVE _MIDDLE

Image1& = _LOADIMAGE("qb64_trans.png") '<<< PNG file with white background to hide
_SOURCE Image1&
clr~& = POINT(0, 0) 'find background color of image
_CLEARCOLOR clr~&, Image1& 'set background color as transparent

topclr~& = clr~& - _RGBA(1, 1, 1, 0)  'get topmost color range just below full white
_DEST main

a& = 0
d = 1
DO
  _LIMIT 10 'regulate speed of fade in and out
  CLS ', _RGB(255, 0, 0)
  a& = a& + d
  IF a& = 255 THEN d = -d
  _SETALPHA a&, 0 TO topclr~&, Image1& 'affects all colors below bright white
  _PUTIMAGE (0, 342), Image1& 
  LOCATE 1, 1: PRINT "Alpha: "; a&
  _DISPLAY
LOOP UNTIL a& = 0 

```

> *Explanation:* The [POINT](POINT) value minus [_RGBA](_RGBA)(1, 1, 1, 0) subtracts a small amount from the bright white color value so that the top [_SETALPHA](_SETALPHA) color range will not affect the [_CLEARCOLOR](_CLEARCOLOR) transparency of the bright white PNG background.

## See Also

* [_ALPHA](_ALPHA), [_ALPHA32](_ALPHA32)
* [_RGBA](_RGBA), [_RGBA32](_RGBA32)
* [_CLEARCOLOR](_CLEARCOLOR)
* [_CLEARCOLOR (function)](_CLEARCOLOR-(function))
* [_BLEND](_BLEND), [_DONTBLEND](_DONTBLEND) 
* [COLOR](COLOR), [Images](Images)
