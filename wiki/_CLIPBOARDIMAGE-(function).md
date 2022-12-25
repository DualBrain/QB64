The [_CLIPBOARDIMAGE (function)](_CLIPBOARDIMAGE-(function)) function pastes an image from the clipboard into a new 32-bit image in memory.

## Syntax

> newImageHandle& = [_CLIPBOARDIMAGE (function)](_CLIPBOARDIMAGE-(function))

## Description

* When the paste operation is successful, newImageHandle& will be < -1. Handle values of -1 or 0 indicate that there wasn't an image in the clipboard or that the format wasn't accepted.
* Use [_FREEIMAGE](_FREEIMAGE) to free the memory used by newImageHandle& when it's no longer needed by your program.
* [Keywords currently not supported](Keywords-currently-not-supported-by-QB64).

## Availability

* Build 20170906/64 and up.

## Example(s)

Monitoring the clipboard for new images copied from other programs:

```vb

SCREEN _NEWIMAGE(800, 600, 32)
DO
    CLS
    COLOR _RGB32(177, 177, 177)
    PRINT "Monitoring clipboard..."
    IF img& < -1 THEN _FREEIMAGE img&
    img& = _CLIPBOARDIMAGE
    IF img& < -1 THEN
        PRINT "Image found:"
        COLOR _RGB32(255, 255, 255)
        PRINT "Width :"; _WIDTH(img&)
        PRINT "Height:"; _HEIGHT(img&)
        w = _WIDTH / 2 - _WIDTH(img&) / 2
        IF w < 0 THEN w = 0
        _PUTIMAGE (w, CSRLIN * _FONTHEIGHT), img&
    ELSE
        PRINT "No image found."
    END IF
    _DISPLAY
    _LIMIT 10
LOOP

```

## See Also

* [_CLIPBOARDIMAGE](_CLIPBOARDIMAGE) (statement - used to copy an image to the clipboard)
* [_CLIPBOARD$](_CLIPBOARD$), [_CLIPBOARD$ (statement)](_CLIPBOARD$-(statement)) (used to copy/paste text)
