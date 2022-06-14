DECLARE SUB ShowNeighbors (x, y)
DECLARE SUB ShowGridItem (x!, y!, mode)
DECLARE SUB PlayGame ()
DECLARE SUB InitializeGame ()

' BOMBER.BAS by Doug Lowe
' Copyright (C) 1994 DOS Resource Guide. Sept. 1994 issue, page 58

CLS : SCREEN 0
DIM SHARED Grid(11, 11)    ' 0-8 = adjacent bombs; 9=bomb
DIM SHARED Show(11, 11)    ' 0 = hidden  1 = exposed  2 = marked
DIM SHARED OpenX         ' Number of squares currently revealed
DIM SHARED FirstMove, StartTime
RANDOMIZE TIMER
CALL InitializeGame
EndGame = 0
OpenX = 0
Marks = 0
x = 1: y = 1: CALL ShowGridItem(x, y, 1)
DO
    COLOR 8, 3
    DO: in$ = INKEY$
        IF FirstMove = 0 THEN
            LOCATE 19, 68: PRINT USING "###"; TIMER - StartTime;
        END IF
    LOOP WHILE in$ = ""
    IF in$ = CHR$(13) THEN             'Enter to reveal square
        IF FirstMove = 1 THEN
            StartTime = TIMER
            FirstMove = 0
        END IF
        Show(x, y) = 1
        CALL ShowGridItem(x, y, 1)
        IF Grid(x, y) = 9 THEN
            COLOR 8, 3
            FOR x = 1 TO 10: FOR y = 1 TO 10
                Show(x, y) = 1
                CALL ShowGridItem(x, y, 0)
            NEXT y: NEXT x
            COLOR 15, 4: BEEP
            LOCATE 5, 58: PRINT "ษอออออออออออออออออป";
            LOCATE 6, 58: PRINT "บ                 บ";
            LOCATE 7, 58: PRINT "บ     Bummer!     บ";
            LOCATE 8, 58: PRINT "บ                 บ";
            LOCATE 9, 58: PRINT "บ    You Lost.    บ";
            LOCATE 10, 58: PRINT "บ                 บ";
            LOCATE 11, 58: PRINT "บ   Press a key   บ";
            LOCATE 12, 58: PRINT "บ    to begin     บ";
            LOCATE 13, 58: PRINT "บ   a new game.   บ";
            LOCATE 14, 58: PRINT "บ                 บ";
            LOCATE 15, 58: PRINT "ศอออออออออออออออออผ";
            DO: LOOP UNTIL INKEY$ <> ""
            CALL InitializeGame
            x = 1: y = 1: CALL ShowGridItem(x, y, 1)
            OpenX = 0: Marks = 0
      
        ELSE
            OpenX = OpenX + 1
            IF Grid(x, y) = 0 THEN
                CALL ShowNeighbors(x, y)
                CALL ShowGridItem(x, y, 1)
            END IF
            IF OpenX = 88 THEN
                COLOR 15, 1: BEEP
                LOCATE 5, 58: PRINT "ษอออออออออออออออออป";
                LOCATE 6, 58: PRINT "บ                 บ";
                LOCATE 7, 58: PRINT "บ   Excellent!    บ";
                LOCATE 8, 58: PRINT "บ                 บ";
                LOCATE 9, 58: PRINT "บ    You Won.     บ";
                LOCATE 10, 58: PRINT "บ                 บ";
                LOCATE 11, 58: PRINT "บ   Press a key   บ";
                LOCATE 12, 58: PRINT "บ    to begin     บ";
                LOCATE 13, 58: PRINT "บ   a new game.   บ";
                LOCATE 14, 58: PRINT "บ                 บ";
                LOCATE 15, 58: PRINT "ศอออออออออออออออออผ";
                DO: LOOP UNTIL INKEY$ <> ""
                CALL InitializeGame
                x = 1: y = 1: CALL ShowGridItem(x, y, 1)
                OpenX = 0: Marks = 0
            END IF
        END IF
    ELSEIF in$ = " " THEN              'Space to mark square
        IF Show(x, y) = 0 THEN
            Show(x, y) = 2: Marks = Marks + 1
        ELSEIF Show(x, y) = 2 THEN
            Show(x, y) = 0: Marks = Marks - 1
        END IF
        COLOR 8, 3: LOCATE 25, 77: PRINT USING "###"; 12 - Marks;
        CALL ShowGridItem(x, y, 1)
    ELSEIF LEN(in$) = 2 THEN
        SELECT CASE RIGHT$(in$, 1)
            CASE CHR$(77)                     'Right arrow
                CALL ShowGridItem(x, y, 0)
                IF x < 10 THEN x = x + 1
                CALL ShowGridItem(x, y, 1)
            CASE CHR$(75)                     'Left arrow
                CALL ShowGridItem(x, y, 0)
                IF x > 1 THEN x = x - 1
                CALL ShowGridItem(x, y, 1)
            CASE CHR$(72)                     'Up arrow
                CALL ShowGridItem(x, y, 0)
                IF y > 1 THEN y = y - 1
                CALL ShowGridItem(x, y, 1)
            CASE CHR$(80)                     'Down arrow
                CALL ShowGridItem(x, y, 0)
                IF y < 10 THEN y = y + 1
                CALL ShowGridItem(x, y, 1)
            CASE CHR$(60)                     'F2
                CALL InitializeGame
                x = 1: y = 1: CALL ShowGridItem(x, y, 1)
                OpenX = 0
            CASE CHR$(68)                     'F10
                COLOR 7, 0: CLS
                SYSTEM
            CASE ELSE
        END SELECT
    END IF
