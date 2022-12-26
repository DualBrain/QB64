The [_SOURCE](_SOURCE) statement establishes the image SOURCE using a handle created by [_LOADIMAGE](_LOADIMAGE), [_NEWIMAGE](_NEWIMAGE) or [_COPYIMAGE](_COPYIMAGE).

## Syntax

> [_SOURCE](_SOURCE) handle&

## Description

* The handle is a [LONG](LONG) integer value from the [_SOURCE (function)](_SOURCE-(function)) function or a handle created by [_NEWIMAGE](_NEWIMAGE). 
* If the handle is designated as 0, it refers to the current [SCREEN](SCREEN) image.
* A source image can only supply information to a program. [POINT](POINT) and [GET (graphics statement)](GET-(graphics-statement)) might require a source other than the one currently active.

## Example(s)

```vb

SCREEN 13
a = _NEWIMAGE(320,200,13)
_DEST a
PSET (100, 100), 15
_SOURCE a
_DEST 0
PRINT POINT(100, 100) 

```

```text

 15

```

> *Explanation:* Create a new image with handle 'a', then use [_DEST](_DEST) to define the image to draw on. Draw a pixel then set the source to 'a' and use [POINT](POINT) to show what color is in that position. White (15) and is the color set with [PSET](PSET). Use [_DEST](_DEST) 0 for the screen to display the results.

### More examples

See the examples in:

* [Bitmaps](Bitmaps)
* [SAVEIMAGE](SAVEIMAGE)
* [SaveIcon32](SaveIcon32)

## See Also

* [_DEST](_DEST)
* [_SOURCE (function)](_SOURCE-(function))
* [POINT](POINT), [GET (graphics statement)](GET-(graphics-statement))
