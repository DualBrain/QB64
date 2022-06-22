OPTION _EXPLICIT

' I used a code snippet by bplus modified to enlarge the characters on the screen.

_TITLE "Maryann - Designed and Programmed by Donald L. Foster Jr. 2018 - Code Snippet by bplus"

SCREEN _NEWIMAGE(1014, 735, 256)

_PALETTECOLOR 1, _RGB32(6, 55, 255) ' Player 1 Piece Color
_PALETTECOLOR 2, _RGB32(255, 61, 0) ' Player 2 Piece Color
_PALETTECOLOR 3, _RGB32(127, 127, 127) ' Board Background Color
_PALETTECOLOR 4, _RGB32(244, 244, 11) ' Arrow Color
_PALETTECOLOR 5, _RGB32(80, 80, 80) ' Cursor Color

_LIMIT 10

DIM A AS STRING
DIM V AS _UNSIGNED INTEGER
DIM W AS _UNSIGNED INTEGER
DIM X AS _UNSIGNED INTEGER
DIM Y AS _UNSIGNED _BYTE
DIM Z AS _UNSIGNED _BYTE

DIM X1 AS _UNSIGNED INTEGER
DIM X2 AS _UNSIGNED INTEGER
DIM X3 AS _UNSIGNED INTEGER
DIM X4 AS _UNSIGNED INTEGER

DIM Player AS _UNSIGNED _BYTE
DIM Opponent AS _UNSIGNED _BYTE
DIM Winner AS _UNSIGNED _BYTE
DIM MovesLeft AS _UNSIGNED _BYTE
DIM CanSelect AS _UNSIGNED _BYTE
DIM Rotation AS _UNSIGNED _BYTE
DIM SquareColor1 AS _UNSIGNED _BYTE
DIM SquareColor2 AS _UNSIGNED _BYTE

DIM BoardX1 AS _UNSIGNED INTEGER
DIM BoardY1 AS _UNSIGNED INTEGER
DIM BoardX2 AS _UNSIGNED INTEGER
DIM BoardY2 AS _UNSIGNED INTEGER

DIM Rotate AS _UNSIGNED _BYTE

DIM TopBoardEdge AS _UNSIGNED _BYTE
DIM BottomBoardEdge AS _UNSIGNED _BYTE
DIM LeftBoardEdge AS _UNSIGNED _BYTE
DIM RightBoardEdge AS _UNSIGNED _BYTE

DIM Row1 AS _UNSIGNED _BYTE
DIM Column1 AS _UNSIGNED _BYTE
DIM Row2 AS _UNSIGNED _BYTE
DIM Column2 AS _UNSIGNED _BYTE

DIM PlayerColor(2) AS INTEGER
DIM Pieces(2) AS _UNSIGNED _BYTE

DIM BoardX(8, 8) AS _UNSIGNED INTEGER
DIM BoardY(8, 8) AS _UNSIGNED INTEGER
DIM BoardPlayer(8, 8) AS _UNSIGNED _BYTE
DIM BoardRotate(8, 8) AS _UNSIGNED _BYTE
DIM Playable(8, 8) AS _UNSIGNED _BYTE
DIM RotationX(8) AS _UNSIGNED INTEGER
DIM RotationY(8) AS _UNSIGNED INTEGER

DIM Arrow AS STRING
DIM Cursor AS STRING
DIM Cursor1 AS STRING
DIM TA$(8)
DIM Message AS STRING

Player = 1: Opponent = 2
Pieces(1) = 8: Pieces(2) = 8
PlayerColor(1) = 1: PlayerColor(2) = 2

TopBoardEdge = 1: BottomBoardEdge = 8: LeftBoardEdge = 1: RightBoardEdge = 8

' Setup Pieces on Board
DATA 6,8,6,8,6,8,5,1,5,1,4,2,4,2,4,2
FOR Z = 1 TO 8: BoardPlayer(1, Z) = 2: BoardPlayer(8, Z) = 1: READ BoardRotate(1, Z), BoardRotate(8, Z): NEXT

