**KEY(n)** assigns, enables, disables or suspends event trapping of a keypress by setting the flag [ON](ON), [STOP](STOP) or [OFF](OFF).

## Syntax

> KEY(number) {[ON](ON) | [OFF](OFF) | [STOP](STOP)}

## Description

* Predefined and user defined KEY event number assignments to use with KEY(n): 

```text

     **1 to 10**.............Reserved **F1 to F10** function keys only.
     **11, 12, 13 and 14**...Reserved **Up, Left, Right and Down** numeric keypad arrows only
     **15 to 29**............**user-defined keys** using value: [CHR$](CHR$)(keyflag)  + [CHR$](CHR$)([Keyboard scancodes](Keyboard-scancodes))
     **30 and 31**...........Reserved **F11 and F12** function keys only.

```

* Keypresses can be read during [INKEY$](INKEY$), [INPUT$](INPUT$) or [INPUT](INPUT) procedures without losing the input. 
* Key event reads will also interrupt [SLEEP](SLEEP). 
* [KEY(n)](KEY(n)) specific status modes are:
     - **ON** enables specific keypress events to be monitored. 
     - **STOP** suspends specific keypress reads, but remembers them. When re-enabled the key presses will be returned.
     - **OFF** disables specified keypress reads and will not remember the event.

## Example(s)

How to trap the LEFT direction keys on both the dedicated cursor keypad and the numeric keypad.

```vb

KEY 15, CHR$(128) + CHR$(75) ' Assign trap for LEFT arrow key on the cursor keypad
ON KEY(15) GOSUB CursorPad     
KEY(15) ON ' enable event trapping                   

ON KEY(12) GOSUB NumericPad ' Trap LEFT key on number pad
KEY(12) ON ' enable event trapping                      

DO
LOOP UNTIL UCASE$(INKEY$) = "Q" ' Idle loop for demo
SYSTEM

CursorPad:
PRINT "Pressed LEFT key on cursor keypad."
RETURN

NumericPad:
PRINT "Pressed LEFT key on numeric keypad."
RETURN 

```

Trapping the F5 keypress.

```vb

KEY(5) ON
ON KEY(5) GOSUB execute
PRINT "Press F5 (or ESC) to quit!)"
DO
LOOP UNTIL INKEY$ = CHR$(27) ' idle loop
SYSTEM
execute:
PRINT "You pressed the F5 key..."
SLEEP 1
PRINT "Press any key to continue..."
SLEEP 

```

## See Also

* [ON KEY(n)](ON-KEY(n)), [KEY n](KEY-n) (softkeys)
* [_KEYHIT](_KEYHIT), [_KEYDOWN](_KEYDOWN)
* [Keyboard scancodes](Keyboard-scancodes)
