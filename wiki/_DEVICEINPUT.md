The **_DEVICEINPUT** function returns the device number when a controller device button, wheel or axis event occurs.

## Syntax

> device% = [_DEVICEINPUT](_DEVICEINPUT)
> device_active% = [_DEVICEINPUT](_DEVICEINPUT)(device_number%)

## Parameter(s)

* Use the _DEVICEINPUT  device% [INTEGER](INTEGER) returned to find the number of the controller device being used.
* A literal specific device_number% parameter can be used to return -1 if active or 0 if inactive. EX: **WHILE _DEVICEINPUT(2)** 

## Description

* Use [_DEVICES](_DEVICES) to find the number of controller devices available BEFORE using this function.
* [_DEVICE$](_DEVICE$) can be used to list the device names and control types using valid [_DEVICES](_DEVICES) numbers.
* When a device button is pressed or a scroll wheel or axis is moved, the device number will be returned.
* Devices are numbered as 1 for keyboard and 2 for mouse. Other controller devices will be numbered 3 or higher if installed.
* [_LASTBUTTON](_LASTBUTTON), [_LASTAXIS](_LASTAXIS), or [_LASTWHEEL](_LASTWHEEL) will indicate the number of functions available with the specified *device* number. 
* User input events can be monitored reading valid numbered [_AXIS](_AXIS), [_BUTTON](_BUTTON), [_BUTTONCHANGE](_BUTTONCHANGE) or [_WHEEL](_WHEEL) functions.
* *Note:* [ON...GOSUB](ON...GOSUB) keyboard, mouse, gamecontrol can be used to control the devices 1,2 and 3, etc. 

## Example(s)

Checking device controller interfaces and finding out what devices are being used.

```vb

FOR i = 1 TO _DEVICES
  PRINT STR$(i) + ") " + _DEVICE$(i)
  PRINT "Button:"; _LASTBUTTON(i); ",Axis:"; _LASTAXIS(i); ",Wheel:"; _LASTWHEEL(i)
NEXT

PRINT
DO
  x = _DEVICEINPUT
  IF x THEN PRINT "Device ="; x;
LOOP UNTIL INKEY$ = CHR$(27) 'escape key exit

END 

```

```text

[KEYBOARD][BUTTON]
Buttons: 512 Axis: 0 Wheels: 0
[MOUSE][BUTTON][AXIS][WHEEL]
Buttons: 3 Axis: 2 Wheels: 3
[CONTROLLER][NAME][Microsoft Sidewinder Precision Pro (USB)](NAME][Microsoft Sidewinder Precision Pro (USB))[BUTTON][AXIS]
Buttons: 9 Axis: 6 Wheels: 0

Device = 2 Device = 2

```

> *Note:* Mouse events must be within the program screen area. Keyboard presses are registered only when program is in focus.

Why does a mouse have 3 wheels? Relative x and y movements can be read using the first 2 [_WHEEL](_WHEEL) reads.

```vb

ignore = _MOUSEMOVEMENTX 'dummy call to put mouse into relative movement mode

PRINT "Move your mouse and/or your mouse wheel (ESC to exit)"

d = _DEVICES '  always read number of devices to enable device input
DO: _LIMIT 30  'main loop
  DO WHILE _DEVICEINPUT(2) 'loop only runs during a device 2 mouse event
        PRINT _WHEEL(1), _WHEEL(2), _WHEEL(3)
  LOOP 
LOOP UNTIL INKEY$ = CHR$(27) 

```

> *Explanation:* Referencing the [_MOUSEMOVEMENTX](_MOUSEMOVEMENTX) function hides the mouse and sets the mouse to a relative movement mode which can be read by [_WHEEL](_WHEEL). [_DEVICEINPUT](_DEVICEINPUT)(2) returns -1 (true) only when the mouse is moved, scrolled or clicked.

Using [ON...GOSUB](ON...GOSUB) with the [_DEVICEINPUT](_DEVICEINPUT) number to add keyboard, mouse and game controller event procedures.

```vb

n = _DEVICES 'required when reading devices
PRINT "Number of devices found ="; n
FOR i = 1 TO n
    PRINT i; _DEVICE$(i) ' 1 = keyboard, 2 = mouse, 3 = other controller, etc.
NEXT
PRINT

DO: device = _DEVICEINPUT
    ON device GOSUB keyboard, mouse, controller  'must be inside program loop
LOOP UNTIL INKEY$ = CHR$(27)
END

keyboard:
PRINT device; "Keyboard";
RETURN

mouse:
PRINT device; "Mouse ";
RETURN

controller:
PRINT device; "Game control ";
RETURN 

```

> *Note:* [ON...GOSUB](ON...GOSUB) and [ON...GOTO](ON...GOTO) events require numerical values to match the order of line labels listed in the event used inside loops.

## See Also

* [_DEVICES](_DEVICES), [_DEVICE$](_DEVICE$)
* [_LASTBUTTON](_LASTBUTTON), [_LASTAXIS](_LASTAXIS), [_LASTWHEEL](_LASTWHEEL)
* [_BUTTON](_BUTTON), [_AXIS](_AXIS), [_WHEEL](_WHEEL)
* [STRIG](STRIG), [STICK](STICK)
* [ON...GOSUB](ON...GOSUB) (numerical events)
* [Controller Devices](Controller-Devices)
