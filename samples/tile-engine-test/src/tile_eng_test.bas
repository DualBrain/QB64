DIM SHARED Map%(0 TO 15, 0 TO 9)        ' This is the 2d array which will be
                                        ' used to hold the map data.

FOR Y = 0 TO 9                          ' This little routine reads the DATA
  FOR X = 0 TO 15                       ' into the map array.  We will use
    READ Map%(X, Y)                     ' this DATA to draw the map and test
  NEXT X                                ' where the player can and can't
NEXT Y                                  ' move.

' Below is the data for a boring little level which I have created.  You can
' change it around in any way you want.
DATA 5,7,7,7,7,7,7,6,6,7,7,7,7,7,7,5  
DATA 5,1,1,0,0,0,0,3,3,0,0,0,0,1,1,5  
DATA 5,5,5,5,5,5,5,4,4,5,5,5,5,5,5,5  
DATA 6,6,6,6,0,0,0,3,3,0,0,0,1,6,6,6 
DATA 6,6,1,1,1,1,0,3,3,0,1,1,1,1,6,6 
DATA 2,6,6,1,1,1,1,3,3,0,1,1,1,1,6,6 
DATA 2,6,6,1,1,1,1,3,3,1,1,1,1,1,1,6 
DATA 2,2,6,6,1,1,1,3,3,1,1,1,1,1,0,5  
DATA 2,2,2,6,6,1,1,3,3,1,1,1,0,0,5,5  
DATA 2,2,6,6,6,5,5,5,5,5,5,5,5,5,5,5

SCREEN 13                               ' We will be using screen mode 13h
                                        ' which has a resolution of 320x200
                                        ' and can display up to 256 colours.

DIM SHARED Grass%(210)                  ' These are the arrays we need to
DIM SHARED Forest%(210)                 ' dimension in order to hold all of
DIM SHARED Desert%(210)                 ' our graphics.
DIM SHARED Dirt%(210)
DIM SHARED Bridge%(210)
DIM SHARED Water%(210)
DIM SHARED Rock%(210)
DIM SHARED Wall%(210)

LINE (0, 0)-(19, 19), 2, BF             ' This is our grass tile.
LINE (5, 5)-(3, 3), 120
LINE (5, 5)-(7, 3), 120
LINE (15, 15)-(13, 13), 120
LINE (15, 15)-(17, 13), 120

GET (0, 0)-(19, 19), Grass%             ' This puts what we have just drawn
                                        ' into the Grass% array.

LINE (0, 0)-(19, 19), 0, BF             ' This command clears what we have
                                        ' just drawn so that we may draw our
                                        ' next tile.

LINE (0, 0)-(19, 19), 120, BF           ' This is our forest tile.
LINE (0, 10)-(10, 5), 2
LINE (10, 5)-(20, 10), 2

GET (0, 0)-(19, 19), Forest%            ' This puts what we have just drawn
                                        ' into the Forest% array.

LINE (0, 0)-(19, 19), 0, BF             ' This command clears what we have
                                        ' just drawn so that we may draw our
                                        ' next tile.

LINE (0, 0)-(19, 19), 43, BF            ' This is our desert tile.
RANDOMIZE TIMER                         ' This is just a simple way of
FOR I = 1 TO 10                         ' drawing 10 random dots on our tile.
  X = INT(RND * 19)
  Y = INT(RND * 19)
  PSET (X, Y), 6
NEXT I

GET (0, 0)-(19, 19), Desert%            ' This puts what we have just drawn
                                        ' into the Desert% array.

LINE (0, 0)-(19, 19), 0, BF             ' This command clears what we have
                                        ' just drawn so that we may draw our
                                        ' next tile.

LINE (0, 0)-(19, 19), 113, BF           ' This is our dirt path tile.
CIRCLE (9, 9), 8, 6
PAINT (9, 9), 6, 6

GET (0, 0)-(19, 19), Dirt%              ' This puts what we have just drawn
                                        ' into the Dirt% array.

LINE (0, 0)-(19, 19), 0, BF             ' This command clears what we have
                                        ' just drawn so that we may draw our
                                        ' next tile.

LINE (0, 0)-(19, 9), 6, BF              ' This is our bridge tile.
LINE (0, 10)-(19, 19), 113, BF

GET (0, 0)-(19, 19), Bridge%            ' This puts what we have just drawn
                                        ' into the Bridge% array.

LINE (0, 0)-(19, 19), 0, BF             ' This command clears what we have
                                        ' just drawn so that we may draw our
                                        ' next tile.

LINE (0, 0)-(19, 19), 105, BF           ' This is our water tile.
LINE (0, 10)-(10, 5), 9
LINE (10, 5)-(20, 10), 9

GET (0, 0)-(19, 19), Water%             ' This puts what we have just drawn
                                        ' into the Water% array.

LINE (0, 0)-(19, 19), 0, BF             ' This command clears what we have
                                        ' just drawn so that we may draw our
                                        ' next tile.

LINE (0, 0)-(19, 19), 2, BF             ' This is our rock/mountain tile.
LINE (1, 17)-(18, 17), 185
LINE (18, 17)-(9, 2), 185
LINE (9, 2)-(1, 17), 185
PAINT (9, 9), 185, 185

GET (0, 0)-(19, 19), Rock%              ' This puts what we have just drawn
                                        ' into the Rock% array.

LINE (0, 0)-(19, 19), 0, BF             ' This command clears what we have
                                        ' just drawn so that we may draw our
                                        ' next tile.

