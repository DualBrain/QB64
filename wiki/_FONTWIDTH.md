The [_FONTWIDTH](_FONTWIDTH) function returns the font width of a MONOSPACE font handle created by [_LOADFONT](_LOADFONT).

## Syntax

> pixelWidth% = [_FONTWIDTH](_FONTWIDTH)[(fontHandle&)]

* Returns the character width of the last font used if a handle is not specified.
* **Variable width fonts always return pixelWidth% = 0.** Even fixed width fonts return 0 unless the [LOADFONT](LOADFONT) style option is used.
* QB64 **version 1.000 and up** can load a variable width font as monospaced with the [LOADFONT](LOADFONT) style parameter.
* The font width is generally 3/4 of the [_FONTHEIGHT](_FONTHEIGHT) specified when loading the font.
* In **graphics** [SCREEN (statement)](SCREEN-(statement)) modes, [_PRINTWIDTH](_PRINTWIDTH) can return the total **pixel width** of a literal or variable [STRING](STRING) of text.

## See Also

* [_FONTHEIGHT](_FONTHEIGHT)
* [_FONT](_FONT)
* [_LOADFONT](_LOADFONT)
* [_PRINTWIDTH](_PRINTWIDTH)
