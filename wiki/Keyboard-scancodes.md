* **Keyboards with Alt Gr key:** [_KEYHIT](_KEYHIT) may return both Alt(100307) and Ctrl(100306) codes when that key is pressed or released.
* **Linux with foreign keyboards:** [SHELL](SHELL) [_HIDE](_HIDE) "setxkbmap us" will setup a keyboard to read US [Scancodes](Scancodes).


## INKEY$ Codes

* [INKEY$](INKEY$) returns a [STRING](STRING) [ASCII](ASCII) character or a function key two byte string. [ASC](ASC) converts to code. Use: **key$ = INKEY$**
* Key presses are read consecutively from the keyboard buffer which will retain a [SLEEP](SLEEP) key press.


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
' **    *Italics* = LCase/NumLock On  [INKEY$](INKEY$),  + = 2 Byte: CHR$(0) + CHR$(code)**
'

```


GO TO: [Keyboard scancodes](Keyboard-scancodes), 
[Keyboard Scancodes](Keyboard-Scancodes),  [Keyboard Scancodes](Keyboard-Scancodes), [Keyboard Scancodes](Keyboard-Scancodes), [Keyboard Scancodes](Keyboard-Scancodes)

## INP and _CINP Scan Codes

* [_CINP](_CINP) can be used in [$CONSOLE]($CONSOLE) Windows to read individual key presses.
* [INP](INP)([&H](&H)60) returns multiple [INTEGER](INTEGER) press and release codes as keys are used. Use: **code% = INP(96)**
* To clear the keyboard buffer, use the [INKEY$](INKEY$) function before or after the [INP](INP) read to avoid buffer overflows and beeps.          
* Keys are assigned only one code irregardless of case or Lock mode with release codes being the press  code + 128.


```text

'                            **Extended Keyboard Press Scancodes**
'
**'  Esc  F1 F2 F3 F4 F5 F6 F7 F8 F9 F10  F11 F12   SysReq ScrL Pause**                  
'   1   59 60 61 62 63 64 65 66 67 68   87  88     0     70    29
'  **`~  1! 2@ 3# 4$ 5% 6^ 7& 8* 9( 0) -_ =+ BkSpc  Insert Home PgUp   NumL   /     *    -** 
'   41 2  3  4  5  6  7  8  9  10 11 12 13  14     82    71    73     69    53    55   74
'  **Tab  Q  W  E  R  T  Y  U  I  O  P  [{ ]} \|    Delete End  PgDn   7/Home 8/▲  9/PU  + **
'   15  16 17 18 19 20 21 22 23 24 25 26 27 43     83    79    81     71    72    73   78
'  **CapL  A  S  D  F  G  H  J  K  L  ;: '"  Enter                     4/◄-   5    6/-►  E**
'   58   30 31 32 33 34 35 36 37 38 39 40   28                        75    76    77   **n**
'  **Shift  Z  X  C  V  B  N  M  ,< .> /?    Shift         ▲           1/End  2/▼  3/PD  t**
'   42    44 45 46 47 48 49 50 51 52 53     54           72           79    80    81   **e**
'  **Ctrl Win Alt    Spacebar    Alt Win Menu Ctrl     ◄-  ▼   -►      0/Insert    ./Del r**
'   29  91  56        57       56  92   93  29       75  80  77       82          83   28 
'
'   QB64 codes only! **Release codes = Press code + 128. Pause/Break may lock code returns.**
'

```


[http://www.quadibloc.com/comp/scan.htm Keyboard Scan Codes]........... [http://www.win.tue.nl/~aeb/linux/kbd/scancodes.html Other Keyboards]


GO TO:[Keyboard Scancodes](Keyboard-Scancodes), [Keyboard Scancodes](Keyboard-Scancodes), [Keyboard Scancodes](Keyboard-Scancodes), [Keyboard Scancodes](Keyboard-Scancodes), [Keyboard Scancodes](Keyboard-Scancodes)

## ON KEY Events


* Assign user defined Soft Key or key combination numbers 15 to 29 with: **[KEY n](KEY-n)umber, CHR$(text) + CHR$(scancode)|green**
* Combo Key flags: <nowiki>0 = none, LShift = 1, RShift = 2, LCtrl = 4, LAlt = 8, NumLock = 32, CapsLock = 64</nowiki>, Extended keys = 128
* Red KEY numbers 1 to 14, 30 or 31 assign predefined one key events using: **[ON KEY(n)](ON-KEY(n))(number) [GOSUB](GOSUB) subname**


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
'             Add function and/or extended flag values for more key combinations.

```


