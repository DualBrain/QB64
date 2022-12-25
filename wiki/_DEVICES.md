The [_DEVICES](_DEVICES) function returns the number of INPUT devices on your computer including keyboard, mouse and game devices.

## Syntax

> device_count% = [_DEVICES](_DEVICES)

## Description

* Returns the number of devices that can be listed separately with the [_DEVICE$](_DEVICE$) function by the device number.
* Devices include keyboard, mouse, joysticks, game pads and multiple stick game controllers.
* **Note: This function must be read before trying to use the [_DEVICE$](_DEVICE$), [_DEVICEINPUT](_DEVICEINPUT) or _LAST control functions.**

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

* [_DEVICE$](_DEVICE$), [_DEVICEINPUT](_DEVICEINPUT)
* [_LASTBUTTON](_LASTBUTTON), [_LASTAXIS](_LASTAXIS), [_LASTWHEEL](_LASTWHEEL)
* [_BUTTON](_BUTTON), [_BUTTONCHANGE](_BUTTONCHANGE)
* [_AXIS](_AXIS), [_WHEEL](_WHEEL)
* [_MOUSEINPUT](_MOUSEINPUT), [_MOUSEX](_MOUSEX), [_MOUSEBUTTON](_MOUSEBUTTON)
* [STRIG](STRIG), [STICK](STICK)
* [ON STRIG(n)](ON-STRIG(n)), [STRIG(n)](STRIG(n))
* [Controller Devices](Controller-Devices)
