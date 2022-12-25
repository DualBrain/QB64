The [_MOUSEINPUT](_MOUSEINPUT) function is used to monitor any new mouse positions, button presses or movements of the scroll wheel. Must be called before other mouse information becomes available.

## Syntax

> infoExists%% = [_MOUSEINPUT](_MOUSEINPUT)

## Description

* Returns -1 if new mouse information is available, otherwise it returns 0.
* Must be called before reading any of the other mouse functions. The function will not miss any mouse input even during an [INPUT](INPUT) entry.
* Use in a loop to monitor the mouse buttons, scroll wheel and coordinate positions.
* To clear all previous mouse data, use [_MOUSEINPUT](_MOUSEINPUT) in a loop until it returns 0.

## Example(s)

Mouse coordinate, click and scroll events are returned sequentially inside of a _MOUSEINPUT loop.

```vb

DO
  DO WHILE _MOUSEINPUT '      Check the mouse status
    PRINT _MOUSEX, _MOUSEY, _MOUSEBUTTON(1), _MOUSEWHEEL
  LOOP
LOOP UNTIL INKEY$ <> "" 

```

> *Explanation:* The latest mouse function status can be read after the loop. [_LIMIT](_LIMIT) and [_DELAY](_DELAY) loops will slow returns down.

How to use a _MOUSEINPUT loop to locate [PSET](PSET) positions on a screen using a right mouse button click.

```vb

SCREEN 12

DO ' main program loop

  ' your program code

  DO WHILE _MOUSEINPUT'mouse status changes only
    x = _MOUSEX
    y = _MOUSEY
    IF x > 0 AND x < 640 AND y > 0 AND y < 480 THEN
      IF _MOUSEBUTTON(2) THEN
        PSET (x, y), 15
        LOCATE 1, 1: PRINT x, y
      END IF
    END IF
  LOOP 

  ' your program code

LOOP UNTIL INKEY$ = CHR$(27) 

```

Clearing any mouse data read before or during an [INPUT](INPUT) entry. Press "I" to enter input:

```vb

PRINT "Press I to enter input! Press Q to quit"
DO 
  K$ = UCASE$(INKEY$) 
  DO  
    IF _MOUSEBUTTON(1) = -1 THEN PRINT "*"    'indicates a mouse click event
  LOOP WHILE _MOUSEINPUT
  IF K$ = "Q" THEN END 
  IF K$ = "I" THEN                                          'press I to enter text
    INPUT "Click the mouse and enter something: ", entry$   'enter some text 
    GOSUB Clickcheck                                        'clear mouse data
  END IF 
LOOP 

END 

Clickcheck: 
count = 0 
DO  
  count = count + 1 
LOOP WHILE _MOUSEINPUT
PRINT count        'returns the number of loops before mouse data is cleared
RETURN 

```

> *Explanation:* Click the mouse a few times while entering [INPUT](INPUT) text. When Enter is pressed, the number of loops are displayed.

## See Also

* [_MOUSEX](_MOUSEX), [_MOUSEY](_MOUSEY), [_MOUSEBUTTON](_MOUSEBUTTON), [_MOUSEWHEEL](_MOUSEWHEEL)
* [_MOUSESHOW](_MOUSESHOW), [_MOUSEHIDE](_MOUSEHIDE), [_MOUSEMOVE](_MOUSEMOVE)
* [Controller Devices](Controller-Devices)
