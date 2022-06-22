OPTION _EXPLICIT

' I used a code snippet by bplus modified to enlarge the characters on the screen.

_TITLE "Outwit - Designer Unknown 1975 - Programmed by Donald L. Foster Jr. 2018 - Code Snippet by bplus"

SCREEN _NEWIMAGE(1084, 735, 256)

_PALETTECOLOR 1, _RGB32(204, 124, 56) ' Player 1 Piece Color
_PALETTECOLOR 2, _RGB32(109, 39, 0) ' Player 2 Piece Color
_PALETTECOLOR 3, _RGB32(205, 76, 0) ' Board Background Color
_PALETTECOLOR 4, _RGB32(245, 116, 0) ' Board Square Color
_PALETTECOLOR 5, _RGB32(245, 205, 0) ' Player 1 Corner Color
_PALETTECOLOR 6, _RGB32(139, 69, 19) ' Player 2 Corner Color
_PALETTECOLOR 7, _RGB32(255, 215, 0) ' Gold Piece Color
_PALETTECOLOR 8, _RGB32(80, 80, 80) ' Cursor Color

_LIMIT 10

DIM A AS STRING
DIM U AS _UNSIGNED INTEGER
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
DIM Square AS _UNSIGNED _BYTE
DIM SquareColor1 AS _UNSIGNED _BYTE
DIM SquareColor2 AS _UNSIGNED _BYTE

DIM BoardX1 AS _UNSIGNED INTEGER
DIM BoardY1 AS _UNSIGNED INTEGER
DIM BoardX2 AS _UNSIGNED INTEGER
DIM BoardY2 AS _UNSIGNED INTEGER

DIM Piece AS _UNSIGNED _BYTE

DIM Row1 AS _UNSIGNED _BYTE
DIM Column1 AS _UNSIGNED _BYTE
DIM Row2 AS _UNSIGNED _BYTE
DIM Column2 AS _UNSIGNED _BYTE

DIM PlayerColor(2) AS INTEGER
DIM Pieces(2) AS _UNSIGNED _BYTE

DIM BoardX(9, 10) AS _UNSIGNED INTEGER
DIM BoardY(9, 10) AS _UNSIGNED INTEGER
DIM BoardPlayer(9, 10) AS _UNSIGNED _BYTE
DIM BoardPiece(9, 10) AS _UNSIGNED _BYTE
DIM BoardSquare(9, 10) AS _UNSIGNED _BYTE
DIM Playable(9, 10) AS _UNSIGNED _BYTE


DIM Cursor AS STRING
DIM Message AS STRING

Player = 1: Opponent = 2
Pieces(1) = 0: Pieces(2) = 0
PlayerColor(1) = 1: PlayerColor(2) = 2

Cursor$ = "BU36BL36C15D72R72U72L72BF2D68R68U68L68BH1P15,15"

CLS , 15

' Draw Game Title Message
Message$ = " Outwit ": X1 = 815: X2 = 2: X3 = 0: X4 = 4: GOSUB DrawMessage
LINE (0, 0)-(100, 30), 15, BF

' Draw Board
LINE (10, 30)-(10, 702), 0
LINE (799, 30)-(799, 702), 0
LINE (30, 10)-(779, 10), 0
LINE (30, 722)-(779, 722), 0
CIRCLE (30, 30), 20, 0, 1.4, 3.1
CIRCLE (779, 30), 20, 0, 0, 1.6
CIRCLE (30, 702), 20, 0, 2.9, 4.72
CIRCLE (779, 702), 20, 0, 4.52, 0
PAINT (30, 30), 3, 0
LINE (28, 28)-(781, 706), 0, BF
X = 67: U = 9
FOR Z = 1 TO 9
    W = 67
    FOR Y = 1 TO 10
        IF Z < 4 AND Y < 4 THEN V = 6 ELSE IF Z > 6 AND Y > 7 THEN V = 5 ELSE V = 4
        LINE (W - 36, X - 36)-(W + 36, X + 36), V, BF
        IF V = 6 THEN BoardSquare(Z, Y) = 2 ELSE IF V = 5 THEN BoardSquare(Z, Y) = 1 ELSE BoardSquare(Z, Y) = 0
        IF Y = U THEN BoardPlayer(Z, Y) = 1: BoardPiece(Z, Y) = 1: BoardSquare(Z, Y) = 3: CIRCLE (W, X), 30, 0: PAINT (W, X), 1, 0
        IF Y = U + 1 THEN BoardPlayer(Z, Y) = 2: BoardPiece(Z, Y) = 1: BoardSquare(Z, Y) = 4: CIRCLE (W, X), 30, 0: PAINT (W, X), 2, 0
        IF Z = 5 AND (Y = 5 OR Y = 6) THEN BoardPiece(Z, Y) = 2: CIRCLE (W, X), 13, 7: PAINT (W, X), 7
        BoardX(Z, Y) = W: BoardY(Z, Y) = X
        W = W + 75
    NEXT
    X = X + 75: U = U - 1
