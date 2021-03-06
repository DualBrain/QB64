DECLARE SUB SETCURS ()
DECLARE SUB SCREENINIT ()
DECLARE SUB SAVEIT ()
DECLARE SUB NEWGRID ()
DECLARE SUB GRID ()
DECLARE SUB EDITCURS ()
DECLARE SUB DISPLAY ()
DECLARE SUB COMMANDIN ()
DECLARE SUB COLORBOX ()

' TILE.BAS
'   by Greg Ennen
' Copyright (C) 1995 DOS World
' Published in Issue #21, May 1995, page 57


DIM SHARED BOXCOLOR(1 TO 8, 1 TO 16)
DIM SHARED BIT(1 TO 4)

GRIDSIZE = 8: CURSX = 1: CURSY = 1
XSTART = 98: YSTART = 28
OLDCURSX = 8: OLDCURSY = 8
BOXCOLOR = 0
CLS
SCREEN 9
CALL SCREENINIT
DO
  CALL COMMANDIN
LOOP
  
SCREEN 0
END  'End of main program

SUB COLORBOX
SHARED GRIDSIZE, CURSX, CURSY, XSTART, YSTART, COMMIN$
COLORTYPE = ASC(COMMIN$)
IF COLORTYPE >= 65 THEN COLORTYPE = COLORTYPE - 7
BOXCOLOR(CURSX, CURSY) = COLORTYPE - 48
CALL SETCURS

END SUB

SUB COMMANDIN
SHARED GRIDSIZE, CURSX, CURSY, XSTART, YSTART, COMMIN$, TILE$
DO
  DO
    COMMIN$ = INKEY$
  LOOP UNTIL COMMIN$ <> ""
  IF LEN(COMMIN$) = 2 THEN CALL EDITCURS
  IF ASC(COMMIN$) >= 48 AND ASC(COMMIN$) <= 57 THEN CALL COLORBOX
  COMMIN$ = UCASE$(COMMIN$)
  IF ASC(COMMIN$) >= 65 AND ASC(COMMIN$) <= 70 THEN CALL COLORBOX
  IF COMMIN$ = "Q" THEN SCREEN 0: END
  IF COMMIN$ = "T" THEN CALL DISPLAY
  IF COMMIN$ = "G" THEN CALL NEWGRID
  IF COMMIN$ = "N" THEN CALL GRID
  IF COMMIN$ = "S" THEN CALL SAVEIT
LOOP

END SUB

SUB DISPLAY
SHARED GRIDSIZE, TILE$, TILETEXT$
LINE (363, 20)-(617, 228), 0, BF
LINE (363, 20)-(617, 228), , B
TILETEXT$ = ""
TILE$ = ""
FOR Y = 1 TO GRIDSIZE
 BITECOUNT = 7
 FOR Z = 1 TO 4: BIT(Z) = 0: NEXT Z
 FOR X = 1 TO 8
    BITE = BOXCOLOR(X, Y)
    FOR Z = 3 TO 0 STEP -1
       R = BITE \ 2 ^ Z
       IF R < 1 THEN R = 0 ELSE BITE = BITE - 2 ^ Z
       BIT(Z + 1) = BIT(Z + 1) + (R * 2 ^ BITECOUNT)
    NEXT Z
 BITECOUNT = BITECOUNT - 1
 NEXT X
TILETEXT$ = TILETEXT$ + "+ CHR$(&H" + HEX$(BIT(1)) + ") + CHR$(&H" + HEX$(BIT(2)) + ") + CHR$(&H" + HEX$(BIT(3)) + ") + CHR$(&H" + HEX$(BIT(4)) + ")"
TILE$ = TILE$ + CHR$(BIT(1)) + CHR$(BIT(2)) + CHR$(BIT(3)) + CHR$(BIT(4))
NEXT Y
VIEW PRINT 22 TO 22
LOCATE 22, 1: PRINT SPACE$(79);
LOCATE 22, 1: PRINT "Tile="; TILETEXT$;
PAINT (400, 100), TILE$, 15

END SUB

SUB EDITCURS
SHARED GRIDSIZE, CURSX, CURSY, XSTART, YSTART, COMMIN$, OLDCURSX, OLDCURSY
CONST UPARROW% = 72
CONST DOWNARROW% = 80
CONST RIGHTARROW% = 77
CONST LEFTARROW% = 75
CONST HOMEKEY% = 71
CONST ENDKEY% = 79
CONST PGUP% = 73
CONST PGDN% = 81

OLDCURSX = CURSX: OLDCURSY = CURSY

SELECT CASE ASC(RIGHT$(COMMIN$, 1))
   CASE UPARROW%
      CURSY = CURSY - 1
      IF CURSY <= 0 THEN CURSY = 1
   CASE DOWNARROW%
      CURSY = CURSY + 1
      IF CURSY >= GRIDSIZE THEN CURSY = GRIDSIZE
   CASE RIGHTARROW%
      CURSX = CURSX + 1
      IF CURSX >= 8 THEN CURSX = 8
   CASE LEFTARROW%
      CURSX = CURSX - 1
      IF CURSX <= 0 THEN CURSX = 1
   CASE HOMEKEY%
      IF (CURSX > 1) AND (CURSY > 1) THEN
         CURSX = CURSX - 1
         CURSY = CURSY - 1
      END IF
      REM IF CURSX <= 0 THEN CURSX = 1  
      REM IF CURSY <= 0 THEN CURSY = 1
   CASE ENDKEY%
      IF (CURSX > 1) AND (CURSY < GRIDSIZE) THEN
         CURSX = CURSX - 1
         CURSY = CURSY + 1
      END IF
      REM IF CURSX <= 0 THEN CURSX = 1  
      REM IF CURSY >= GRIDSIZE THEN CURSY = GRIDSIZE
   CASE PGUP%
      IF (CURSX < 8) AND (CURSY > 1) THEN
         CURSX = CURSX + 1
         CURSY = CURSY - 1
      END IF
      REM IF CURSX >= 8 THEN CURSX = 8  
      REM IF CURSY <= 0 THEN CURSY = 1
   CASE PGDN%
      IF (CURSX < 8) AND (CURSY < GRIDSIZE) THEN
         CURSX = CURSX + 1
         CURSY = CURSY + 1
      END IF
      REM IF CURSX >= 8 THEN CURSX = 8  
      REM IF CURSY >= GRIDSIZE THEN CURSY = GRIDSIZE
