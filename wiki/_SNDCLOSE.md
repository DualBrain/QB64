The [_SNDCLOSE](_SNDCLOSE) statement frees and unloads an open sound using a [_SNDOPEN](_SNDOPEN) or [_SNDCOPY](_SNDCOPY) handle.

## Syntax

> [_SNDCLOSE](_SNDCLOSE) handle&

## Description

* If the sound is still playing, it will be freed automatically after it finishes.
  * Closing a looping/paused/etc. sound means it is never freed until the QB64 program terminates.
* When your QB64 program terminates, all sounds are automatically freed.

## See Also

* [_SNDSTOP](_SNDSTOP), [_SNDPAUSE](_SNDPAUSE)
