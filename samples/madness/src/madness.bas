'Dennis Mull

DEFINT A-Z
DECLARE SUB BOXFILL (ROWR%, COLS%, CLR%, FILL%)
DECLARE SUB EXAMPLE (HOWMANY%)
DECLARE SUB GAMEWIN ()
DECLARE SUB GETCOLUMN (COLUMN$)
DECLARE SUB KEYKILL ()
DECLARE SUB MAKESCRN (ROWSTART%, HITE%, WIDE%)
DECLARE SUB MAKESOUND (WHICH%)
DECLARE SUB WARNING (MESSAGE%)
DECLARE SUB WINCHECK ()

COMMON SHARED COUNT%, ATTEMPT%, COLS%, GEN$
DIM SHARED BOX$(11), KEEP$(30)

 FOR REPLAY% = 1 TO 30         'Get example winning data
  READ A$: KEEP$(REPLAY%) = A$
 NEXT REPLAY%

 GEN$ = "YOU ARE A GENIUS"
 MAKESCRN 10, 5, 70
 EXAMPLE REPLAY%               'Play example game
TOP:
 COUNT% = 0: ATTEMPT% = ATTEMPT% + 1
 IF ATTEMPT% > 4 THEN GEN$ = "Sorry, genius status denied"
 MAKESCRN 10, 5, 70

DO
REDO:
  DO
  KEYKILL                       'Remove keystrokes from keyboard
  LOCATE 9, 14: PRINT "Number of Moves > "; COUNT%
  LOCATE 9, 44: PRINT "Number of Attempts > "; ATTEMPT%
  LOCATE 20, 31: PRINT "    ": LOCATE 20, 69: PRINT "    "
 
  LOCATE 20, 30: INPUT " ", A$
  IF UCASE$(A$) = "Q" THEN COLOR 7, 0: CLS : END   'Quit MADNESS
  IF UCASE$(A$) = "N" THEN GOTO TOP                'Start new game
 
  LOCATE 20, 68: INPUT " ", B$
  AA% = VAL(A$): BB% = VAL(B$)
  IF AA% = 0 OR BB% = 0 THEN MAKESOUND 2: GOTO REDO
  IF AA% > 10 OR BB% > 10 THEN AA% = 1: BB% = AA%
  IF AA% < 1 OR BB% < 1 THEN AA% = 1: BB% = AA%
  
  IF BOX$(BB%) <> "BLANK" THEN WARNING 3: A$ = ""
 
  IF A$ <> "" THEN
   IF BOX$(AA%) = "BLANK" THEN WARNING 4: A$ = ""
  END IF

  IF A$ <> "" THEN
   IF AA% > BB% THEN          'Check for jump > 1
   IF AA% - BB% > 2 THEN WARNING 1: A$ = ""
   END IF
  END IF
 
  IF AA% < BB% THEN           'Check for jump > 1
   IF BB% - AA% > 2 THEN WARNING 1: A$ = ""
  END IF
 
  IF A$ <> "" THEN
   IF BOX$(AA%) = "RED" THEN  'Check for backward move by red
    IF BB% > AA% THEN
    EXIT DO
   ELSE
    MAKESOUND 2: WARNING 2: A$ = ""
   END IF
  END IF
  END IF

  IF A$ <> "" THEN
   IF BOX$(AA%) = "BLUE" THEN  'Check for backward move by blue
    IF BB% < AA% THEN
    EXIT DO
   ELSE
    MAKESOUND 2: WARNING 2: A$ = ""
   END IF
  END IF
  END IF
  LOOP WHILE A$ = "" OR B$ = ""
  
  COUNT% = COUNT% + 1             'Count the moves
  LOCATE 9, 14: PRINT "Number of Moves > "; COUNT%
  LOCATE 9, 44: PRINT "Number of Attempts > "; ATTEMPT%
  
  GETCOLUMN A$
  
  IF BOX$(VAL(B$)) = "BLANK" THEN 'Change to blank square
   FILL% = 32
   BOXFILL 11, COLS%, CLR%, FILL%
   BOX$(VAL(B$)) = BOX$(VAL(A$))
  END IF
  
  GETCOLUMN B$
  
  IF BOX$(VAL(A$)) = "RED" THEN   'Check for color swap
   CLR% = 4
  ELSE CLR% = 1
  END IF
  
  BOX$(VAL(A$)) = "BLANK"
  FILL% = 186                     'Change moved box character
  BOXFILL 11, COLS%, CLR%, FILL%
  MAKESOUND 5
  WINCHECK                        'Check for winning game
  COLOR 15, 0
  KEEP$(COUNT%) = STR$(AA%) + STR$(BB%)   'Keep track of moves

