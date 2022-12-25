The [INKEY$](INKEY$) function returns user input as [ASCII](ASCII) [STRING](STRING) character(s) from the keyboard buffer.

## Syntax

> keypress$ = [INKEY$](INKEY$)

## Description

* Returns [ASCII](ASCII) character string values in upper or lower cases. See: [UCASE$](UCASE$) and [LCASE$](LCASE$)
* Returns "" if no key has been pressed since the last keyboard read.
* Some control keys cannot be read by INKEY$ or will return 2 byte [ASCII](ASCII) codes.
* INKEY$ can also be used to clear a [SLEEP](SLEEP) key press or the keyboard buffer in a loop.
* Assign the INKEY$ return to a string variable to save the key entry.
* `LOCATE , , 1` displays the INKEY$ cursor. Use `LOCATE , , 0` to turn it off.
* To receive input from a [$CONSOLE]($CONSOLE) window, use [_CINP](_CINP).
* Returns can be evaluated as certain [ASCII](ASCII) characters or codes.

```text

'                                **ASCII Keyboard Codes**
'
**' Esc  F1  F2  F3  F4  F5  F6  F7  F8  F9  F10  F11  F12  Sys ScL Pause**
'  27 +59 +60 +61 +62 +63 +64 +65 +66 +67 +68  +133 +134   -   -    -
**' `~  1!  2@  3#  4$  5%  6^  7&  8*  9(  0) -_ =+ BkSp   Ins Hme PUp   NumL  /   *    -**
' 126 33  64  35  36  37  94  38  42  40  41 95 43   8    +82 +71 +73    -    47  42   45
**  96 49  50  51  52  53  54  55  56  57  48 45 61*
**' Tab Q   W   E   R   T   Y   U   I   O   P  [{  ]}  \|   Del End PDn   7Hme 8/▲  9PU  + **
'  9  81  87  69  82  84  89  85  73  79  80 123 125 124  +83 +79 +81   +71  +72  +73  43
**    113 119 101 114 116 121 117 105 111 112  91  93  92                 55   56   57 *
**' CapL  A   S   D   F   G   H   J   K   L   ;:  '" Enter                4/◄-  5   6/-►
'   -   65  83  68  70  71  72  74  75  76  58  34  13                  +75  +76  +77  **E**
**       97 115 100 102 103 104 106 107 108  59  39                       52   53   54 * **n**
**' Shift  Z   X   C   V   B   N   M   ,<  .>  /?    Shift       ▲        1End 2/▼  3PD  t**
'   *    90  88  67  86  66  78  77  60  62  63      *        +72       +79  +80  +81  **e**
**       122 120  99 118  98 110 109  44  46  47                          49   50   51 * **r**
**' Ctrl Win Alt       Spacebar          Alt Win Menu Ctrl   ◄-  ▼   -►   0Ins     .Del **
'  *    -   *           32              *   -   -    *    +75 +80 +77   +82       +83  13
'                                                                   *     48        46*
'
' **    *Italics* = LCase/NumLock On  * = 2 byte combo only,  + = 2 Byte: CHR$(0) + CHR$(code)**
'