END SELECT

CALL SETCURS

END SUB

SUB GRID
SHARED GRIDSIZE, CURSX, CURSY, XSTART, YSTART
FOR X = 1 TO 8
   FOR Y = 1 TO 16
      BOXCOLOR(X, Y) = 0
   NEXT Y
NEXT X

FOR Y = YSTART TO (9 * 16 - 1) + YSTART STEP 9
   Y1 = Y
      FOR X = XSTART TO 12 * 7 + XSTART STEP 12
         LINE (X, Y1)-(X + 12, Y1 + 9), 0, BF
         COUNT = COUNT + 1
      NEXT X
NEXT Y

FOR Y = YSTART TO (9 * GRIDSIZE - 1) + YSTART STEP 9
   Y1 = Y
      FOR X = XSTART TO 12 * 7 + XSTART STEP 12
         LINE (X, Y1)-(X + 12, Y1 + 9), 7, B
         COUNT = COUNT + 1
      NEXT X
NEXT Y
CALL SETCURS
END SUB

SUB NEWGRID
SHARED GRIDSIZE, CURSX, CURSY, XSTART, YSTART, COMMIN$
DO
   LOCATE 22, 1
   PRINT SPACE$(79);
   LOCATE 22, 1
   INPUT ; "Enter new gridsize (8, 12 or 16) ", GRIDSIZE
LOOP UNTIL GRIDSIZE = 8 OR GRIDSIZE = 12 OR GRIDSIZE = 16
LOCATE 22, 1
PRINT SPACE$(79);
LOCATE 22, 1
PRINT "No messages";
CURSX = 1: CURSY = 1
CALL GRID

END SUB

SUB SAVEIT
SHARED TILE$, TILETEXT$
LOCATE 22, 1
PRINT SPACE$(79);
LOCATE 22, 1
INPUT ; "Enter path and filename "; TILENAME$
IF TILENAME$ = "" THEN LOCATE 22, 1: PRINT SPACE$(79); : EXIT SUB
TILETEXT$ = "TILE$ = " + TILETEXT$

OPEN TILENAME$ FOR OUTPUT AS #1
PRINT #1, TILETEXT$
CLOSE
LOCATE 22, 1
PRINT SPACE$(79);
LOCATE 22, 1
PRINT "Tile design has been saved as "; TILENAME$

END SUB

SUB SCREENINIT
SHARED GRIDSIZE, CURSX, CURSY, XSTART, YSTART
REM SETUP SCREEN TEXT
FOR X = 0 TO 15
   X$ = STR$(X)
   LOCATE X + 2, 39
   PRINT HEX$(X);
NEXT X
LOCATE 18, 10: PRINT "Tile-Design Window"; SPACE$(25); "Tile-Display Window";

VIEW PRINT 23 TO 24
TEXT$ = "Tiling-Effect Experimenter - Screen Mode 9"
PRINT STRING$(80, "=")
PRINT TAB(40 - (LEN(TEXT$) / 2)); TEXT$;
VIEW PRINT 20 TO 22
PRINT STRING$(80, "=")
LOCATE 21, 1: PRINT "(0-9 A-F) Colors  (G)rid  (N)ew Grid  (Q)uit  (S)ave  (T)ile display";
LOCATE 22, 1
PRINT "No messages";

'Set up view port
VIEW (1, 1)-(638, 265), , 15

'Set up view-port windows
LINE (293, 0)-(343, 265), , B

'Set up up color bar
LINE (318, 12)-(333, 237), , B
LINY = 12
FOR X = 1 TO 16
   LINY = LINY + 14
   LINE (318, LINY)-(333, LINY)
   PAINT (320, LINY - 2), X - 1, 15
NEXT X

'Set up Tile-Display Window
LINE (363, 20)-(617, 228), , B

'Set up Tile-Design Window
CALL GRID

END SUB

SUB SETCURS
SHARED GRIDSIZE, CURSX, CURSY, XSTART, YSTART, OLDCURSX, OLDCURSY, BOXCOLOR

LINE (OLDCURSX * 12 + XSTART - 12, OLDCURSY * 9 + YSTART - 9)-(OLDCURSX * 12 + XSTART, OLDCURSY * 9 + YSTART), 7, B
LINE (CURSX * 12 + XSTART - 12, CURSY * 9 + YSTART - 9)-(CURSX * 12 + XSTART, CURSY * 9 + YSTART), BOXCOLOR(CURSX, CURSY), BF

LINE (CURSX * 12 + XSTART - 12, CURSY * 9 + YSTART - 9)-(CURSX * 12 + XSTART, CURSY * 9 + YSTART), 15, B

END SUB

