 '                      Diamond Pong
 '                           by
 '                     John Wolfskill
 '
 '  Copyright (C) 1993 DOS Resource Guide
 '  Published in Issue #9, May 1993
 '
 '  Requires IBM PC with CGA, EGA or VGA color monitor
 '  A joystick is optional (recommended)
 '
 ' -- Program Initialization --
 DEFINT A-Z
 GOSUB PROMPT
 INPUT "Select color monitor: <1> VGA  <2> CGA, EGA Monitor"; VGA
 GOSUB PROMPT
 INPUT "Input device is <1> Keyboard <2> Joystick"; IDEV
 
 IF IDEV = 2 THEN
  CX = 30: CY = 30       ' default joystick calibration values
  GOSUB PROMPT
  INPUT "Do you want to calibrate the joystick (Y/N)"; YN$
  IF UCASE$(YN$) = "Y" THEN GOSUB CALIBRATE
 END IF

 DIM PONG(1000)       ' array to hold pong
 DIM PADDLE(1000)     ' array to hold paddle
 '--- Paddle movement strings ---
 L$ = CHR$(0) + CHR$(75): R$ = CHR$(0) + CHR$(77)
 U$ = CHR$(0) + CHR$(72): D$ = CHR$(0) + CHR$(80)
 DL$ = CHR$(0) + CHR$(79): UR$ = CHR$(0) + CHR$(73)
 DR$ = CHR$(0) + CHR$(81): UL$ = CHR$(0) + CHR$(71)
 ' -- Data for pong diamond --
 DATA 60,60,66,66,60,72,54,66
 CLICKS = 240      ' 240 seconds. Initial time allocation
 PINCR = 4         ' default paddle speed (1-20)
 TINC = 3          ' default pong speed (1-20)
 IF VGA = 1 THEN SCREEN 13 ELSE SCREEN 1     ' set video mode
 '-- Set up playfield --
 WX = 20                       ' left edge of pong table
 WY = 20                       ' top edge pong table
 WX1 = 300                     ' right edge of pong table
 WY1 = 180                     ' bottom edge of pong table
 MIDY = 20 + (WY1 - WY) / 2    ' middle top (x) of pong table
 MIDX = 20 + (WX1 - WX) / 2    ' middle top (y) of pong table
 START! = TIMER                ' reset game timer
 '-----
DO
  CLS
  BS = INT(((50 - 20) + 1) * RND + 20)  ' random bumper size
  GOSUB DRAWTABLE                       ' draw the pong table
  '-- Setup the pong --
  REDIM X(4), Y(4)                      ' arrays hold pong hotspots
  RESTORE                               ' reset data pointer

  FOR J = 1 TO 4
   READ X(J)    ' store the default pong hotspots
   READ Y(J)
  NEXT

  PSET (X(1), Y(1)), 1                    ' set the pong position
  DRAW "F6G6H6E6BD2P14,1"                 ' draw it
  GET (X(4), Y(1))-(X(2), Y(3)), PONG     ' snapshot the pong
  LINE (X(4), Y(1))-(X(2), Y(3)), 0, BF   ' then erase it
  X = X(4): Y = Y(1)                      ' set inital pong position
  CDEEP = (Y(3) - Y(1)) + 1               ' pong depth
  CWIDE = (X(2) - X(4)) + 1               ' pong width
  '-- Setup the paddle --
  PADX = 160: PADY = 100                  ' initial paddle position
  GOSUB MAKEPAD                           ' draw the paddle
  GOSUB DISPLAY                           ' print parmeters
  PINGX = TINC: PINGY = TINC              ' initial pong movement
 ' ------ Main processing loop -------
