The [_WIDTH (function)](_WIDTH-(function)) function returns the width of an image handle or of the current write page.

## Syntax

>  columns& = [_WIDTH (function)](_WIDTH-(function))[(imageHandle&)]

## Description

* If imageHandle& is omitted, it's assumed to be the handle of the current [SCREEN](SCREEN) or write page.
* To get the width of the current program [SCREEN](SCREEN) window use zero for the handle value or nothing: columns& = [_WIDTH (function)](_WIDTH-(function))(0) *or* columns& = [_WIDTH (function)](_WIDTH-(function))
* If the image specified by imageHandle& is in text only([SCREEN](SCREEN) 0) mode, the number of characters per row is returned.
* If the image specified by imageHandle& is in graphics mode, the number of pixels per row is returned. 
* If imageHandle& is an invalid handle, then an [ERROR Codes](ERROR-Codes) is returned.
* The last visible pixel coordinate of a program [SCREEN](SCREEN) is **[_WIDTH (function)](_WIDTH-(function)) - 1**.

## Example(s)

## Example(s)
 A SUB program that centers text in any graphic screen mode except text mode [SCREEN (statement)](SCREEN-(statement)) 0.

```vb

s& = _NEWIMAGE(800, 600, 256)
SCREEN s&
Align 15, 5, s&, "This text is centered on the screen!"

SUB Align (Tcolor, Trow, mode&, txt$)    
  center& = _WIDTH (mode&) \ 2     'returns pixels in graphic modes 
  MaxCol = (center& \ 8) + 1              'screen text width = 8 pixels
  Tcol = MaxCol - (LEN(txt$) \ 2)
  COLOR Tcolor: LOCATE Trow, Tcol: PRINT txt$;  
END SUB

```

> *Explanation:* [_NEWIMAGE](_NEWIMAGE) enlarges a screen to 800 pixels wide which is what [_WIDTH (function)](_WIDTH-(function)) function will return. The center is 800 \ 2 or 400. Since the text width is 8 pixels, that is divided by 8 to get 50 as the center text column. Then half of the text length is subtracted to find the starting text print [LOCATE](LOCATE) column.

>  *Note:* The screen handle parameter is required because using no handle could assume other page handles created by functions like [_NEWIMAGE](_NEWIMAGE) or [_PUTIMAGE](_PUTIMAGE). Use the correct handle in the SUB call! When using SCREEN 0, the MaxCol variable is not needed because _WIDTH returns the number of text columns, not pixels. Use the center value and add 1. **Tcol = (center& + 1) - LEN(txt$) \ 2**

## See Also

* [_HEIGHT](_HEIGHT), [_LOADIMAGE](_LOADIMAGE), [_NEWIMAGE](_NEWIMAGE)
* [WIDTH](WIDTH)
* [Bitmaps](Bitmaps)
