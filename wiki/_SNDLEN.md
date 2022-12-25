The [_SNDLEN](_SNDLEN) function returns the length in seconds of a loaded sound using a handle from the [_SNDOPEN](_SNDOPEN) function.

## Syntax

> soundLength = [_SNDLEN](_SNDLEN)(handle&)

## Description

* Returns the length of a sound in seconds.
* In versions **prior to build 20170811/60**, the sound identified by handle& must have been opened using the [_SNDOPEN](_SNDOPEN) to use this function.

## See Also

* [_SNDCOPY](_SNDCOPY), [_SNDLIMIT](_SNDLIMIT)