DO
 X$ = INKEY$
 
 IF LEN(X$) THEN
  IF LEN(X$) = 2 THEN GOSUB MOVEPADDLE                  ' check keyboard
  IF X$ = "P" THEN IF PINCR < 20 THEN PINCR = PINCR + 1 ' faster paddle
  IF X$ = "p" THEN IF PINCR > 1 THEN PINCR = PINCR - 1  ' slower paddle
  IF X$ = "S" THEN IF TINC < 20 THEN TINC = TINC + 1    ' faster pong
  IF X$ = "s" THEN IF TINC > 1 THEN TINC = TINC - 1     ' slower pong
  GOSUB DISPLAY
 END IF

  IF X(2) > WX1 OR X(4) < WX THEN        'check for a goal
   IF Y(1) > MIDY - 15 AND Y(3) < MIDY + 15 THEN
    SCORE = SCORE + 1                    ' increment score
    START! = START! + 10                 ' add bonus 10 secs as reward
    SOUND 200, 1: SOUND 400, 1           ' make a happy sound!!
    SOUND 600, 1: SOUND 800, 1           '
    EXIT DO
   END IF
  END IF
 
  GOSUB MOVEPONG                              ' move the pong
  GOSUB COLLIDE                               ' check for collision
  CURTIME! = TIMER                            ' get current time
  ETIME! = CURTIME! - START!                  ' subtract to get elapsed time
  IF ETIME! > 240 THEN EXITGAME = 1: EXIT DO  ' time's up
  LOCATE 25, 31: PRINT "TIME:"; 240 - INT(ETIME!);
 LOOP

 IF EXITGAME THEN
  EXITGAME = 0
  CLS : LOCATE 12, 17: PRINT "GAME OVER"
  LOCATE 13, 13: PRINT "Final score "; SCORE;
  LOCATE 14, 12: INPUT " Play again (Y/N)"; YN$
  IF UCASE$(YN$) = "N" THEN EXIT DO
  SCORE = 0: CLICKS = 240: START! = TIMER       ' reset values for new game
 END IF

LOOP
'---- End the game --
CLS : END
'---------
MOVEPONG:
  SEED = INT(((5 - (-5)) + 1) * RND(1) + (-5)) ' random bounce angle seed

  IF X < WX THEN                    ' pong hit left wall
   X(4) = WX: X(3) = WX + 6         ' reset pong hotspots
   X(2) = WX + 12: X(1) = WX + 6
   X = WX                           ' reset pong coordinates
   PINGX = TINC: SOUND 1000, 1      ' make it bounce away
   PINGY = TINC + SEED              ' SEED creates pseudo-random bounce
  END IF

  IF X + CWIDE > WX1 THEN           'pong hit right wall
    X(4) = WX1 - 12: X(3) = WX1 - 6 ' reset pong hotspots
    X(2) = WX1: X(1) = WX1 - 6
    X = WX1 - CWIDE                 ' reset pong x coordinate
    PINGX = -TINC: SOUND 1000, 1    ' make it bounce away
    PINGY = -TINC - SEED            ' SEED creates pseudo-random bounce
  END IF

  IF Y < WY THEN                   ' pong hit top wall
    Y(4) = WY + 6: Y(3) = WY + 12  ' reset pong hotspots
    Y(2) = WY + 6: Y(1) = WY
    Y = WY                         ' and pong y coordinate
    PINGY = TINC: SOUND 1000, 1    ' make it bounce away
    PINGX = -TINC + SEED           ' SEED creates psuedo-random bounce
  END IF

  IF Y + CDEEP > WY1 THEN          ' pong hit bottom wall
    Y(4) = WY1 - 6: Y(3) = WY1     ' reset hotspots
    Y(2) = WY1 - 6: Y(1) = WY1 - 12
    Y = WY1 - CDEEP                ' and pong y coordinate
    PINGY = -TINC: SOUND 1000, 1   ' make it bounce away
    PINGX = TINC - SEED            ' SEED creates puedo-random bonce
  END IF
   
  FOR J = 1 TO 4                   ' update all hotspot coordinates
   X(J) = X(J) + PINGX
   Y(J) = Y(J) + PINGY
  NEXT
  
   PUT (X, Y), PONG, XOR           ' print the pong

   
 IF IDEV = 2 THEN                                       ' if joystick in use
    AA = STICK(0): BB = STICK(1)                        ' get x,y coordinates
    DG = 0                                              ' set the activity flag
    IF AA < CX - 8 AND BB > CY - 8 THEN X$ = DL$: DG = 1' move down and left
    IF AA > CX + 8 AND BB < CY - 8 THEN X$ = UR$: DG = 1' move up and right
    IF AA > CX + 8 AND BB > CY + 8 THEN X$ = DR$: DG = 1' move down and right
    IF AA < CX - 8 AND BB < CY - 8 THEN X$ = UL$: DG = 1' move up and left

   IF DG = 0 THEN
    IF AA < CX - 8 THEN X$ = L$: DG = 1 ' move left
    IF AA > CX + 8 THEN X$ = R$: DG = 1 ' move right
    IF BB < CY - 8 THEN X$ = U$: DG = 1 ' move up
    IF BB > CY + 8 THEN X$ = D$: DG = 1 ' move down
   END IF

    IF DG THEN GOSUB MOVEPADDLE    ' move the paddle
  ELSE
   GOSUB SWAIT   ' if no joystick, a small time delay
 END IF

 PUT (X, Y), PONG, XOR                    ' erase the pong
 IF HIT THEN HIT = 0: TINC = TTINC        ' reset pong accelerator flag

  IF IDEV = 2 THEN                        ' if joystick installed
    GOSUB MOVEPADDLE                      ' move the paddle
   ELSE
    GOSUB SWAIT                           ' create a small time delay
   END IF
   
   X = X + PINGX                    ' move x coordinate of pong
   Y = Y + PINGY                    ' move y coordinate of pong
   RETURN
