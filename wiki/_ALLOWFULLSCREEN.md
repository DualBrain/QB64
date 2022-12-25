The [_ALLOWFULLSCREEN](_ALLOWFULLSCREEN) statement allows setting the behavior of the ALT+ENTER combo.

## Syntax

> [_ALLOWFULLSCREEN](_ALLOWFULLSCREEN) [{_STRETCH|_SQUAREPIXELS|OFF|_ALL}][, {_SMOOTH|OFF|_ALL}]

## Description

* Calling the statement with no parameters enables all four possible full screen modes (and is the default state when a program is started): both [_STRETCH](_STRETCH) ([_SMOOTH](_SMOOTH) and _OFF) and [_SQUAREPIXELS](_SQUAREPIXELS) ([_SMOOTH](_SMOOTH) and _OFF).
  * Using [_ALLOWFULLSCREEN](_ALLOWFULLSCREEN) _ALL, _ALL has the same effect.
* [_ALLOWFULLSCREEN](_ALLOWFULLSCREEN) only affects the behavior of ALT+ENTER. The [_FULLSCREEN](_FULLSCREEN) statement is not bound by [_ALLOWFULLSCREEN](_ALLOWFULLSCREEN)'s settings so all modes can be accessed programmatically.
* To limit just the mode but allow both _SMOOTH + _OFF antialiasing modes, pass just the first parameter: *Example:* [_ALLOWFULLSCREEN](_ALLOWFULLSCREEN) _SQUAREPIXELS
* To allow multiple modes with _SMOOTH or _OFF as default, pass just the second parameter. *Example:* [_ALLOWFULLSCREEN](_ALLOWFULLSCREEN) , _SMOOTH
* Any possible permutation of the parameters is allowed.
* With [_ALLOWFULLSCREEN](_ALLOWFULLSCREEN) _OFF you can trap Alt+Enter manually in your program and reassign it. See example 2 below.

## Availability

* Version 1.3 and up.

## Example(s)

Allowing only one full-screen mode with square pixels and no anti-aliasing:

```vb

_ALLOWFULLSCREEN _SQUAREPIXELS, OFF

```

Disabling _FULLSCREEN with Alt+ENTER so the combo can be manually trapped:

```vb

DO
    CLS

    LOCATE 7
    PRINT "    - Press ALT+ENTER to test trapping the combo..."
    PRINT "    _ Press SPACEBAR to allow fullscreen again..."

    k& = _KEYHIT

    IF k& = 13 THEN
        IF _KEYDOWN(100307) OR _KEYDOWN(100308) THEN
            altEnter = altEnter + 1
        END IF
    ELSEIF k& = 32 THEN
        fullscreenEnabled = NOT fullscreenEnabled
    END IF

    LOCATE 14
    IF fullscreenEnabled THEN
        _ALLOWFULLSCREEN _ALL, _ALL
        altEnter = 0
        PRINT "_ALLOWFULLSCREEN _ALL, _ALL"

        LOCATE 18
        PRINT "ALT+ENTER will trigger all four fullscreen modes now."
    ELSE
        _ALLOWFULLSCREEN OFF
        PRINT "_ALLOWFULLSCREEN OFF"
    END IF

    IF altEnter THEN
        LOCATE 18
        PRINT "ALT+ENTER manually trapped"; altEnter; "times."
    END IF

    _DISPLAY
    _LIMIT 30
LOOP

```

## See Also

* [_FULLSCREEN](_FULLSCREEN), [_SMOOTH (function)](_SMOOTH-(function))
