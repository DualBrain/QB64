The [BEEP](BEEP) statement produces a beep sound through the sound card.

## Syntax

> [BEEP](BEEP)

## Description

* [BEEP](BEEP) can be placed anywhere to alert the user that there is something to do or an error has occurred.
* **QB64** produces the actual "beep" sound through the PC's sound card, to emulate QBasic's beeping through the [PC speaker](https://en.wikipedia.org/wiki/PC_speaker).

## QBasic

* Older programs may attempt to produce a BEEP by printing [CHR$](CHR$)(7) to the screen. This is no longer supported in QB64 after **version 1.000**.
* You may have to replace instances of PRINT CHR$(7) in older programs to the [BEEP](BEEP) statement to maintain the legacy functionality.

## See Also

* [SOUND](SOUND), [PLAY](PLAY)
* [_SNDPLAY](_SNDPLAY) (play sound files)
* [_SNDRAW](_SNDRAW) (play frequency waves)
