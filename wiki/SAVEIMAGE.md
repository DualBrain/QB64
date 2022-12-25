**The SAVEIMAGE SUB program to create [Bitmaps](Bitmaps) of other type Images or Screenshots**

**Bitmaps** are image files with the .BMP file name extension.

* Bitmaps can be 1, 4, 8 or 24/32 bits per pixel(BPP) color palettes. QB64 is capable of working with high color bitmaps.
* Screen or Image width and height calculations are automatically made using the image handle value.
* Use an image handle value of 0(zero) to get a screen shot of the entire active program screen. 
* **Note: SCREEN 0 text mode cannot be screen saved in QBasic or QB64.**

## Example(s)

*The following example uses a SUB program created to save a 32 bit JPEG image as a bitmap using QB64's graphic functions:*

>  Module Demo Code: Change the _LOADIMAGE filename to an image file you can access.

```vb

i& = _LOADIMAGE("nice.jpg",32) ' loads a 32 bit .JPG file image
SaveImage i&, "nice"      'saves it as .BMP file "nice.bmp"
'SaveImage 0, "screenshot" 'saves entire program screen as "screenshot.bmp"
END

```

```vb

SUB SaveImage (image AS LONG, filename AS STRING)
bytesperpixel& = _PIXELSIZE(image&)
IF bytesperpixel& = 0 THEN PRINT "Text modes unsupported!": END
IF bytesperpixel& = 1 THEN bpp& = 8 ELSE bpp& = 24
x& = _WIDTH(image&)
y& = _HEIGHT(image&)
b$="BM????QB64????"+MKL$(40)+MKL$(x&)+MKL$(y&)+MKI$(1)+MKI$(bpp&)+MKL$(0)+"????"+STRING$(16, 0) 'partial BMP header info(???? to be filled later)
IF bytesperpixel& = 1 THEN
  FOR c& = 0 TO 255 ' read BGR color settings from JPG image + 1 byte spacer(CHR$(0))
    cv& = _PALETTECOLOR(c&, image&) ' color attribute to read. 
    b$ = b$ +CHR$(_BLUE32(cv&))+CHR$(_GREEN32(cv&))+CHR$(_RED32(cv&))+CHR$(0) 'spacer byte
  NEXT
END IF
MID$(b$, 11, 4) = MKL$(LEN(b$)) ' image pixel data offset(BMP header)
lastsource& = _SOURCE
_SOURCE image&
IF ((x& * 3) MOD 4) THEN padder$ = STRING$(4 - ((x& * 3) MOD 4), 0)
FOR py& = y& - 1 TO 0 STEP -1 ' read JPG image pixel color data 
  r$ = ""
  FOR px& = 0 TO x& - 1
   c& = POINT(px&, py&) 'POINT 32 bit values are large LONG values 
   IF bytesperpixel& = 1 THEN r$ = r$ + CHR$(c&) ELSE r$ = r$ + LEFT$(MKL$(c&), 3)
  NEXT px&  
  d$ = d$ + r$ + padder$
NEXT py&
_SOURCE lastsource&
MID$(b$, 35, 4) = MKL$(LEN(d$)) ' image size(BMP header)
b$ = b$ + d$ ' total file data bytes to create file
MID$(b$, 3, 4) = MKL$(LEN(b$)) ' size of data file(BMP header)
IF LCASE$(RIGHT$(filename$, 4)) <> ".bmp" THEN ext$ = ".bmp"
f& = FREEFILE
OPEN filename$ + ext$ FOR OUTPUT AS #f&: CLOSE #f& ' erases an existing file
OPEN filename$ + ext$ FOR BINARY AS #f&
PUT #f&,,b$
CLOSE #f&
END SUB * *     

```
<sub>Code by Galleon</sub>

**This SUB program can also be [$INCLUDE]($INCLUDE) with any program!**

*SUB Explanation:* b$ and d$ assemble the entire string of data to create a bitmap file. Some of the bitmap header info is placed later using a [MID$ (statement)](MID$-(statement)) to add final header numerical data converted to [ASCII](ASCII) characters by [MKI$](MKI$) or [MKL$](MKL$). 

After the header, the [RGB](RGB) color settings are created using [ASCII](ASCII) characters read backwards as Blue, Green, Red and CHR$(0) as a spacer. [MKL$](MKL$) places the byte values in reverse order too. Bitmaps and icons require that format. [LEFT$](LEFT$) trims off the [_ALPHA](_ALPHA) byte.

The actual image is read as pixel attributes from the image bottom to the top for proper formatting with zero padding when necessary.

*** Note:** 32-bit images will be saved as 24-bit BMP files. All palette indexed images/modes will be saved as 256 color BMP files. Text modes cannot be saved. As QB64 has no official _SAVEIMAGE command yet and QBasic programs to save screen-shots don't work in QB64 yet this is a very useful alternative.

## See Also

* [_LOADIMAGE](_LOADIMAGE), [_ICON](_ICON), [$EXEICON]($EXEICON)
* [SCREEN (statement)](SCREEN-(statement))
* [TYPE](TYPE), [MKI$](MKI$), [MKL$](MKL$)
* [Program ScreenShots](Program-ScreenShots) (member SUB program)
* [ThirtyTwoBit SUB](ThirtyTwoBit-SUB) (member SUB captures selected area)
* [ThirtyTwoBit MEM SUB](ThirtyTwoBit-MEM-SUB) (Fast SUB uses memory instead of POINT)
* [SaveIcon32](SaveIcon32) (converts any image to icon)
* [Bitmaps](Bitmaps), [Icons and Cursors](Icons-and-Cursors)
