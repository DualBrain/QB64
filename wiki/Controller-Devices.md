QB64 supports all kinds of keyboard, mouse, joystick, gamepad, steering wheel and other multi-stick controller input devices. 

* **In order to read the device controls, the number of input devices MUST first be found using [_DEVICES](_DEVICES).**

* After the device count is determined we can find out the type of device, the device name and the type of controls available using the [_DEVICE$](_DEVICE$)(device_number) function. The function returns a [STRING](STRING) containing information about each numbered device.

> `"[CONTROLLER][[DEVICENAME] device description][BUTTON][AXIS][WHEEL]"`

* [_DEVICEINPUT](_DEVICEINPUT) can indicate a used device number or true when a specified device number  is active.

> **device = _DEVICEINPUT** would return 1 for a keyboard event and 2 for a mouse event.

> **mouse = _DEVICEINPUT(2)** would return -1(true) when the mouse was moved, clicked or scrolled.

## [KEYBOARD]

Normally the number 1 device, it usually only has [[BUTTON](BUTTON)] controls. Program window must be in focus to read key activity.

> **[KEYBOARD][BUTTON]**

>  [_LASTBUTTON](_LASTBUTTON)(1) will normally return 512 buttons.

>  [_BUTTONCHANGE](_BUTTONCHANGE)(number) returns -1 when pressed, 1 when released and 0 when there is no event since the last read.

>  [_BUTTON](_BUTTON)(number) returns -1 when a button is pressed and 0 when released.

```text

'                                  **Keyboard Device Button Numbers**
'
**'  Esc F1  F2  F3  F4  F5  F6  F7  F8  F9  F10  F11 F12      SysReq ScrL Pause**                  
'  177 436 433 434 439 440 437 438 395 396 393  394 399       402   392   ---
'  **`~  1!  2@  3#  4$  5%  6^  7&  8*  9(  0)  -_  =+ BkSpc  Insert Home PgUp   NumL    /    *    -** 
'  246 155 156 153 154 159 160 157 158 147 134 135 151 174    447   448   446   386    417  418  423
'  **Tab  Q   W   E   R   T   Y   U   I   O   P   [{  ]}  \|   Delete End  PgDn   7/Home 8/▲  9/PU  + **
'  163 219 221 207 220 218 211 223 195 197 198 241 247 242    213   445   435   429    430  419  424
'  **CapL  A   S   D   F   G   H   J   K   L   ;:  '"   Enter                     4/◄-    5   6/-►  E**
'  391  203 217 202 208 205 206 196 193 194  145 141   167                      426    431  432   **n**
'  **Shift  Z   X   C   V   B   N   M  ,<  .>  /?       Shift          ▲          1/End  2/▼  3/PD  t**
'  390   212 222 201 224 204 200 199 130 136 133       389          443         427    428  432   **e**
'  **Ctrl Win  Alt    Spacebar    Alt  Win  Menu Ctrl            ◄-    ▼    -►    0/Insert    ./Del r**
'  412  413  410      182       409  414  405  411             442  444   441    86         420  421 
'

```

## [MOUSE]

Normally the number 2 device, a mouse usually has [[AXIS](AXIS)], [[BUTTON](BUTTON)] and [[WHEEL](WHEEL)] controls. Pointer must be in program screen area.

> **[MOUSE][BUTTON][AXIS][WHEEL]**

> [_LASTAXIS](_LASTAXIS)(2) normally returns 2 axis representing the horizontal and vertical mouse, trackball, touch pad or touchscreen axis.

> [_AXIS](_AXIS)(number) returns a [SINGLE](SINGLE) value from -1 to 1 with 0 representing the axis center in normal movement mode.

> [_AXIS](_AXIS)(1) returns the horizontal axis position in normal movement mode only.

> [_AXIS](_AXIS)(2) returns the vertical axis position in normal movement mode only. 

Program window pointer AXIS values change from 0 at the center to -1 or + 1 values at the window borders.

> [_LASTBUTTON](_LASTBUTTON)(2) will normally return 3 buttons when mouse has a center or scroll wheel button.

> [_BUTTONCHANGE](_BUTTONCHANGE)(number) returns -1 when pressed, 1 when released and 0 when there is no event since the last read.

> [_BUTTON](_BUTTON)(number) returns -1 when corresponding button is pressed and 0 when released.

> [_BUTTON](_BUTTON)(1) returns Left button presses like [_MOUSEBUTTON](_MOUSEBUTTON)(1) and [_BUTTONCHANGE](_BUTTONCHANGE)(1) returns events.

> [_BUTTON](_BUTTON)(2) returns Center button presses like [_MOUSEBUTTON](_MOUSEBUTTON)(3) and [_BUTTONCHANGE](_BUTTONCHANGE)(2) returns events.

> [_BUTTON](_BUTTON)(3) returns Right button presses like [_MOUSEBUTTON](_MOUSEBUTTON)(2) and [_BUTTONCHANGE](_BUTTONCHANGE)(3) returns events.

**Note that middle _BUTTON(2) is equivalent to [_MOUSEBUTTON](_MOUSEBUTTON)(3)!**

> [_LASTWHEEL](_LASTWHEEL)(2) will normally return 3 wheels where the first two return relative coordinate movements when set. 

> [_WHEEL](_WHEEL)(number) returns -1 when wheel is scrolled up or forward and 1 when wheel is scrolled down or backward.

> [_WHEEL](_WHEEL)(1) returns relative horizontal pixel moves after [_MOUSEMOVEMENTX](_MOUSEMOVEMENTX) or Y enables relative mode.

> [_WHEEL](_WHEEL)(2) returns relative vertical pixel moves after [_MOUSEMOVEMENTX](_MOUSEMOVEMENTX) or Y enables relative mode.

> [_WHEEL](_WHEEL)(3) returns -1 when scroll wheel is moved forward or up and 1 when scrolled backward or down.

Relative WHEEL move values are negative when mouse is moved up or left. Positive when mouse is moved down or right.

WHEEL values can be added for a cumulative movement value when needed. Scroll reads can be off program screen.

## [CONTROLLER]

[NAME][manufacturer name](NAME][manufacturer name) may follow in the controller [_DEVICE$](_DEVICE$) string. Devices can be joysticks, game pads or multi-stick.

> `[CONTROLLER][[DeviceName]description][BUTTON][AXIS][WHEEL]`

Normally device numbers 3 or higher, controllers may have any number of [[AXIS](AXIS)], [[BUTTON](BUTTON)] and/or [[WHEEL](WHEEL)] controls.

> [_LASTAXIS](_LASTAXIS)(device_number) normally returns dual axis representing the horizontal and vertical axis or view point("top hat").

> [_AXIS](_AXIS)(number) returns a [SINGLE](SINGLE) value from -1 to 1 with 0 representing the axis center.

> [_AXIS](_AXIS)(1) returns the horizontal axis position.

> [_AXIS](_AXIS)(2) returns the vertical axis position. 

**Note: Some slide controls may only have one axis!**

> [_LASTBUTTON](_LASTBUTTON)(device_number) will return the number of buttons or triggers a device has.

> [_BUTTONCHANGE](_BUTTONCHANGE)(number) returns -1 when pressed, 1 when released and 0 when there is no event since the last read.

> [_BUTTON](_BUTTON)(number) returns -1 when button number is pressed and 0 when released.

> [_LASTWHEEL](_LASTWHEEL)(device_number) will return the number of wheel controls a device has. 

> [_WHEEL](_WHEEL)(number) returns -1 when wheel is scrolled up or forward and 1 when wheel is scrolled down or backward.

## Example

> Displays all keyboard, mouse and game controller button, axis and wheel control input values when each device is being used.

```vb

