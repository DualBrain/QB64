The [_SNDRAW](_SNDRAW) statement plays sound wave sample frequencies created by a program. 

## Syntax

> [_SNDRAW](_SNDRAW) leftSample[, rightSample][, pipeHandle&]

## Parameter(s)

* The leftSample and rightSample value(s) can be any [SINGLE](SINGLE) or [DOUBLE](DOUBLE) literal or variable frequency value from -1.0 to 1.0.
* The pipeHandle& parameter refers to the sound pipe opened using [_SNDOPENRAW](_SNDOPENRAW). 

## Description

* Specifying pipeHandle& allows sound to be played through two or more channels at the same time (**version 1.000 and up**).
* If only leftSample value is used, the sound will come out of both speakers.
* Using _SNDRAW will pause any currently playing music.
* _SNDRAW is designed for continuous play. It will not produce any sound until a significant number of samples have been queued. No sound is played if only a few samples are queued.
* Ensure that [_SNDRAWLEN](_SNDRAWLEN) is comfortably above 0 (until you've actually finished playing sound). If you are getting occasional unintended random clicks, this generally means that [_SNDRAWLEN](_SNDRAWLEN) has dropped to 0.
* _SNDRAW is not intended to queue up many minutes worth of sound. It will probably work but will chew up a lot of memory (and if it gets swapped to disk, your sound could be interrupted abruptly).
* [_SNDRATE](_SNDRATE) determines how many samples are played per second, but timing is done by the sound card, not your program. 
* **Do not attempt to use [_TIMER](_TIMER) or [_DELAY](_DELAY) or [_LIMIT](_LIMIT) to control the timing of _SNDRAW. You may use them for delays or to limit your program's CPU usage, but how much to queue should only be based on the [_SNDRAWLEN](_SNDRAWLEN).**

## Example(s)

Sound using a sine wave with _SNDRAW Amplitude * SIN(8 * ATN(1) * Duration * (Frequency / _SNDRATE))

```vb

FREQ = 400                             'any frequency desired from 36 to 10,000
Pi2 = 8 * ATN(1)                       '2 * pi 
Amplitude = .3                         'amplitude of the signal from -1.0 to 1.0
SampleRate = _SNDRATE                  'sets the sample rate
FRate = FREQ / SampleRate'
FOR Duration = 0 TO 5 * SampleRate     'play 5 seconds
        _SNDRAW Amplitude * SIN(Pi2 * Duration * FRate)            'sine wave
       '_SNDRAW Amplitude * SGN(SIN(Pi2 * Duration * FRate))       'square wave
NEXT
DO: LOOP WHILE _SNDRAWLEN
END 

```

> *Explanation:* The loop Duration is determined by the number of seconds times the [_SNDRATE](_SNDRATE) number of samples per second. Square waves can use the same formula with Amplitude * [SGN](SGN)(SIN(8 * ATN(1) * Duration * (Frequency/_SNDRATE))).

A simple ringing bell tone that tapers off.

```vb

t = 0
tmp$ = "Sample = ##.#####   Time = ##.#####"
LOCATE 1, 60: PRINT "Rate:"; _SNDRATE
DO
  'queue some sound
  DO WHILE _SNDRAWLEN < 0.1             'you may wish to adjust this    
    sample = SIN(t * 440 * ATN(1) * 8)  '440Hz sine wave (t * 440 * 2π)   
    sample = sample * EXP(-t * 3)       'fade out eliminates clicks after sound
    _SNDRAW sample
    t = t + 1 / _SNDRATE                'sound card sample frequency determines time
  LOOP

  'do other stuff, but it may interrupt sound
  LOCATE 1, 1: PRINT USING tmp$; sample; t
LOOP WHILE t < 3.0                      'play for 3 seconds

DO WHILE _SNDRAWLEN > 0                 'Finish any left over queued sound!
LOOP
END 

```

Routine uses _SNDRAW to display and play 12 notes from octaves 1 through 9.

```vb

DIM SHARED rate&
rate& = _SNDRATE
DO
  PRINT "Enter the octave 1 to 8 (0 quits!):";
  oct% = VAL(INPUT$(1)): PRINT oct%
  IF oct% = 0 THEN EXIT DO
  octave = oct% - 4 '440 is in the 4th octave, 9th note
  COLOR oct% + 1
  PRINT USING "Octave: ##"; oct%
  FOR Note = 0 TO 11  'notes C to B
    fq = FreQ(octave, Note, note$)
    PRINT USING "#####.## \\"; fq, note$
    PlaySound fq
    IF INKEY$ > "" THEN EXIT DO
  NEXT
LOOP
END

FUNCTION FreQ (octave, note, note$)
FreQ = 440 * 2 ^ (octave + (note + 3) / 12 - 1) '* 12 note octave starts at C (3 notes up)
note$ = MID$("C C#D D#E F F#G G#A A#B ", note * 2 + 1, 2)
END FUNCTION

SUB PlaySound (frq!)    ' plays sine wave fading in and out
SndLoop! = 0
DO WHILE SndLoop! < rate&
  _SNDRAW SIN((2 * 4 * ATN(1) * SndLoop! / rate&) * frq!) * EXP(-(SndLoop! / rate&) * 3)
  SndLoop! = SndLoop! + 1
LOOP
DO: LOOP WHILE _SNDRAWLEN   'flush the sound playing buffer
END SUB 

```

## See Also

* [_SNDRATE](_SNDRATE), [_SNDRAWLEN](_SNDRAWLEN)
* [_SNDOPENRAW](_SNDOPENRAW), [_SNDRAWDONE](_SNDRAWDONE)
* [_SNDOPEN](_SNDOPEN)
* [PLAY](PLAY), [BEEP](BEEP)
* Music Frequency table in [SOUND](SOUND).
* [DTMF Phone Demo](DTMF-Phone-Demo)
