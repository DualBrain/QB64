The [_GREEN32](_GREEN32) function returns the green component intensity of a 32-bit image or surface color.

## Syntax

> green32color& = [_GREEN32](_GREEN32)(rgbaColor&)

## Description

* rgbaColor& is the 32-bit *RGBA* color value to retrieve the green component intensity value from.
* *RGBA* color values are returned by the [_PALETTECOLOR (function)](_PALETTECOLOR-(function)), [POINT](POINT), [_RGB](_RGB), [_RGB32](_RGB32), [_RGBA](_RGBA) or [_RGBA32](_RGBA32) functions.
* [LONG](LONG) intensity values returned range from 0 (no intensity, not present) to 255 (full intensity).

## Example(s)

* See example in [POINT](POINT).

## See Also

* [_RED32](_RED32), [_BLUE32](_BLUE32)
* [_RGB32](_RGB32), [_GREEN](_GREEN)
