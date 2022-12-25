The [_AUTODISPLAY (function)](_AUTODISPLAY-(function)) function returns the current display mode as true (-1) if automatic or false (0) if disabled using [_DISPLAY](_DISPLAY).

## Syntax

>  displayStatus%% = [_AUTODISPLAY (function)](_AUTODISPLAY-(function))

## Description

* The function returns true (-1) if [_AUTODISPLAY](_AUTODISPLAY) is enabled. This is the default state and indicates that every screen change (text or graphics) is displayed immediately to the user.
* If [_DISPLAY](_DISPLAY) is used, then [_AUTODISPLAY (function)](_AUTODISPLAY-(function)) returns 0, to indicate that screen changes (text or graphics) are only displayed per request, by calling [_DISPLAY](_DISPLAY) again to refresh the screen.

## Availability

* Build 20170924/69 and up.

## See Also

* [_AUTODISPLAY](_AUTODISPLAY)
* [_DISPLAY](_DISPLAY)
