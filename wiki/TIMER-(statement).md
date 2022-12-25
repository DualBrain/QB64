A [TIMER](TIMER) statement enables, turns off or stops timer event trapping. QBasic only uses the base timer, but **QB64** can run many.

## Syntax
 
QB

> TIMER {ON|STOP|OFF}

QB64
 
> TIMER(*number%*) {ON|STOP|OFF|FREE}

## Parameter(s)

* *number* denotes a specific numbered timer event in **QB64 only**. QB64 can run many timer events at once including the base timer.
* TIMER ON enables event trapping of an [ON TIMER (n)](ON-TIMER-(n)) statement. While enabled, a check is made after every code statement to see if the specified time has elapsed and the ON TIMER [GOSUB](GOSUB) (or [SUB](SUB) in QB64) procedure is executed.
* TIMER STOP disables timer event trapping. When an event occurs while stopped, it is remembered. If timer events are turned back on later, any remembered events are immediately executed. 
* TIMER OFF turns timer event trapping completely off and no subsequent events are remembered.
* TIMER(n) **FREE** clears a specific timer event when it is no longer needed. **The base TIMER or TIMER(0) cannot be freed!**

## Description

**QB64 only**

* Get a TIMER number from [_FREETIMER](_FREETIMER) ONLY except when the base timer(no number or 0) is used. Use specific variables or an array to hold each event number value for later reference.
* If the TIMER number is omitted or 0, the TIMER used is the base timer.
* Specific TIMER events can be enabled, suspended, turned off or freed using [TIMER (statement)](TIMER-(statement)) ON, STOP, OFF or FREE.
* TIMER(n) **FREE** clears a specific timer event when it is no longer needed. **The base TIMER or TIMER(0) cannot be freed!** 

**QB64 Timing Alternatives**

* The [TIMER](TIMER) function can be used to find timed intervals down to 1 millisecond(.001) accuracy.
* The [_DELAY](_DELAY) statement can be used to delay program execution for intervals down to milliseconds.
* [_LIMIT](_LIMIT) can slow down loops to a specified number of frames per second. This can also alleviate a program's CPU usage.

## Example(s)

 How to update the time while [PRINT](PRINT) at the same time in a program.

```vb

TIMER ON ' enable timer event trapping
LOCATE 4, 2 ' set the starting PRINT position
ON TIMER(10) GOSUB Clock ' set procedure execution repeat time
DO WHILE INKEY$ = "": PRINT "A"; : SLEEP 6: LOOP
TIMER OFF
SYSTEM

Clock:
  row = CSRLIN ' Save current print cursor row.
  col = POS(0) ' Save current print cursor column.
  LOCATE 2, 37: PRINT TIME$; ' print current time at top of screen.
  LOCATE row, col ' return to last print cursor position 
RETURN 

```

> NOTE: SLEEP will be interrupted in QBasic.

## See Also

* [ON TIMER(n)](ON-TIMER(n)), [TIMER](TIMER)(function)
* [_DELAY](_DELAY), [_LIMIT](_LIMIT)