Cursor$ = "TA0BU43BL43C5D86R86U86L86BF2D82R82U82L82BU1P5,5"
Cursor1$ = "TA0BU43BL43C0D86R86U86L86BF2D82R82U82L82BU1P0,0"
Arrow$ = "BD20BL10C4R20U20R10H20G20R10D20R10BU10P4,4"
TA$(1) = "TA0": TA$(2) = "TA45": TA$(3) = "TA90": TA$(4) = "TA135": TA$(5) = "TA180": TA$(6) = "TA225": TA$(7) = "TA270": TA$(8) = "TA315"

' Draw Game Title Message
Message$ = " Maryann ": X1 = 727: X2 = 2: X3 = 15: X4 = 4: GOSUB DrawMessage
LINE (0, 0)-(100, 30), 0, BF

' Draw Board
LINE (10, 10)-(724, 724), 3, BF: ' LINE (12, 12)-(723, 723), 3, BF
X = 59
FOR Z = 1 TO 8
    W = 59
    FOR Y = 1 TO 8
        IF (Z + Y) / 2 = FIX((Z + Y) / 2) THEN V = 0 ELSE V = 15
        LINE (W - 43, X - 43)-(W + 43, X + 43), V, BF
        IF BoardPlayer(Z, Y) > 0 THEN X1 = W: X2 = X: X3 = PlayerColor(BoardPlayer(Z, Y)): X4 = BoardRotate(Z, Y): GOSUB DrawPiece
        BoardX(Z, Y) = W: BoardY(Z, Y) = X
        W = W + 88
    NEXT
    X = X + 88
NEXT


StartGame:
MovesLeft = 2

' Draw Player Indicator
X1 = 863: X2 = 130: X3 = Player: X4 = 1: GOSUB DrawPiece
LOCATE 12, 105: PRINT "Player"; Player;

MovesLeft: LOCATE 45, 104: PRINT "Moves Left:"; MovesLeft;

LOCATE 16, 100: PRINT "  Choose a Piece.  ";

ChooseAPieceInput:
DO WHILE _MOUSEINPUT
    FOR Z = 1 TO 8
        FOR Y = 1 TO 8
            IF _MOUSEBUTTON(1) = -1 AND _MOUSEX > BoardX(Z, Y) - 44 AND _MOUSEX < BoardX(Z, Y) + 44 AND _MOUSEY > BoardY(Z, Y) - 44 AND _MOUSEY < BoardY(Z, Y) + 44 THEN
                IF BoardPlayer(Z, Y) = Player THEN Row1 = Z: Column1 = Y: GOSUB ReleaseMouseButton: GOTO EndChoice1
            END IF
        NEXT
    NEXT
LOOP
GOTO ChooseAPieceInput

EndChoice1:
BoardX1 = BoardX(Row1, Column1): BoardY1 = BoardY(Row1, Column1): Rotate = BoardRotate(Row1, Column1)

' Get Color Row1 Column1 Square
IF (Row1 + Column1) / 2 = FIX((Row1 + Column1) / 2) THEN SquareColor1 = 0 ELSE SquareColor1 = 15

' Draw Cursor After Piece is Selected
PSET (BoardX(Row1, Column1), BoardY(Row1, Column1)), 4: DRAW Cursor$

' Set All Playable Locations to 0
FOR Z = 1 TO 8: FOR Y = 1 TO 8: Playable(Z, Y) = 0: NEXT: NEXT

' Get Playable Locations
Playable(Row1, Column1) = 1

ON Rotate GOSUB Check_Up, Check_Up_Left, Check_Left, Check_Down_Left, Check_Down, Check_Down_Right, Check_Right, Check_Up_Right

LOCATE 16, 100: PRINT "Choose a Location. ";

