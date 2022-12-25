The [_SNDPLAYFILE](_SNDPLAYFILE) statement is used to play a sound file without generating a handle, automatically closing it after playback finishes.

## Syntax

> [_SNDPLAYFILE](_SNDPLAYFILE) filename$[, ignored%][, volume!]

## Description

* Supported file formats are **WAV, OGG and MP3**. See [_SNDOPEN](_SNDOPEN).
* ignored% is an optional parameter , accepted for historical reasons.
  * In versions prior to **build 20170811/60**, ignored% identified if a sound was to be loaded with [_SNDOPEN](_SNDOPEN), (-1 for true, 0 for false). This is true for all sound files in the latest versions, making this parameter safe to be ignored.
* volume! is a [SINGLE](SINGLE) value from 0 (silence) to 1 (full volume). If not used or outside this range, the sound will be played at full volume.
* [_SNDPLAYFILE](_SNDPLAYFILE) never creates an error. If the sound cannot be played it takes no further action.
* The sound is closed automatically after it finishes playing.
* When a sound will be used often, open the file with [_SNDOPEN](_SNDOPEN) and use [_SNDPLAYCOPY](_SNDPLAYCOPY) to play the handle instead to reduce the burden on the computer.

## Example(s)

Playing a sound file at half volume.

```vb

_SNDPLAYFILE "dog.wav", , .5 

```

## See Also

* [_SNDOPEN](_SNDOPEN), [_SNDPLAY](_SNDPLAY)
* [_SNDPLAYCOPY](_SNDPLAYCOPY)
