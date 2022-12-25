The [PCOPY](PCOPY) statement copies one source screen page to a destination page in memory. 

## Syntax

> [PCOPY](PCOPY) sourcePage%, destinationPage%

## Description

* sourcePage% is an image page in video memory.
* destinationPage% is the video memory location to copy the source image to.
* The working page is set as 0. All drawing occurs there.
* The visible page is set as any page number that the SCREEN mode allows.
* The [_DISPLAY (function)](_DISPLAY-(function)) return can be used a page number reference in **QB64** (See Example 1).
* The **QB64** [_DISPLAY](_DISPLAY) statement can also be used to stop screen flicker without page flipping or [CLS](CLS) and **is the recommended practice**.

## QBasic

* sourcePage% and destinationPage% numbers are limited by the SCREEN mode used. In **QB64**, the same limits don't apply.

## Example(s)

Creating a mouse cursor using a page number that **you create** in memory without setting up page flipping.

```vb

SCREEN _NEWIMAGE(640, 480, 32) 'any graphics mode should work without setting up pages
_MOUSEHIDE
SetupCursor
PRINT "Hello World!"
DO: _LIMIT 30
  DO WHILE _MOUSEINPUT: LOOP 'main loop must contain _MOUSEINPUT   
'       other program code    
LOOP

SUB SetupCursor
ON TIMER(0.02) UpdateCursor
TIMER ON
END SUB

SUB UpdateCursor
PCOPY _DISPLAY, 100  'any page number as desination with the _DISPLAY function as source
PSET (_MOUSEX, _MOUSEY), _RGB(0, 255, 0)
DRAW "ND10F10L3F5L4H5L3"
_DISPLAY                  'statement shows image
PCOPY 100, _DISPLAY 'function return as destination page
END SUB 

```

> *Note:* Works with [_DISPLAY (function)](_DISPLAY-(function)) as the other page. If mouse reads are not crucial, put the _MOUSEINPUT loop inside of the UpdateCursor Sub.

Bouncing balls

```vb

 SCREEN 7, 0, 1, 0
 DIM x(10), y(10), dx(10), dy(10)
 FOR a = 1 TO 10
   x(a) = INT(RND * 320) + 1
   y(a) = INT(RND * 200) + 1
   dx(a) = (RND * 2) - 1
   dy(a) = (RND * 2) - 1
 NEXT
 DO
 PCOPY 1, 0                           'place image on the visible page 0
 CLS
 _LIMIT 100                           'regulates speed of balls in QB64
 FOR a = 1 TO 10     
   CIRCLE(x(a), y(a)), 5, 15          'all erasing and drawing is done on page 1
    x(a) = x(a) + dx(a)
    y(a) = y(a) + dy(a)
   IF x(a) > 320 THEN dx(a) = -dx(a): x(a) = x(a) - 1
   IF x(a) < 0 THEN dx(a) = -dx(a): x(a) = x(a) + 1
   IF y(a) > 200 THEN dy(a) = -dy(a): y(a) = y(a) - 1
   IF y(a) < 0 THEN dy(a) = -dy(a): y(a) = y(a) + 1
 NEXT
 LOOP UNTIL INKEY$ = CHR$(27) ' escape exit

```

> *Explanation:* PCOPY reduces the flickering produced by clearing the screen. x(a) = x(a) - 1, etc. is just to be safe that the balls stay within the boundaries. dx(a) = -dx(a), etc. is to keep the actual speed while inverting it (so that the ball "bounces"). The rest should be self-explanatory, but if you are unsure about arrays you might want to look at QB64 Tutorials -> [Arrays](Arrays).

## See Also

* [_DISPLAY](_DISPLAY)
* [SCREEN (statement)](SCREEN-(statement))
