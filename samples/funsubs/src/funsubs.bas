DECLARE SUB MarqueePause (CH%, BKCLR%, CHCLR%, ROW%, COL%, WIDE%, HIGH%, TOUT!)
DECLARE SUB TICKPRINT (MESSAGE$, ROW%, COL%, DELAY!, SND%, BKCLR%, CHCLR%)
DECLARE SUB TickerTape (MESSAGE$, ROW%, DELAY!, SND%, BKCLR%, CHCLR%)
DECLARE SUB DoSound (Whichsnd%, HowMany%)
DEFINT A-Z

' FUNSUBS.BAS
' by Dennis Mull and Tina Sweet
' Copyright (C) 1994 DOS World
' Published in Issue #18, November 1994, page 54

'--------- Demo Program ------------'
CH% = 42               'Use any number from 1 to 6, 8, 14 to 27, or 33 to 254
CHCLR% = 15            'Foreground (text) color value, use 0 to 15
BKCLR% = 0             'Background color value, use 0 to 15
WIDE% = 45             'Width of marquee, use 5 to 78
ROW% = 19              'Starting row, use 1 to 23
COL% = 17              'Starting column, use 1 to 78
HIGH% = 2              'Border height, use 1 to 23
TOUT! = 5              'Timeout value, use 1 to ? seconds

CLS
LOCATE 20, 24: PRINT "Press any key to exit the marquee"
MarqueePause CH%, BKCLR%, CHCLR%, ROW%, COL%, WIDE%, HIGH%, TOUT!
CLS : MESSAGE$ = "Press any key to Exit"
TICKPRINT MESSAGE$, 12, 26, 5, 1, 0, 14

CLS
LOCATE 12, 35, 0: PRINT "Whistle   "
DoSound 1, 5: SLEEP 1
LOCATE 12, 35: PRINT "Bomb Drop "
DoSound 2, 1: SLEEP 1
LOCATE 12, 35: PRINT "Bee Bop   "
DoSound 3, 3: SLEEP 1
LOCATE 12, 35: PRINT "Siren     "
DoSound 4, 3: SLEEP 1
LOCATE 12, 35: PRINT "          "

MESSAGE$ = " Press any key any exit.    **** This is a simple ticker-tape program. ****"
TickerTape MESSAGE$, 25, 6, 40, 0, 14
LOCATE 11, 35: PRINT "The End!"
END

DEFSNG A-Z
SUB DoSound (Whichsnd%, HowMany%) STATIC

  Repeat% = 0

  DO
    SELECT CASE Whichsnd%
            CASE 1
                 FOR n = 900 TO 1500 STEP 8     ' Whistle
                    SOUND n, .1
                 NEXT n
            CASE 2                              ' Bomb drop
                 FOR n = 1900 TO 100 STEP -5
                     SOUND n, .1
                 NEXT n
            CASE 3                              ' BeepBop
                 SOUND 500, 1
                 loops = 6
                 TIN! = TIMER
                 WHILE TIMER < (TIN! + loops) / 100: WEND
                     SOUND 1000, 1
                 WHILE TIMER < (TIN! + loops) / 100: WEND
            CASE 4                              ' Siren
                 SOUND 1700, 5
                 SOUND 1000, 5
    END SELECT

    Repeat% = Repeat% + 1

  LOOP WHILE Repeat% < HowMany%
END SUB