' Draw Piece Rotations
X = 0: V = 1
FOR Z = 1 TO 7 STEP 2
    W = 0
    FOR Y = 0 TO 1
        X1 = 810 + W: X2 = 315 + X: X3 = Player: X4 = V: GOSUB DrawPiece
        RotationX(Z + Y) = 810 + W: RotationY(Z + Y) = 315 + X
        W = W + 110: V = V + 1
    NEXT
    X = X + 110
NEXT

LOCATE 16, 100: PRINT "Choose a Rotation. ";

GetRotationMouseInput:
DO WHILE _MOUSEINPUT
    FOR Z = 1 TO 8
        IF _MOUSEX > RotationX(Z) - 44 AND _MOUSEX < RotationX(Z) + 44 AND _MOUSEY > RotationY(Z) - 44 AND _MOUSEY < RotationY(Z) + 44 THEN
            CanSelect = 1: PSET (RotationX(Z), RotationY(Z)), 4: DRAW Cursor$
        ELSE
            CanSelect = 0: PSET (RotationX(Z), RotationY(Z)), 4: DRAW Cursor1$
        END IF
        IF _MOUSEBUTTON(1) = -1 AND CanSelect = 1 THEN Rotation = Z: GOSUB ReleaseMouseButton: GOTO EndChoice2
    NEXT
LOOP
GOTO GetRotationMouseInput

EndChoice2:
IF Rotation <> Rotate THEN MovesLeft = MovesLeft - 1: LOCATE 45, 104: PRINT "Moves Left:"; MovesLeft; 'ELSE Rotation = Rotate

IF MovesLeft = 0 THEN
    ' Remove Piece Rotations
    LINE (766, 271)-(964, 689), 0, BF

    ' Set Current Piece To New Rotation Position
    BoardRotate(Row1, Column1) = Rotation

    ' Remove Cursor and Piece From Current Location
    LINE (BoardX1 - 43, BoardY1 - 43)-(BoardX1 + 43, BoardY1 + 43), SquareColor1, BF

    ' Redraw Piece in Current Position With New Rotation
    X1 = BoardX1: X2 = BoardY1: X3 = Player: X4 = Rotation: GOSUB DrawPiece: GOTO EndTurn
END IF

ChooseALocationInput:
DO WHILE _MOUSEINPUT
    FOR Z = 1 TO 8
        FOR Y = 1 TO 8
            IF _MOUSEBUTTON(1) = -1 AND _MOUSEX > BoardX(Z, Y) - 44 AND _MOUSEX < BoardX(Z, Y) + 44 AND _MOUSEY > BoardY(Z, Y) - 44 AND _MOUSEY < BoardY(Z, Y) + 44 THEN
                IF Playable(Z, Y) = 1 THEN Row2 = Z: Column2 = Y: GOSUB ReleaseMouseButton: GOTO EndChoice3
            END IF
        NEXT
    NEXT
LOOP
GOTO ChooseALocationInput

EndChoice3:

' Get New Location Information
BoardX2 = BoardX(Row2, Column2): BoardY2 = BoardY(Row2, Column2)
IF (Row2 + Column2) / 2 = FIX((Row2 + Column2) / 2) THEN SquareColor2 = 0 ELSE SquareColor2 = 15

' Piece stayed at Same Location
IF Row2 = Row1 AND Column2 = Column1 THEN
    LINE (BoardX1 - 43, BoardY1 - 43)-(BoardX1 + 43, BoardY1 + 43), SquareColor1, BF
    BoardRotate(Row2, Column2) = Rotation: X1 = BoardX2: X2 = BoardY2: X3 = Player: X4 = Rotation: GOSUB DrawPiece
    LINE (766, 271)-(964, 689), 0, BF: GOTO MovesLeft
END IF

' Remove Piece Rotations
LINE (766, 271)-(964, 689), 0, BF

' Check If Opponent's Piece is Captured
IF BoardPlayer(Row2, Column2) = Opponent THEN Pieces(Opponent) = Pieces(Opponent) - 1

