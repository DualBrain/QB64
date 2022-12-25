The [_RESIZEHEIGHT](_RESIZEHEIGHT) function returns the user resized screen pixel height if [$RESIZE]($RESIZE):ON allows it and [_RESIZE (function)](_RESIZE-(function)) returns -1 

## Syntax

> newHeight& = [_RESIZEHEIGHT](_RESIZEHEIGHT)

## Description

* [_RESIZE (function)](_RESIZE-(function)) function must return true (-1) before the requested screen dimensions can be returned by the function.
* The program should decide if the request is allowable for proper program interaction.

## Availability

* Version 1.000 and up.

## Example(s)

Resize the current screen image according to user's request.

```vb

$RESIZE:ON

s& = _NEWIMAGE(300, 300, 32)
SCREEN s&

bee& = _LOADIMAGE("qb64_trans.png") 'replace with your own image

DO
    IF _RESIZE THEN
        oldimage& = s&
        s& = _NEWIMAGE(_RESIZEWIDTH, _RESIZEHEIGHT, 32)
        SCREEN s&
        _FREEIMAGE oldimage&
    END IF

    CLS

    'Center the QB64 bee image:
    x = _WIDTH / 2 - _WIDTH(bee&) / 2
    y = _HEIGHT / 2 - _HEIGHT(bee&) / 2
    _PUTIMAGE (x, y), bee&
    _DISPLAY
    _LIMIT 30
LOOP

```

## See Also

* [$RESIZE]($RESIZE)
* [_RESIZE (function)](_RESIZE-(function))
* [_RESIZEWIDTH](_RESIZEWIDTH)
