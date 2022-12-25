The [ON KEY(n)](ON-KEY(n)) statement defines a line number or label to go to (or a [SUB](SUB) to run) when a specified key is pressed.

## Syntax

>  [ON KEY(n)](ON-KEY(n)) [GOSUB](GOSUB) linelabel|linenumber
>  [ON KEY(n)](ON-KEY(n)) [SUB](SUB)procedure

## Description

* Predefined and user defined KEY event number assignments to use with ON KEY(n): 
  * **1 to 10**.............Reserved **F1 to F10** function keys only.
  * **11, 12, 13 and 14**...Reserved **Up, Left, Right and Down** numeric keypad arrows only
  * **15 to 29**............**user-defined keys** using value: [CHR$](CHR$)(keyflag) + [CHR$](CHR$)([Keyboard scancodes](Keyboard-scancodes))
  * **30 and 31**...........Reserved **F11 and F12** function keys only.
* See the [KEY n](KEY-n) page for user defined key or key combination presses and F function softkey assignments.
* [GOSUB](GOSUB) with a linelabel or linenumber  or a [SUB](SUB) procedure (without the [CALL](CALL) keyword) can be triggered in **QB64**.

## Example(s)

Using ON KEY with [GOSUB](GOSUB) to execute code.

```vb

KEY(1) ON
ON KEY(1) GOSUB trap
PRINT "Press F1 to quit!"
DO:LOOP          'never ending loop

trap:
PRINT "You pressed F1 like I told you to :)"
END
RETURN 

```

Setting multiple ON KEY statements to send different values to a [SUB](SUB) procedure.

```vb
  
FOR n = 1 TO 10
  KEY n, STR$(n)  '   assigns soft key as a numerical string 
  ON KEY(n) Funct n  'designate SUB procedure and parameter value passed
  KEY(n) ON '         turns each key event monitor on
NEXT
KEY ON  'displays F1 to F10 soft key assignments at bottom of screen

DO
LOOP UNTIL INKEY$ = CHR$(27)
END

SUB Funct (num%)
CLS'                  clears the screen and refreshes bottom soft key list
PRINT "You pressed F"; LTRIM$(STR$(num%))
END SUB 

```

## See Also

* [KEY(n)](KEY(n)), [KEY n](KEY-n) (soft key)
* [ON...GOSUB](ON...GOSUB), [Scancodes](Scancodes)
* [_KEYHIT](_KEYHIT), [_KEYDOWN](_KEYDOWN)
