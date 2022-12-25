The [CLS](CLS) statement clears the [_DEST](_DEST).

## Syntax
 
> [CLS](CLS) [method%] [, bgColor&]

## Parameter(s)

* method% specifies which parts of the page to clear, and can have one of the following values:
  * CLS - clears the active graphics or text viewport or the entire text screen and refreshes bottom function [KEY LIST](KEY-LIST) line.
  * CLS 0 - Clears the entire page of text and graphics. Print cursor is moved to row 1 at column 1.
  * CLS 1 - Clears only the graphics view port. Has no effect for text mode.
  * CLS 2 - Clears only the text view port. The print cursor is moved to the top row of the text view port at column 1.
* The bgColor& specifies the color attribute or palette index to use when clearing the screen in **QB64**.

## Description

* In legacy [SCREEN](SCREEN) modes bgColor& specifies the color attribute of the background.
* For 32-bit graphics mode, bgColor& specifies the [_RGB](_RGB) or [_RGBA](_RGBA) color to use. 
* **32-bit screen surface backgrounds (black) have zero [_ALPHA](_ALPHA) so that they are transparent when placed over other surfaces.**
  * Use [CLS](CLS) or [_DONTBLEND](_DONTBLEND) to make a new surface background [_ALPHA](_ALPHA) 255 or opaque.
* If not specified, bgColor& is assumed to be the current background color. 32-bit backgrounds will change to opaque.
* If bgColor& is not a valid attribute, an [ERROR Codes](ERROR-Codes) error will occur.
* Use [_PRINTMODE](_PRINTMODE) to allow the background colors to be visible through the text or the text background.

## Example(s)

Printing black text on a white background in QB64.

```vb

SCREEN 12
CLS , 15
_PRINTMODE  _KEEPBACKGROUND        'keeps the text background visible
COLOR 0: PRINT "This is black text on a white background!"
K$ = INPUT$(1)

```

> *Explanation:* [_PRINTMODE](_PRINTMODE) can be used with [PRINT](PRINT) or [_PRINTSTRING](_PRINTSTRING) to make the text or the text background transparent.

You don't need to do anything special to use a .PNG image with alpha/transparency. Here's a simple example:

```vb

SCREEN _NEWIMAGE(640, 480, 32)
CLS , _RGB(0, 255, 0)
i = _LOADIMAGE(**"qb64_trans.png"**) 'see note below examples to get the image 
_PUTIMAGE (0, 0), i 'places image at upper left corner of window w/o stretching it 


```

> *Explanation:* When QB64 loads a .PNG file containing a transparent color, that color will be properly treated as transparent when _PUTIMAGE is used to put it onto another image. You can use a .PNG file containing transparency information in a 256-color screen mode in QB64. [CLS](CLS) sets the [_CLEARCOLOR](_CLEARCOLOR) setting using [_RGB](_RGB).

## See Also

* [SCREEN](SCREEN)
* [_RGB](_RGB), [_RGBA](_RGBA), [_RGB32](_RGB32), [_RGBA32](_RGBA32)
* [VIEW PRINT](VIEW-PRINT), [VIEW](VIEW)
* [_CLEARCOLOR](_CLEARCOLOR)
