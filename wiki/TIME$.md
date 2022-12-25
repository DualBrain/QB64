The **TIME$** Function returns a [STRING](STRING) representation of the current computer time in a 24 hour format.

## Syntax

> PRINT "Present time = "; **TIME$**

* Returns the present computer time in hh:mm:ss 24 hour format: "19:20:33"
* Uses 2 colon (:) separators between hours, minutes and seconds
* Hour values range from "00" to "23" starting from midnite.
* Minutes and seconds range from "00" to "59"
* Continuous TIME$ calls may lag if a QBasic program is minimized to the taskbar!

## Example(s)

A simple clock using [DRAW](DRAW) with Turn Angle.

```vb

SCREEN 12
DO
  CLS
  t$ = TIME$: h = VAL(t$): m = VAL(MID$(t$, 4, 2)): s = VAL(MID$(t$, 7, 2))
  PRINT t$
  CIRCLE STEP(0, 0), 200, 8
  DRAW "c12ta" + STR$((h MOD 12) * -30) + "nu133"
  DRAW "c14ta" + STR$(m * -6) + "nu200"
  DRAW "c9ta" + STR$(s * -6) + "nu200"
  _DISPLAY
  _LIMIT 1
LOOP UNTIL INKEY$ = CHR$(27) 

```


> Explanation: Note that [VAL](VAL)(TIME$) can just return the hour number 0 to 23 as the read stops at the first colon.

The following Function converts TIME$ to normal 12 hour AM-PM digital clock  format.

```vb

PRINT TIME$
PRINT Clock$

FUNCTION Clock$
  hour$ = LEFT$(TIME$, 2): H% = VAL(hour$)
  min$ = MID$(TIME$, 3, 3)   
  IF H% >= 12 THEN ampm$ = " PM" ELSE ampm$ = " AM" 
  IF H% > 12 THEN
    IF H% - 12 < 10 THEN hour$ = STR$(H% - 12) ELSE hour$ = LTRIM$(STR$(H% - 12))
  ELSEIF H% = 0 THEN hour$ = "12"          ' midnight hour
  ELSE : IF H% < 10 THEN hour$ = STR$(H%)  ' eliminate leading zeros   
  END IF  
  Clock$ = hour$ + min$ + ampm$
END FUNCTION 

```

```text

14:13:36
 2:13 PM

```

> *Explanation:* When hours are less than 10 (but not 0), STR$(H%) alone keeps a space ahead of the hour. For 2 digit hours, LTRIM$ is used to remove that leading space. For the hours of 10 AM to 12 PM, the hour STRING value is passed from LEFT$(TIME$, 2) at the beginning of the function.

## See Also

* [TIMER](TIMER)
* [DATE$](DATE$)
* [VAL](VAL), [STR$](STR$), [HEX$](HEX$) 
* [LTRIM$](LTRIM$), [MID$](MID$), [LEFT$](LEFT$)
* [IF...THEN](IF...THEN)