```

## Two Byte Combinations

* INKEY$ 2 byte combinations always begin with [CHR$](CHR$)(0). [ASC](ASC) will always read the first byte code as zero.
* Read the second byte code using: **code2 = ASC(press$, 2)**

**[ASCII](ASCII)**

```text

                    **Two Byte Characters        Key                 CHR$(0) + "?" **

                    CHR$(0) + CHR$(16-50)      [Alt] + letter
                    CHR$(0) + CHR$(59)         [F1]                 ";"
                    CHR$(0) + CHR$(60)         [F2]                 "<"
                    CHR$(0) + CHR$(61)         [F3]                 "="
                    CHR$(0) + CHR$(62)         [F4]                 ">"
                    CHR$(0) + CHR$(63)         [F5]                 "?"
                    CHR$(0) + CHR$(64)         [F6]                 "@"
                    CHR$(0) + CHR$(65)         [F7]                 "A"
                    CHR$(0) + CHR$(66)         [F8]                 "B"
                    CHR$(0) + CHR$(67)         [F9]                 "C"
                    CHR$(0) + CHR$(68)         [F10]                "D"
                    CHR$(0) + CHR$(71)         [Home]               "G"
                    CHR$(0) + CHR$(72)         [↑] Arrow            "H"
                    CHR$(0) + CHR$(73)         [Page Up]            "I"
                    CHR$(0) + CHR$(75)         [←] Arrow            "K"
                    CHR$(0) + CHR$(76)         [5 NumberPad]        "L" (NumLock off in QB64)
                    CHR$(0) + CHR$(77)         [→] Arrow            "M"
                    CHR$(0) + CHR$(79)         [End]                "O"
                    CHR$(0) + CHR$(80)         [↓] Arrow            "P"
                    CHR$(0) + CHR$(81)         [Page Down]          "Q"
                    CHR$(0) + CHR$(82)         [Insert]             "R"
                    CHR$(0) + CHR$(83)         [Delete]             "S"
                    CHR$(0) + CHR$(84-93)      [Shift] + F1-10
                    CHR$(0) + CHR$(94-103)     [Ctrl] + F1-10
                    CHR$(0) + CHR$(104-113)    [Alt] + F1-10
                    CHR$(0) + CHR$(114-119)    [Ctrl] + keypad
                    CHR$(0) + CHR$(120-129)    [Alt] + number
                    CHR$(0) + CHR$(130 or 131) [Alt] + _/- or +/=   "é" or "â"
                    CHR$(0) + CHR$(133)        [F11]                "à"
                    CHR$(0) + CHR$(134)        [F12]                "å"
                    CHR$(0) + CHR$(135)        [Shift] + [F11]      "ç"
                    CHR$(0) + CHR$(136)        [Shift] + [F12]      "ê"
                    CHR$(0) + CHR$(137)        [Ctrl] + [F11]       "ë"
                    CHR$(0) + CHR$(138)        [Ctrl] + [F12]       "è"
                    CHR$(0) + CHR$(139)        [Alt] + [F11]        "ï"
                    CHR$(0) + CHR$(140)        [Alt] + [F12]        "î"

```

> In **QB64**, [CVI](CVI) can be used to get the [_KEYDOWN](_KEYDOWN) 2-byte code value. Example: **status = _KEYDOWN(CVI(CHR$(0) + "P"))**

## Example(s)

Clearing the keyboard buffer after [SLEEP](SLEEP) delays for later [INPUT](INPUT).

```vb

PRINT "Press any keyboard typing key to end SLEEP"
SLEEP
DO: K$ = INKEY$: PRINT K$: LOOP UNTIL K$ = "" 

```

> *Explanation:* [SLEEP](SLEEP) key presses will be kept in the keyboard buffer and may be added into an [INPUT](INPUT) later.

> See also: [_KEYCLEAR](_KEYCLEAR)

Entering a Ctrl + letter keypress combination will print [ASCII](ASCII) Control characters 1 to 26. .

```vb

DO
    K$ = INKEY$
    IF K$ <> "" THEN PRINT K$; " ";
LOOP UNTIL K$ = CHR$(27) 'Esc key exit 

```

> *Note:* The above code will print Esc arrow, Backspace symbol, and 2 byte characters led by CHR$(0) in addition to normal keys.

Use [UCASE$](UCASE$)(INKEY$) in a keyboard read loop looking for uppercase "Y" or "N" user inputs to avoid multiple IF statements.

```vb

DO
  PRINT "Do you want to continue? (Y/N): ";  'semicolon saves position for user entry
  DO: K$ = UCASE$(INKEY$) 'change any user key press to uppercase
  LOOP UNTIL K$ = "Y" OR K$ = "N"
  PRINT K$  'print valid user entry
  IF K$ = "N" THEN END
LOOP  

```

Getting just number values entered by a user in an INKEY$ input loop.

```vb

LOCATE 10, 10: PRINT "Enter a number value: ";
DO: SLEEP
  K$ = INKEY$
  IF K$ >= CHR$(48) AND K$ <= CHR$(57) THEN entry$ = entry$ + K$ ' numbers only
  L = LEN(entry$) ' check entry length for possible backspace
  IF K$ = CHR$(46) AND flag = 0 THEN entry$ = entry$ + K$: flag = 1: mark = L ' decimal point
  IF K$ = CHR$(8) AND L > 0 THEN ' backspace pressed and entry has a length
    entry$ = MID$(entry$, 1, L - 1) ' remove one character from entry$
    IF LEN(entry$) < mark THEN flag = 0 ' allow decimal point entry if other was removed.
    LOCATE CSRLIN, POS(0) - 1: PRINT SPACE$(1); ' remove end character from screen
  END IF
  LOCATE 10, 32: PRINT entry$; ' display entry to user (semicolon required for correct POS)
LOOP UNTIL K$ = CHR$(13) AND L > 0 'assures something is entered 

