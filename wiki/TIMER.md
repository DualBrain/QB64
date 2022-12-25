The **TIMER** function returns the number of seconds past the previous midnite down to an accuracy of 1/18th of a second. 

## QB Syntax 

> seconds! = TIMER

##  QB64 Syntax 

> seconds# = TIMER[(*accuracy!*)]

* TIMER return values range from 0 at midnight to 86399! A comparison value must stay within that range!
* [INTEGER](INTEGER) or [LONG](LONG) second values range from 0 at midnight to 86399 seconds each day.
* QBasic can return [SINGLE](SINGLE) values down to about .04 or 1/18th (one tick) of a second accurately. 
* **QB64** can read [DOUBLE](DOUBLE) *accuracy* down to 1 millisecond. Example: start# = TIMER(.001) 
* Use [DOUBLE](DOUBLE) variables for millisecond accuracy as [SINGLE](SINGLE) values are only accurate to 100ths of a second later in the day!
* TIMER loops should use a midnight adjustment to avoid non-ending loops in QBasic.
* TIMER can also be used for timing program Events. See [ON TIMER(n)](ON-TIMER(n)) or the [TIMER (statement)](TIMER-(statement))
* **QB64** can use a [_DELAY](_DELAY) down to .001(one millisecond) or [_LIMIT](_LIMIT) loops per second. Both help limit program CPU usage.

## Example(s)

Delay SUB with a midnight correction for when TIMER returns to 0. **QB64** can use [_DELAY](_DELAY) for delays down to .001.

```vb

DO
  PRINT "Hello";
  Delay .5  'accuracy down to .05 seconds or 1/18th of a second in QBasic
  PRINT "World!";
LOOP UNTIL INKEY$ = CHR$(27) 'escape key exit

END

SUB Delay (dlay!)
start! = TIMER
DO WHILE start! + dlay! >= TIMER
  IF start! > TIMER THEN start! = start! - 86400
LOOP
END SUB 

```

> *Explanation:* When the delay time is added to the present TIMER value, it could be over the maximum number of 86399 seconds. So when TIMER becomes less than start it has reached midnight. The delay value then must be corrected by subtracting 86400.

Looping one TIMER tick of 1/18th of a second (ticks per second can be changed)

```vb

DEF SEG = 0 ' set to PEEK and POKE TIMER Ticks
DO ' main program loop
  ' program code
  POKE 1132, 0 ' zero Timer ticks
  DO ' delay loop
    x% = PEEK(1132)
    IF x% <> px% THEN PRINT x%;
    px% = x%
  LOOP UNTIL x% >= 18 '18 ticks in one second
  PRINT "code " ' program code
LOOP UNTIL INKEY$ = CHR$(27)
DEF SEG ' reset segment to default

END 

```

```text

 0  1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18 code
 0  1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18 code
 0  1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18 code

```

> *Explanation:* The [POKE](POKE) before the delay loop sets the tick count to 0. The [PEEK](PEEK) count increases until the tick count returns 18 ticks and ends the loop. The same thing could be approximated by using a delay loop with: second! = **TIMER** + 1

Using a [DOUBLE](DOUBLE) variable for [TIMER](TIMER)(.001) millisecond accuracy in **QB64** throughout the day.

```vb

 ts! = TIMER(.001)     'single variable
 td# = TIMER(.001)     'double variable

 PRINT "Single ="; ts!
 PRINT "Double ="; td# 

```

```text

 Single = 77073.09
 Double = 77073.094 

```

> *Explanation:* [SINGLE](SINGLE) variables will cut off the millisecond accuracy returned so [DOUBLE](DOUBLE) variables should be used. TIMER values will also exceed [INTEGER](INTEGER) limits. When displaying TIMER values, use [LONG](LONG) for seconds and [DOUBLE](DOUBLE) for milliseconds.

## See Also

* [_DELAY](_DELAY), [_LIMIT](_LIMIT), [SLEEP](SLEEP)   
* [RANDOMIZE](RANDOMIZE), [Scancodes](Scancodes)(example)
* [ON TIMER(n)](ON-TIMER(n)), [TIMER (statement)](TIMER-(statement))