'--- Print paddle/pong speed and score --
DISPLAY:
 LOCATE 25, 1: PRINT "SCORE:"; : PRINT USING "##"; SCORE;
 LOCATE 25, 11: PRINT "<S>PD:"; : PRINT USING "##"; TINC;
 LOCATE 25, 21: PRINT "<P>AD:"; : PRINT USING "##"; PINCR;
 RETURN
'-- Print the paddle --
PP:
 PUT (PADX, PADY), PADDLE, XOR                  ' print the paddle
 RETURN
'-- Check paddle bounds and erase it --
PP1:
 IF PADY + PDEEP > WY1 THEN PADY = WY1 - PDEEP  ' keep paddle in bounds
 IF PADY < WY THEN PADY = WY
 IF PADX + PWIDE > WX1 THEN PADX = WX1 - PWIDE
 IF PADX < WX THEN PADX = WX
 PUT (PADX, PADY), PADDLE, XOR                  ' erase the paddle
 RETURN
'-- Move the paddle --
MOVEPADDLE:
 GOSUB PP
 IF X$ = D$ THEN PADY = PADY + PINCR: PADY1 = PADY1 + PINCR
 IF X$ = U$ THEN PADY = PADY - PINCR: PADY1 = PADY1 - PINCR
 IF X$ = L$ THEN PADX = PADX - PINCR: PADX1 = PADX1 - PINCR
 IF X$ = R$ THEN PADX = PADX + PINCR: PADX1 = PADX1 + PINCR
 IF X$ = UR$ THEN PADX = PADX + PINCR: PADY = PADY - PINCR
 IF X$ = UL$ THEN PADX = PADX - PINCR: PADY = PADY - PINCR
 IF X$ = DR$ THEN PADX = PADX + PINCR: PADY = PADY + PINCR
 IF X$ = DL$ THEN PADX = PADX - PINCR: PADY = PADY + PINCR
 GOSUB PP1
 RETURN
