The **_DEVICE$** function returns a [STRING](STRING) value holding the controller type, name and input types of the input devices on a computer.

## Syntax

> device$ = _DEVICE$(device_number)

* The **[_DEVICES](_DEVICES) function must be read first to get the number of devices and to enable [_DEVICE$](_DEVICE$) and [_DEVICEINPUT](_DEVICEINPUT).**
* The device_number parameter indicates the number of the controller device to be read.
* Returns the [STRING](STRING) control type, name of the device and input types each can use included in brackets:
  * Control type:
    * [KEYBOARD] always listed as first device when keyboard(s) available. Only one keyboard will show.
    * [MOUSE]] always listed as second device when keyboard(s) and mouse(mice) are available. Only one mouse will show.
    * [CONTROLLER] subsequent devices are listed as controllers which include joysticks and game pads.
    * When [CONTROLLER] is returned it may also give the [STRING](STRING) [NAME] [device description](NAME] [device description) of the controller.
  * Returns the type of input after the device name as one or more of the following types:
    * [[BUTTON](BUTTON)] indicates there are button types of input. [_LASTBUTTON](_LASTBUTTON) can return the number of buttons available. 
    * [[AXIS](AXIS)] indicates there are stick types of input. [_LASTAXIS](_LASTAXIS) can return the number of axis available. 
    * [[WHEEL](WHEEL)] indicates that a scrolling input can be read. [_LASTWHEEL](_LASTWHEEL) can return the number of wheels available.

* **Device numbers above the number of [_DEVICES](_DEVICES) found will return an OS error.**
* Devices found include keyboard, mouse, joysticks, game pads and multiple stick game controllers.

## Example(s)

Checking for the system's input devices and the number of buttons available.

```vb

devices = _DEVICES  'MUST be read in order for other 2 device functions to work!
PRINT "Number of input devices found ="; devices
FOR i = 1 TO devices
  PRINT _DEVICE$(i)
  PRINT "Buttons:"; _LASTBUTTON(i); "Axis:"; _LASTAXIS(i); "Wheels:"; _LASTWHEEL(i)
NEXT 

```

```text

Number of input devices found = 3
[KEYBOARD][BUTTON]
Buttons: 512 Axis: 0 Wheels: 0
[MOUSE][BUTTON][AXIS][WHEEL]
Buttons: 3 Axis: 2 Wheels: 3
[CONTROLLER][NAME][Microsoft Sidewinder Precision Pro (USB)](NAME][Microsoft Sidewinder Precision Pro (USB))[BUTTON][AXIS]
Buttons: 9 Axis: 6 Wheels: 0

```

> Note: The [STRIG](STRIG)/[STICK](STICK) commands won't read from the keyboard or mouse device the above example lists. They will only work on controllers.

Finding the number of mouse buttons available in QB64. This could also be used for other devices.

```vb

FOR d = 1 TO _DEVICES  'number of input devices found
  dev$ = _DEVICE$(d)
  IF INSTR(dev$, "[MOUSE]") THEN buttons = _LASTBUTTON(d): EXIT FOR
NEXT
PRINT buttons; "mouse buttons available" 

```

## See Also

* [_DEVICES](_DEVICES), [_DEVICEINPUT](_DEVICEINPUT)
* [_LASTBUTTON](_LASTBUTTON), [_LASTAXIS](_LASTAXIS), [_LASTWHEEL](_LASTWHEEL)
* [_BUTTON](_BUTTON), [_BUTTONCHANGE](_BUTTONCHANGE)
* [_AXIS](_AXIS), [_WHEEL](_WHEEL)
* [_MOUSEBUTTON](_MOUSEBUTTON)
* [STRIG](STRIG), [STICK](STICK)
* [ON STRIG(n)](ON-STRIG(n)), [STRIG(n)](STRIG(n))
* [Controller Devices](Controller-Devices)