GO TO:[Keyboard Scancodes](Keyboard-Scancodes), [Keyboard scancodes](Keyboard-scancodes), [Keyboard Scancodes](Keyboard-Scancodes), [Keyboard Scancodes](Keyboard-Scancodes), [Keyboard Scancodes](Keyboard-Scancodes)

## KEYHIT and KEYDOWN Codes

* [_KEYHIT](_KEYHIT) returns multiple [LONG](LONG) press and negative release codes as keys are used. Use: **code& = _KEYHIT**
* [_KEYDOWN](_KEYDOWN) returns -1 when a specified key code value is pressed or 0. Use: **status% = _KEYDOWN(code&)**
* [_KEYCLEAR](_KEYCLEAR) clears the keyboard buffer memory instantly without a [LOOP](LOOP).


```text

'                            **QB64 _KEYHIT and _KEYDOWN Values**
'
**'Esc  F1    F2    F3    F4    F5    F6    F7    F8    F9    F10   F11   F12   Sys  ScL Pause**                  
' 27 15104 15360 15616 15872 16128 16384 16640 16896 17152 17408 34048 34304 +316 +302 +019
**'`~  1!  2@  3#  4$  5%  6^  7&  8*  9(  0) -_ =+ BkSp   Ins   Hme   PUp   NumL   /     *    -** 
'126 33  64  35  36  37  94  38  42  40  41 95 43   8   20992 18176 18688 +300   47    42   45
** 96 49  50  51  52  53  54  55  56  57  48 45 61*
**'Tab Q   W   E   R   T   Y   U   I   O   P  [{  ]}  \|   Del   End   PDn   7Hme  8/▲   9PU   + **
' 9  81  87  69  82  84  89  85  73  79  80 123 125 124 21248 20224 20736 18176 18432 18688 43
**   113 119 101 114 116 121 117 105 111 112  91  93  92                    55    56    57 *
**'CapL   A   S   D   F   G   H   J   K   L   ;:  '" Enter                   4/◄-   5    6/-►  
'+301   65  83  68  70  71  72  74  75  76  58  34  13                    19200 19456 19712  **E**
**       97 115 100 102 103 104 106 107 108  59  39                         52    53    54 *   **n**                                    
**'Shift   Z   X   C   V   B   N   M   ,<  .>  /?    Shift       ▲           1End  2/▼   3PD   t**
'+304   90  88  67  86  66  78  77  60  62  63    +303       18432        20224 20480 20736  **e**
**      122 120  99 118  98 110 109  44  46  47                             49    50    51 *   **r**
**'Ctrl   Win  Alt     Spacebar      Alt  Win  Menu  Ctrl   ◄-   ▼   -►      0Ins        .Del **
'+306  +311 +308       32         +307 +312 +319  +305 19200 20480 19712  20992       21248 13 
'                                                                     *     48          46*
'     **    Lower value = LCase/NumLock On __________________ + = add 100000 **

```


GO TO: [Keyboard Scancodes](Keyboard-Scancodes), [Keyboard scancodes](Keyboard-scancodes), [Keyboard Scancodes](Keyboard-Scancodes), [Keyboard Scancodes](Keyboard-Scancodes), [Keyboard Scancodes](Keyboard-Scancodes)

>  Most keys use [ASCII](ASCII) key code values. Function key code values can be calculated using the [INKEY$](INKEY$), two byte values with [CVI](CVI).
Example: **status = _KEYDOWN(CVI(CHR$(0) + "P"))**

[INKEY$](INKEY$)

## [_DEVICES](_DEVICES) Button


* [_LASTBUTTON](_LASTBUTTON)(1) keyboards will normally return 512 buttons. One button is read per loop through all numbers.
* [_BUTTONCHANGE](_BUTTONCHANGE)(number) returns -1 when pressed, 1 when released and 0 when there is no event since the last read.
* [_BUTTON](_BUTTON)(number) returns -1 when a button is pressed and 0 when released.



```text

'                              **Keyboard Device 1 Button Numbers**
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
'                        **Mouse Device 2 buttons: Left = 1, Middle = 2, Right = 3**

```



GO TO: [Keyboard Scancodes](Keyboard-Scancodes), [Keyboard scancodes](Keyboard-scancodes), [Keyboard Scancodes](Keyboard-Scancodes), [Keyboard Scancodes](Keyboard-Scancodes), 
[Keyboard Scancodes](Keyboard-Scancodes)

## Windows Virtual Codes


* Virtual key code status can be read **independently of program focus in Windows**. Not available in Linux or Mac systems.
* Use: **status = GetKeyState%(code%)** or **GetAsyncKeyState%(code&)** or with **keybd_event** in [Windows Libraries](Windows-Libraries) "User32".



```text