'-- Draw the playing field --
DRAWTABLE:
  LINE (WX - 1, WY - 1)-(WX1 + 1, WY1 + 1), 2, B        ' draw the playfield
  LINE (WX1 + 1, MIDY - 15)-(WX1 + 1, MIDY + 15), 0, B  ' right goal
  LINE (WX - 1, MIDY - 15)-(WX - 1, MIDY + 15), 0, B    ' left goal
  
  IF SCORE > 1 THEN
   LINE (MIDX - 3, WY)-(MIDX + 3, WY + (BS)), 3, BF       ' top bumper
   LINE (MIDX - 4, WY + (BS))-(MIDX + 4, WY + (BS)), 3, B ' top bumper rail
  END IF

  IF SCORE > 2 THEN
   LINE (MIDX - 16, WY1)-(MIDX - 10, WY1 - (BS)), 3, BF       ' btm bumper
   LINE (MIDX - 17, WY1 - (BS))-(MIDX - 9, WY1 - (BS)), 3, B  ' btm bumper rail
  END IF

  IF SCORE > 3 THEN
   CIRCLE (MIDX + 50, MIDY - 20), 10, 3   'left round bumper
   PAINT (MIDX + 50, MIDY - 20), 3, 3
  END IF

  IF SCORE > 4 THEN
   CIRCLE (MIDX - 50, MIDY + 20), 10, 3   ' right round bumper
   PAINT (MIDX - 50, MIDY + 20), 3, 3
  END IF

  IF SCORE > 8 THEN
   LINE (WX1 - 32, MIDY - 5)-(WX1 - 22, MIDY + 5), 3, BF ' right goal block
  END IF

  IF SCORE > 10 THEN
   LINE (WX + 32, MIDY - 5)-(WX + 22, MIDY + 5), 3, BF ' left goal block
  END IF

  RETURN

'-- Create a short time delay to control XOR flashing --
SWAIT:
 T! = TIMER: WHILE T! = TIMER: WEND: RETURN
'--- Check for a collision between color 3 objects and the pong --
COLLIDE:
  SIDE = 0   ' reset collision flag

  FOR J = 1 TO 4
   IF POINT(X(J), Y(J)) = 3 THEN   ' is the pixel under hotspot color 3 ?
    SIDE = J       ' collision on this side!
    SOUND 2000, 1  ' sound the collision alert
    EXIT FOR       ' abandon ship
   END IF
  NEXT

  IF SIDE THEN
   TTINC = TINC                             ' save the old pong speed
   TINC = INT(((12 - 5) + 1) * RND(1) + 5)  ' random pong accelerator
   HIT = 1                                  ' set the accelerator flag
  END IF

  IF SIDE = 1 THEN PINGX = 0: PINGY = TINC   ' collison top side
  IF SIDE = 2 THEN PINGX = -TINC: PINGY = 0  ' collision right side
  IF SIDE = 3 THEN PINGX = 0: PINGY = -TINC  ' collsion bottom side
  IF SIDE = 4 THEN PINGX = TINC: PINGY = 0   ' collsion left side
  RETURN
'-- Create the paddle --
MAKEPAD:
   PADX1 = PADX + 4: PADY1 = PADY + 18       ' paddle coordinates
   PWIDE = (PADX1 - PADX) + 1                ' paddle width
   PDEEP = (PADY1 - PADY) + 1                ' paddle depth
   LINE (PADX, PADY)-(PADX1, PADY1), 3, BF   ' create the paddle
   GET (PADX, PADY)-(PADX1, PADY1), PADDLE   ' snapshot the paddle
   LINE (PADX, PADY)-(PADX1, PADY1), 0, BF   ' then erase it
   PUT (PADX, PADY), PADDLE, XOR             ' place it on the screen
   RETURN
'---- Erase the screen --
PROMPT:
 CLS : LOCATE 12, 12  ' prepare to display the prompt
 RETURN
'-- Calibrate the joystick --
CALIBRATE:
 GOSUB PROMPT
 PRINT "Please center the joystick lever. Press <ENTER>";
 DO
 X$ = INKEY$
  IF X$ = CHR$(13) THEN
   CX = STICK(0): CY = STICK(1)     ' read joystick centerline values
   RETURN
  END IF
 LOOP
 

