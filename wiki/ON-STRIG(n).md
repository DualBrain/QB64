The [ON STRIG(n)](ON-STRIG(n)) statement is an event procedure that directs program flow upon the press of a specified joystick button.

## Syntax

>  **ON STRIG**(buttonFunction) [GOSUB](GOSUB) {lineNumber|lineLabel}

>  **ON STRIG**(buttonFunction[, joystickNumber]) {[GOSUB](GOSUB) {lineNumber|lineLabel} | [SUB](SUB)procedure}

* In **QB64** the value can be any button function number with any number of joysticks. See [STRIG](STRIG) and [STICK](STICK) for parameters.
* There are two buttonFunction for each button. The even numbered function is always the event of any press since last read.
* The statement sends the procedure to a line number, line label or [SUB](SUB) procedure when a button event occurs.

## QBasic

* In QBasic, value of *n* could only be a number from 0 to 3 only as it could only monitor 2 joystick buttons and 2 joysticks.

## Example(s)

Reading a STRIG event to do something in a [GOSUB](GOSUB) procedure.

```vb

ON STRIG(0) GOSUB 10
STRIG(0)ON

DO
    PRINT ".";
    _LIMIT 30
LOOP UNTIL INKEY$ <> ""
END

10
a$ = "[STRIG 0 EVENT]"
FOR x = 1 TO LEN(a$)
    PRINT MID$(a$, x, 1);
    _DELAY 0.02
NEXT
RETURN 

```

Displays any number of game pad or joystick device button presses.

```vb

FOR j = 1 TO 256
    FOR b = 1 TO 256
        ON STRIG((b - 1) * 4, j) JoyButton (j - 1) * 256 + b - 1
    NEXT
NEXT
STRIG ON

DO
    PRINT ".";
    _LIMIT 30
LOOP UNTIL INKEY$ <> ""
END

SUB JoyButton (js AS LONG)
PRINT "Joystick #"; js \ 256 + 1; "button #"; (js AND 255) + 1; "pressed!"
END SUB 

```

> *Explanation:* Up to 256 controllers can be used in QB64 with many buttons to read.

## See Also

* [STRIG](STRIG), [STICK](STICK) (functions)
* [STRIG(n)](STRIG(n)) (statement)
* [_DEVICES](_DEVICES), [_DEVICE$](_DEVICE$), [_LASTBUTTON](_LASTBUTTON)

### External links

* [Single and Dual Stick Controllers](http://en.wikipedia.org/wiki/Analog_stick)
