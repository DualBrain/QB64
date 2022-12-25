Images are areas of graphics stored in memory, the most common image is the program screen itself, where graphics are displayed. This image is designated as image handle 0 or [_DEST](_DEST) 0. QB64 refers to the image memory by using negative [LONG](LONG) handle values. Those values can then be referred to using other functions such as [_WIDTH](_WIDTH) and [_HEIGHT](_HEIGHT) to find the image properties. Statements like [SCREEN](SCREEN) or [_PUTIMAGE](_PUTIMAGE) can use the image handle to display the image when necessary. QBasic functions like [POINT](POINT) can read the colors, even 32 bit [_ALPHA](_ALPHA) colors.

Images are called by other names in other programming languages or in different situations, examples of other names can be "surfaces", "pages" or "layers".

## QB64 Images

You can create a program screen image by using the [_NEWIMAGE](_NEWIMAGE) function. _NEWIMAGE returns a handle for you to use as a reference to that image. The handle is a negative number below -1 where -1 indicates a failure to load an image.

For the image handle parameter in a statement you can also use any positive number and this handle will not need to be defined by [_NEWIMAGE](_NEWIMAGE) or anything else. In this case the image referred to is the screen page of that value. This is why image handle 0 refers to the screen, specifically screen page 0.

You can also load an image from a file using the [_LOADIMAGE](_LOADIMAGE) function (click the link for further information), or retrieve the handle to a copy of a image by using the [_COPYIMAGE](_COPYIMAGE) function.

All images except for the screen are hidden from view unless drawn onto the screen, this enables you to draw multiple things on an image and then display all of it at once, enabling smooth animation (amongst many other things), you can also put multiple images ontop of one image and then display that image to the screen to enable all sorts of effects, like parallax scrolling and objects moving in front of as well as behind each other.

## _PUTIMAGE

To set which image you want to draw graphics on, use [_DEST](_DEST), all drawing will now go to the desired image instead of the screen (to enable drawing to the screen set _DEST 0), if you want to retrieve information about a image you use [_SOURCE](_SOURCE) instead, as when you want to know the color a pixel has at a certain coordinate you would use [_SOURCE](_SOURCE) along with [POINT](POINT) (see the [_SOURCE](_SOURCE) example for more information about this). If you have drawn graphics on one image you can display it to the screen using [_PUTIMAGE](_PUTIMAGE), like this;

`_PUTIMAGE imagehandle, 0`

Where imagehandle is the handle you have drawn, or if you don't know the image handle you can use [_DEST (function)](_DEST-(function)) as a function like this;
 
`_PUTIMAGE _DEST, 0`

You could also use the [SCREEN (statement)](SCREEN-(statement)) statement to display the image to the screen like this;

`SCREEN imagehandle`

or

`SCREEN _DEST`

Just be careful so that [_DEST](_DEST) is indeed a negative number other than -1.

## _ALPHA

If you want a color to be transparent you would use the [_CLEARCOLOR](_CLEARCOLOR) statement, the _CLEARCOLOR statement also has a optional argument as to which image you want the color to be transparent on, if this argument is set then the color will only be transparent on that particular image. If you want the color to be solid again you would use _NONE as the color argument (see [_CLEARCOLOR](_CLEARCOLOR) statement for further details).

The [_SETALPHA](_SETALPHA) statement also enables transparency (_CLEARCOLOR just sets the transparency level to full (which is 0) on images that have an alpha channel), to enable partial transparency you need a 32-bit image which has an alpha channel (a PNG image may already contain alpha information), the alpha level is between **0** (transparent) and **255** (opaque). If you have a 32-bit image but don't want to alpha blend it you have to turn it off using [_DONTBLEND](_DONTBLEND). To turn it on again you can use the [_BLEND](_BLEND) statement (which is on by default).

To put an image on top of another image you would use [_PUTIMAGE](_PUTIMAGE), if you want to put/stretch the whole image on top of another you would just omit the range arguments and if you only want to put part of the image on top of another image you would use the range arguments as necessary. Keep in mind that _PUTIMAGE will stretch the image to fit the destination range. If the coordinates are inverted then the image will be inverted accordingly (enables flipping).

The [_ALPHA](_ALPHA) function returns the alpha channel level of a color value.