PRINT "Use relative mouse movement mode with ESC key exit only?(Y/N) ";
K$ = UCASE$(INPUT$(1))
PRINT K$
PRINT

FOR i = 1 TO _DEVICES 'DEVICES MUST be read first!
  PRINT STR$(i) + ") " + _DEVICE$(i) + " Buttons:"; _LASTBUTTON(i); ",Axis:"; _LASTAXIS(i); ",Wheel:"; _LASTWHEEL(i)
NEXT
IF K$ = "Y" THEN dummy = _MOUSEMOVEMENTX 'enable relative mouse movement reads
PRINT

DO
  x& = _DEVICEINPUT 'determines which device is currently being used
  IF x& = 1 THEN
    PRINT "Keyboard: ";
    FOR b = 1 TO _LASTBUTTON(x&)
      bb = _BUTTONCHANGE(b)
      IF bb THEN PRINT b; bb; _BUTTON(b);
    NEXT
    PRINT
  END IF
  IF x& > 1 THEN '  skip keyboard reads
    PRINT "Device:"; x&;
    FOR b = 1 TO _LASTBUTTON(x&)
      PRINT _BUTTONCHANGE(b); _BUTTON(b);
    NEXT
    FOR a = 1 TO _LASTAXIS(x&)
      PRINT _AXIS(a); 'mouse axis returns -1 to 1 with 0 center screen
    NEXT
    FOR w = 1 TO _LASTWHEEL(x&)
      PRINT _WHEEL(w); 'wheels 1 and 2 of mouse return relative pixel moves when enabled
    NEXT
    PRINT
  END IF
LOOP UNTIL INKEY$ = CHR$(27) 'escape key exit

END 

```
<sub>Code by Ted Weissgerber</sub>

> *Note:* When there is no device control to read, a [FOR...NEXT](FOR...NEXT) n = 1 TO 0 loop will not run thus avoiding a control function read error.

> Using [_MOUSEMOVEMENTX](_MOUSEMOVEMENTX) or Y will hide the mouse cursor and return relative mouse movements with the 1 and 2 [_WHEEL](_WHEEL) controls.
[_MOUSESHOW](_MOUSESHOW) will return the mouse coordinate reads to the [_AXIS](_AXIS) control after it is used!

## See Also

* [_DEVICEINPUT](_DEVICEINPUT), [_AXIS](_AXIS), [_BUTTON](_BUTTON), [_BUTTONCHANGE](_BUTTONCHANGE), [_WHEEL](_WHEEL)
* [_DEVICES](_DEVICES), [_DEVICE$](_DEVICE$), [_LASTAXIS](_LASTAXIS), [_LASTBUTTON](_LASTBUTTON), [_LASTWHEEL](_LASTWHEEL)
* [_MOUSEINPUT](_MOUSEINPUT), [_MOUSEX](_MOUSEX), [_MOUSEY](_MOUSEY), [_MOUSEBUTTON](_MOUSEBUTTON), [_MOUSEWHEEL](_MOUSEWHEEL)
* [_MOUSEMOVE](_MOUSEMOVE), [_MOUSEHIDE](_MOUSEHIDE), [_MOUSESHOW](_MOUSESHOW)
* [_MOUSEMOVEMENTX](_MOUSEMOVEMENTX), [_MOUSEMOVEMENTY](_MOUSEMOVEMENTY) (relative movement)
* [STRIG](STRIG) (button), [STICK](STICK) (axis)
