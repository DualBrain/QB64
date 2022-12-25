The [_BLINK](_BLINK) statement toggles blinking colors in text mode (SCREEN 0). Default state is ON.

## Syntax

> [_BLINK](_BLINK) {ON|OFF}

## Description

* SCREEN 0 emulates the VGA palette with regular colors from 0 to 15 and blinking colors from 16-31 (these are the same colors as 0-15, except their blink attribute is set to on). [_BLINK](_BLINK) OFF emulates writing to the video memory and disabling blinking for colors 16-31.
* Using colors 16-31 for the foreground with [_BLINK](_BLINK) set to OFF will produce high intensity background colors.
* [_BLINK](_BLINK) is only effective in SCREEN 0. It's ignored in graphic modes.
* IF [_DISPLAY](_DISPLAY) is used, blinking is disabled, even if _BLINK is ON, but high intensity backgrounds aren't enabled in this case.

## Availability

* Build 20170816/61 up (August 16, 2017).

## Example(s)

```vb

COLOR 16, 7
PRINT "This is printed in black over gray background. Black letters are blinking."
PRINT "Hit a key..."
SLEEP
_BLINK OFF
PRINT "Now the same text is printed in black over bright white, because blinking was disabled."

```

## See Also

* [_BLINK (function)](_BLINK-(function))
* [OUT](OUT)
* [_DISPLAY](_DISPLAY)
