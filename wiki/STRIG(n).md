The STRIG(n) statement controls event trapping for a particular joystick or game pad device button.

## Syntax

> STRIG(button%) {ON|OFF|STOP}

## QB64 Syntax

> STRIG[(*button_function%*[, *device_number%*])] {ON|OFF|STOP}

## Description

* button function specifies the device's button function. Even functions record events while odd ones read the actual presses.
* **QB64** can designate a button function and controller device number from 0 to 256.
* When no parameters are used **QB64** enables, disables or suspends the reading of ALL button events.
* [STRIG(n)](STRIG(n)) specifies that event trapping is turned on for the specified button.
* [STRIG(n)](STRIG(n)) specifies that event trapping is turned off for the specified button.
* If STOP is specified, event trapping is suspended for the specified button. Further joystick button events are remembered and trapped, in order, after the next STRIG(n) ON statement is used.

## Example(s)

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

## See Also

* [ON STRIG(n)](ON-STRIG(n)) (event statement)
* [STRIG](STRIG), [STICK](STICK) (functions)
* [Single and Dual Stick Controllers](http://en.wikipedia.org/wiki/Analog_stick)
