The [_DEST](_DEST) statement sets the current write image or page. All graphic and print changes will be done to this image.

## Syntax

> [_DEST](_DEST) imageHandle&

## Description

* imageHandle& is the handle of the image that will act as the current write page.
* **_DEST 0** refers to the present program [SCREEN](SCREEN). You can use 0 to refer to the present program [SCREEN](SCREEN).
* [_DEST](_DEST) [_CONSOLE](_CONSOLE) can set the destination to send information to a console window using [PRINT](PRINT) or [INPUT](INPUT).
* If imageHandle& is an invalid handle, an [ERROR Codes](ERROR-Codes) error occurs. Always check for valid handle values first (imageHandle& < -1).
* *Note:* Use [_SOURCE](_SOURCE) when you need to read a page or image with [POINT](POINT), [GET (graphics statement)](GET-(graphics-statement)) or the [SCREEN (function)](SCREEN-(function)) function.

## Example(s)

Placing a center point and a circle using [_CLEARCOLOR](_CLEARCOLOR) to eliminate the background color black.

```vb

SCREEN 13      'program screen can use 256 colors
a& = _NEWIMAGE(320,200,13)        'create 2 screen page handles a& and b&
b& = _NEWIMAGE(320,200,13)
_DEST a&                          'set destination image to handle a&
PSET (100, 100), 15               'draw a dot on the current destination handle a&
_DEST b&                          'set destination image to handle b&
CIRCLE (100, 100), 50, 15         'draw a circle on the current destination handle b&
_CLEARCOLOR 0                     'make page b color 0 (black) transparent
_PUTIMAGE , b&, a&                'put circle on image b to image a& (a PSET dot)
_PUTIMAGE , a&, 0                 'put what is on image a& to the screen (handle 0) 

```

Demonstrates how [PRINT](PRINT) text can be stretched using [_PUTIMAGE](_PUTIMAGE) with [_DEST](_DEST) pages.

```vb

DIM a(10) AS LONG
DIM b AS LONG

REM Sets up a newimage for B then sets the screen to that.
b = _NEWIMAGE(640, 480, 32)
SCREEN b

REM Make pages 48 pixels tall. If the image is not at least that it wont work
a(1) = _NEWIMAGE(240, 48, 32)
a(2) = _NEWIMAGE(240, 48, 32)
a(3) = _NEWIMAGE(98, 48, 32)

xa = 100
ya = 120
xm = 4
ym = 4

REM Some fun things for the bouncing text.
st$(0) = "doo"
st$(1) = "rey"
st$(2) = "mee"
st$(3) = "faa"
st$(4) = "soo"
st$(5) = "laa"
st$(6) = "tee"

sta$(0) = "This is a demo"
sta$(1) = "showing how to use"
sta$(2) = "the _DEST command"
sta$(3) = "with PRINT"
sta$(4) = "and _PUTIMAGE"

REM prints to a(3) image then switches back to the default 0
_DEST a(3): f = INT(RND * 6): PRINT st$(3): _DEST 0

DO
    REM prints to a(1) and a(2) then switches bac to 0
    _DEST a(1)
    CLS
    PRINT sta(r)
    _DEST a(2)
    CLS
    PRINT sta(r + 1)
    _DEST 0          'destination zero is the main program page

    REM a loop to putimage the images in a(1) and a(2) in a way to make it look like its rolling
    FOR yat = 150 TO 380 STEP 4
        CLS
        _PUTIMAGE (0, yat)-(640, 380), a(1)
        _PUTIMAGE (0, 150)-(640, yat), a(2)
        GOSUB bounce
        _DISPLAY
        _LIMIT 20
    NEXT yat

    r = r + 1
    IF r = 4 THEN r = 0
LOOP UNTIL INKEY$ <> ""
END

bounce:
IF xa > 600 OR xa < 20 THEN xm = xm * -1: _DEST a(3): f = INT(RND * 6): CLS: _CLEARCOLOR 0: PRINT st$(f): _DEST 0
IF ya > 400 OR ya < 20 THEN ym = ym * -1: _DEST a(3): f = INT(RND * 7): CLS: _CLEARCOLOR 0: PRINT st$(f): _DEST 0
_PUTIMAGE (xa, ya)-(xa + 150, ya + 80), a(3)
xa = xa + xm
ya = ya + ym
RETURN 

```

## See Also

* [_DEST (function)](_DEST-(function))
* [_SOURCE](_SOURCE)
* [_PUTIMAGE](_PUTIMAGE)
* [_CONSOLE](_CONSOLE)
