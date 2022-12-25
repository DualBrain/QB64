The [_FONTWIDTH (function)](_FONTWIDTH-(function)) function returns the point-size width of a monospace font.

## Syntax

> *result&* = [_FONTWIDTH (function)](_FONTWIDTH-(function))(fontHandle&)

## Description

* If fontHandle& is omitted, it is assumed to be the font of the current write page.
* If fontHandle& is an invalid handle, an [ERROR Codes](ERROR-Codes) error is thrown.
* If the font specified by fontHandle& is not a monospace font, 0 (zero) is returned.

## See Also

* [_FONTWIDTH](_FONTWIDTH)
* [_FONTHEIGHT](_FONTHEIGHT), [_FONTHEIGHT (function)](_FONTHEIGHT-(function))
* [_LOADFONT](_LOADFONT)
