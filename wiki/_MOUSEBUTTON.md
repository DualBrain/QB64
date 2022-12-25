The [_MOUSEBUTTON](_MOUSEBUTTON) function returns the button status of a specified mouse button when read after [_MOUSEINPUT](_MOUSEINPUT).

## Syntax

> buttonStatus%% = [_MOUSEBUTTON](_MOUSEBUTTON)(buttoNumber)

## Parameter(s)

* [INTEGER](INTEGER) buttoNumber designates the mouse button to read (See [_DEVICES](_DEVICES) for more than 3).
  * 1 = Left mouse button
  * 2 = Right mouse button
  * 3 = Center or scroll button 

## Description

* Returns -1 if the corresponding buttoNumber is pressed or zero when released. 
* Read [_MOUSEINPUT](_MOUSEINPUT) first to return the current button up or down status. (See Example 2)
* Button clicks and mouse movements will be remembered and should be cleared after an [INPUT](INPUT) statement or other interruption. 
* To clear unread mouse input, use a [_MOUSEINPUT](_MOUSEINPUT) loop that loops until it returns 0.
* Use [_DEVICE$](_DEVICE$) to find the "[MOUSE]" [_DEVICES](_DEVICES) number to find the number of buttons available using [_LASTBUTTON](_LASTBUTTON).
* **Note:** The center mouse button can also be read as [_BUTTON](_BUTTON)(2) on [_DEVICEINPUT](_DEVICEINPUT)(2) when a mouse is present.

## Example(s)

Finding the number of mouse buttons available in QB64. This could also be used for other controller devices.

```vb

FOR d = 1 TO _DEVICES  'number of input devices found
  dev$ = _DEVICE$(d)
  IF INSTR(dev$, "[MOUSE]") THEN buttons = _LASTBUTTON(d): EXIT FOR
NEXT
PRINT buttons; "mouse buttons available" 

```

How to monitor when a button is down or wait until a mouse button is not held down.

```vb

PRINT "Hold down the left mouse button until you want to quit!"
DO
    i = _MOUSEINPUT ' read #1
    IF _MOUSEBUTTON(1) THEN PRINT "Left button down!": EXIT DO
LOOP
DO '                                                      need to wait
    i = _MOUSEINPUT '  read #2                         until the mouse
LOOP UNTIL NOT _MOUSEBUTTON(1) '                       button is released

PRINT "DONE!" 

```

Checking for a click or a double-click by the user.

```vb

DO  'main program loop

  DO WHILE _MOUSEINPUT                'check mouse status
    buttondown = _MOUSEBUTTON(1)
  LOOP
  DO WHILE buttondown                 'check for button release
    i = _MOUSEINPUT
    buttondown = _MOUSEBUTTON(1)
    Click = 1
  LOOP

  IF Click = 1 THEN                   'if button was pressed and released
    t = TIMER + .3
    DO WHILE TIMER < t      'check for a second press within .3 seconds
      i = _MOUSEINPUT
      IF _MOUSEBUTTON(1) THEN Click = 2: EXIT DO
    LOOP
    IF Click = 2 THEN PRINT "Double click" ELSE PRINT "Click"
  END IF
  Click = 0: buttondown = 0            'reset where needed
LOOP UNTIL INKEY$ = CHR$(27) 

```

> *Explanation:* To find the current button status read [_MOUSEINPUT](_MOUSEINPUT) repeatedly. The [TIMER](TIMER) loop looks for a second click.

Verifying that a user clicked and released a mouse button on a program button.

```vb

SCREEN 12
LINE (250, 250)-(300, 300), 14, BF

DO
  Mouser mx, my, mb
  IF mb THEN
    IF mx >= 250 AND my >= 250 AND mx <= 300 AND my <= 300 THEN 'button down
      DO WHILE mb 'wait for button release
        Mouser mx, my, mb
      LOOP
      'verify mouse still in box area
      IF mx >= 250 AND my >= 250 AND mx <= 300 AND my <= 300 THEN PRINT "Click verified on yellow box!"
    END IF
  END IF
LOOP

SUB Mouser (x, y, b)
mi = _MOUSEINPUT
b = _MOUSEBUTTON(1)
x = _MOUSEX
y = _MOUSEY
END SUB 

```

