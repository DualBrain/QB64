The [_BLUE](_BLUE) function returns the palette intensity or the blue component intensity of a 32-bit image color.

## Syntax

> blueintensity& = [_BLUE](_BLUE)(rgbaColorIndex&[, imageHandle&])

## Description

* rgbaColorIndex& is the *RGBA* color value or palette index of the color to retrieve the blue component intensity from.
* The [LONG](LONG) intensity value returned ranges from 0 (no intensity, not present) to 255 (full intensity).
* If imageHandle& specifies a 32-bit color image, rgbaColorIndex& is interpreted as a 32-bit *RGBA* color value.
* If imageHandle& specifies an image that uses a palette, rgbaColorIndex& is interpreted as a palette index.
* If imageHandle& is not specified, it is assumed to be the current write page.
* If imageHandle& is an invalid handle, an [ERROR Codes](ERROR-Codes) error will occur.
* If rgbaColorIndex& is outside the range of valid indexes for a given image mode, an [ERROR Codes](ERROR-Codes) error occurs.
* Uses index parameters passed by the [_RGB](_RGB), [_RGBA](_RGBA), [_RGB32](_RGB32) or [_RGBA32](_RGBA32) funtions.
* An image handle is optional.

## Example(s)

* See the example for [POINT](POINT).

## See Also

* [_RED](_RED), [_GREEN](_GREEN)
* [_RGB](_RGB), [RGB32](RGB32)
* [_LOADIMAGE](_LOADIMAGE) 
