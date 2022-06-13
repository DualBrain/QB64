' BARDEMO.BAS
' by Douglas Park
' Copyright (C) 1995 DOS World Magazine
' Published in Issue #19, January 1995, page 60

DECLARE SUB BOX (Y1%, X1%, Y2%, X2%)
DECLARE SUB CHART (STR1$, STR2$, NUM1%, NUM2%, WID%, X%, Y%)

CALL BOX(1, 1, 23, 80)
CALL BOX(2, 2, 8, 79)
CALL CHART("STRING1", "STRING2", 500, 5000, 54, 2, 2)
CALL BOX(9, 19, 15, 60)
CALL CHART("STRING1", "STRING2", 1, 2, 20, 19, 9)
LOCATE 23, 10: PRINT " Press a Key "
DO                                  'Pause for a keystroke
  KEY$ = INKEY$
LOOP WHILE KEY$ = ""
J% = 8
FOR I% = 1 TO J% + 8
  CALL CHART("I : " + STR$(I%), "J : " + STR$(J%), I%, J%, 54, 2, 16)
DO                                  'Pause for a keystroke
  KEY$ = INKEY$
LOOP WHILE KEY$ = ""
NEXT I%
END

SUB BOX (Y1%, X1%, Y2%, X2%)
  BOXWIDTH = X2% - X1% + 1
  LOCATE Y1%, X1%
  PRINT CHR$(218); STRING$(BOXWIDTH - 2, CHR$(196)); CHR$(191)
  FOR I = Y1% + 1 TO Y2% - 1
    LOCATE I, X1%
    PRINT CHR$(179); SPACE$(BOXWIDTH - 2); CHR$(179)
  NEXT I
  LOCATE Y2%, X1%
  PRINT CHR$(192); STRING$(BOXWIDTH - 2, CHR$(196)); CHR$(217)
END SUB

SUB CHART (STR1$, STR2$, NUM1%, NUM2%, WID%, X%, Y%)
  TEMPSTRING$ = ""
  IF WID% > 56 THEN WID% = 56        'Fit chart to 80 columns
  IF NUM1% <= NUM2% THEN             'Determine largest number
    KEYNUM% = NUM2%
  ELSE
    KEYNUM% = NUM1%
  END IF
  IF WID% < KEYNUM% THEN              'Adjust to fit display
    DO
      KEYNUM% = KEYNUM% \ 2: NUM1% = NUM1% \ 2: NUM2% = NUM2% \ 2
    LOOP WHILE WID% < KEYNUM%
  END IF
  BARLENGTH1 = (NUM1% * (WID% / KEYNUM%))
  BARLENGTH2 = (NUM2% * (WID% / KEYNUM%))
  LOCATE (Y% + 2), (X% + 4): PRINT STR1$ 'Write the first title
  FOR I = 1 TO BARLENGTH1                'Draw the bar
  TEMPSTRING$ = TEMPSTRING$ + CHR$(178)
  NEXT I
  IF BARLENGTH1 < BARLENGTH2 THEN
     FOR I = BARLENGTH1 + 1 TO BARLENGTH2
       TEMPSTRING$ = TEMPSTRING$ + " "
     NEXT I
  END IF
  LOCATE (Y% + 2), (X% + 20): PRINT TEMPSTRING$
  TEMPSTRING$ = ""
  LOCATE (Y% + 4), (X% + 4): PRINT STR2$    'Write the second title
  FOR I = 1 TO BARLENGTH2                   'Draw the bar
    TEMPSTRING$ = TEMPSTRING$ + CHR$(178)
  NEXT I
  IF BARLENGTH2 < BARLENGTH1 THEN
     FOR I = BARLENGTH2 + 1 TO BARLENGTH1
       TEMPSTRING$ = TEMPSTRING$ + " "
     NEXT I
  END IF
  LOCATE (Y% + 4), (X% + 20): PRINT TEMPSTRING$
 END SUB

