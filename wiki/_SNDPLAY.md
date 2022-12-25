The [_SNDPLAY](_SNDPLAY) statement plays a sound designated by a file handle created by [_SNDOPEN](_SNDOPEN).

## Syntax

> [_SNDPLAY](_SNDPLAY) handle&

## Description

* Make sure that the handle& value is not 0 before attempting to play it.

## Example(s)

Checking a handle value before playing

```vb

IF h& THEN _SNDPLAY h& 

```

## See Also

* [_SNDOPEN](_SNDOPEN), [_SNDPAUSE](_SNDPAUSE), [_SNDPLAYING](_SNDPLAYING)