```

> *Explanation:* [SLEEP](SLEEP) waits for a keypress. It also allows background programs to share the processor and it leaves the keypress in the buffer for INKEY$. Keyboard string number characters range from [ASCII](ASCII) codes 48 to 57. Any other entry is ignored by the IF statement. A decimal point (code 46) entry is allowed once in the input. The flag value stops further decimal point additions. Backspacing (code 8) is also allowed if the entry has at least one character. The cursor column returned by [POS](POS)(0) reverts too after the end of the entry when printed each loop. The loop exits when [Enter] (code 13) is pressed and the entry has a length.

Using arrow keys to move a text character. A change from a previous position tells program when to PRINT:

```vb

movey = 1: movex = 1 'text coordinates can never be 0
at$ = "@"  'text sprite could be almost any ASCII character
LOCATE movey, movex: PRINT at$;
DO
    px = movex: py = movey 'previous positions
    B$ = INKEY$
    IF B$ = CHR$(0) + CHR$(72) AND movey > 1 THEN movey = movey - 1 'rows 1 to 23 only
    IF B$ = CHR$(0) + CHR$(80) AND movey < 23 THEN movey = movey + 1
    IF B$ = CHR$(0) + CHR$(75) AND movex > 1 THEN movex = movex - 1 'columns 1 to 80 only
    IF B$ = CHR$(0) + CHR$(77) AND movex < 80 THEN movex = movex + 1

    IF px <> movex OR py <> movey THEN 'only changes when needed
        LOCATE py, px: PRINT SPACE$(1); 'erase old sprite
        LOCATE movey, movex: PRINT at$; 'show new position
    END IF
LOOP UNTIL B$ = CHR$(27) 'ESCape key exit
END

```

Using INKEY$ with the arrow or WASD keys to move the QB64 bee image sprite with [_PUTIMAGE](_PUTIMAGE):

```vb

DIM image AS LONG
DIM x AS INTEGER
DIM y AS INTEGER
DIM Keypress AS STRING

SCREEN _NEWIMAGE(800, 600, 32)

x = 0
y = 0
image = _LOADIMAGE("QB64bee.png") 'Here I actually used the QB64 icon

DO
  _PUTIMAGE (x, y), image
  DO
    Keypress = UCASE$(INKEY$)
    ' ***** The following line detects the arrow keys *****
    IF LEN(Keypress) > 1 THEN Keypress = RIGHT$(Keypress, 1)
  LOOP UNTIL Keypress > ""

  CLS ' blank screen after valid key press to avoid smearing image on page

  SELECT CASE Keypress
    CASE "W", "H": y = y - 10 'Up
    CASE "A", "K": x = x - 10 'Left
    CASE "S", "P": y = y + 10 'Down
    CASE "D", "M": x = x + 10 'Right
    CASE "Q", CHR$(27): END 'Q or Esc Ends prog.
  END SELECT
  _PUTIMAGE (x, y), image
LOOP 

```
 
> *Note:* The image can be placed off of the screen without error. The image moves 10 pixels to move faster. [CLS](CLS) eliminates any background.

Creating upper [ASCII](ASCII) characters in a QB program using **Alt +** three number keys:

```vb

DO
    A$ = "": WHILE A$ = "": A$ = INKEY$: WEND
    IF LEN(A$) = 2 THEN '2 byte INKEY$ return
        B$ = RIGHT$(A$, 1)  'read second byte
        b% = ASC(B$)        'read second byte code
        IF b% > 119 AND b% < 130 THEN ' Alt + number codes only
           C% = b% - 119  ' convert to actual number
           IF C% > 9 THEN C% = 0
           num$ = num$ + LTRIM$(STR$(C%))
        END IF
    END IF
LOOP UNTIL LEN(num$) = 3  ' 3 digit codes only

PRINT num$
PRINT CHR$(VAL(num$)

```

```text

 155 ¢ 

```

> *Explanation:* Hold down Alt key and press 3 keyboard code number keys. **Number pad keys may not work.** Note that [INKEY$](INKEY$) cannot read Alt, Ctrl or Shift key presses without a key combination and the return is CHR$(0) + CHR$(code).

## See Also

* [_KEYHIT](_KEYHIT), [_KEYDOWN](_KEYDOWN), [_MAPUNICODE](_MAPUNICODE)
* [_KEYCLEAR](_KEYCLEAR)
* [INPUT](INPUT), [LINE INPUT](LINE-INPUT)
* [INPUT$](INPUT$), [INP](INP)
* [CHR$](CHR$), [ASCII](ASCII)
* [ASC](ASC), [Scancodes](Scancodes) (keyboard)
* [Windows Libraries](Windows-Libraries)