'Example data of winning moves
DATA " 7 5"," 8 7"," 4 6"," 3 4"," 6 8"," 7 6"," 5 3"," 9 7"," 8 9"," 6 5"
DATA " 4 6"," 2 4"," 1 2"," 3 1"," 5 3"," 10 8"," 7 5"," 9 10"," 8 7"," 6 8"
DATA " 8 9"," 4 6"," 6 8"," 2 4"," 4 6"," 3 2"," 5 3"," 7 5"," 5 4"," 6 7"
LOOP

SUB BOXFILL (ROWR%, COLS%, CLR%, FILL%) STATIC
  F$ = STRING$(6, FILL%)          'Define contents of box
  FOR R = 11 TO ROWR% + 2
   COLOR CLR%, 0: LOCATE R, COLS%: PRINT F$
  NEXT
  COLOR 15, 0
END SUB

SUB EXAMPLE (HOWMANY%) STATIC
  
  FOR REP% = 1 TO HOWMANY% - 1
   TIN! = TIMER: WHILE TIMER < (TIN! + .1): WEND
   A$ = LEFT$(KEEP$(REP%), 3): A$ = LTRIM$(RTRIM$(A$))
   B$ = RIGHT$(KEEP$(REP%), 2): B$ = LTRIM$(RTRIM$(B$))
   LOCATE 9, 14: PRINT "Number of Moves > "; REP%
   LOCATE 9, 44: PRINT "Number of Attempts > "; ATTEMPT%
  
   GETCOLUMN A$
   IF BOX$(VAL(B$)) = "BLANK" THEN
    FILL% = 32
    BOXFILL 11, COLS%, CLR%, FILL%
    BOX$(VAL(B$)) = BOX$(VAL(A$))
   END IF
   GETCOLUMN B$
   IF BOX$(VAL(A$)) = "RED" THEN
    CLR% = 4
   ELSE CLR% = 1
   END IF
 
   BOX$(VAL(A$)) = "BLANK": FILL% = 186
   BOXFILL 11, COLS%, CLR%, FILL%
   WINCHECK
   MAKESOUND 4
  NEXT REP%
  SLEEP 3: COLOR 15, 0
 
END SUB

SUB GETCOLUMN (COLUMN$) STATIC
  SELECT CASE COLUMN$     'Set column position of square
   CASE "1": COLS% = 6:   CASE "2":  COLS% = 13
   CASE "3": COLS% = 20:  CASE "4":  COLS% = 27
   CASE "5": COLS% = 34:  CASE "6":  COLS% = 41
   CASE "7": COLS% = 48:  CASE "8":  COLS% = 55
   CASE "9": COLS% = 62:  CASE "10": COLS% = 69
  END SELECT
END SUB

DEFSNG A-Z
SUB KEYKILL STATIC
 WHILE INKEY$ <> "": WEND
END SUB

