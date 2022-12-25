The [_RGBA32](_RGBA32) function returns the 32-bit *RGBA* color value with the specified red, green, blue and alpha component intensities.

## Syntax

> color32value~& = [_RGBA32](_RGBA32)(red&, green&, blue&, alpha&)

## Description

* The value returned is a 32-bit [_UNSIGNED](_UNSIGNED) [LONG](LONG) color value. 
* **Return variable types must be [_UNSIGNED](_UNSIGNED) [LONG](LONG) or resulting color may lose the [_BLUE](_BLUE) value.**
* red& specifies the red component intensity from 0 to 255.
* green& specifies the green component intensity from 0 to 255.
* blue& specifies the blue component intensity from 0 to 255.
* alpha& specifies the [_ALPHA](_ALPHA) component transparency value from 0 (fully transparent) to 255 (opaque).
* Alpha or intensity values outside of the valid range of 0 to 255 are clipped.
* Returns [LONG](LONG) 32-bit hexadecimal values from **&H00000000** to **&HFFFFFFFF** with varying [_ALPHA](_ALPHA) transparency.
* When [LONG](LONG) values are [PUT](PUT) to file, the ARGB values become BGRA. Use [LEFT$](LEFT$)([MKL$](MKL$)(color32value~&), 3) to place 3 colors.
* **NOTE: Default 32-bit backgrounds are clear black or [_RGBA](_RGBA)(0, 0, 0, 0). Use [CLS](CLS) to make the black opaque.**

## Example(s)

Changing the [ALPHA](ALPHA) value to fade an image in and out using a 32 bit PNG image.

```vb

SCREEN _NEWIMAGE(600, 400, 32)

img& = _LOADIMAGE("qb64_trans.png")  'use any 24/32 bit image
'Turn off auto display
_DISPLAY

' Fade in
FOR i% = 255 TO 0 STEP -5
  _LIMIT 20                          'control fade speed 
  _PUTIMAGE (0, 0)-(600, 400), img&
  LINE (0, 0)-(600, 400), _RGBA(0, 0, 0, i%), BF 'decrease black box transparency
  _DISPLAY
NEXT

' Fade out
FOR i% = 0 TO 255 STEP 5
  _LIMIT 20                          'control fade speed 
  _PUTIMAGE (0, 0)-(600, 400), img&
  LINE (0, 0)-(600, 400), _RGBA(0, 0, 0, i%), BF 'increase black box transparency
  _DISPLAY
NEXT
END 

```

## See Also

* [_RGB32](_RGB32), [_RGBA](_RGBA), [_RGB](_RGB)
* [_RED32](_RED32), [_GREEN32](_GREEN32), [_BLUE32](_BLUE32)
* [HEX$ 32 Bit Values](HEX$-32-Bit-Values), [POINT](POINT)
* [SAVEIMAGE](SAVEIMAGE)
* [Hexadecimal Color Values](http://www.w3schools.com/html/html_colornames.asp)
