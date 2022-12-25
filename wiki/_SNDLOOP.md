The [_SNDLOOP](_SNDLOOP) statement is like [_SNDPLAY](_SNDPLAY) but the sound is looped. Uses a handle from the [_SNDOPEN](_SNDOPEN) function.

## Syntax

> [_SNDLOOP](_SNDLOOP) handle&

## Description

* Plays the sound identified by handle& in a loop.

## Example(s)

Loading a sound or music file and playing it in a loop until a key is pressed.

```vb

bg = _SNDOPEN("back.ogg") '<<<<<<<<<< change to your sound file name
_SNDLOOP bg

DO
    _LIMIT 10   'keep CPU resources used low
LOOP UNTIL INKEY$ <> "" 'key press program exit
_SNDSTOP bg
_SNDCLOSE bg 

```

## See Also

* [_SNDOPEN](_SNDOPEN), [_SNDSTOP](_SNDSTOP)
