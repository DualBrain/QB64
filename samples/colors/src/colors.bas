'   COLORS.BAS
'   Copyright (c) 1993 DOS Resource Guide
'   Published in Issue #12, November 1993, page 69.

' This program lets you pick foreground
' and background text colors by moving
' a cursor with the arrow keys.
' The program displays the QBasic color numbers,
' the color names, and the ANSI codes that
' will generate those colors.
' You should find this program handy if you are
' customizing your DOS prompt, designing a batch
' file menu screen, or writing a QBasic program.

' Written by Hardin Brothers

' This program requires a color adapter and monitor

DEFINT A-Z

DECLARE SUB ReadDATA ()
DECLARE SUB SetInfo ()
DECLARE SUB SetText ()
DECLARE SUB MoveCursor (UserKey%)
DECLARE SUB SetCursor ()
DECLARE SUB SetScreen ()
DECLARE FUNCTION GetAKey% ()
DECLARE SUB FlushKBDBuffer ()

CONST KeyEscape = 27
CONST KeyEnter = 13
CONST KeyLeft = -75
CONST KeyRight = -77
CONST KeyUp = -72
CONST KeyDown = -80

DIM SHARED ForeGround, BackGround
DIM SHARED ANSI(0 TO 7)
DIM SHARED Colors$(0 TO 15)
DIM SHARED MaxName

AnsiOrder:
' Colors: Black, Blue, Green, Cyan
DATA        0,     4,    2,     6

' Colors: Red, Magenta, Brown, White
DATA        1,    5,      3,     7

ColorNames:
DATA  Black, Blue, Green, Cyan, Red, Magenta
DATA  Brown, White
DATA  Gray, Light Blue, Light Green, Light Cyan
DATA  Light Red, Light Magenta, Yellow
DATA  Bright White

'Top-level outline

ReadDATA                        'Get data into arrays
SetScreen                       'Create general display
FlushKBDBuffer                  'Make sure no keys are waiting
ForeGround = 0                  'Set beginning colors
BackGround = 0

DO                              'Main program loop
 SetCursor                      'Place the cursor & info
 UserKey = GetAKey              'Wait for keystroke
  IF UserKey <> KeyEscape THEN  'Process keystroke
    MoveCursor (UserKey)        'Move cursor unless we quit
  END IF
LOOP UNTIL UserKey = KeyEscape  'Loop until user ESCapes
CLS                             'Clean up before ending
END

SUB FlushKBDBuffer
  DO
    A$ = INKEY$                 'Try to get a key
  LOOP UNTIL LEN(A$) = 0        'Continue until no more
END SUB                         ' are waiting

FUNCTION GetAKey
  DO
    A$ = INKEY$                 'Loop until key
  LOOP UNTIL LEN(A$) > 0        ' is ready
  IF LEN(A$) = 1 THEN           'If it's alphanumeric
    GetAKey = ASC(A$)           '  return its code
  ELSE                          'For special keys
    GetAKey = -1 * ASC(MID$(A$, 2))
  END IF                        '  return -1 * extended code
END FUNCTION

SUB MoveCursor (UserKey)
  SELECT CASE UserKey           'Base action on key
    CASE KeyLeft
      ForeGround = ForeGround - 1
      IF ForeGround < 0 THEN
        ForeGround = ForeGround + 16
      END IF
    CASE KeyRight
      ForeGround = ForeGround + 1
      ForeGround = ForeGround MOD 16
    CASE KeyUp
      BackGround = BackGround - 1
      IF BackGround < 0 THEN
        BackGround = BackGround + 8
      END IF
    CASE KeyDown
      BackGround = BackGround + 1
      BackGround = BackGround MOD 8
    CASE ELSE
      BEEP                      'For all unrecognized
  END SELECT                    '  keys -- BEEP error
END SUB

SUB ReadDATA
  RESTORE AnsiOrder             'Read ANSI's color
  CLS                           '  numbers into ANSI
  FOR i = 0 TO 7                '  arrau
    READ ANSI(i):  PRINT ANSI(i)
  NEXT i

  RESTORE ColorNames            'Read the color
  MaxName = 0                   'names into an array
  FOR i = 0 TO 15
    READ Colors$(i)
    IF LEN(Colors$(i)) > MaxName THEN
      MaxName = LEN(Colors$(i)) 'and find longest name
    END IF
  NEXT i
END SUB

SUB SetCursor
  STATIC OldFG, OldBG
  COLOR 7, 0                    'Turn off previous cursor
  LOCATE OldBG + 5, (OldFG * 5) + 1, 0
  PRINT " ";
  LOCATE OldBG + 5, (OldFG * 5) + 5, 0
  PRINT " ";
  OldFG = ForeGround            'Turn on new one
  OldBG = BackGround
  LOCATE BackGround + 5, (ForeGround * 5) + 1, 0
  PRINT CHR$(174);
  LOCATE BackGround + 5, (ForeGround * 5) + 5, 0
  PRINT CHR$(175);

  SetText                       'Display sample text
  SetInfo                       ' and color info
END SUB

SUB SetInfo                     'Display color info
  Format$ = "\" + SPACE$(MaxName) + "\"
  ANSI$ = " ANSI Code = ESC[0;##;##\ \"  '1 space
  Blnk$ = "Blink Code = ESC[0;5;##;##\ \"
  FG = ForeGround: BG = BackGround

  COLOR 7, 0                    'Color numbers and names
  LOCATE 15, 30
  PRINT USING "Foreground Color = ##  "; FG;
  PRINT USING Format$; "(" + Colors$(FG) + ")";

  LOCATE 16, 30
  PRINT USING "Background Color = ##  "; BG;
  PRINT USING Format$; "(" + Colors$(BG) + ")";

  IF FG < 8 THEN                'ANSI sequences
    Tail$ = "m"
  ELSE
    Tail$ = ";1m"
  END IF
  
  LOCATE 18, 30
  PRINT USING ANSI$; 30 + ANSI(FG MOD 8); 40 + ANSI(BG); Tail$
  LOCATE 19, 30
  PRINT USING Blnk$; 30 + ANSI(FG MOD 8); 40 + ANSI(BG); Tail$
END SUB

SUB SetScreen                   'Create general display
  Title$ = "Text Colors and ANSI Color Codes"
 
  WIDTH 80, 25                  'Set screen size
  COLOR 7, 0
  CLS
 
  PRINT " "; STRING$(78, 205)   'Print title bar
  PRINT SPACE$((80 - LEN(Title$)) / 2);
  PRINT Title$
  PRINT " "; STRING$(78, 205)

  FOR BG = 0 TO 7               'Display color blockx
    FOR FG = 0 TO 15
      LOCATE BG + 5, (FG * 5) + 2, 0
      COLOR FG, BG
      PRINT " X ";
    NEXT FG
  NEXT BG
  
  COLOR 7, 0                    'Print instructions
  LOCATE 23, 1
  PRINT "Use arrow keys to move the cursor"
  PRINT "Press the Esc key to end the program";
END SUB

SUB SetText                     'Display sample text
   Format$ = "\                    \"  ' 20 spaces
  
   COLOR ForeGround, BackGround
   LOCATE 15, 2
   PRINT USING Format$; "  This is some";
   LOCATE 16, 2
   PRINT USING Format$; "  sample text";
   LOCATE 17, 2
   PRINT USING Format$; "  in the selected";
   LOCATE 18, 2
   PRINT USING Format$; "  colors.";
END SUB

