The [$RESIZE]($RESIZE) [Metacommand](Metacommand) determines if a program window can be resized by the user.

## Syntax

>  [$RESIZE]($RESIZE):{ON|OFF|STRETCH|SMOOTH}

## Description

* $RESIZE:ON is used to allow the program window to be resized by a program user. Otherwise it cannot be changed.
* $RESIZE:OFF (**default**) is used when the program's window size cannot be changed by the user.
* $RESIZE:STRETCH the screen will be stretched to fit the new window size with a 1 to 1 ratio of width and height.
* $RESIZE:SMOOTH the screen will be stretched also, but with linear filtering applied to the pixels.

## Availability

* Version 1.000 and up.

## Example(s)

 Resizing a program screen when the user changes it without clearing the entire screen image:

```vb

$RESIZE:ON

SCREEN _NEWIMAGE(160, 140, 32)
_DELAY 0.1
_SCREENMOVE 20, 20
_DISPLAY

' CLEAR _RESIZE FLAG BY READING IT ONCE
temp& = _RESIZE

DO

    _LIMIT 60

    IF CheckResize(_SOURCE) = -1 THEN
        FOR i = 1 TO 10
            CIRCLE (RND * _WIDTH(0) - 1, RND * _HEIGHT(0) - 1), RND * 100 + 5, _RGB32(RND * 255, RND * 255, RND * 255)
        NEXT
    ELSE
        FOR i = 1 TO 200
            PSET (RND * _WIDTH(0) - 1, RND * _HEIGHT(0) - 1), _RGB32(RND * 255, RND * 255, RND * 255)
        NEXT
    END IF

    _DISPLAY

    k& = _KEYHIT

LOOP UNTIL k& = 27 OR k& = 32

SYSTEM

' *************************************************************************************************
' *                                                                                               *
' *  CheckResize: This FUNCTION checks if the user resized the window, and if so, recreates the   *
' *               ORIGINAL SCREEN image to the new window size.                                   *
' *                                                                                               *
' *               Developer Note: You must use $RESIZE:ON, $RESIZE:SMOOTH, or $RESIZE:SMOOTH at   *
' *                               the beginning of your project for this to work.                 *
' *                               This FUNCTION only works in QB64 version 1.000 and up.          *
' *                                                                                               *
' *************************************************************************************************
FUNCTION CheckResize (CurrentScreen AS _UNSIGNED LONG)

    ' *** Define local variable for temporary screen
    DIM TempScreen AS _UNSIGNED LONG

    CheckResize = 0

    ' *** Check to see if the user resized the window. If so, change the SCREEN image to the correct size.
    IF _RESIZE THEN

        ' *** First, create a copy of the current SCREEN image.
        TempScreen = _COPYIMAGE(CurrentScreen, 32)

        ' *** Set the SCREEN to the copied image, releasing the current SCREEN image.
        SCREEN TempScreen

        ' *** Remove (FREE) the original SCREEN image.
        _FREEIMAGE CurrentScreen

        ' *** Create a new "original" SCREEN image.
        CurrentScreen = _NEWIMAGE(_RESIZEWIDTH, _RESIZEHEIGHT, 32)

        ' *** Set the SCREEN to the new "original" image, releasing the copied SCREEN image.
        SCREEN CurrentScreen

        '  DRAW PREVIOUS SCREEN ON THE NEW ONE
        _PUTIMAGE (0, 0), TempScreen, CurrentScreen

        _DISPLAY

        ' *** Remove (FREE) the copied SCREEN image.
        _FREEIMAGE TempScreen

        ' *** Tell the caller there was a resize
        CheckResize = -1

    END IF

END FUNCTION

```

## See Also

* [_RESIZE](_RESIZE), [_RESIZE (function)](_RESIZE-(function))
* [_RESIZEWIDTH](_RESIZEWIDTH), [_RESIZEHEIGHT](_RESIZEHEIGHT) (functions return the requested dimensions)
