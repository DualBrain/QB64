'CRAM!
'   by Hardin Brothers
'
'   Copyright (C) 1993 DOS Resource Guide
'   Published in Issue #9, May 1993, page 57
'
'This program may be run in DOS 5.0's QBasic or
'compiled with QuickBasic 4.0 or later, or with
'Visual Basic for DOS.
'
DEFINT A-Z
DECLARE SUB Pause ()
DECLARE SUB NextColor ()
DECLARE SUB Score ()
DECLARE SUB Setup ()
DECLARE SUB Hello ()
DECLARE SUB GoRight ()
DECLARE SUB GoDown ()
DECLARE SUB GoLeft ()
DECLARE SUB GoUp ()
CONST FALSE = 0
CONST TRUE = NOT FALSE
CONST ESC = 27
CONST Duration = 3
DIM SHARED TopLimit, LeftLimit, RightLimit, BottomLimit
DIM SHARED Crash, Done, Turns
DIM SHARED DrawChar$, Difficulty, CurColor, Note(4)
  DrawChar$ = CHR$(219): CurColor = 1
  Note(1) = 800: Note(2) = 600: Note(3) = 400: Note(4) = 500
Hello
Done = FALSE
DO
  Setup
  IF NOT Done THEN
    Crash = FALSE
    DO
      IF NOT Crash AND NOT Done THEN GoRight
      IF NOT Crash AND NOT Done THEN GoDown
      IF NOT Crash AND NOT Done THEN GoLeft
      IF NOT Crash AND NOT Done THEN GoUp
    LOOP UNTIL Crash OR Done
  END IF
  IF NOT Done THEN Score
LOOP UNTIL Done
CLS
END
SUB GoDown
  col = RightLimit
  row = TopLimit
  WHILE INKEY$ <> "": WEND
  DO
    LOCATE row, col
    PRINT DrawChar$;
    Pause
    row = row + 1
    IF row = BottomLimit THEN Crash = TRUE
    k$ = INKEY$
  LOOP WHILE LEN(k$) = 0 AND Crash = FALSE
  IF LEN(k$) THEN Done = (ASC(k$) = ESC)
  SOUND Note(2), Duration
  BottomLimit = row
  Turns = Turns + 1
  NextColor
END SUB
SUB GoLeft
  col = RightLimit
  row = BottomLimit
  WHILE INKEY$ <> "": WEND
  DO
    LOCATE row, col
    PRINT DrawChar$;
    Pause
    col = col - 1
    IF col = LeftLimit THEN Crash = TRUE
    k$ = INKEY$
  LOOP WHILE LEN(k$) = 0 AND Crash = FALSE
  IF LEN(k$) THEN Done = (ASC(k$) = ESC)
  SOUND Note(3), Duration
  LeftLimit = col
  Turns = Turns + 1
  NextColor
END SUB
SUB GoRight
  col = LeftLimit
  row = TopLimit
  WHILE INKEY$ <> "": WEND
  DO
    LOCATE row, col
    PRINT DrawChar$;
    Pause
    col = col + 1
    IF col = RightLimit THEN Crash = TRUE
    k$ = INKEY$
  LOOP WHILE LEN(k$) = 0 AND Crash = FALSE
  IF LEN(k$) THEN Done = (ASC(k$) = ESC)
  SOUND Note(1), Duration
  RightLimit = col
  Turns = Turns + 1
  NextColor
END SUB
SUB GoUp
  col = LeftLimit
  row = BottomLimit
  WHILE INKEY$ <> "": WEND
  DO
    LOCATE row, col
    PRINT DrawChar$;
    Pause
    row = row - 1
    IF row = TopLimit THEN Crash = TRUE
    k$ = INKEY$
  LOOP WHILE LEN(k$) = 0 AND Crash = FALSE
  IF LEN(k$) THEN Done = (ASC(k$) = ESC)
  SOUND Note(4), Duration
  TopLimit = row
  Turns = Turns + 1
  NextColor
END SUB
SUB Hello
  CLS
  PRINT , , "Welcome to Cram"
  PRINT
  PRINT "  To play. simply press a key when the line gets too close"
  PRINT "to a wall. The more turns you can make, the higher you will"
  PRINT "score. Press <ESC> at any time to end the game."
  PRINT
  PRINT , , "Good Luck!"
  PRINT : PRINT
  DO
    INPUT "Difficulty 1 (hard) to 3 (easy) ==> "; Difficulty
  LOOP UNTIL Difficulty >= 1 AND Difficulty <= 3
END SUB
SUB NextColor
  CurColor = CurColor + 1
  IF CurColor = 8 THEN CurColor = 9
  IF CurColor > 15 THEN CurColor = 1
  COLOR CurColor
END SUB
SUB Pause
  FOR j = 1 TO Difficulty
    T! = TIMER
    WHILE T! = TIMER: WEND
  NEXT j
END SUB
SUB Score
  Turns = Turns - 1
  COLOR 7
  LOCATE 12, 30
  IF Turns = 1 THEN
    LastWord$ = "turn!"
  ELSE
    LastWord$ = "turns!"
  END IF
  PRINT "You made"; Turns; LastWord$
  FOR i = 1 TO 4
    FOR j = 1 TO 4
      SOUND Note(j), Duration
    NEXT j
  NEXT i
  FOR i = 1 TO 10
    Pause
  NEXT i
END SUB
SUB Setup
  Crash = FALSE
  Done = FALSE
  Turns = 0
  CLS
  NextColor
  FOR x = 1 TO 80
    LOCATE 1, x
    PRINT DrawChar$;
  NEXT x
  SOUND Note(1), Duration
  NextColor
  
  FOR y = 1 TO 25
    LOCATE y, 80
    PRINT DrawChar$;
  NEXT y
  SOUND Note(2), Duration
  NextColor
  
  FOR x = 79 TO 1 STEP -1
    LOCATE 25, x
    PRINT DrawChar$;
  NEXT x
  SOUND Note(3), Duration
  NextColor
  
  FOR y = 24 TO 3 STEP -1
    LOCATE y, 1
    PRINT DrawChar$;
  NEXT y
  SOUND Note(4), Duration
  NextColor
  
  TopLimit = 3: RightLimit = 80
  BottomLimit = 25: LeftLimit = 1
  
  k$ = INKEY$
  IF LEN(k$) THEN Done = (ASC(k$) = ESC)
END SUB

