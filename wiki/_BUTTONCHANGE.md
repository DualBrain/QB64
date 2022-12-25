The [_BUTTONCHANGE](_BUTTONCHANGE) function returns -1 or 1 when a specified button number on a controller device has been pressed or released.

## Syntax

> press% = [_BUTTONCHANGE](_BUTTONCHANGE)(button_number%)

## Description

* The **[_DEVICEINPUT](_DEVICEINPUT) function should be read first to specify which device [_BUTTONCHANGE](_BUTTONCHANGE) is intended to check.**
* Values returned are -1 for a press and 1 when a button is released. No press or release event returns zero.
* The button_number% must be a number which does not exceed the number of buttons found by the [_LASTBUTTON](_LASTBUTTON) function.
* **The number of [_DEVICES](_DEVICES) must be read before using [_DEVICE$](_DEVICE$), [_DEVICEINPUT](_DEVICEINPUT) or [_LASTBUTTON](_LASTBUTTON).**
* **Note:** The center mouse button is button number 2. Center can also be read using  [_MOUSEBUTTON](_MOUSEBUTTON)(3).

## Example(s)

Reading multiple controller device buttons, axis and wheels.

```vb

FOR i = 1 TO _DEVICES
  PRINT STR$(i) + ") " + _DEVICE$(i) + " Buttons:"; _LASTBUTTON(i); ",Axis:"; _LASTAXIS(i); ",Wheel:"; _LASTWHEEL(i)
NEXT

DO
  d& = _DEVICEINPUT
  IF d& THEN '             the device number cannot be zero!
    PRINT "Found"; d&;
    FOR b = 1 TO _LASTBUTTON(d&)
      PRINT _BUTTONCHANGE(b); _BUTTON(b);
    NEXT
    FOR a = 1 TO _LASTAXIS(d&)
      PRINT _AXIS(a);
    NEXT
    FOR w = 1 TO _LASTWHEEL(d&)
      PRINT _WHEEL(w);
    NEXT
    PRINT
  END IF
LOOP UNTIL INKEY$ = CHR$(27) 'escape key exit

END 

```

> *Note:* When there is no device control to read, a [FOR...NEXT](FOR...NEXT) n = 1 TO 0 loop will not run thus avoiding a control function read error.

## See Also

* [_LASTWHEEL](_LASTWHEEL), [_LASTBUTTON](_LASTBUTTON), [_LASTAXIS](_LASTAXIS)
* [_AXIS](_AXIS), [_WHEEL](_WHEEL), [_BUTTON](_BUTTON)
* [_DEVICE$](_DEVICE$), [_DEVICES](_DEVICES)
* [_MOUSEBUTTON](_MOUSEBUTTON)
* [Controller Devices](Controller-Devices)
