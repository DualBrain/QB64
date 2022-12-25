The [ON_TIMER(n)](ON-TIMER(n)) statement sets up a timed event to be repeated at specified intervals throughout a program when enabled.

## Syntax
 
>  **ON TIMER**(seconds%) [GOSUB](GOSUB) {lineLabel|lineNumber}

>  **ON TIMER**([number%,] seconds!) { [SUB](SUB)procedure | [GOSUB](GOSUB) {lineLabel|lineNumber} }

## Description

### Legacy syntax

* In the first syntax, the [INTEGER](INTEGER) seconds% parameter can be from 1 to 86400 seconds (one day).
* A [TIMER (statement)](TIMER-(statement)) statement must follow an **ON TIMER** event setup to initiate it.
* [TIMER (statement)](TIMER-(statement)) disables timer events but remembers previous events when enabled again by a [TIMER (statement)](TIMER-(statement)) statement, and the recorded events may be executed immediately if a timer event has occurred. 
* [TIMER (statement)](TIMER-(statement)) disables timer event trapping. Events will not be remembered in a subsequent [TIMER (statement)](TIMER-(statement)) statement.
* **ON TIMER** events will interrupt a [SLEEP](SLEEP) call and [RETURN](RETURN) to running program procedures.
* Only one TIMER event can be set at a time using this legacy syntax and all TIMER code must be in the main code, as it uses [GOSUB](GOSUB).

### QB64 syntax

* **QB64** can use multiple numbered timer events and [SINGLE](SINGLE) floating point second values down to one millisecond (.001).
* The **TIMER** number% must be obtained from the [_FREETIMER](_FREETIMER) function. Store _FREETIMER numbers in a variable or an array to be able to reference them later.
* If the **TIMER** number is omitted or `**ON TIMER**(0, seconds!)` is used, then the TIMER used is the *base TIMER* (same as in the legacy syntax above).
* [SUB](SUB) procedures are allowed to be referenced, but [CALL](CALL) must not be used. 
* **[SUB](SUB) parameter values are passed by value and should be [SHARED](SHARED) or literal values.**
* Specific **TIMER** events can be turned on, suspended, turned off or freed using [TIMER (statement)](TIMER-(statement)) ON, STOP, OFF or FREE.
* Use **TIMER(n) FREE** to release a timer event after it has been turned off or is no longer used.
  * The *base TIMER* cannot be freed.
* **QB64** allows TIMER statements to also be inside of SUB and FUNCTION procedures.
* **ON TIMER** events will interrupt a [SLEEP](SLEEP) call and [RETURN](RETURN) to running program procedures.
* [$CHECKING]($CHECKING):OFF can disable all QB64 event checking. **Setting $CHECKING:OFF is only designed for 100% stable, error-less sections of code, where every CPU cycle saved counts.**

## QB64 Timing Alternatives

* The [TIMER](TIMER) function can be used to find timed intervals down to 1 millisecond(.001) accuracy.
* The [_DELAY](_DELAY) statement can be used to delay program execution for intervals down to milliseconds.
* [_LIMIT](_LIMIT) can slow down loops to a specified number of frames per second. This can also alleviate a program's CPU usage.

## Example(s)

Using a numbered TIMER to check the mouse button press status in **QB64**.

```vb

DIM SHARED Button AS LONG    'share variable value with Sub

t1 = _FREETIMER              'get a timer number from _FREETIMER ONLY!
ON TIMER(t1, .05) MouseClick
TIMER(t1) ON

DO
  LOCATE 1, 1
  IF Button THEN
    PRINT "Mouse button"; Button; "is pressed.";
  ELSE PRINT SPACE$(70)
  END IF
  _DISPLAY
LOOP UNTIL INKEY$ = CHR$(27)
TIMER(t1) OFF
TIMER(t1) FREE 'release timer
END

SUB MouseClick
DO WHILE _MOUSEINPUT
  IF _MOUSEBUTTON(1) THEN
    COLOR 10: Button = 1
  ELSEIF _MOUSEBUTTON(2) THEN
    COLOR 12: Button = 2
  ELSE Button = 0
  END IF
LOOP
END SUB 

```

## See Also

* [TIMER](TIMER), [_FREETIMER](_FREETIMER)
* [TIMER (statement)](TIMER-(statement)), [_DELAY](_DELAY), [_LIMIT](_LIMIT)
* [$CHECKING]($CHECKING) (QB64 [Metacommand](Metacommand))