'                                  **Virtual KeyState Codes**
'
**' Esc  F1  F2  F3  F4  F5  F6  F7  F8  F9  F10  F11 F12   Sys ScL Pause**                  
' 27   112 113 114 115 116 117 118 119 120 121  122 123   44  145 19
**' `~  1!  2@  3#  4$  5%  6^  7&  8* 9(  0) -_  =+  BkS   Ins Hme PUp   NumL  /   *    -** 
' 192 49  50  51  52  53  54  55  56  57 48 189 187  8    45  36  33    144  111  106 109
**' Tab Q   W   E   R   T   Y   U   I   O   P  [{  ]}  \|   Del End PDn   7Hme 8/▲  9PU  +**
'  9  81  87  69  82  84  89  85  73  79  80 219 221 120  46  35  34    103  104  105 107
**' CapL  A   S   D   F   G   H   J   K   L   ;:  '" Enter                4/◄-  5   6/-► E**
'  20   65  83  68  70  71  72  74  75  76 186 222  13                  100  101  102  **n**                                                                                                                          
**' Shift  Z   X   C   V   B   N   M   ,<  .>  /?    Shift       ▲        1End 2/▼  3PD  t**
' 16/160 90  88  67  86  66  78  77 188  190 191   16/161      38       97   98   99   **e**                                                                                       
**' Ctrl   Win   Alt       Spacebar      Alt Win Menu Ctrl   ◄-  ▼   -►   0Ins     .Del  r**
' 17/162 91  18/164        32        18/165 92  93 17/163  37  40  39   96        110  13
'
'     Num Lock On values shown. Off values same as functions and arrows, 5 = code 12.
'
'  **Mouse click returns: LB = 1, RB = 2, MB = 4, etc. [http://msdn.microsoft.com/en-us/library/windows/desktop/dd375731(v=vs.85).aspx Special keys] may also work.**

```



GO TO: [Keyboard Scancodes](Keyboard-Scancodes), [Keyboard scancodes](Keyboard-scancodes), [Keyboard Scancodes](Keyboard-Scancodes), [Keyboard Scancodes](Keyboard-Scancodes), [Keyboard Scancodes](Keyboard-Scancodes), 

## Example Code

An [INP](INP) Function that retrieves multiple scancodes (allows 2 players and diagonal moves). Function includes it's own array.


```vb

CLS
x = 40: px = x
y = 20: py = y
xx = 41: pxx = xx
yy = 21: pyy = yy

DO ' program or game loop
  _LIMIT 20  ' Delay .05 'in QBasic
  COLOR 15
  LOCATE 8, 14: PRINT "W A S D": LOCATE 8, 52: PRINT "ARROW PAD"
  IF ScanKey%(17) THEN 'W key
    LOCATE 2, 15: PRINT " UP "
    IF y > 1 THEN y = y - 1
  ELSE LOCATE 2, 15: PRINT "----" 
  END IF
  IF ScanKey%(31) THEN 'S key
    LOCATE 6, 15: PRINT "DOWN"
    IF y < 25 THEN y = y + 1
  ELSE LOCATE 6, 15: PRINT "----" 
  END IF
  IF ScanKey%(30) THEN 'A key
    LOCATE 4, 12: PRINT "LEFT"
    IF x > 1 THEN x = x - 1
  ELSE LOCATE 4, 12: PRINT "----" 
  END IF
  IF ScanKey%(32) THEN 'D key
    LOCATE 4, 18: PRINT "RIGHT"
    IF x < 80 THEN x = x + 1
  ELSE LOCATE 4, 18: PRINT "---- " 
  END IF
  IF ScanKey%(72) THEN 'up arrow
    LOCATE 2, 55: PRINT " UP " 
    IF yy > 1 THEN yy = yy - 1
  ELSE LOCATE 2, 55: PRINT "----" 
  END IF
  IF ScanKey%(80) THEN 'down arrow
    LOCATE 6, 55: PRINT "DOWN"  
    IF yy < 25 THEN yy = yy + 1
  ELSE LOCATE 6, 55: PRINT "----" 
  END IF
  IF ScanKey%(75) THEN 'left arrow
    LOCATE 4, 52: PRINT "LEFT" 
    IF xx > 1 THEN xx = xx - 1
  ELSE LOCATE 4, 52: PRINT "----" 
  END IF
  IF ScanKey%(77) THEN 'right arrow
    LOCATE 4, 58: PRINT "RIGHT" 
    IF xx < 80 THEN xx = xx + 1
  ELSE LOCATE 4, 58: PRINT "---- " 
  END IF
  LOCATE py, px: PRINT SPACE$(1);  'erase sprite at previous position
  LOCATE pyy, pxx: PRINT SPACE$(1);
  COLOR 10: LOCATE y, x: PRINT CHR$(1); 'place sprite at new position
  COLOR 12: LOCATE yy, xx: PRINT CHR$(2);
  px = x: py = y: pxx = xx: pyy = yy
