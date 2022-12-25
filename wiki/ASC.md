The [ASC](ASC) function returns the [ASCII](ASCII) code number of a certain [STRING](STRING) text character or a keyboard press.

## Syntax

> code% = [ASC](ASC)(text$[, position%])

* text$ [STRING](STRING) character parameter must have a length of at least 1 byte or an error occurs. 
* **In QB64** the optional byte position% [INTEGER](INTEGER) parameter greater than 0 can specify the ASCII code of any character in a string to be returned.
* If the optional position% parameter is omitted, ASC will return the [ASCII](ASCII) code of the first [STRING](STRING) character.
* [ASCII](ASCII) code [INTEGER](INTEGER) or [_UNSIGNED](_UNSIGNED) [_BYTE](_BYTE) values returned range from 0 to 255. 
* ASC returns 0 when reading [ASCII](ASCII) 2 byte codes returned by [INKEY$](INKEY$) when the arrow, function, Home/Page keys are used. 
  * Use QB64's position% parameter to read the second byte if necessary. IF ASC(key$) <nowiki>=</nowiki> 0 THEN byte2 <nowiki>=</nowiki> ASC(key$, 2)
* In **QB64** ASC string byte position reads are about **5 times faster** than [MID$](MID$) when parsing strings. See [MID$](MID$) *Example 2*.

## Error(s)

* If the function is used to read an **empty string value** an illegal function call [ERROR Codes](ERROR-Codes) will occur. [INKEY$](INKEY$) returns an empty string when a key is not pressed.
* **QB64**'s position% parameters must range from 1 to the [LEN](LEN) of the string being read or an illegal function call [ERROR Codes](ERROR-Codes) will occur.

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
' **    *Italics* = LCase/NumLock On  ____________  + = 2 Byte: CHR$(0) + CHR$(code)**
'

```

**[ASCII](ASCII)**

```text

                    **Two Byte Characters        Key                 CHR$(0) + "?" **

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

> In **QB64**, [CVI](CVI) can be used to get the [_KEYDOWN](_KEYDOWN) 2-byte code value. Example: IF _KEYDOWN([CVI](CVI)([CHR$](CHR$)(0) + "P")) THEN

## Example(s)

How ASC can be used to find any ASCII code in a string of characters using QB64.

```vb

PRINT ASC("A")
PRINT ASC("Be a rockstar")
PRINT ASC("QB64 is not only COMPATIBLE, it can find any part of the string!", 18) 

```

*Returns:*

```text

 65
 66
 67

```

*Explanation:* The ASCII code for "A" is 65 and the ASCII code for "B" is 66, ASCII code for "C" is 67 and the "C" is at position 18 in the string.

> *Note:* The ASCII code for "A" and "a" are different by the value of 32, "A" + 32 is "a", 65("A") + 32 = 97("a").

Reading the ASCII and two byte code combinations with ASC in **QB64**.

```vb

Q$ = CHR$(34) ' quote character
COLOR 10: LOCATE 5, 22: PRINT "Press some keys or combinations!"
COLOR 13: LOCATE 23, 30: PRINT "Escape key Quits"
DO
   DO: SLEEP: key$ = INKEY$: LOOP UNTIL key$ <> "" ' prevent ASC empty string read error
   code% = ASC(key$): COLOR 11: LOCATE 10, 10
   IF code% THEN    ' ASC returns any value greater than 0
    PRINT "CHR$(" + LTRIM$(STR$(code%)) + ")" + SPACE$(13): 
    IF code% > 8 AND code% < 14 THEN code% = 32    ' unprintable control codes
    COLOR 14: LOCATE 10, 50: PRINT CHR$(code%) + SPACE$(13)        
   ELSE: PRINT "CHR$(0) + CHR$(" + LTRIM$(STR$(ASC(key$, 2))) + ")"
    COLOR 14: LOCATE 10, 50: PRINT "CHR$(0) + " + Q$ + CHR$(ASC(key$, 2)) + Q$
   END IF
LOOP UNTIL code% = 27 * '


```

*Explanation:* The keypress read loop checks that ASC will not read an empty string. That would create a program error. [SLEEP](SLEEP) reduces CPU memory usage between keypresses. Normal byte codes returned are indicated by the IF statement when ASC returns a value. Otherwise the routine will return the two byte ASCII code. The extended keyboard keys(Home pad, Arrow pad and Number pad), Function keys or Ctrl, Alt or Shift key combinations will return two byte codes. Ctrl + letter combinations will return control character codes 1 to 26.

Reading only numerical values input by a program user.

```vb

 DO: SLEEP ' requires a keypress to run loop once
   K$ = INKEY$
   code = ASC(K$)
   IF code >= 48 AND code <= 57 THEN entry$ = entry$ + CHR$(code) ' numbers only
   IF code = 46 AND flag = 0 THEN 
      entry$ = entry$ + K$: flag = 1: mark = LEN(entry$) ' decimal point
   END IF
   L = LEN(entry$) ' check entry length for possible backspace
   IF code = 8 AND L > 0 THEN ' backspace pressed and entry has a length
     entry$ = MID$(entry$, 1, L - 1) ' remove one character from entry$
     IF L - 1 < mark THEN flag = 0 ' allow another decimal point if removed.
     LOCATE 10, POS(0) - 1: PRINT SPACE$(1); ' remove character from screen
   END IF
   LOCATE 10, 10: PRINT entry$; 
   ' display present entry to user(semicolon required for correct POS return)
 LOOP UNTIL code = 13 AND L 

```

*Explanation:* [SLEEP](SLEEP) waits for a keypress allowing background programs to use the processor time. It also keeps the press in the keyboard buffer for [INKEY$](INKEY$) to read and guarantees that ASC will not read an empty string value to create an error. Filtered codes 48 to 57 are only number characters. One decimal point is allowed by using the flag. Code 8 is a backspace request which is ignored if the entry has no characters. If it is allowed it removes the last character from the entry and the screen. The loop exits when the user presses the [Enter] key and the entry has a length.

## See Also

* [ASC (statement)](ASC-(statement))
* [_KEYHIT](_KEYHIT), [_KEYDOWN](_KEYDOWN)
* [MID$](MID$), [CHR$](CHR$), [INKEY$](INKEY$)
* [VAL](VAL), [STRING$](STRING$)
* [ASCII](ASCII), [_MAPUNICODE](_MAPUNICODE)
* [Scancodes](Scancodes)
