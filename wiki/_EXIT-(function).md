The [_EXIT](_EXIT) function prevents the user from closing a program and indicates if a user has clicked the close button in the window title (**X** button) or used CTRL + BREAK.

## Syntax

> exitSignal% = [_EXIT](_EXIT)

## Description

* Once the [_EXIT](_EXIT) function is used, the user can no longer manually exit the program until it is ended with [END](END) or [SYSTEM](SYSTEM).
* [_EXIT](_EXIT) returns any exit requests made after the initial call as:
  * 0 = no exit request has been made since _EXIT monitoring began in the program.
  * 1 = exit attempted by clicking the window X (close) button since last function call. (Bit 0 set)
  * 2 = exit attempted with CTRL + BREAK since last call. (Bit 1 set)
  * 3 = both CTRL + BREAK and the X box have been used since last call. (Bit 0 and 1 set)
* If a return value is not 0 the program can handle an exit request at a more convenient time if necessary.
* After being read, the _EXIT value is reset to 0 so store the value when a program delays an exit request.
* **Note: Once _EXIT has been used once, you must monitor your program by checking it for user _EXIT requests.**
* Don't just use _EXIT once to prevent a user from exiting a program early, as that constitutes bad practice.

## Example(s)

Using an ON TIMER check to read the _EXIT request return values.

```vb

q = _EXIT 'function read prevents any program exit at start of program
ON TIMER(5) GOSUB quit
TIMER ON
PRINT "  The Timer will check for exit request every 5 seconds."
PRINT "Click the X box and/or Ctrl - Break to see the _EXIT return!"
PRINT "                    Any Key Quits"
PRINT
DO: _LIMIT 30
  '                    ' simulated program loop
LOOP UNTIL INKEY$ <> ""
END

quit:
q = _EXIT
IF q THEN PRINT q;
SELECT CASE q
  CASE 1: PRINT "= X button was clicked"
  CASE 2: PRINT "= Ctrl + Break keypress"
  CASE 3: PRINT "= Both X and Ctrl + Break!"
END SELECT
RETURN 

```

Removing temporary files before closing a program upon a user's exit request.

```vb

x = _EXIT  'initial function call blocks a user exit
OPEN "t3mpdata.tmp" FOR APPEND AS #1
DO
IF _EXIT THEN CLOSE: KILL "t3mpdata.tmp": _DELAY 1: SYSTEM
LOOP 

```

Note: If you have a file named *t3mpdata.tmp* change the file name!

## See Also

* [SYSTEM](SYSTEM)
* [END](END)
* [EXIT](EXIT)
