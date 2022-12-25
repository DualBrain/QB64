The [_LASTWHEEL](_LASTWHEEL) function returns the number of wheels a specified number INPUT device on your computer has.

## Syntax

> wheelCount% = [_LASTWHEEL](_LASTWHEEL)(deviceNumber)

* Returns the number of wheels that can be used on a specified device number within the number of [_DEVICES](_DEVICES) found.
* A valid number can be sent to the [_WHEEL](_WHEEL) function to find any relative positive or negative wheel movements. 
* The devices are listed in a numerical order determined by the OS and can be read by the [_DEVICE$](_DEVICE$) function.
* **The [_DEVICES](_DEVICES) function must be read before using _LASTWHEEL or an [ERROR Codes](ERROR-Codes) may occur.**
* Devices include keyboard (reported as 1), mouse (reported as 2), joysticks, game pads and multiple stick game controllers.

## Example(s)

Checking for the system's input devices and number of wheels available.

```vb

devices = _DEVICES  'MUST be read in order for other 2 device functions to work!
PRINT "Number of input devices found ="; devices
FOR i = 1 TO devices
  PRINT _DEVICE$(i)
  IF INSTR(_DEVICE$(i), "[WHEEL]") THEN PRINT "Wheels:"; _LASTWHEEL(i)
NEXT 

```

```text

Number of input devices found = 2
[KEYBOARD][BUTTON]
[MOUSE][BUTTON][AXIS][WHEEL]
Wheels: 3

```

> *Note:* A mouse may have 3 wheels listed when there is only one scroll wheel.

## See Also

* [_LASTBUTTON](_LASTBUTTON), [_LASTAXIS](_LASTAXIS)
* [_AXIS](_AXIS), [_BUTTON](_BUTTON), [_WHEEL](_WHEEL)
* [_DEVICE$](_DEVICE$), [_DEVICES](_DEVICES)
* [_MOUSEBUTTON](_MOUSEBUTTON)
* [STRIG](STRIG), [STICK](STICK)
* [ON STRIG(n)](ON-STRIG(n)), [STRIG(n)](STRIG(n))
