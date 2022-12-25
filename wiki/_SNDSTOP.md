The [_SNDSTOP](_SNDSTOP) statement stops a playing or paused sound using a handle from the [_SNDOPEN](_SNDOPEN) or [_SNDCOPY](_SNDCOPY) functions.

## Syntax

> [_SNDSTOP](_SNDSTOP) handle&

## Description

* Sounds can be resumed using [_SNDPLAY](_SNDPLAY) with the correct handle.

## Example(s)

```vb

_SNDSTOP h& 

```

## See Also

* [_SNDPAUSE](_SNDPAUSE)