> *Explanation:* The mouse SUB has no internal [_MOUSEINPUT](_MOUSEINPUT) loop so that no button presses, releases or moves are missed.
> If the above read procedure goes to another one, it may be advisable to skip over unread input in a [_MOUSEINPUT](_MOUSEINPUT) only loop.

```text

SUB Catchup
DO WHILE _MOUSEINPUT: LOOP 
END SUB 

```

> The above procedure can be used to catch up after [INPUT](INPUT), [LINE INPUT](LINE-INPUT) or [INPUT$](INPUT$) delays when mouse input may accumulate.

Combining mouse button or keyboard selections in a menu or test:

```vb

DO 'main program loop in demo only
  LOCATE 10, 10: PRINT "A" 'position A, B & C in same position on every question
  LOCATE 12, 10: PRINT "B"
  LOCATE 14, 10: PRINT "C" 'demo only

  DO: _LIMIT 10 'get user answer loop
    DO WHILE _MOUSEINPUT: LOOP 'read mouse
    K$ = UCASE$(INKEY$) 'read keypresses also
    x% = _MOUSEX
    y% = _MOUSEY
    Lclick = _MOUSEBUTTON(1)

    LOCATE 20, 10: PRINT x%, y%, Lclick 'only used to find mouse coordinates
    IF x% = 10 AND y% = 10 AND Lclick THEN 'position clicked
      DO
        i = _MOUSEINPUT
        x% = _MOUSEX
        y% = _MOUSEY
      LOOP WHILE _MOUSEBUTTON(1)
      IF x% = 10 AND y% = 10 THEN K$ = "A" 'position released
    END IF
    IF x% = 10 AND y% = 12 AND Lclick THEN 'position clicked
      DO
        i = _MOUSEINPUT
        x% = _MOUSEX
        y% = _MOUSEY
      LOOP WHILE _MOUSEBUTTON(1)
      IF x% = 10 AND y% = 12 THEN K$ = "B" 'position released
    END IF
    IF x% = 10 AND y% = 14 AND Lclick THEN 'position clicked
      DO
        i = _MOUSEINPUT
        x% = _MOUSEX
        y% = _MOUSEY
      LOOP WHILE _MOUSEBUTTON(1)
      IF x% = 10 AND y% = 14 THEN K$ = "C" 'position released
    END IF
  LOOP UNTIL K$ = "A" OR K$ = "B" OR K$ = "C" 'GOTO next question

  IF LEN(K$) THEN 'DEMO ONLY
    LOCATE 22, 35: PRINT "  Answer = "; K$ 'display user answer at location
    _DELAY 2 'allow time for user to view answer
    LOCATE 22, 35: PRINT "SELECT AGAIN"
    K$ = "" 'reset K$
  END IF
LOOP 'DEMO only loop use red X box to quit 

``` 

> *Explanation:* User can cancel letter selection by moving pointer off letter before releasing the left mouse button.

## See Also

* [_MOUSEX](_MOUSEX), [_MOUSEY](_MOUSEY), [_MOUSEWHEEL](_MOUSEWHEEL)
* [_MOUSEINPUT](_MOUSEINPUT), [_MOUSEMOVE](_MOUSEMOVE)
* [_MOUSESHOW](_MOUSESHOW), [_MOUSEHIDE](_MOUSEHIDE)
* [_DEVICES](_DEVICES), [_DEVICE$](_DEVICE$), [_LASTBUTTON](_LASTBUTTON)
* [_BUTTON](_BUTTON), [_BUTTONCHANGE](_BUTTONCHANGE) ([_DEVICES](_DEVICES))
* [Controller Devices](Controller-Devices)
