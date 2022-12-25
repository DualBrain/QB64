The [_SNDPAUSE](_SNDPAUSE) statement pauses a sound using a handle from the [_SNDOPEN](_SNDOPEN) function.

## Syntax

> [_SNDPAUSE](_SNDPAUSE) handle&

## Description

* Continue playing by calling [_SNDPLAY](_SNDPLAY) handle&
* In versions **prior to build 20170811/60**, the sound identified by handle& must have been opened using the [_SNDOPEN](_SNDOPEN) to use this function.

## See Also

* [_SNDPLAY](_SNDPLAY), [_SNDSTOP](_SNDSTOP)
* [_SNDPAUSED](_SNDPAUSED)