' Assign New Location to Player
BoardPlayer(Row2, Column2) = Player: BoardRotate(Row2, Column2) = Rotation

' Set Old Location to 0
BoardPlayer(Row1, Column1) = 0: BoardRotate(Row1, Column1) = 0

' Clear Piece and Cursors From Old Location
LINE (BoardX1 - 43, BoardY1 - 43)-(BoardX1 + 43, BoardY1 + 43), SquareColor1, BF

' Clear New Location
LINE (BoardX2 - 43, BoardY2 - 43)-(BoardX2 + 43, BoardY2 + 43), SquareColor2, BF

' Redraw Piece at New Location
X1 = BoardX2: X2 = BoardY2: X3 = Player: X4 = Rotation: GOSUB DrawPiece

' Substract 1 from MovesLeft
MovesLeft = MovesLeft - 1: LOCATE 45, 104: PRINT "Moves Left:"; MovesLeft;

' Check if a Row or Column is Empty
X1 = 0: X2 = 0: X3 = 0: X4 = 0

FOR Z = 1 TO 8
    IF BoardPlayer(TopBoardEdge, Z) > 0 THEN X1 = 1
    IF BoardPlayer(BottomBoardEdge, Z) > 0 THEN X2 = 1
    IF BoardPlayer(Z, LeftBoardEdge) > 0 THEN X3 = 1
    IF BoardPlayer(Z, RightBoardEdge) > 0 THEN X4 = 1
NEXT

IF X1 = 0 THEN Y = TopBoardEdge: FOR Z = 1 TO 8: LINE (BoardX(Y, Z) - 43, BoardY(Y, Z) - 43)-(BoardX(Y, Z) + 43, BoardY(Y, Z) + 43), 3, BF: NEXT: TopBoardEdge = TopBoardEdge + 1
IF X2 = 0 THEN Y = BottomBoardEdge: FOR Z = 1 TO 8: LINE (BoardX(Y, Z) - 43, BoardY(Y, Z) - 43)-(BoardX(Y, Z) + 43, BoardY(Y, Z) + 43), 3, BF: NEXT: BottomBoardEdge = BottomBoardEdge - 1
IF X3 = 0 THEN Y = LeftBoardEdge: FOR Z = 1 TO 8: LINE (BoardX(Z, Y) - 43, BoardY(Z, Y) - 43)-(BoardX(Z, Y) + 43, BoardY(Z, Y) + 43), 3, BF: NEXT: LeftBoardEdge = LeftBoardEdge + 1
IF X4 = 0 THEN Y = RightBoardEdge: FOR Z = 1 TO 8: LINE (BoardX(Z, Y) - 43, BoardY(Z, Y) - 43)-(BoardX(Z, Y) + 43, BoardY(Z, Y) + 43), 3, BF: NEXT: RightBoardEdge = RightBoardEdge - 1

' Check for Winner
IF Pieces(Opponent) = 0 THEN GOTO Winner

' Check if Still Have More Moves
IF MovesLeft > 0 THEN GOTO MovesLeft

EndTurn:
SWAP Player, Opponent: GOTO StartGame


DrawPiece:
CIRCLE (X1, X2), 36, X3: PAINT (X1, X2), X3
PSET (X1, X2), X3: DRAW TA$(X4) + Arrow$
RETURN


DrawMessage:
COLOR 15, V: LOCATE 1, 1: PRINT Message$;
W = 8 * LEN(Message$): X = 16

FOR Y = 0 TO X
    FOR Z = 0 TO W
        IF POINT(Z, Y) <> 0 THEN LINE (X1 + Z * X4, X2 + Y * X4)-(X1 + Z * X4 + X4, X2 + Y * X4 + X4), 15, BF
    NEXT
NEXT
RETURN


ReleaseMouseButton:
DO WHILE _MOUSEINPUT
    IF _MOUSEBUTTON(1) = 0 THEN RETURN
LOOP
GOTO ReleaseMouseButton


