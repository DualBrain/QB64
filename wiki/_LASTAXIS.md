The [_LASTAXIS](_LASTAXIS) function returns the number of axis a specified number INPUT device on your computer has.

## Syntax

> axisCount% = [_LASTAXIS](_LASTAXIS)(deviceNumber)

## Description

* Returns the number of axis that can be read on a specified device number within the number of [_DEVICES](_DEVICES) found.
* A valid number can be sent to the [_AXIS](_AXIS) function to find any relative axis movements.
* The devices are listed in a numerical order determined by the OS and can be read by the [_DEVICE$](_DEVICE$) function.
* **The [_DEVICES](_DEVICES) function must be read before using _LASTAXIS or an [ERROR Codes](ERROR-Codes) will occur.**
* Devices include keyboard(1), mouse(2), joysticks, game pads and multiple stick game controllers.

## Example(s)

Checking for the system's input devices and number of axis.

```vb

devices = _DEVICES  'MUST be read in order for other 2 device functions to work!
PRINT "Number of input devices found ="; devices
FOR i = 1 TO devices
  PRINT _DEVICE$(i)
  IF INSTR(_DEVICE$(i), "[AXIS]") THEN PRINT "Axis:"; _LASTAXIS(i)
NEXT 

```

```text

Number of input devices found = 2
[KEYBOARD][BUTTON]
[MOUSE][BUTTON][AXIS][WHEEL]
Axis: 2

```

> Note: The [STRIG](STRIG)/[STICK](STICK) commands won't read from the keyboard or mouse device the above example lists.

## See Also

* [_LASTBUTTON](_LASTBUTTON), [_LASTWHEEL](_LASTWHEEL)
* [_AXIS](_AXIS), [_BUTTON](_BUTTON), [_WHEEL](_WHEEL)
* [_DEVICE$](_DEVICE$), [_DEVICES](_DEVICES)
* [_MOUSEBUTTON](_MOUSEBUTTON)
* [STRIG](STRIG), [STICK](STICK)
* [ON STRIG(n)](ON-STRIG(n)), [STRIG(n)](STRIG(n))