## Syntax

> `*result&* = [_ALPHA](_ALPHA)(c&[, imageHandle&])`

[_RED32](_RED32), [_GREEN32](_GREEN32), [_BLUE32](_BLUE32) and [_ALPHA32](_ALPHA32) are all equivalent to [_RED](_RED), [_GREEN](_GREEN), [_BLUE](_BLUE) and [_ALPHA](_ALPHA) but they are highly optimized and only accept a 32-bit color (B8:G8:R8:A8). Using these in your code (as appose to dividing then ANDing 32-bit color values manually) makes your code easy to read too.

## Image file types

* [Bitmaps](Bitmaps)
* [Creating Icon Bitmaps](Creating-Icon-Bitmaps)
* [Icons and Cursors](Icons-and-Cursors) 
* [GIF Images](GIF-Images)
* [Creating Icons from Bitmaps](Creating-Icons-from-Bitmaps)
* [SaveIcon32](SaveIcon32) (convert any image to icon)
* [SAVEIMAGE](SAVEIMAGE) (convert any image to bitmap)
* [Text Using Graphics](Text-Using-Graphics)
* [$EXEICON]($EXEICON)

## QB64 statements and functions

* [_ALPHA](_ALPHA) (function)
* [_ALPHA32](_ALPHA32) (function)
* [_BACKGROUNDCOLOR](_BACKGROUNDCOLOR) (function)
* [_BLEND](_BLEND) (sub)
* [_BLEND (function)](_BLEND-(function))
* [_BLUE](_BLUE) (function)
* [_BLUE32](_BLUE32) (function)
* [_CLEARCOLOR](_CLEARCOLOR) (sub)
* [_CLEARCOLOR (function)](_CLEARCOLOR-(function))
* [_COPYIMAGE](_COPYIMAGE) (function)
* [_COPYPALETTE](_COPYPALETTE) (sub)
* [_DEFAULTCOLOR](_DEFAULTCOLOR) (function)
* [_DEST](_DEST) (sub)
* [_DEST (function)](_DEST-(function))
* [_DISPLAY (function)](_DISPLAY-(function))
* [_DONTBLEND](_DONTBLEND) (sub)
* [_FONT](_FONT) (sub)
* [_FONT (function)](_FONT-(function))
* [_FONTHEIGHT (function)](_FONTHEIGHT-(function))
* [_FONTWIDTH (function)](_FONTWIDTH-(function))
* [_FREEFONT](_FREEFONT) (sub)
* [_FREEIMAGE](_FREEIMAGE) (sub)
* [_GREEN](_GREEN) (function)
* [_GREEN32](_GREEN32) (function)
* [_HEIGHT](_HEIGHT) (function)
* [_ICON](_ICON)
* [_LOADFONT](_LOADFONT) (function)
* [_LOADIMAGE](_LOADIMAGE) (function) (cannot use Icons)
* [_NEWIMAGE](_NEWIMAGE) (function)
* [_PALETTECOLOR](_PALETTECOLOR) (sub)
* [_PALETTECOLOR (function)](_PALETTECOLOR-(function))
* [_PIXELSIZE](_PIXELSIZE) (function)
* [_PRINTIMAGE](_PRINTIMAGE) (sub) (printer)
* [_PRINTMODE](_PRINTMODE) (sub)
* [_PRINTMODE (function)](_PRINTMODE-(function))
* [_PRINTSTRING](_PRINTSTRING) (sub)
* [_PRINTWIDTH](_PRINTWIDTH) (sub)
* [_PUTIMAGE](_PUTIMAGE) (sub)
* [_RED](_RED) (function)
* [_RED32](_RED32) (function)
* [_RGB](_RGB) (function)
* [_RGB32](_RGB32) (function)
* [_RGBA](_RGBA) (function)
* [_RGBA32](_RGBA32) (function)
* [SCREEN](SCREEN) (sub)
* [_SCREENIMAGE](_SCREENIMAGE) (function) (desktop)
* [_SETALPHA](_SETALPHA) (sub)
* [_SOURCE](_SOURCE) (sub)
* [_SOURCE (function)](_SOURCE-(function))
* [_WIDTH](_WIDTH) (function) 
