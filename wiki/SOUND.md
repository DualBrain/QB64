**SOUND** sets frequency and duration of sounds from the internal PC speaker if the computer has one or the sound card in QB64.

## Syntax

> SOUND *frequency*, *duration*

## Description

* *Frequency* is any literal or variable value from 37 to 32767, but 0 is allowed for delays.
* *Duration* is any literal or variable number of [TIMER](TIMER) ticks with a duration of 1/18th second. 18 = one second.
* In **QB64** the sound comes from the soundcard and the volume can be adjusted through the OS.

## Error(s)

* Low *frequency* values between 0 and 37 will create an [ERROR Codes](ERROR-Codes).
* **Warning:** SOUND may not work when the program is not in focus. Use SOUND 0, 0 at sound procedure start to set focus. 
* **Note:** SOUND 0, 0 will not stop previous **QB64** sounds like it did in QBasic!
* SOUND may have clicks or pauses between the sounds generated. [PLAY](PLAY) can be used for musical sounds.

```text

        **                     The Seven Music Octaves ** 
      
        ** Note     Frequency      Note     Frequency      Note      Frequency**
       **1*** D#1 ...... 39           G3 ....... 196          A#5 ...... 932 
          E1 ....... 41           G#3 ...... 208          B5 ....... 988 
          F1 ....... 44           A3 ....... 220       **6*** C6 ....... 1047 
          F#1 ...... 46           A#3 ...... 233          C#6 ...... 1109 
          G1 ....... 49           B3 ....... 247          D6 ....... 1175 
          G#1 ...... 51        **4*** C4 ....... 262          D#6 ...... 1245 
          A1 ....... 55           C#4 ...... 277          E6 ....... 1318 
          A#1 ...... 58           D4 ....... 294          F6 ....... 1397 
          B1 ....... 62           D#4 ...... 311          F#6 ...... 1480 
       **2*** C2 ....... 65           E4 ....... 330          G6 ....... 1568 
          C#2 ...... 69           F4 ....... 349          G# ....... 1661 
          D2 ....... 73           F#4 ...... 370          A6 ....... 1760 
          D#2 ...... 78           G4 ....... 392          A#6 ...... 1865 
          E2 ....... 82           G#4 ...... 415          B6 ....... 1976 
          F2 ....... 87           A4 ....... 440       **7*** C7 ....... 2093 
          F#2 ...... 92           A# ....... 466          C#7 ...... 2217 
          G2 ....... 98           B4 ....... 494          D7 ....... 2349 
          G#2 ...... 104       **5*** C5 ....... 523          D#7 ...... 2489 
          A2 ....... 110          C#5 ...... 554          E7 ....... 2637 
          A#2 ...... 117          D5 ....... 587          F7 ....... 2794 
          B2 ....... 123          D#5 ...... 622          F#7 ...... 2960 
       **3*** C3 ....... 131          E5 ....... 659          G7 ....... 3136 
          C#3 ...... 139          F5 ....... 698          G#7 ...... 3322 
          D3 ....... 147          F#5 ...... 740          A7 ....... 3520 
          D#3 ...... 156          G5 ....... 784          A#7 ...... 3729 
          E3 ....... 165          G#5 ...... 831          B7 ....... 3951 
          F3 ....... 175          A5 ....... 880       **8*** C8 ....... 4186 
          F#3 ...... 185  
                                 **# denotes sharp**

```

## Example(s)

Playing the seven octaves based on the base note DATA * 2 ^ (octave - 1).

```vb

notes$ = "C C#D D#E F F#G G#A A#B "
COLOR 9:LOCATE 5, 20: PRINT "Select an octave (1 - 7) to play (8 quits):"
DO			
  DO: octa$ = INKEY$
    IF octa$ <> "" THEN
      IF ASC(octa$) > 48 AND ASC(octa$) < 58 THEN octave% = VAL(octa$): EXIT DO
    END IF
  LOOP UNTIL octave% > 7 
  IF octave% > 0 AND octave% < 8 THEN
    LOCATE 15, 6: PRINT SPACE$(70)
    LOCATE 16, 6: PRINT SPACE$(70)
    COLOR 14: LOCATE 15, 6: PRINT "Octave"; octave%; ":";
    RESTORE Octaves
    FOR i = 1 TO 12
      READ note!
      snd% = CINT(note! * (2 ^ (octave% - 1)))  'calculate note frequency
      COLOR 14: PRINT STR$(snd%);
      c0l = POS(0)
      COLOR 11: LOCATE 16, c0l - 2: PRINT MID$(notes$, 1 + (2 * (i - 1)), 2)
      LOCATE 15, c0l
      IF snd% > 36 THEN SOUND snd%, 12  'error if sound value is < 36
      _DELAY .8
    NEXT
  END IF
LOOP UNTIL octave% > 7 
END

Octaves:
DATA 32.7,34.65,36.71,38.9,41.2,43.65,46.25,49,51.91,55,58.27,61.74 

```


Playing a song called "Bonnie" with [SOUND](SOUND) frequencies.

```vb

SCREEN 13
_FULLSCREEN
OUT &H3C8, 0: OUT &H3C9, 0: OUT &H3C9, 0: OUT &H3C9, 20
COLOR 1
FOR i% = 1 TO 21
  LOCATE 2 + i%, 2: PRINT CHR$(178)
  LOCATE 2 + i%, 39: PRINT CHR$(178)
NEXT i%
FOR i% = 2 TO 39
  LOCATE 2, i%: PRINT CHR$(223)
  LOCATE 23, i%: PRINT CHR$(220)
NEXT i%
COLOR 9
LOCATE 3, 16: PRINT CHR$(34); "MY BONNIE"; CHR$(34)
SLEEP 3
FOR i% = 1 TO 34
  SELECT CASE i%
    CASE 1: LOCATE 5, 5
    CASE 10: LOCATE 10, 5
    CASE 18: LOCATE 15, 5
    CASE 27: LOCATE 20, 5
  END SELECT
  READ note%, duration%, word$
  SOUND note%, duration%: PRINT word$;
NEXT i%
SLEEP 2
LOCATE 23, 16: PRINT "Thank You!"
SLEEP 4
SYSTEM

DATA 392,8,"My ",659,8,"Bon-",587,8,"nie ",523,8,"lies ",587,8,"O-",523,8,"Ver ",440,8,"the "
DATA 392,8,"O-",330,32,"cean ",392,8,"My ",659,8,"Bon-",587,8,"nie ",523,8,"lies "
DATA 523,8,"O-",494,8,"ver ",523,8,"the ",587,40,"sea ",392,8,"My ",659,8,"Bon-",587,8,"nie"
DATA 523,8," lies ",587,8,"O-",523,8,"ver ",440,8,"the ",392,8,"O-",330,32,"cean ",392,8,"Oh "
DATA 440,8,"bring ",587,8,"back ",523,8,"my ",494,8,"Bon-",440,8,"nie ",494,8,"to ",523,32,"me..!" 

```


## See Also
 
* [PLAY](PLAY), [BEEP](BEEP)
* [_SNDOPEN](_SNDOPEN) (play sound files)
* [_SNDRAW](_SNDRAW)  (play frequency waves)
