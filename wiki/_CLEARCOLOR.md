The [_CLEARCOLOR](_CLEARCOLOR) statement sets a specific color to be treated as transparent when an image is later put (via [_PUTIMAGE](_PUTIMAGE)) onto another image. 

## Syntax

> [_CLEARCOLOR](_CLEARCOLOR) {color&|_NONE}[, Dest_Handle&]

## Parameter(s)

* In color modes using a palette, color& is the palette index of the new transparent color value or _NONE designates no clear colors.
* If color& is not a valid palette index, an [ERROR Codes](ERROR-Codes) error will occur.
* In 32-bit color modes, color& is the [_LONG](_LONG) color value of the new transparent color.
* If Dest_Handle& is omitted, the destination is assumed to be the current write page. Zero can designate the current program screen.

## Description

* If Dest_Handle& is an invalid handle, then an [ERROR Codes](ERROR-Codes) error is returned. Check for bad handle values of -1 first.
* In 32-bit color modes, it simply sets the Alpha to 0 for all pixels matching the specified color.
* In the second syntax, transparency is disabled for color modes using a palette.
* **Note:** [_SETALPHA](_SETALPHA) can affect any _CLEARCOLOR alpha setting within the color range set.
* **NOTE: 32 bit [_NEWIMAGE](_NEWIMAGE) screen page backgrounds are transparent black or [_ALPHA](_ALPHA) 0. Use [_DONTBLEND](_DONTBLEND) or [CLS](CLS) for opaque.**

## Example(s)

Using _CLEARCOLOR to "mask" the background color of an image.

```vb

SCREEN 13
img& = _LOADIMAGE("qb64_trans.png")
_PUTIMAGE , img&, 0               'place actual image with background
K$ = INPUT$(1)
CLS , _RGB(255, 0, 0)             'clear screen with red background
_CLEARCOLOR _RGB(255, 255, 255), img&
_PUTIMAGE , img&, 0               'place image without white background
PRINT _CLEARCOLOR(img&)           'displays closest clear color attribute
END 

```

Using a _CLEARCOLOR transparency with images created on a [_NEWIMAGE](_NEWIMAGE) page. Does not require an image file.

```vb

SCREEN _NEWIMAGE(512, 384, 32) ' screen uses handle value
CIRCLE(50, 50), 50, _RGB(128, 0, 0) ' create a red ball image
PAINT(50, 50), _RGB(255, 0, 0), _RGB(128, 0, 0)
redball = _NEWIMAGE(101, 101, 32) ' create a new image page
_PUTIMAGE , 0, redball,(0, 0)-(101, 101) ' put screen page 0 image onto redball page
_CLEARCOLOR _RGB(0, 0, 0), redball ' makes black become see-through
CLS, _RGB(0, 0, 255) ' erase original ball and create a blue background
DO
 _PUTIMAGE (RND * 512, RND * 384), redball
 SLEEP 1 ' one second delay
LOOP UNTIL INKEY$ <> "" 

```

Fading an image with a _CLEARCOLOR background using a new page image to prevent [_SETALPHA](_SETALPHA) changes.

```vb

mainscreen = _NEWIMAGE(640, 480, 32) ' Main Screen (viewable)
SCREEN mainscreen
_SCREENMOVE _MIDDLE
Image1& = _LOADIMAGE("qb64_trans.png") '<<<<<< any image with one background color to clear

IF Image1& < -1 THEN 'check loaded image handle value before using!
  _SOURCE Image1&
  clr~& = POINT(0, 0) 'get background color from image source
  _CLEARCOLOR clr~&, Image1& 'clear background color of loaded image
  NewImage1& = _NEWIMAGE(_WIDTH(Image1&), _HEIGHT(Image1&), 32) 'new image page
  _PUTIMAGE , Image1&, NewImage1& 'put image without background color on new page
  _FREEIMAGE Image1& 'free loaded image from memory
END IF
_DEST mainscreen:

a& = 0: d = 1
DO
  _LIMIT 10 'regulate speed of fades
  CLS
  a& = a& + d
  IF a& = 255 THEN d = -d 'reverse fade 
  _SETALPHA a&, , NewImage1& 'sets alpha level of all colors to fade image page in/out
  _PUTIMAGE (0, 342), NewImage1& 
  LOCATE 1, 1: PRINT "Alpha: "; a&
  _DISPLAY
LOOP UNTIL a& = 0
END

```

> *Note:* If the _CLEARCOLOR background was not put onto a separate page, [_SETALPHA](_SETALPHA) would display it also.

## See Also

* [_CLEARCOLOR (function)](_CLEARCOLOR-(function))
* [_SETALPHA](_SETALPHA) (sets transparency level)
* [_ALPHA](_ALPHA), [_ALPHA32](_ALPHA32) (read functions)
* [Images](Images), [Creating Sprite Masks](Creating-Sprite-Masks)
