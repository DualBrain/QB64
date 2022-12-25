The [_SNDRAWLEN](_SNDRAWLEN) function returns the length, in seconds, of a [_SNDRAW](_SNDRAW) sound currently queued.

## Syntax

> length# = [_SNDRAWLEN](_SNDRAWLEN) [pipeHandle&]

## Parameters

* The optional pipeHandle& parameter refers to the sound pipe opened using [_SNDOPENRAW](_SNDOPENRAW). 

## Description

* Use [_SNDRAWLEN](_SNDRAWLEN) to determine the length of a sound queue during creation and when to stop playing the sound.
* Ensure that [_SNDRAWLEN](_SNDRAWLEN) is comfortably above 0 (until you've actually finished playing sound). 
* If you are getting occasional random clicks, this generally means that [_SNDRAWLEN](_SNDRAWLEN) has dropped to 0.
* The [_SNDRATE](_SNDRATE) determines how many samples are played per second. However, the timing is achieved by the sound card and [_SNDRAWLEN](_SNDRAWLEN), not your program.
* **Do not attempt to use [_TIMER](_TIMER) or [_DELAY](_DELAY) or [_LIMIT](_LIMIT) to control the timing of [_SNDRAW](_SNDRAW) sounds. You may use them as usual for delays or to limit your program's CPU usage, but the decision of how much sound to queue should only be based on the remaining _SNDRAWLEN**.

## Example(s)

* See the example in [_SNDRAW](_SNDRAW)

## See Also

* [_SNDRAW](_SNDRAW)
* [_SNDRATE](_SNDRATE)
