The [_SNDSETPOS](_SNDSETPOS) statement changes the current/starting playing position in seconds of a sound.

## Syntax

> [_SNDSETPOS](_SNDSETPOS) handle&, position!

## Description

* Changes the current/starting playing position in seconds (a [SINGLE](SINGLE) value) of a sound in memory.
* If position! is past the length of the sound, playback will be interrupted.
* Function cannot be called while a looping sound is being played (see [_SNDLOOP](_SNDLOOP)).
* In versions **prior to build 20170811/60**, the sound identified by handle& must have been opened using the [_SNDOPEN](_SNDOPEN) to use this statement.

## Example(s)

To check the current playing position in an MP3 file, use [_SNDPLAY](_SNDPLAY) with [_SNDGETPOS](_SNDGETPOS) printed in a loop

```vb

SoundFile& = _SNDOPEN("YourSoundFile.mp3") '<<< your MP3 sound file here!
_SNDSETPOS SoundFile&, 5.5   'set to play sound 5 1/2 seconds into music 
_SNDPLAY SoundFile&  'play sound 
Do: _LIMIT 60     
   LOCATE 5, 2: PRINT "Current play position> "; _SNDGETPOS(SoundFile&)
LOOP UNTIL _KEYDOWN(27) OR NOT _SNDPLAYING(SoundFile&) 'ESC or end of sound exit

```

## See Also

* [_SNDGETPOS](_SNDGETPOS), [_SNDLEN](_SNDLEN) 
* [_SNDOPEN](_SNDOPEN), [_SNDLIMIT](_SNDLIMIT)
