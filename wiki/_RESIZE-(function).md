The [_RESIZE](_RESIZE) function returns true (-1) when a user has attempted to resize the program window and [$RESIZE]($RESIZE):ON has allowed it.

## Syntax

> IF **_RESIZE** THEN rx& = [_RESIZEWIDTH](_RESIZEWIDTH): ry& = [_RESIZEHEIGHT](_RESIZEHEIGHT)

## Description

* The function returns -1 if a program screen resize was attempted by the user. 
* After the function returns -1, [_RESIZEWIDTH](_RESIZEWIDTH) and [_RESIZEHEIGHT](_RESIZEHEIGHT) can return the new requested dimensions in pixels.
* The [$RESIZE]($RESIZE):ON [metacommand](metacommand) must be used so the program is created with a user resizable window.

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

    'Center the image:
    x = _WIDTH / 2 - _WIDTH(bee&) / 2
    y = _HEIGHT / 2 - _HEIGHT(bee&) / 2
    _PUTIMAGE (x, y), bee&
    _DISPLAY
    _LIMIT 30
LOOP

```

## See Also

* [$RESIZE]($RESIZE) (metacommand)
* [_RESIZE](_RESIZE)
* [_RESIZEWIDTH](_RESIZEWIDTH), [_RESIZEHEIGHT](_RESIZEHEIGHT) (requested pixel dimensions)
