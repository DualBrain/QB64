The [_SNDOPEN](_SNDOPEN) function loads a sound file into memory and returns a [LONG](LONG) handle value above 0.

## Syntax

> soundHandle& = [_SNDOPEN](_SNDOPEN)(fileName$)

## Description

* Returns a [LONG](LONG) soundHandle& value to the sound file in memory. **A zero value means the sound could not be loaded.**
* The literal or variable [STRING](STRING) sound fileName$ can be **WAV, OGG or MP3** file types.
* **Always check the handle value returned is greater than zero before attempting to play the sound.**
  * Make sure the variable is set to 0 before using _SNDOPEN.
* The handle can be used by most of the _SND sound playing functions and statements in QB64 except [_SNDPLAYFILE](_SNDPLAYFILE) which plays a sound file directly from the disk and does not use a handle value.
* Handles can be closed with [_SNDCLOSE](_SNDCLOSE) when the sound is no longer necessary. 
* If a WAV sound file won't play, try it using the Windows [Windows Libraries](Windows-Libraries) to check it or convert the sound file to OGG.
* The raw audio data can be accessed with [_MEMSOUND](_MEMSOUND).

## Example(s)

Loading a sound file to use in the program later. Only load it once and use the handle any time you want.

```vb

h& = _SNDOPEN("dog.wav")
IF h& = 0 THEN BEEP ELSE _SNDPLAY h&      'check for valid handle before using!

```

Playing a sound from 2 different speakers based on program results.

```vb

Laff& = _SNDOPEN("KONGlaff.ogg") 'load sound file and get LONG handle value 
IF LaffX! < -1 THEN LaffX! = -1   'set full volume to left speaker
IF LaffX! > 1 THEN LaffX! = 1     'set full volume to right speaker

_SNDBAL Laff&, LaffX!             'balance sound to left or right speaker
_SNDPLAY Laff&                    'play sound 

```

Playing a file and controlling playback:

```vb

s& = _SNDOPEN("song.ogg")
PRINT "READY"; s&
_SNDPLAY s&
_SNDLOOP s&

xleft = -1
xright = 1
DO
    k$ = INKEY$
    SELECT CASE k$
        CASE "f"
            xleft = xleft - 0.1
            _SNDBAL s&, xleft, , , 1
        CASE "g"
            xleft = xleft + 0.1
            _SNDBAL s&, xleft, , , 1
        CASE "h"
            xright = xright - 0.1
            _SNDBAL s&, xright, , , 2
        CASE "j"
            xright = xright + 0.1
            _SNDBAL s&, xright, , , 2
        CASE "n"
            volume = volume - 0.1
            _SNDVOL s&, volume
        CASE "m"
            volume = volume + 0.1
            _SNDVOL s&, volume
        CASE "p"
            _SNDPAUSE s&
        CASE " "
            _SNDPLAY s&
        CASE "i"
            PRINT _SNDPLAYING(s&)
            PRINT _SNDPAUSED(s&)
            SLEEP
        CASE "b"
            _SNDSETPOS s&, 110
        CASE "l"
            _SNDLIMIT s&, 10
            PRINT "LIM"
            SLEEP
        CASE "k"
            _SNDSTOP s&
        CASE "c"
            _SNDCLOSE s&
            SLEEP
            s2& = _SNDOPEN("song.ogg")
        CASE "d"
            s2& = _SNDCOPY(s&)
            _SNDPLAY s2&
    END SELECT
    LOCATE 1, 1
    PRINT xleft, xright, volume, _SNDGETPOS(s&); "   "
LOOP

```

## See Also

* [_SNDCLOSE](_SNDCLOSE), [_SNDPLAY](_SNDPLAY), [_SNDSTOP](_SNDSTOP)
* [_SNDPAUSE](_SNDPAUSE), [_SNDLOOP](_SNDLOOP), [_SNDLIMIT](_SNDLIMIT)
* [_SNDSETPOS](_SNDSETPOS), [_SNDGETPOS](_SNDGETPOS)
* [_SNDPLAYING](_SNDPLAYING), [_SNDPAUSED](_SNDPAUSED)
* [_SNDCOPY](_SNDCOPY), [_SNDPLAYCOPY](_SNDPLAYCOPY)
* [_SNDBAL](_SNDBAL), [_SNDLEN](_SNDLEN), [_SNDVOL](_SNDVOL)
* [_SNDPLAYFILE](_SNDPLAYFILE) (plays a named sound file directly and closes)
* [_SNDRAW](_SNDRAW), [_SNDRATE](_SNDRATE), [_SNDRAWLEN](_SNDRAWLEN) (raw sounds without files)
* [_MEMSOUND](_MEMSOUND)