Check_Up:
IF Row1 - 1 >= TopBoardEdge THEN IF BoardPlayer(Row1 - 1, Column1) <> Player THEN Playable(Row1 - 1, Column1) = 1
RETURN

Check_Up_Left:
IF Row1 - 1 >= TopBoardEdge AND Column1 - 1 >= LeftBoardEdge THEN
    IF BoardPlayer(Row1 - 1, Column1 - 1) = 0 THEN Playable(Row1 - 1, Column1 - 1) = 1
    IF BoardPlayer(Row1 - 1, Column1 - 1) = Player THEN
        IF Row1 - 2 >= TopBoardEdge AND Column1 - 2 >= LeftBoardEdge THEN IF BoardPlayer(Row1 - 2, Column1 - 2) = 0 THEN Playable(Row1 - 2, Column1 - 2) = 1
    END IF
END IF
RETURN

Check_Left:
IF Column1 - 1 >= LeftBoardEdge THEN IF BoardPlayer(Row1, Column1 - 1) <> Player THEN Playable(Row1, Column1 - 1) = 1
RETURN

Check_Down_Left:
IF Row1 + 1 <= BottomBoardEdge AND Column1 - 1 >= LeftBoardEdge THEN
    IF BoardPlayer(Row1 + 1, Column1 - 1) = 0 THEN Playable(Row1 + 1, Column1 - 1) = 1
    IF BoardPlayer(Row1 + 1, Column1 - 1) = Player THEN
        IF Row1 + 2 <= BottomBoardEdge AND Column1 - 2 >= LeftBoardEdge THEN IF BoardPlayer(Row1 + 2, Column1 - 2) = 0 THEN Playable(Row1 + 2, Column1 - 2) = 1
    END IF
END IF
RETURN

Check_Down:
IF Row1 + 1 <= BottomBoardEdge THEN IF BoardPlayer(Row1 + 1, Column1) <> Player THEN Playable(Row1 + 1, Column1) = 1
RETURN

Check_Down_Right:
IF Row1 + 1 <= BottomBoardEdge AND Column1 + 1 <= RightBoardEdge THEN
    IF BoardPlayer(Row1 + 1, Column1 + 1) = 0 THEN Playable(Row1 + 1, Column1 + 1) = 1
    IF BoardPlayer(Row1 + 1, Column1 + 1) = Player THEN
        IF Row1 + 2 <= BottomBoardEdge AND Column1 + 2 <= RightBoardEdge THEN IF BoardPlayer(Row1 + 2, Column1 + 2) = 0 THEN Playable(Row1 + 2, Column1 + 2) = 1
    END IF
END IF
RETURN

Check_Right:
IF Column1 + 1 <= RightBoardEdge THEN IF BoardPlayer(Row1, Column1 + 1) <> Player THEN Playable(Row1, Column1 + 1) = 1
RETURN

Check_Up_Right:
IF Row1 - 1 >= TopBoardEdge AND Column1 + 1 <= RightBoardEdge THEN
    IF BoardPlayer(Row1 - 1, Column1 + 1) = 0 THEN Playable(Row1 - 1, Column1 + 1) = 1
    IF BoardPlayer(Row1 - 1, Column1 + 1) = Player THEN
        IF Row1 - 2 >= TopBoardEdge AND Column1 + 2 <= RightBoardEdge THEN IF BoardPlayer(Row1 - 2, Column1 + 2) = 0 THEN Playable(Row1 - 2, Column1 + 2) = 1
    END IF
END IF
RETURN


Winner:
LOCATE 16, 96: PRINT "  Player"; Player; "is the Winner!! ";

LOCATE 18, 96: PRINT "Play Another Game? ( Y / N )";

LOCATE 45, 104: PRINT "             ";

GetYorN:
A$ = UCASE$(INKEY$)
IF A$ = "" THEN GOTO GetYorN
IF A$ = "Y" THEN RUN
IF A$ = "N" THEN SYSTEM
GOTO GetYorN


