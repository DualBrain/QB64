The [_SNDPAUSED](_SNDPAUSED) function checks if a sound is paused. Uses a handle parameter passed from [_SNDOPEN](_SNDOPEN).

## Syntax

> isPaused%% = [_SNDPAUSED](_SNDPAUSED)(handle&)

## Description

* Returns true (-1) if the sound is paused. False (0) if not paused.

## Example(s)

```vb

PRINT _SNDPAUSED(h&) 

```

## See Also

* [_SNDPAUSE](_SNDPAUSE), [_SNDPLAY](_SNDPLAY), 
* [_SNDSTOP](_SNDSTOP)