NEXT


StartGame:

' Draw Player Indicator
CIRCLE (941, 130), 30, 0: PAINT (941, 130), PlayerColor(Player), 0: CIRCLE (941, 130), 13, 7: PAINT (941, 130), 7
LOCATE 12, 115: PRINT "Player"; Player;


StartMove: LOCATE 16, 105: PRINT "  Choose a Piece to Move.  ";

ChooseAPieceInput:
DO WHILE _MOUSEINPUT
    FOR Z = 1 TO 9
        FOR Y = 1 TO 10
            IF _MOUSEBUTTON(1) = -1 AND _MOUSEX > BoardX(Z, Y) - 44 AND _MOUSEX < BoardX(Z, Y) + 44 AND _MOUSEY > BoardY(Z, Y) - 44 AND _MOUSEY < BoardY(Z, Y) + 44 THEN
                IF BoardPlayer(Z, Y) = Player THEN Row1 = Z: Column1 = Y: GOSUB ReleaseMouseButton: GOTO EndChoice1
            END IF
        NEXT
    NEXT
LOOP
GOTO ChooseAPieceInput

EndChoice1:
Piece = BoardPiece(Row1, Column1): Square = BoardSquare(Row1, Column1): BoardX1 = BoardX(Row1, Column1): BoardY1 = BoardY(Row1, Column1)
IF Square = 1 THEN SquareColor1 = 5 ELSE IF Square = 2 THEN SquareColor1 = 6 ELSE SquareColor1 = 4

V = POINT(BoardX1, BoardY1): PSET (BoardX1, BoardY1), V: DRAW Cursor$

FOR Z = 1 TO 9: FOR Y = 1 TO 10: Playable(Z, Y) = 0: NEXT: NEXT

Playable(Row1, Column1) = 1

X = 0
CheckUp:
IF Row1 - X - 1 >= 1 THEN
    IF BoardPlayer(Row1 - X - 1, Column1) > 0 GOTO EndUp
    IF Square = 1 THEN
        IF BoardSquare(Row1 - X - 1, Column1) = 0 GOTO EndUp
        X = X + 1: GOTO CheckUp
    ELSE
        IF BoardSquare(Row1 - X - 1, Column1) = 2 AND Player = 1 GOTO EndUp
        IF Piece = 2 THEN Playable(Row1 - X, Column1) = 1
        X = X + 1: GOTO CheckUp
    END IF
    EndUp: Playable(Row1 - X, Column1) = 1
ELSE
    Playable(Row1 - X, Column1) = 1
END IF

X = 0
CheckLeft:
IF Column1 - X - 1 >= 1 THEN
    IF BoardPlayer(Row1, Column1 - X - 1) > 0 GOTO EndLeft
    IF Square = 1 THEN
        IF BoardSquare(Row1, Column1 - X - 1) = 0 GOTO EndLeft
        X = X + 1: GOTO CheckLeft
    ELSE
        IF BoardSquare(Row1, Column1 - X - 1) = 2 AND Player = 1 GOTO EndLeft
        IF Piece = 2 THEN Playable(Row1, Column1 - X - 1) = 1
        X = X + 1: GOTO CheckLeft
    END IF
    EndLeft: Playable(Row1, Column1 - X) = 1
ELSE
    Playable(Row1, Column1 - X) = 1
END IF


X = 0
CheckDown:
IF Row1 + X + 1 <= 9 THEN
    IF BoardPlayer(Row1 + X + 1, Column1) > 0 GOTO EndDown
    IF Square = 2 THEN
        IF BoardSquare(Row1 + X + 1, Column1) = 0 GOTO EndDown
        X = X + 1: GOTO CheckDown
    ELSE
        IF BoardSquare(Row1 + X + 1, Column1) = 1 AND Player = 2 GOTO EndDown
        IF Piece = 2 THEN Playable(Row1 + X + 1, Column1) = 1
        X = X + 1: GOTO CheckDown
    END IF
    EndDown: Playable(Row1 + X, Column1) = 1
