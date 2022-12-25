The [_PIXELSIZE](_PIXELSIZE) function returns the color depth (Bits Per Pixel) of an image as 0 for text, 1 for 1 to 8 BPP or 4 for 32 bit.

## Syntax

> pixelSize% = [_PIXELSIZE](_PIXELSIZE)[(imageHandle&)]

## Description

* If imageHandle& is omitted, it is assumed to be the current write page.
* Returns:
  * 0 if the image or screen page specified by imageHandle& is in text mode.
  * 1 if the image specified by imageHandle& is in 1 (B & W), 4 (16 colors) or 8 (256 colors) BPP mode.
  * 4 if the image specified is a 24/32-bit compatible mode. Pixels use three bytes, one per red, green and blue color intensity.
* The [SCREEN](SCREEN) or [_NEWIMAGE](_NEWIMAGE) or [_LOADIMAGE](_LOADIMAGE) color mode (256 or 32) can influence the pixel sizes that can be returned.
* If imageHandle& is an invalid handle, then an [ERROR Codes](ERROR-Codes) error occurs.

## Example(s)

*Snippet:* Saving Images for later program use. Handle values could be saved to an array. 

```text
  
handle1& = _Getimage(sx1, sy1, sx2, sy2, sourcehandle&) ' function call

FUNCTION GetImage& (sx1, sy1, sx2, sy2, sourcehandle&)
bytespp = _PIXELSIZE(sourcehandle&)
IF bytespp = 4 THEN Pal = 32 ELSE IF bytespp = 1 THEN Pal = 256 ELSE EXIT FUNCTION
h& = _NEWIMAGE(ABS(sx2 - sx1) + 1, ABS(sy2 - sy1) + 1, Pal)
_PUTIMAGE (0, 0), sourcehandle&, h&, (sx1, sy1)-(sx2, sy2) 'image is not displayed
GetImage& = h&
END FUNCTION 

```

### More examples

* [SAVEIMAGE](SAVEIMAGE) (SUB to convert image to bitmap)
* [SaveIcon32](SaveIcon32) (convert any image to icon)
* [ThirtyTwoBit SUB](ThirtyTwoBit-SUB) (convert partial image to bitmap)
* [Bitmaps](Bitmaps)

## See Also

* [_LOADIMAGE](_LOADIMAGE)
* [_NEWIMAGE](_NEWIMAGE)
* [_PUTIMAGE](_PUTIMAGE)
* [_COPYPALETTE](_COPYPALETTE)
