The [_SNDGETPOS](_SNDGETPOS) function returns the current playing position in seconds using a handle from [_SNDOPEN](_SNDOPEN).

## Syntax

> position = [_SNDGETPOS](_SNDGETPOS)(handle&)

## Description

* Returns the current playing position in seconds from an open sound file.
* If a sound isn't playing, it returns 0.
* If a sound is paused, it returns the paused position.
* For a looping sound, the value returned continues to increment and does not reset to 0 when the sound loops.
* In versions **prior to build 20170811/60**, the sound identified by handle& must have been opened using the [_SNDOPEN](_SNDOPEN) to use this function.

## Example(s)

To check the current playing position in an MP3 file, use [_SNDPLAY](_SNDPLAY) with [_SNDGETPOS](_SNDGETPOS) printed in a loop:

```vb

SoundFile& = _SNDOPEN("YourSoundFile.mp3") '<<< your MP3 sound file here!
_SNDSETPOS SoundFile&, 5.5   'set to play sound 5 1/2 seconds into music 
_SNDPLAY SoundFile&  'play sound 
Do: _LIMIT 60     
   LOCATE 5, 2: PRINT "Current play position> "; _SNDGETPOS(SoundFile&)
LOOP UNTIL _KEYDOWN(27) OR NOT _SNDPLAYING(SoundFile&) 'ESC or end of sound exit

```

## See Also

* [_SNDSETPOS](_SNDSETPOS)
* [_SNDOPEN](_SNDOPEN)