ELSE
    Playable(Row1 + X, Column1) = 1
END IF

X = 0
CheckRight:
IF Column1 + X + 1 <= 10 THEN
    IF BoardPlayer(Row1, Column1 + X + 1) > 0 GOTO EndRight
    IF Square = 2 THEN
        IF BoardSquare(Row1, Column1 + X + 1) = 0 GOTO EndRight
        X = X + 1: GOTO CheckRight
    ELSE
        IF BoardSquare(Row1, Column1 + X + 1) = 1 AND Player = 2 GOTO EndRight
        IF Piece = 2 THEN Playable(Row1, Column1 + X + 1) = 1
        X = X + 1: GOTO CheckRight
    END IF
    EndRight: Playable(Row1, Column1 + X) = 1
ELSE
    Playable(Row1, Column1 + X) = 1
END IF

IF Piece = 2 THEN
    X = 0
    CheckUpLeft:
    IF Row1 - X - 1 >= 1 AND Column1 - X - 1 >= 1 THEN
        IF BoardPlayer(Row1 - X - 1, Column1 - X - 1) > 0 GOTO EndUpLeft
        IF Square = 1 THEN
            IF BoardSquare(Row1 - X - 1, Column1 - X - 1) = 0 GOTO EndUpLeft
            X = X + 1: GOTO CheckUpLeft
        ELSE
            IF BoardSquare(Row1 - X - 1, Column1 - X - 1) = 2 AND Player = 1 GOTO EndUpLeft
            Playable(Row1 - X - 1, Column1 - X - 1) = 1: X = X + 1: GOTO CheckUpLeft
        END IF
        EndUpLeft: Playable(Row1 - X, Column1 - X) = 1
    ELSE
        Playable(Row1 - X, Column1 - X) = 1
    END IF

    X = 0
    CheckDownLeft:
    IF Row1 + X + 1 <= 9 AND Column1 - X - 1 >= 1 THEN
        IF BoardPlayer(Row1 + X + 1, Column1 - X - 1) > 0 GOTO EndDownLeft
        IF Square = 1 THEN
            IF BoardSquare(Row1 + X + 1, Column1 - X - 1) = 0 GOTO EndDownLeft
            X = X + 1: GOTO CheckDownLeft
        ELSE
            IF BoardSquare(Row1 + X + 1, Column1 - X - 1) = 2 AND Player = 1 GOTO EndDownLeft
            IF BoardSquare(Row1 + X + 1, Column1 - X - 1) = 1 AND Player = 2 GOTO EndDownLeft
            Playable(Row1 + X + 1, Column1 - X - 1) = 1: X = X + 1: GOTO CheckDownLeft
        END IF
        EndDownLeft: Playable(Row1 + X, Column1 - X) = 1
    ELSE
        Playable(Row1 + X, Column1 - X) = 1
    END IF

    X = 0
    CheckDownRight:
    IF Row1 + X + 1 <= 9 AND Column1 + X + 1 <= 10 THEN
        IF BoardPlayer(Row1 + X + 1, Column1 + X + 1) > 0 GOTO EndDownRight
        IF Square = 1 THEN
            IF BoardSquare(Row1 + X + 1, Column1 + X + 1) = 0 GOTO EndDownRight
            X = X + 1: GOTO CheckDownRight
        ELSE
            IF BoardSquare(Row1 + X + 1, Column1 + X + 1) = 1 AND Player = 2 GOTO EndDownRight
            Playable(Row1 + X + 1, Column1 + X + 1) = 1: X = X + 1: GOTO CheckDownRight
        END IF
        EndDownRight: Playable(Row1 + X, Column1 + X) = 1
    ELSE
        Playable(Row1 + X, Column1 + X) = 1
    END IF

    X = 0
    CheckUpRight:
    IF Row1 - X - 1 >= 1 AND Column1 + X + 1 <= 10 THEN
        IF BoardPlayer(Row1 - X - 1, Column1 + X + 1) > 0 GOTO EndUpRight
        IF Square = 1 THEN
            IF BoardSquare(Row1 - X - 1, Column1 + X + 1) = 0 GOTO EndUpRight
            X = X + 1: GOTO CheckUpRight
        ELSE
            IF BoardSquare(Row1 - X - 1, Column1 + X + 1) = 1 AND Player = 2 GOTO EndUpRight
            IF BoardSquare(Row1 - X - 1, Column1 + X + 1) = 2 AND Player = 1 GOTO EndUpRight
            Playable(Row1 - X - 1, Column1 + X + 1) = 1: X = X + 1: GOTO CheckUpRight
        END IF
        EndUpRight: Playable(Row1 - X, Column1 + X) = 1
    ELSE
        Playable(Row1 - X, Column1 + X) = 1
    END IF
