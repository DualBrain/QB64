' PERSONAL.BAS
'   by Tim Syrop
' Copyright (C) 1995 DOS World
' Published in Issue #22, March 1995, page 66


CLS
STARTTIME# = TIMER
NAME$ = "Place your name or message here."
RANDOMIZE TIMER

DO
  IMBACK$ = INKEY$
  ROW% = INT(RND * 25) + 1
  COL% = INT(RND * (80 - LEN(NAME$)) + 1)
  COLORS% = INT(RND * 15) + 1
  LOCATE ROW%, COL%
  COLOR COLORS%
  PRINT NAME$;
  LOCATE ROW%, COL%
  PAUSE# = TIMER
    DO
      IMBACK$ = INKEY$
        IF IMBACK$ > "" THEN EXIT DO
    LOOP UNTIL TIMER > PAUSE# + 2
  PRINT SPACE$(LEN(NAME$));
LOOP UNTIL IMBACK$ > ""

COLOR 7, 0
CLS
PRINTTIME# = (TIMER - STARTTIME#) / 60

IF PRINTTIME# < 1 THEN
  PRINT "The screen saver was on less than one minute."
  SYSTEM
ELSEIF PRINTTIME# < 1.5 THEN MINS$ = "Minute."
ELSE
  MINS$ = "Minutes."
END IF

IF PRINTTIME# < 1000 THEN A$ = "###"
IF PRINTTIME# < 100 THEN A$ = "##"
IF PRINTTIME# < 10 THEN A$ = "#"
PRINT "The screen saver was on ";
PRINT USING A$; PRINTTIME#;
PRINT " "; MINS$
SYSTEM

