The [_AXIS](_AXIS) function returns the relative position of a specified axis number on a controller device.

## Syntax

> move! = [_AXIS](_AXIS)(axis_number%)

* [SINGLE](SINGLE) values returned range between -1 and 1 as maximums and 0 indicating minimum or axis center.
* When the mouse is moved on the program screen, moves left or above center are negative while below or right are positive.
* The *axis_number* must be a number which does not exceed the number of axis found by the [_LASTAXIS](_LASTAXIS) function.
* **The number of [_DEVICES](_DEVICES) must be read before using [_DEVICE$](_DEVICE$), [_DEVICEINPUT](_DEVICEINPUT) or [_LASTAXIS](_LASTAXIS).**

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
* [_WHEEL](_WHEEL), [_BUTTON](_BUTTON), [_BUTTONCHANGE](_BUTTONCHANGE)
* [_DEVICE$](_DEVICE$), [_DEVICES](_DEVICES)
* [_MOUSEMOVEMENTX](_MOUSEMOVEMENTX), [_MOUSEMOVEMENTY](_MOUSEMOVEMENTY) (relative movement)
* [Controller Devices](Controller-Devices)
