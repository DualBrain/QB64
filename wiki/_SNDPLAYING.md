The [_SNDPLAYING](_SNDPLAYING) function returns whether a sound is being played. Uses a handle from the [_SNDOPEN](_SNDOPEN) or [_SNDCOPY](_SNDCOPY) functions.

## Syntax

> isPlaying% = [_SNDPLAYING](_SNDPLAYING)(handle&)

## Description

* Returns false (0) if a sound is not playing or true (-1) if it is.
* If a sound is paused, [_SNDPLAYING](_SNDPLAYING) returns 0.

## Example(s)

```vb

PRINT _SNDPLAYING(h&) 

```

## See Also

* [_SNDPLAY](_SNDPLAY), [_SNDPAUSE](_SNDPAUSE), [_SNDSTOP](_SNDSTOP)
* [_SNDPAUSED](_SNDPAUSED)
