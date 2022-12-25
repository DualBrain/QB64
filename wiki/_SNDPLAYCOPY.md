The [_SNDPLAYCOPY](_SNDPLAYCOPY) statement copies a sound, plays it, and automatically closes the copy using a handle parameter passed from [_SNDOPEN](_SNDOPEN) or [_SNDCOPY](_SNDCOPY)

## Syntax

> [_SNDPLAYCOPY](_SNDPLAYCOPY) handle&[, volume!]

## Parameter(s)

* The [LONG](LONG) handle& value is returned by [_SNDOPEN](_SNDOPEN) using a specific sound file. 
* The volume! parameter can be any [SINGLE](SINGLE) value from 0 (no volume) to 1 (full volume).

## Description

* Makes coding easier by doing all of the following automatically:
  * #Copies/duplicates the source handle (see [_SNDCOPY](_SNDCOPY)).
  * #Changes the volume of the copy if volume is passed.
  * #Plays the copy.
  * #Closes the copy.
* This statement is a better choice than [_SNDPLAYFILE](_SNDPLAYFILE) if the sound will be played often, reducing the burden on the computer. 

## Example(s)

Playing a previously opened sound at half volume.

```vb

_SNDPLAYCOPY applause&, 0.5 

```

Playing a song at random volumes.

```vb
 
chomp& = _SNDOPEN("chomp.wav") 
_SNDPLAYCOPY chomp&, 0.5 + RND * 0.49

```

## See Also

* [_SNDOPEN](_SNDOPEN)
* [_SNDCOPY](_SNDCOPY)
* [_SNDPLAYFILE](_SNDPLAYFILE)
