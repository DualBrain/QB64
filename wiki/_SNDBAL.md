The [_SNDBAL](_SNDBAL) statement attempts to set the balance or 3D position of a sound.

## Syntax

> [_SNDBAL](_SNDBAL) handle&[, x!][, y!][, z!][, channel&]]

## Parameter(s)

* *handle&* is a valid sound handle created by the [_SNDOPEN](_SNDOPEN) function.
* x! distance values go from left (negative) to right (positive).
* y! distance values go from below (negative) to above (positive).
* z! distance values go from behind (negative) to in front (positive).
* channel& value 1 denotes left (mono) and 2 denotes right (stereo) channel (beginning with **build 20170811/60**)

## Description

* Attempts to position a sound in 3D space, or as close to it as the underlying software libraries allow. In some cases, this will be true 3D positioning, in others, a mere volume adjustment based on distance alone.
* Omitted x!, y! or z! [SINGLE](SINGLE) values are set to 0 or not changed in **build 20170811/60 onward**.
* By setting the x! value to -1 or 1 it plays the sound at full volume from the appropriate speaker.
* Sounds at a distance of 1 or -1 are played at full volume. Sounds further than a distance of 1000 cannot be heard.
* The volume decreases linearly (at a constant gradient) over distance. Half volume = 500.
* An "**Illegal Function Call**" error can occur if another sound is using the primary or same channel position.
* Opened sound files must have the [_SNDOPEN](_SNDOPEN) capability to use this statement in versions **before build 20170811/60.**

## Example(s)

```vb

h& = _SNDOPEN("LOL.wav", "SYNC,VOL")
_SNDBAL h&, 1
_SNDPLAY h& 

```

Loading a sound after **build 20170811/60** - no need to specify "sound capabilities" in [_SNDOPEN](_SNDOPEN). 

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

* [_SNDOPEN](_SNDOPEN), [_SNDVOL](_SNDVOL), [_SNDLIMIT](_SNDLIMIT)