SUB MarqueePause (CH%, BKCLR%, CHCLR%, ROW%, COL%, WIDE%, HIGH%, TOUT!) STATIC

  COLOR CHCLR%, BKCLR%                 ' Set character color
  CHAR$ = CHR$(CH%)
  IF WIDE% > 80 THEN WIDE% = 79

  IF WIDE% > 1 THEN
    WIDE% = (WIDE% / 5) + 1
  END IF

  LESS% = 5: W% = 4
  IF WIDE% >= 15 THEN
    LESS% = -1
    W% = 5
  END IF

  IF HIGH% > 25 THEN HIGH% = 24        ' Check for out-of-range values

  IF ROW% > 25 THEN
    ROW% = 25 - HIGH%
  END IF
  IF ROW% + HIGH% > 25 THEN
    ROW% = 25 - HIGH%
  END IF

  IF CHAR$ = " " THEN CHAR$ = "*"
  CHAR$ = CHAR$ + SPACE$(W%)
  TOP% = ROW%: BOTTOM% = ROW% + HIGH%

  FOR I = 1 TO WIDE%                   ' Create character bars
    TOPCHAR$ = CHAR$ + TOPCHAR$
  NEXT I
  CHAR$ = TOPCHAR$

  LENGTH% = LEN(CHAR$)                 ' Check bar length
  IF LENGTH% > 79 THEN LENGTH% = 78

  IF LENGTH% < 79 THEN
    IF COL% + LENGTH% > 78 THEN
      COL% = (78 - LENGTH%) + 3
    END IF
  END IF
  IF LENGTH% = 78 THEN COL% = 1
  TIN! = TIMER
  TOUT! = TIMER + TOUT!

  DO                                   ' Break out on key press
    FOR X = 1 TO 5                     ' Begin printing loop for border
      TIN! = TIMER
      WHILE TIMER < TIN! + .008: WEND  ' Control light speed
      LOCATE TOP%, COL%, 0
      PRINT MID$(RTRIM$(CHAR$), X, 80);   ' Print horizontal bars
      LOCATE TOP%, COL% + (WIDE% * 5) - 6, 0
      PRINT " "
      LOCATE TOP%, COL% + (WIDE% * 5) - 8, 0
      PRINT " "
      LOCATE BOTTOM%, COL%, 0
      PRINT MID$(RTRIM$(CHAR$), 6 - X, 80);

      FOR B = ROW% TO BOTTOM%          ' Print vertical bars
        C = (X + B) MOD 2
        IF C = 1 THEN
          LOCATE B, COL%, 0
          PRINT LEFT$(CHAR$, 1);
          LOCATE B, (LENGTH% - LESS%) + COL%, 0
          PRINT LEFT$(CHAR$, 1);
        ELSE
          LOCATE B, COL%, 0
          PRINT " ";
          LOCATE B, (LENGTH% - LESS%) + COL%, 0
          PRINT " ";
        END IF
      NEXT B
    NEXT X

    KEY$ = "": KEY$ = INKEY$
    IF TIMER > TOUT! THEN EXIT DO      ' Drop out when TIMER = TOUT!

  LOOP WHILE KEY$ = ""
  COLOR 7, 0
  CLS

END SUB

SUB TickerTape (MESSAGE$, ROW%, DELAY!, SND%, BKCLR%, CHCLR%) STATIC

  Spac% = 80 - Tapelen%                    ' Find spaces needed
  MESSAGE$ = STRING$(Spac%, 32) + MESSAGE$ ' Add those spaces to MESSAGE$
  Tapelen% = LEN(MESSAGE$)                 ' Assign length to Tapelen%
  COLOR CHCLR%, BKCLR%

DO
  FOR tap% = Tapelen% TO 1 STEP -1             ' Print MESSAGE$ starting at
                                               ' the end.
    LOCATE ROW%, 1, 0                          ' Start printing MESSAGE$ here
    IF Expand% < 80 THEN Expand% = Expand% + 1 ' Advance position counter
    PRINT MID$(MESSAGE$, tap%, Expand%);       ' Print MESSAGE$
    KEY$ = INKEY$: IF KEY$ <> "" THEN EXIT DO  ' Check for a key press

    TIN! = TIMER
    WHILE TIMER < TIN! + DELAY! / 100: WEND    ' Timing loop
    IF SND% THEN SOUND 200, .1                 ' Make Ticking sound

    IF CHCLR% = 0 THEN                 ' If set to zero, then make it print
      IF colr% < 13 THEN               ' in colors.
        colr% = colr% + 1              ' Increment color value
        COLOR colr% + 2, 0
      ELSE colr% = 0                   ' Reset to zero
      END IF
    END IF

  NEXT tap%
LOOP
  COLOR 15, 0
END SUB

SUB TICKPRINT (MESSAGE$, ROW%, COL%, DELAY!, SND%, BKCLR%, CHCLR%) STATIC

DEFSNG A-Z

COLOR CHCLR%, BKCLR%

IF COL% + LEN(MESSAGE$) > 79 THEN      ' Check for column position
  COL% = 79 - LEN(MESSAGE$)            ' If too long, reset COL%
END IF

DO
  LOCATE ROW%, COL%, 0
  PRINT SPACE$(LEN(MESSAGE$)) + " "
  FOR T = 1 TO LEN(MESSAGE$)           ' Print message, left to right
    IF CHCLR% = 0 THEN                 ' If color is zero, print in 15
      IF DOC% < 15 THEN DOC% = DOC% + 1       ' different colors
      COLOR DOC%, BKCLR%
      IF DOC% = 15 THEN DOC% = 0
    END IF

    LOCATE ROW%, COL% + T
    PRINT MID$(MESSAGE$, T, 1)
    TIN! = TIMER
    WHILE TIMER < TIN! + (DELAY! / 100): WEND   ' Timing loop
    IF SND% THEN
      IF MID$(MESSAGE$, T, 1) <> " " THEN
        SOUND 500, .1                  ' If SND% = 1, make sound
      END IF
    END IF
    KEY$ = INKEY$: IF KEY$ <> "" THEN EXIT DO   ' Check for a key press
  NEXT T
  SLEEP 1
  LOCATE , , 1                                  ' Turn cursor back on
LOOP
COLOR 15, 0

END SUB

