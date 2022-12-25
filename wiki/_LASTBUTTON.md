The [_LASTBUTTON](_LASTBUTTON) function returns the number of buttons a specified INPUT device on your computer has.

## Syntax

> buttonCount% = _[_LASTBUTTON](_LASTBUTTON)(deviceNumber)

* Returns the number of buttons that can be read on a specified device number within the number of [_DEVICES](_DEVICES) found.
* A valid number can be sent to the [_BUTTON](_BUTTON) or [_BUTTONCHANGE](_BUTTONCHANGE) function to find any button events.
* The specific device name and functions can be found by the [_DEVICE$](_DEVICE$) function [STRING](STRING).
* The devices are listed in a numerical order determined by the OS and can be read by the [_DEVICE$](_DEVICE$) function.
* **The [_DEVICES](_DEVICES) function must be read before using _LASTBUTTON or an [ERROR Codes](ERROR-Codes) will occur.**
* Devices include keyboard (reported as 1), mouse (reported as 2), joysticks, game pads and multiple stick game controllers.

## Example(s)

Checking for the system's input devices.

```vb

devices = _DEVICES  'MUST be read in order for other 2 device functions to work!
PRINT "Number of input devices found ="; devices
FOR i = 1 TO devices
  PRINT _DEVICE$(i)
  PRINT "Buttons:"; _LASTBUTTON(i)
NEXT 

```

```text

Number of input devices found = 2
[KEYBOARD][BUTTON]
Buttons: 512
[MOUSE][BUTTON][AXIS][WHEEL]
Buttons: 3

```

> Note: The [STRIG](STRIG)/[STICK](STICK) commands won't read from the keyboard or mouse device the above example lists.

## See Also

* [_LASTAXIS](_LASTAXIS), [_LASTWHEEL](_LASTWHEEL)
* [_AXIS](_AXIS), [_BUTTON](_BUTTON), [_WHEEL](_WHEEL)
* [_DEVICES](_DEVICES), [_DEVICE$](_DEVICE$)
* [_DEVICEINPUT](_DEVICEINPUT)
* [_MOUSEBUTTON](_MOUSEBUTTON)
* [STRIG](STRIG), [STICK](STICK)
* [ON STRIG(n)](ON-STRIG(n)), [STRIG(n)](STRIG(n))