END IF

LOCATE 16, 105: PRINT "Choose Location to Move to.";

ChooseALocationInput:
DO WHILE _MOUSEINPUT
    FOR Z = 1 TO 9
        FOR Y = 1 TO 10
            IF _MOUSEBUTTON(1) = -1 AND _MOUSEX > BoardX(Z, Y) - 44 AND _MOUSEX < BoardX(Z, Y) + 44 AND _MOUSEY > BoardY(Z, Y) - 44 AND _MOUSEY < BoardY(Z, Y) + 44 THEN
                IF Playable(Z, Y) = 1 THEN Row2 = Z: Column2 = Y: GOSUB ReleaseMouseButton: GOTO EndChoice2
            END IF
        NEXT
    NEXT
LOOP
GOTO ChooseALocationInput

EndChoice2:
IF Row1 = Row2 AND Column1 = Column2 THEN PAINT (BoardX1 - 36, BoardY1 - 36), SquareColor1, 0: GOTO StartMove

BoardX2 = BoardX(Row2, Column2): BoardY2 = BoardY(Row2, Column2)

IF BoardSquare(Row2, Column2) = 1 THEN SquareColor2 = 5 ELSE IF BoardSquare(Row2, Column2) = 2 THEN SquareColor2 = 6 ELSE SquareColor2 = 4
LINE (BoardX2 - 36, BoardY2 - 36)-(BoardX2 + 36, BoardY2 + 36), SquareColor2, BF

BoardPlayer(Row2, Column2) = Player: BoardPiece(Row2, Column2) = Piece
BoardPlayer(Row1, Column1) = 0: BoardPiece(Row1, Column1) = 0

LINE (BoardX1 - 36, BoardY1 - 36)-(BoardX1 + 36, BoardY1 + 36), SquareColor1, BF

IF Square > 2 THEN
    IF Piece = 2 THEN CIRCLE (BoardX1, BoardY1), 30, 0: 'PAINT (BoardX1, BoardY1), 7
    V = Square + 2: CIRCLE (BoardX1, BoardY1), 13, 0: PAINT (BoardX1, BoardY1), V, 0
END IF

LINE (BoardX2 - 36, BoardY2 - 36)-(BoardX2 + 36, BoardY2 + 36), SquareColor2, BF
CIRCLE (BoardX2, BoardY2), 30, 0: PAINT (BoardX2, BoardY2), PlayerColor(Player), 0
IF Piece = 2 THEN CIRCLE (BoardX2, BoardY2), 13, 7: PAINT (BoardX2, BoardY2), 7

IF (Square = 0 OR Square = 3 OR Square = 4) AND BoardSquare(Row2, Column2) = Player THEN Pieces(Player) = Pieces(Player) + 1

IF Pieces(Player) = 9 THEN GOTO Winner

SWAP Player, Opponent: GOTO StartGame


DrawMessage:
COLOR 0, 15: LOCATE 1, 1: PRINT Message$;
W = 8 * LEN(Message$): X = 16

FOR Y = 0 TO X
    FOR Z = 0 TO W
        IF POINT(Z, Y) <> 15 THEN LINE (X1 + Z * X4, X2 + Y * X4)-(X1 + Z * X4 + X4, X2 + Y * X4 + X4), 0, BF
    NEXT
NEXT
RETURN


ReleaseMouseButton:
DO WHILE _MOUSEINPUT
    IF _MOUSEBUTTON(1) = 0 THEN RETURN
LOOP
GOTO ReleaseMouseButton


Winner:
LOCATE 16, 105: PRINT "  Player"; Player; "is the Winner!  ";

LOCATE 18, 104: PRINT "Play Another Game? ( Y or N )";

GetYorN:
A$ = UCASE$(INKEY$)
IF A$ = "" THEN GOTO GetYorN
IF A$ = "Y" THEN RUN
IF A$ = "N" THEN SYSTEM
GOTO GetYorN

