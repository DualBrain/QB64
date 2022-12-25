The [_SNDCOPY](_SNDCOPY) function copies a sound to a new handle so that two or more of the same sound can be played at once. The passed handle parameter is from the [_SNDOPEN](_SNDOPEN) function.

## Syntax

> copyHandle& = [_SNDCOPY](_SNDCOPY)(handle&)

## Description

* Returns a new handle to the a copy in memory of the sound data referred to by the source handle.
* No changes to the source handle (such as a volume change) are inherited.
* The sound data referred to by the handle and its copies are not freed until all of them are closed.

## See Also

* [_SNDPLAYCOPY](_SNDPLAYCOPY)
* [_SNDOPEN](_SNDOPEN)