DEFINT A-Z
SUB MAKESCRN (ROWSTART%, HITE%, WIDE%) STATIC
 CLS : N% = 0
 LOCATE 2
 COLOR 7, 0
 PRINT "             ²²   ²²   ²²²²²   ²²²²   ²²    ²  ²²²²  ²²²²²  ²²²²²"
 COLOR 5, 0
 PRINT "             ² ² ² ²   ²   ²   ²   ²  ² ²   ²  ²     ²      ²    "
 COLOR 4, 0
 PRINT "             ²  ²  ²   ²²²²²   ²   ²  ²  ²  ²  ²²²   ²²²²²  ²²²²²"
 COLOR 3, 0
 PRINT "             ²  ²  ²   ²   ²   ²   ²  ²   ² ²  ²         ²      ²"
 COLOR 2, 0
 PRINT "             ²  ²  ²   ²   ²   ²²²²   ²    ²²  ²²²²  ²²²²²  ²²²²²"
 COLOR 15, 0

 WINBOX% = ROWSTART%
 COL% = (80 - WIDE%) / 2
 P% = 201: T% = 205: Q% = 187         'Box characters
 U% = 186: R% = 200: S% = 188         'for double-line box.
 LOCATE WINBOX%, COL%, 0
 PRINT CHR$(P%); STRING$(WIDE% - 1, T%); CHR$(Q%)  'First line box
 FOR A% = 1 TO HITE% - 2
 LOCATE (WINBOX% + A%), COL%, 0
 PRINT CHR$(U%); SPC(WIDE% - 1); CHR$(U%)   'Body of box
 NEXT
 LOCATE WINBOX% + A%, COL%, 0
 PRINT CHR$(R%); STRING$(WIDE% - 1, T%); CHR$(S%); 'Bottom line box

  FOR T = 12 TO 72 STEP 7             'Build rest of game board
   LOCATE 10, T: PRINT CHR$(203)
   LOCATE 11, T: PRINT CHR$(186)
   LOCATE 12, T: PRINT CHR$(186)
   LOCATE 13, T: PRINT CHR$(186)
   LOCATE 14, T: PRINT CHR$(202)
   N% = N% + 1
   LOCATE 16, T - 5: PRINT N%
  NEXT T
   LOCATE 16, T - 4: PRINT "10"
 
  FOR COLS% = 6 TO 27 STEP 7          'Set red squares
   BOXFILL 11, COLS%, 4, 178
  NEXT
 
  FOR COLS% = 48 TO 73 STEP 7         'Set blue squares
   BOXFILL 11, COLS%, 1, 178
  NEXT
 
  FOR X = 1 TO 4: BOX$(X) = "RED": NEXT
   BOX$(5) = "BLANK"
   BOX$(6) = "BLANK"
  FOR X = 7 TO 10: BOX$(X) = "BLUE": NEXT
 
  LOCATE 20, 10: PRINT "MOVE SQUARE NUMBER >"
  LOCATE 20, 50: PRINT "TO SQUARE NUMBER >"
  LOCATE 9, 14: PRINT "Number of Moves > "; COUNT%
  LOCATE 9, 44: PRINT "Number of Attempts > "; ATTEMPT%
  COLOR 15, 6
  LOCATE 24, 1: PRINT "  Q=Quit  N=New Game"; SPACE$(58);
  COLOR 15, 0
END SUB

SUB MAKESOUND (WHICH%) STATIC    'Sound generator
  SELECT CASE WHICH%
   CASE 1: SOUND 1800, 5
   CASE 2: SOUND 50, 5
   CASE 3
    FOR X = 40 TO 1 STEP -1      'Make sound for winning game
     SOUND 1000 - X * 10, .5
     SOUND 100 + X * 10, .5
    NEXT X
   CASE 4: SOUND 1100, 1
   CASE 5
    FOR X = 5 TO 1 STEP -1       'Make sound for moving a piece
     SOUND 1000 - X * 10, .6
     SOUND 100 + X * 10, .2
    NEXT X
  END SELECT
END SUB

SUB WARNING (MESSAGE) STATIC
 
  SELECT CASE MESSAGE
   CASE 1: MESS$ = "  You may jump only one square at a time"
   CASE 2: MESS$ = "    Sorry, you may not jump backward"
   CASE 3: MESS$ = "Sorry, you must move to an empty square"
   CASE 4: MESS$ = "  Sorry, you may not move an empty square"
  END SELECT
  
   MAKESOUND 2: LOCATE 22, 22: PRINT MESS$;
   TIN! = TIMER: WHILE TIMER < (TIN! + 2): WEND
   LOCATE 22, 22: PRINT STRING$(40, 32);
   COUNT% = COUNT% + 2
   KEYKILL
END SUB

SUB WINCHECK STATIC

 FOR WIN% = 1 TO 4
  IF BOX$(WIN%) <> "BLUE" THEN YES% = 0: EXIT SUB
  YES% = YES% + 1
 NEXT WIN%

 FOR WIN% = 7 TO 10
  IF BOX$(WIN%) <> "RED" THEN YES% = 0: EXIT SUB
  YES% = YES% + 1
 NEXT WIN%

 FOR WIN% = 5 TO 6
  IF BOX$(WIN%) <> "BLANK" THEN YES% = 0: EXIT SUB
  YES% = YES% + 1
 NEXT WIN%

 IF YES% = 10 THEN
  ATTEMPT% = 0: COLOR 31, 6: LOCATE 24, 50: PRINT GEN$;
  MAKESOUND 3
 END IF
 COLOR 15, 0
END SUB

