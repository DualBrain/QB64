The [_MEMSOUND](_MEMSOUND) function returns a [_MEM](_MEM) value referring to a sound's raw data in memory using a designated sound handle created by the [_SNDOPEN](_SNDOPEN) function.

## Syntax

> imageBlock = [_MEMSOUND](_MEMSOUND)[(soundHandle&, channel%)]

## Parameter(s)

* The imageBlock [_MEM](_MEM) type variable holds the read-only elements .OFFSET, .SIZE, .ELEMENTSIZE, and .SOUND.
  * .ELEMENTSIZE will contain the number of bytes-per-sample the audio contains. Usually returns 2 (16-bit audio).
  * .SOUND will contain the same handle value as returned by the [_SNDOPEN](_SNDOPEN) function.
* The second parameter channel% must be 1 (left channel/mono) or 2 (right channel, for stereo files).

## Description

* Use the function to access raw sound data in memory for direct access.
* Sound handle values and the memory used must still be freed using [_SNDCLOSE](_SNDCLOSE) when no longer required.
* If .SIZE returns 0, that means the data could not be accessed. It may happen if you try to access the right channel in a mono file, for example.

## Availability

* Version 1.5 and up.

## Example(s)

Checking that a sound file is stereo.

```vb

song& = _SNDOPEN("song.wav") 'replace song.wav with a sound file you have
IF song& = 0 THEN PRINT "Load failed.": END

DIM leftchannel AS _MEM, rightchannel AS _MEM
leftchannel = _MEMSOUND(song&, 1)
rightchannel = _MEMSOUND(song&, 2)

IF rightchannel.SIZE > 0 THEN PRINT "This file is STEREO"
IF rightchannel.SIZE = 0 AND leftchannel.SIZE > 0 THEN
    PRINT "This file is MONO"
ELSEIF rightchannel.SIZE = 0 AND leftchannel.SIZE = 0 THEN
    PRINT "An error occurred."
END IF

_SNDCLOSE song& 'closing the sound releases the mem blocks

```

Plotting a sound's waves.

```vb

SCREEN _NEWIMAGE(800, 327, 32)
song& = _SNDOPEN("drums.ogg") 'replace drums.ogg with a sound file you have
IF song& = 0 THEN PRINT "Load failed.": END

DIM leftchannel AS _MEM
leftchannel = _MEMSOUND(song&, 1)

IF leftchannel.SIZE = 0 THEN
    PRINT "An error occurred."
    END
END IF

DIM i AS _OFFSET
i = 0
DO
    _MEMGET leftchannel, leftchannel.OFFSET + i, a% 'get sound data
    LOCATE 1, 1: PRINT i; "/"; leftchannel.SIZE
    LINE (x, _HEIGHT / 2)-STEP(0, a% / 100), _RGB32(0, 111, 0) 'plot wave
    x = x + 1
    IF x > _WIDTH THEN
        x = 0
        LINE (0, 0)-(_WIDTH, _HEIGHT), _RGB32(0, 120), BF 'fade out screen
    END IF
    i = i + 2
    IF i + 2 > leftchannel.SIZE THEN EXIT DO
    _LIMIT 500
LOOP

_SNDCLOSE song& 'closing the sound releases the mem blocks

```

## See Also

* [_MEM](_MEM), [_MEMIMAGE](_MEMIMAGE)
* [_MEMNEW](_MEMNEW)
* [_MEMGET](_MEMGET), [_MEMPUT](_MEMPUT)
* [_MEMFREE](_MEMFREE)
* [$CHECKING]($CHECKING)
