The [_WHEEL](_WHEEL) function returns the relative position of a specified wheel number on a controller device.

## Syntax

>  move = [_WHEEL](_WHEEL)(wheelNumber%)

* Returns -1 when scrolling up and 1 when scrolling down with 0 indicating no movement since last read.
* Add consecutive wheel values to determine a cumulative value over time for scrolling or moving objects.
* wheelNumber% must be a number which does not exceed the number of wheels found by the [_LASTWHEEL](_LASTWHEEL) function.
* When a mouse indicates it has 3 wheels, the first two are for relative movement reads. The third wheel is for scrolling.
* **The number of [_DEVICES](_DEVICES) must be read before using [_DEVICE$](_DEVICE$), [_DEVICEINPUT](_DEVICEINPUT) or [_LASTWHEEL](_LASTWHEEL).**

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

>  *Note:* When there is no device control to read, a [FOR...NEXT](FOR...NEXT) n = 1 TO 0 loop will not run thus avoiding a control function read error.

Why does a mouse have 3 wheels? Relative x and y movements can be read using the first 2 _WHEEL reads.

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

>  *Explanation:* Referencing the [_MOUSEMOVEMENTX](_MOUSEMOVEMENTX) function hides the mouse and sets the mouse to a relative movement mode which can be read by [_WHEEL](_WHEEL). [_DEVICEINPUT](_DEVICEINPUT)(2) returns -1 (true) only when the mouse is moved, scrolled or clicked.

## See Also

* [_MOUSEWHEEL](_MOUSEWHEEL)
* [_LASTWHEEL](_LASTWHEEL), [_LASTBUTTON](_LASTBUTTON), [_LASTAXIS](_LASTAXIS)
* [_AXIS](_AXIS), [_BUTTON](_BUTTON), [_BUTTONCHANGE](_BUTTONCHANGE)
* [_DEVICES](_DEVICES), [_DEVICE$](_DEVICE$), [_DEVICEINPUT](_DEVICEINPUT)
* [_MOUSEMOVEMENTX](_MOUSEMOVEMENTX), [_MOUSEMOVEMENTY](_MOUSEMOVEMENTY)
* [Controller Devices](Controller-Devices)
