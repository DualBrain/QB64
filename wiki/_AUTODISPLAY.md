The [_AUTODISPLAY](_AUTODISPLAY) statement enables the automatic display of the screen image changes previously disabled by [_DISPLAY](_DISPLAY).

## Syntax

> [_AUTODISPLAY](_AUTODISPLAY)

## Description

* [_AUTODISPLAY](_AUTODISPLAY) is on by default and displays the screen at around 30 frames per second (normal vertical retrace speed).
* [_DISPLAY](_DISPLAY) disables automatic graphic displays, but it also eliminates having to use PCOPY or page flipping when used correctly. Placing _DISPLAY after screen draws or other screen changes assures completion of the changes before they are displayed. The speed of QB64 code execution makes this a viable option. 
* The [_AUTODISPLAY (function)](_AUTODISPLAY-(function)) can be used to detect the current display behavior.

## See Also

* [_DISPLAY](_DISPLAY)
* [_AUTODISPLAY (function)](_AUTODISPLAY-(function))