LOOP UNTIL EndGame = 1

SUB InitializeGame
COLOR 7, 0: CLS
COLOR 10: LOCATE 1, 23: PRINT "M A D   B O M B E R"
COLOR 8, 3
LOCATE 2, 10: PRINT " ษอออัอออัอออัอออัอออัอออัอออัอออัอออัอออป ";
FOR x = 3 TO 19 STEP 2
LOCATE x, 10: PRINT " บ   ณ   ณ   ณ   ณ   ณ   ณ   ณ   ณ   ณ   บ ";
LOCATE x + 1, 10: PRINT " วฤฤฤลฤฤฤลฤฤฤลฤฤฤลฤฤฤลฤฤฤลฤฤฤลฤฤฤลฤฤฤลฤฤฤถ ";
NEXT x
LOCATE 21, 10: PRINT " บ   ณ   ณ   ณ   ณ   ณ   ณ   ณ   ณ   ณ   บ ";
LOCATE 22, 10: PRINT " ศอออฯอออฯอออฯอออฯอออฯอออฯอออฯอออฯอออฯอออผ ";

FOR x = 0 TO 11: FOR y = 0 TO 11: Grid(x, y) = 0: NEXT y: NEXT x
FOR Bomb = 1 TO 12
    BombPlaced = 0
    DO: x = INT(RND * 10 + 1): y = INT(RND * 10 + 1)
        IF Grid(x, y) = 0 AND Grid(x, y) <> 11 THEN
            Grid(x, y) = 9
            BombPlaced = 1
        END IF
    LOOP UNTIL BombPlaced = 1
NEXT Bomb
FOR x = 1 TO 10: FOR y = 1 TO 10
    IF Grid(x, y) = 0 THEN
        Count = 0
        IF Grid(x - 1, y - 1) = 9 THEN Count = Count + 1
        IF Grid(x, y - 1) = 9 THEN Count = Count + 1
        IF Grid(x + 1, y - 1) = 9 THEN Count = Count + 1
        IF Grid(x - 1, y) = 9 THEN Count = Count + 1
        IF Grid(x + 1, y) = 9 THEN Count = Count + 1
        IF Grid(x - 1, y + 1) = 9 THEN Count = Count + 1
        IF Grid(x, y + 1) = 9 THEN Count = Count + 1
        IF Grid(x + 1, y + 1) = 9 THEN Count = Count + 1
        Grid(x, y) = Count
    END IF
    Show(x, y) = 0
NEXT y: NEXT x

'Show grid
FOR x = 1 TO 10: FOR y = 1 TO 10
    CALL ShowGridItem(x, y, 0)
NEXT y: NEXT x
LOCATE 25, 1: PRINT STRING$(80, " "); : LOCATE 25, 1
PRINT " F2 = New Game   F10 = Quit   Enter = Reveal   Space = Mark";
LOCATE 25, 66: PRINT "Bombs left: 12";
LOCATE 18, 61: PRINT "            ";
LOCATE 19, 61: PRINT "  Time:     ";
LOCATE 20, 61: PRINT "            ";
FirstMove = 1
END SUB

SUB ShowGridItem (x, y, mode)
    IF mode = 1 THEN COLOR 3, 8 ELSE COLOR 8, 3
    SELECT CASE Show(x, y)
    CASE 0
        LOCATE (y - 1) * 2 + 3, (x - 1) * 4 + 12
        PRINT "ฑฑฑ";
    CASE 1
        LOCATE (y - 1) * 2 + 3, (x - 1) * 4 + 12
        IF Grid(x, y) = 9 THEN
            COLOR 12: PRINT " * ";
        ELSEIF Grid(x, y) > 0 THEN
            PRINT STR$(Grid(x, y)) + " ";
        ELSE
            PRINT "   ";
        END IF
    CASE 2
        IF mode = 1 THEN COLOR 3, 12 ELSE COLOR 12, 3
        LOCATE (y - 1) * 2 + 3, (x - 1) * 4 + 12
        PRINT " = ";
    CASE ELSE
    END SELECT
END SUB

SUB ShowNeighbors (x, y)
COLOR 8, 3
IF Grid(x, y) = 0 AND Show(x, y) = 1 THEN
   IF y > 1 AND x > 1 THEN
       x1 = x - 1: y1 = y - 1: GOSUB Neighbor
   END IF
   IF y > 1 THEN
       x1 = x: y1 = y - 1: GOSUB Neighbor
   END IF
   IF y > 1 AND x < 10 THEN
       x1 = x + 1: y1 = y - 1: GOSUB Neighbor
   END IF
   IF x > 1 THEN
       x1 = x - 1: y1 = y: GOSUB Neighbor
   END IF
   IF x < 10 THEN
       x1 = x + 1: y1 = y: GOSUB Neighbor
   END IF
   IF y < 10 AND x > 1 THEN
       x1 = x - 1: y1 = y + 1: GOSUB Neighbor
   END IF
   IF y < 10 THEN
       x1 = x: y1 = y + 1: GOSUB Neighbor
   END IF
   IF y < 10 AND x < 10 THEN
        x1 = x + 1: y1 = y + 1: GOSUB Neighbor
   END IF
END IF
EXIT SUB
Neighbor:
   IF Show(x1, y1) = 0 THEN
       Show(x1, y1) = 1: OpenX = OpenX + 1
       CALL ShowGridItem(x1, y1, 0)
       IF Grid(x1, y1) = 0 THEN CALL ShowNeighbors(x1, y1)
   END IF
   RETURN
END SUB

