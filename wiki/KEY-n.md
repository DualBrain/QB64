The [KEY n](KEY-n) statement is used to assign a "soft key" string or a flag and scan code to a function key or display function soft key assignments. 

## Syntax

>  **KEY *n%*, *textString$***

>  **KEY *n%*, CHR$(*keyFlag%*) + CHR$(*scanCode*)**

## Function Soft Key Strings (1 to 10, 30 & 31)

**Assigning "Softkey" [STRING](STRING) values to function key press events**

* n% is the number 1 to 10 (F1 to F10), 30 or 31 (F11 or F12) of the function key to assign the soft key string.
* Instead of using an [ON KEY(n)](ON-KEY(n)) [GOSUB](GOSUB) statement, Function keys F1 to F12 can be assigned a "soft key" string value to return.
* `KEY n, text$` defines a literal or variable [STRING](STRING) "soft key" function key return value.

```text

        **KEY 1, "Help"** 'returns the string "Help" to [INPUT](INPUT) variable when F1 is pressed

```

* [KEY LIST](KEY-LIST) displays each of the 12 softkey **function key** (F1 to F12) string values going down left side of screen.
* [KEY LIST](KEY-LIST) displays or hides the softkey values of function keys F1 to F10 at the bottom of the screen.

## Number Pad Arrow Keys (11 to 14)

* Arrow keys on the Number Pad are predefined KEY numbers 11 to 14 and only work with Number Lock off.
* Soft Key [STRING](STRING)s cannot be assigned to these key numbers!
* To use the extended arrow keys on a keyboard use the Extended Key Flag 128 with corresponding Scan code as User Defined Keys.

## User Defined Keys (15 to 29)

**Assigning user defined keys or combinations with: KEY n, CHR$(keyflag) + CHR$(scancode)**

```text

                   **Function Key Flag Combination Values**

                  **0** = no function key combination flag(single key)
                  **1** = Left Shift key flag
                  **2** = Right Shift key flag
                  **4** = Ctrl flag
                  **8** = Alt flag
                 **32** = Number Lock flag
                 **64** = Caps Lock flag
                **128** = Extended keys (see trapping extended keys below)

          Flag values can be added to monitor multiple function key combinations.

```

* After the keyflag code character the [Scancodes](Scancodes) character is added using one of the two **trapping methods** that follow:

```text

'                           **Soft Key Scan Code Values**
'
'       1  2  3  4  5  6  7  8  9  10   30  31                       Predefined Keys
**'  Esc  F1 F2 F3 F4 F5 F6 F7 F8 F9 F10  F11 F12   SysReq ScrL Pause**                  
'   1   59 60 61 62 63 64 65 66 67 68   87  88     --    70    29            
'  **`~  1! 2@ 3# 4$ 5% 6^ 7& 8* 9( 0) -_ =+ BkSpc  Insert Home PgUp   NumL   /     *    -** 
'   41 2  3  4  5  6  7  8  9  10 11 12 13  14     82    71    73    32/69  53    55   74
'  **Tab  Q  W  E  R  T  Y  U  I  O  P  [{ ]} \|    Delete End  PgDn   7/Home 8/▲  9/PU  + **
'   15  16 17 18 19 20 21 22 23 24 25 26 27 43     83    79    81     71   11/72  73   78
'  **CapL  A  S  D  F  G  H  J  K  L  ;: '"  Enter                     4/◄-   5    6/-►  E**
'  64/58 30 31 32 33 34 35 36 37 38 39 40   28                       12/75  76   13/77 **n**
'  **Shift  Z  X  C  V  B  N  M  ,< .> /?    Shift         ▲           1/End  2/▼  3/PD  t**
'  1/42   44 45 46 47 48 49 50 51 52 53    2/54          72           79   14/80  81   **e**
'  **Ctrl Win Alt    Spacebar    Alt Win Menu Ctrl     ◄-  ▼   -►      0/Insert    ./Del r**
'  4/29  91 8/56      57       56  92   93  29       75  80  77       82          83   28 
'
'   **Keyflag:** Function(0, 1, 2, 4, 8, 32, 64), Extended(128) **Scan Code: **1-88, QB64 only(91-93)
'
'        Reserved and function key combinations can be made using the scan code instead.
'             Add function flag values to 128 for Extended key combinations.

```

**Trapping Ctrl, Alt and Shift key combinations**

> Keyboard Flag values can be added to monitor more than one control key. For example, flag combination 12 would flag both the Ctrl and Alt key presses. Since the flag already determines the function key to monitor, you don't necessarily have to use it's scancode. You can look for a key combination such as Ctrl + by using the plus key's scancode which is 13 as shown below: 

```text

      **KEY 15, CHR$(4) + CHR$(13)** 'enabled event when Ctrl and + key are pressed

