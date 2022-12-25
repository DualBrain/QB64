The [_COPYPALETTE](_COPYPALETTE) statement copies the color palette intensities from one 4 or 8 BPP image to another image or a [_NEWIMAGE](_NEWIMAGE) screen page using 256 or less colors.

## Syntax

> [_COPYPALETTE](_COPYPALETTE) [sourceImageHandle&[, destinationImageHandle&]]

## Description

* Palette Intensity settings are **not** used by 24/32 bit images. Use only with 4 or 8 BPP images.
* [_PIXELSIZE](_PIXELSIZE) function returns 1 to indicate that _COPYPALETTE can be used. 4 indicates 24/32 bit images.
* If sourceImageHandle& is omitted, it is assumed to be the current read page.
* If destinationImageHandle& is omitted, it is assumed to be the current write page.
* If either of the images specified by sourceImageHandle& or destinationImageHandle& do not use a palette, an [ERROR Codes](ERROR-Codes) error is returned.
* If either sourceImageHandle& or destinationImageHandle& is an invalid handle, an [ERROR Codes](ERROR-Codes) error is returned.
* When loading 4 or 8 BPP image files, it is necessary to adopt the color palette of the image or it may not have the correct colors!

## Example(s)

* See the example in [SAVEIMAGE](SAVEIMAGE).

## See Also

* [_LOADIMAGE](_LOADIMAGE)
* [_PIXELSIZE](_PIXELSIZE)
* [_PALETTECOLOR](_PALETTECOLOR), [_PALETTECOLOR (function)](_PALETTECOLOR-(function))
* [PALETTE](PALETTE), [Images](Images)
