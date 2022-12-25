The [_RGBA](_RGBA) function returns the closest palette index (legacy SCREEN modes) OR the 32-bit [LONG](LONG) color value (32-bit screens).

## Syntax

> colorIndex~& = [_RGBA](_RGBA)(red&, green&, blue&, alpha&[, imageHandle&]**)**

* The value returned is either the closest color attribute number or a 32-bit [_UNSIGNED](_UNSIGNED) [LONG](LONG) color value. 
* **Return variable types must be [LONG](LONG) or the resulting color may lose the [_BLUE](_BLUE) value.**
* red& specifies the red component intensity from 0 to 255.
* green& specifies the green component intensity from 0 to 255.
* blue& specifies the blue component intensity from 0 to 255.
* The [_ALPHA](_ALPHA) value can be set to make the color transparent (0), opaque (255) or somewhere in between.
* Parameter values outside of the 0 to 255 range are clipped.
* Returns [LONG](LONG) 32-bit hexadecimal values from **&H00000000** to **&HFFFFFFFF** with varying [_ALPHA](_ALPHA) transparency.
* When [LONG](LONG) values are [PUT](PUT) to file, the ARGB values become BGRA. Use [LEFT$](LEFT$)([MKL$](MKL$)(colorIndex~&), 3) to place 3 colors.
* If imageHandle& is omitted, the image is assumed to be the current [_DEST](_DEST) or [SCREEN](SCREEN) page.
* Allows the blending of pixel colors red, green and blue to create any of 16 million colors.
* **NOTE: Default 32-bit backgrounds are clear black or [_RGBA](_RGBA)(0, 0, 0, 0). Use [CLS](CLS) to make the black opaque.**

## Example(s)

Setting a font's background color alpha to clear to overlay a second text color.

```vb

scrn& = _NEWIMAGE(400, 400, 32)
SCREEN scrn&
fnt& = _LOADFONT("C:\WINDOWS\FONTS\ARIAL.TTF", 26)
_FONT fnt&
X% = 20
Y% = 20
COLOR _RGB(255, 255, 255), _RGB(0, 0, 0) 'Foreground set to WHITE background to BLACK
_PRINTSTRING (X%, Y%), "Hello World"
COLOR _RGB(255, 0, 0), _RGBA(0, 0, 0, 0) 'Foreground set to RED background to TRANSPARENT BLACK
_PRINTSTRING (X% + 2, Y% + 2), "Hello World"
END 

```

*Explanation:* [_PRINTSTRING](_PRINTSTRING) allows text or font colors to be alpha blended in 32 bit screens.

## See Also

* [_RGB](_RGB), [_RGB32](_RGB32), [_RGBA32](_RGBA32)
* [_RED](_RED), [_GREEN](_GREEN), [_BLUE](_BLUE)
* [_LOADIMAGE](_LOADIMAGE)
* [_PRINTSTRING](_PRINTSTRING)
* [HEX$ 32 Bit Values](HEX$-32-Bit-Values), [POINT](POINT)
* [SAVEIMAGE](SAVEIMAGE)
* [Hexadecimal Color Values](http://www.w3schools.com/html/html_colornames.asp)