LOOP UNTIL ScanKey%(1)
zerocodes% = ScanKey%(0) 'reset all array values to zero for next part of program
END

FUNCTION ScanKey% (scancode%)
STATIC Ready%, keyflags%() 'retain values on procedure exit
IF NOT Ready% THEN REDIM keyflags%(0 TO 127): Ready% = -1 'create array on first use
i% = INP(&H60) 'read keyboard states
IF (i% AND 128) THEN keyflags%(i% XOR 128) = 0
IF (i% AND 128) = 0 THEN keyflags%(i%) = -1
K$ = INKEY$ 'clears the key from buffer to prevent beeps
ScanKey% = keyflags%(scancode%)
IF scancode% = 0 THEN Ready% = 0 'a zero scancode value clears all previous key presses with a REDIM
END FUNCTION

SUB Delay (dlay!) 'optional QBasic delay
start! = TIMER
DO WHILE start! + dlay! >= TIMER
  IF start! > TIMER THEN start! = start! - 86400
LOOP
END SUB 

```

```text

     
                UP                                      UP

            ----  RIGHT                             LEFT  ----

               ----                                    ----    

             W A S D                                ARROW PAD





                                      ☺
                                       ☻ 

```

<sub>Adapted from Code by Cyperium.</sub>
> *Explanation:* Displays multiple arrow key presses to move a game character diagonally or allows 2 players to press keys at once. Each keypress is placed into a [STATIC](STATIC) array inside of the ScanKey function. When a key is pressed, the corresponding code index in the array is changed to -1 or True. When a key is released, the scancode returned is over 128 so AND 128 becomes True and the XOR 128 index value is changed to 0. XOR causes 128 to be subtracted from the release code index value which is then changed to 0 (False) from -1. As the main program loop reads the array each of the IF statements look to see if that code is -1. When a statement is True, it prints the appropriate key(s). The example moves two [ASCII](ASCII) sprites. **Note:** [INKEY$](INKEY$) can be removed from the function if it is used elsewhere to help clear the key buffer. 

**The Scankey Function array can be cleared by sending 0 as the *scancode%* or press the *Print Scrn/SysReq* key.**


How to get Control, Alt and shift key entries from a user using [PEEK](PEEK) in QB64 or QBasic:

```vb

DO
    _LIMIT 50
    DEF SEG = &H40  'set memory segment to read
    ShiftFlag = PEEK(&H17)  'read keyboard function keys
    DEF SEG
    IF ShiftFlag <> x THEN  'find key not previously read
        x = ShiftFlag  'read a new keypress
        IF (ShiftFlag AND 1) = 1 THEN PRINT "rightshift"
        IF (ShiftFlag AND 2) = 2 THEN PRINT "leftshift"
        IF (ShiftFlag AND 4) = 4 THEN PRINT "ctrl"
        IF (ShiftFlag AND 8) = 8 THEN PRINT "alt"
    END IF
    x$ = INKEY$ 'clear keyboard buffer to prevent beeping
    IF x$ <> "" THEN PRINT ASC(x$)  'read other keypress ASCII codes
LOOP UNTIL x$ = CHR$(27) 'Escape key exit

``` <sub>Derived from code by eoredson</sub>
>  Note: Each key must be read individually or sequentially. For combinations use the QB64 [_KEYDOWN](_KEYDOWN) function.




## Reference


## See Also
 
* [INKEY$](INKEY$), [ASCII](ASCII), [ASC](ASC) 
* [_KEYHIT](_KEYHIT), [_KEYDOWN](_KEYDOWN), [_KEYCLEAR](_KEYCLEAR)
* [ON KEY(n)](ON-KEY(n)), [KEY(n)](KEY(n)), [KEY](KEY), 
* [INP](INP), [Scancodes](Scancodes) (examples)
* [Windows Libraries](Windows-Libraries)
* [http://www.howtogeek.com/236462/which-key-on-a-mac-keyboard-corresponds-to-the-symbol/ Mac keyboard Symbols]
 