LINE (0, 0)-(19, 9), 23, BF             ' This is our wall tile.
LINE (0, 10)-(19, 19), 25, BF

GET (0, 0)-(19, 19), Wall%              ' This puts what we have just drawn
                                        ' into the Wall% array.

LINE (0, 0)-(19, 19), 0, BF             ' This command clears what we have
                                        ' just drawn.

FOR Y = 0 TO 9
  FOR X = 0 TO 15
    IF Map%(X, Y) = 0 THEN
        PUT (X * 20, Y * 20), Grass%, PSET
      ELSEIF Map%(X, Y) = 1 THEN
        PUT (X * 20, Y * 20), Forest%, PSET
      ELSEIF Map%(X, Y) = 2 THEN
        PUT (X * 20, Y * 20), Desert%, PSET
      ELSEIF Map%(X, Y) = 3 THEN
        PUT (X * 20, Y * 20), Dirt%, PSET
      ELSEIF Map%(X, Y) = 4 THEN
        PUT (X * 20, Y * 20), Bridge%, PSET
      ELSEIF Map%(X, Y) = 5 THEN
        PUT (X * 20, Y * 20), Water%, PSET
      ELSEIF Map%(X, Y) = 6 THEN
        PUT (X * 20, Y * 20), Rock%, PSET
      ELSEIF Map%(X, Y) = 7 THEN
        PUT (X * 20, Y * 20), Wall%, PSET
    END IF
  NEXT X
NEXT Y

DIM SHARED PlayerX%, PlayerY%           ' We must create global variables    
                                        ' for the character's X and Y
                                        ' position, relative to the map.

PlayerX% = 7                            ' We give our player any ol' starting
PlayerY% = 8                            ' position.  Just make sure they are
                                        ' not standing on an impassable tile.

Moved = 1
DO
  SELECT CASE INKEY$
  CASE CHR$(0) + CHR$(77)               ' Code for right arrow key.
    IF Map%(PlayerX% + 1, PlayerY%) < 5 THEN
      GOSUB DrawBackGround
      PlayerX% = PlayerX% + 1
      Moved = 1
    END IF
  CASE CHR$(0) + CHR$(75)               ' Code for left arrow key.
    IF Map%(PlayerX% - 1, PlayerY%) < 5 THEN
      GOSUB DrawBackGround
      PlayerX% = PlayerX% - 1
      Moved = 1
    END IF
  CASE CHR$(0) + CHR$(80)               ' Code for down arrow key.
    IF Map%(PlayerX%, PlayerY% + 1) < 5 THEN
      GOSUB DrawBackGround
      PlayerY% = PlayerY% + 1
      Moved = 1
    END IF
  CASE CHR$(0) + CHR$(72)               ' Code for up arrow key.
    IF Map%(PlayerX%, PlayerY% - 1) < 5 THEN
      GOSUB DrawBackGround
      PlayerY% = PlayerY% - 1
      Moved = 1
    END IF
  CASE CHR$(27)                         ' Code for Esc key.
    Quit = 1
  END SELECT
 
  IF Moved = 1 THEN
    X% = PlayerX% * 20                  ' This little routine draws our
    Y% = PlayerY% * 20                  ' character in the right position
    CIRCLE (X% + 9, Y% + 9), 9, 40      ' on the screen.
    PAINT (X% + 9, Y% + 9), 40, 40
    CIRCLE (X% + 5, Y% + 6), 3, 31
    PAINT (X% + 5, Y% + 6), 31, 31
    CIRCLE (X% + 13, Y% + 6), 3, 31
    PAINT (X% + 13, Y% + 6), 31, 31
    CIRCLE (X% + 5, Y% + 6), 0, 16
    CIRCLE (X% + 13, Y% + 6), 0, 16
    CIRCLE (X% + 4, Y% + 17), 2, 4
    PAINT (X% + 4, Y% + 17), 4, 4
    CIRCLE (X% + 14, Y% + 17), 2, 4
    PAINT (X% + 14, Y% + 17), 4, 4
    CIRCLE (X% + 9, Y% + 9), 2, 16
    PAINT (X% + 9, Y% + 9), 16, 16
    Moved = 0
  END IF
   
LOOP UNTIL Quit = 1

SCREEN 0: WIDTH 80
PRINT "Thank you for trying this demo."
SYSTEM
 
DrawBackGround:
  X = PlayerX%
  Y = PlayerY%
  IF Map%(X, Y) = 0 THEN
      PUT (X * 20, Y * 20), Grass%, PSET
    ELSEIF Map%(X, Y) = 1 THEN
      PUT (X * 20, Y * 20), Forest%, PSET
    ELSEIF Map%(X, Y) = 2 THEN
      PUT (X * 20, Y * 20), Desert%, PSET
    ELSEIF Map%(X, Y) = 3 THEN
      PUT (X * 20, Y * 20), Dirt%, PSET
    ELSEIF Map%(X, Y) = 4 THEN
      PUT (X * 20, Y * 20), Bridge%, PSET
    ELSEIF Map%(X, Y) = 5 THEN
      PUT (X * 20, Y * 20), Water%, PSET
    ELSEIF Map%(X, Y) = 6 THEN
      PUT (X * 20, Y * 20), Rock%, PSET
    ELSEIF Map%(X, Y) = 7 THEN
      PUT (X * 20, Y * 20), Wall%, PSET
  END IF
  RETURN