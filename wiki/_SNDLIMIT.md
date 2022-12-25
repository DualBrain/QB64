The [_SNDLIMIT](_SNDLIMIT) statement stops playing a sound after it has been playing for a set number of seconds. 

## Syntax

> [_SNDLIMIT](_SNDLIMIT) handle&, numberOfSeconds!

## Parameter(s)

* The handle& variable name is created using the [_SNDOPEN](_SNDOPEN) function from a loaded sound file.
* numberOfSeconds! is a [SINGLE](SINGLE) value of seconds that the sound will play.

## Description

* Sets how long a sound will be played in seconds. If the limit is set after the sound is started, the timer starts counting down from when the limit is applied, not from the start of playing.
* Set numberOfSeconds! to 0 seconds to remove the limit.
* Pausing or stopping the sound will also remove the limit.

## Example(s)

```vb

_SNDLIMIT h&, 5.5 

```

## See Also

* [_SNDOPEN](_SNDOPEN), [_SNDLEN](_SNDLEN)
