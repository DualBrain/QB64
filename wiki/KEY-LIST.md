See [KEY n](KEY-n).

The [KEY LIST](KEY-LIST) statement lists the soft key strings assigned to each of the function keys down the left side of the screen.

## Syntax

> [KEY LIST](KEY-LIST)

## Description

* [KEY LIST](KEY-LIST) displays each of the 12 softkey **function key** (F1 to F12) string values going down the screen.

## Example(s)

Displaying the current **KEY LIST** string assignments to the Function keys.

```vb

KEY 1, "Help"
KEY 5, "Compile"
KEY 10, "Quit"
PRINT "Press any key!"
K$ = INPUT$(1)
KEY LIST
END

```

```text

Press any key!
F1  Help
F2
F3
F4
F5  Compile
F6
F7
F8
F9
F10 Quit
F11
F12

```

Displaying the function key assignments for F1 to F10 at the bottom of the screen with **KEY ON** and **KEY OFF**.

```vb

KEY 1, "Help" + CHR$(13)    'add Return character to complete the input
KEY 5, "Compile" + CHR$(13)
KEY 10, "Quit" + CHR$(13)
**KEY ON**
DO
INPUT "Press F10 to turn display off! ", M$
LOOP UNTIL M$ = "Quit"
**KEY OFF**
K$ = INPUT$(1)
KEY LIST
END

```

```text

Press F10 to turn display off! Help
Press F10 to turn display off! Compile

1 Help?  2        3        4        5 Compil  6        7        8        9        10 Quit?

```

> *Explanation:* The [INPUT](INPUT) variable will hold the string value as if it was typed in and entered. "Quit" will KEY OFF bottom display.

## See Also

* [KEY n](KEY-n), [KEY(n)](KEY(n)),
* [ON KEY(n)](ON-KEY(n))
* [_KEYHIT](_KEYHIT), [_KEYDOWN](_KEYDOWN)
