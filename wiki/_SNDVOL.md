The [_SNDVOL](_SNDVOL) statement sets the volume of a sound loaded in memory using a handle from the [_SNDOPEN](_SNDOPEN) function.

## Syntax

> [_SNDVOL](_SNDVOL) handle&, volume!

## Description

* volume! is a value from 0 (silence) to 1 (full volume).
* In versions **prior to build 20170811/60**, the sound identified by handle& must have been opened using the [_SNDOPEN](_SNDOPEN) to use this function.

## Example(s)

```vb

h& = _SNDOPEN("bell.wav")
_SNDVOL h&, 0.5
_SNDPLAY h& 

```

## See Also

* [_SNDOPEN](_SNDOPEN), [_SNDBAL](_SNDBAL)