```

**Trapping Extended keys (Insert, Home, Page Up, Right Ctrl, R.Alt, and cursor arrow pad)**

On a 101-key keyboard, you can trap any of the keys on the dedicated cursorpad by assigning the string to any of the keynumber values from 15 to 25 using the 128 keyboard flag. The cursor arrows are not the same as the pre-assigned number pad arrows:

```text

      **KEY n, [CHR$](CHR$)(128) + [CHR$](CHR$)(scancode) ' where n = 15 to 29. See: [Scancodes](Scancodes)**

              KEY 15, CHR$(128) + CHR$(75)  'left arrow cursor pad 

              KEY 16, CHR$(128) + CHR$(72)  'up arrow cursor pad  

              KEY 17, CHR$(128) + CHR$(77)  'right arrow cursor pad

              KEY 18, CHR$(128) + CHR$(80)  'down arrow cursor pad

```

Use CHR$(0) for the first byte flag for non-function keys. You can substitute a literal [STRING](STRING) value to trap as shown in Example 2.

## Examples

Shows a list of all the string assignments to the function keys F1-F12 (Prints help every time F1 is pressed in the input)

```vb

KEY 1, "Help"
KEY LIST
INPUT "Press F1 or to quit press ENTER: ", a$


```

```text

F1 Help
F2
F3
F4
F5
F6
F7
F8
F9
F10
F11
F12
Press F1 or to quit press ENTER: HelpHelpHelpHelp

```

Trapping the Control + key combination. Use the Control Keyboard flag 4 and + key scancode 13.

```vb

CLS 
KEY 15, CHR$(4) + CHR$(13)     'scancode for "=" or "+" key is 13
ON KEY(15) GOSUB control       'action of user defined key press 
KEY(15) ON                     'turn ON event trapping for key combination 
PRINT "Press Ctrl and plus key combination, escape quits!"
DO: SLEEP
count = count + 1
PRINT count;
IF INKEY$ = CHR$(27) THEN END  'escape key exit
LOOP

control:                             'NUMBER LOCK MUST BE OFF!
PRINT "Control and + keys pressed!";
RETURN 

```

Differentiating the extended cursor keypad arrows from the predefined Number Pad arrow keys.

```vb

'predefined keys 11 to 14 for number pad arrows only
ON KEY(11) GOSUB UpNum: KEY(11) ON 'up
ON KEY(12) GOSUB LNum: KEY(12) ON  'left
ON KEY(13) GOSUB RNum: KEY(13) ON  'right
ON KEY(14) GOSUB DnNum: KEY(14) ON 'down
'user defined keys use extended key flag 128 + scan code 
ON KEY(15) GOSUB UpPad 
KEY 15, CHR$(128) + CHR$(72): KEY(15) ON 'cursor up
ON KEY(16) GOSUB LPad  
KEY 16, CHR$(128) + CHR$(75): KEY(16) ON 'cursor left
ON KEY(17) GOSUB RPad
KEY 17, CHR$(128) + CHR$(77): KEY(17) ON 'cursor right
ON KEY(18) GOSUB DnPad 
KEY 18, CHR$(128) + CHR$(80): KEY(18) ON 'cursor down

DEF SEG = 0
DO
  numL = PEEK(1047) AND 32 '32 if on
  capL = PEEK(1047) AND 64 '64 on
  IF numL OR capL THEN
    COLOR 12: LOCATE 13, 50: PRINT "Turn Num or Cap Lock OFF!"
  ELSE : COLOR 10: LOCATE 13, 50: PRINT "Number and Cap Lock OK!  "
    SLEEP                  ' KEY or TIMER event breaks a sleep
  END IF  
LOOP UNTIL INKEY$ = CHR$(27)
DEF SEG

KEY(15) OFF: KEY(16) OFF: KEY(17) OFF: KEY(18) OFF
KEY(11) OFF: KEY(12) OFF: KEY(13) OFF: KEY(14) OFF
END

UpPad:
COLOR 14: LOCATE 11, 26: PRINT " Up cursor pad  "
RETURN
LPad:
COLOR 14: LOCATE 11, 26: PRINT "Left cursor pad "
RETURN
RPad:
COLOR 14: LOCATE 11, 26: PRINT "Right cursor pad"
RETURN
DnPad:
COLOR 14: LOCATE 11, 26: PRINT "Down cursor pad "
RETURN
UpNum:
COLOR 11: LOCATE 11, 26: PRINT " Up number pad  "
RETURN
LNum:
COLOR 11: LOCATE 11, 26: PRINT "Left number pad "
RETURN
RNum:
COLOR 11: LOCATE 11, 26: PRINT "Right number pad"
RETURN
DnNum:
COLOR 11: LOCATE 11, 26: PRINT "Down number pad "
RETURN 

```

> *Explanation:* The Number Lock or Caps Lock keys ON may hinder extended key reads in QBasic but not QB64!

## See Also
 
* [KEY LIST](KEY-LIST), [ON KEY(n)](ON-KEY(n)) 
* [KEY(n)](KEY(n)), [INKEY$](INKEY$)
* [_KEYHIT](_KEYHIT), [_KEYDOWN](_KEYDOWN)
* [Keyboard scancodes](Keyboard-scancodes)
