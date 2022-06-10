'-----------------------------------------------------------------------------------------------------
' These are some metacommands and compiler options for QB64 to write modern & type-strict code
'-----------------------------------------------------------------------------------------------------
' This will disable prefixing all modern QB64 calls using a underscore prefix.
$NoPrefix
' Whatever indentifiers are not defined, should default to signed longs (ex. constants and functions).
DefInt A-Z
' All variables must be defined.
Option Explicit
' All arrays must be defined.
Option ExplicitArray
' Array lower bounds should always start from 1 unless explicitly specified.
' This allows a(4) as integer to have 4 members with index 1-4.
Option Base 1
' This game erases arrays and does not redim them. So we use static arrays instead.
'$Static
' This allows the executable window & it's contents to be resized.
$Resize:Smooth
Title "Reversi"
'-----------------------------------------------------------------------------------------------------

Const FALSE = 0
Const TRUE = Not FALSE
Const QUIT = 113
Const UP = 72
Const DOWN = 80
Const LEFT = 75
Const RIGHT = 77
Const BBLOCK = 1
Const EBLOCK = 8
Const ENTER = 13
Const ULEFT = 71
Const URIGHT = 73
Const DLEFT = 79
Const DRIGHT = 81
Const PASS = 112
Const DIFF = 100
Const START = 115
Const HELP = 104
Const FMOVE = 99
Const SPACE = 32

Type GameGrid
    player As Integer
    nTake As Integer
    cx As Integer
    cy As Integer
End Type

Type GameStatus
    curRow As Integer
    curCol As Integer
    stat As Integer
    rScore As Integer
    bScore As Integer
    mDisplay As Integer
    dLevel As String * 6
    GColor As Integer
End Type

Dim Shared GS As GameStatus, smode As Integer
Dim Shared GG(8, 8) As GameGrid, GBoard As Integer
Dim Shared COMP As Integer, HUMAN As Integer, BG As Integer
Dim Shared GP(8, 8, 8) As Integer, GW(8, 8) As Integer
Dim vmode As Integer
Dim k As String

On Error GoTo BadMode

Do
    Read smode
    vmode = TRUE
    Screen smode
Loop Until vmode = TRUE

If smode = 0 Then
    Cls
    Locate 10, 15: Print "No graphics screen mode available; cannot run Reversi"
Else
    AllowFullScreen SquarePixels , Smooth
    GS.stat = START
    GS.dLevel = "Novice"
    While GS.stat <> QUIT
        If GS.stat = START Then
            InitGame
            DrawGameBoard
        End If
        If GS.stat <> COMP Then
            If ValidMove(COMP) Then
                UserMove
            ElseIf ValidMove(HUMAN) Then
                Do
                    DisplayMsg "You have no valid moves.  Select pass."
                    Do
                        k = InKey$
                    Loop Until k <> ""
                Loop Until Asc(Right$(k, 1)) = PASS
                Line (0, 420)-(640, 447), 3, BF
                GS.mDisplay = FALSE
                GS.stat = COMP
                ComputerMove
            Else
                GameOver
            End If
        Else
            If ValidMove(HUMAN) Then
                ComputerMove
            ElseIf ValidMove(COMP) Then
                DisplayMsg "Computer has no valid moves.  Your Turn."
                GS.stat = HUMAN
                UserMove
            Else
                GameOver
            End If
        End If
    Wend
    DisplayMsg "Game Over"
End If

Data 9,10,2,3,0

BadMode:
vmode = FALSE
Resume Next

System 0

Function CheckPath (i As Integer, IBound As Integer, IStep As Integer, j As Integer, JBound As Integer, JStep As Integer, Opponent As Integer)
    Dim As Integer done, count

    done = FALSE
    While (i <> IBound Or j <> JBound) And Not done
        If GG(i, j).player = GBoard Then
            count = 0
            done = TRUE
        ElseIf GG(i, j).player = Opponent Then
            count = count + 1
            i = i + IStep
            j = j + JStep
            If (i < 1 Or i > 8) Or (j < 1 Or j > 8) Then
                count = 0
                done = TRUE
            End If
        Else
            done = TRUE
        End If
    Wend
    CheckPath = count
End Function

Sub ComputerMove
    Dim As Integer BestMove, row, col, value, BestRow, BestCol

    BestMove = -99
    For row = 1 To 8
        For col = 1 To 8
            If GG(row, col).nTake > 0 Then
                If GS.dLevel = "Novice" Then
                    value = GG(row, col).nTake + GW(row, col)
                Else
                    value = GG(row, col).nTake + GW(row, col)
                    Select Case row
                        Case 1
                            If col < 5 Then value = value + Abs(10 * GG(1, 1).player = COMP)
                            If col > 4 Then value = value + Abs(10 * GG(1, 8).player = COMP)
                        Case 2
                            If GG(1, col).player <> COMP Then value = value + 5 * (GG(1, col).player = HUMAN)
                            If col > 1 And GG(1, col - 1).player <> COMP Then value = value + 5 * (GG(1, col - 1).player = HUMAN)
                            If col < 8 And GG(1, col + 1).player <> COMP Then value = value + 5 * (GG(1, col + 1).player = HUMAN)
                        Case 7
                            If GG(8, col).player <> COMP Then value = value + 5 * (GG(8, col).player = HUMAN)
                            If col > 1 And GG(8, col - 1).player <> COMP Then value = value + 5 * (GG(8, col - 1).player = HUMAN)
                            If col < 8 And GG(8, col + 1).player <> COMP Then value = value + 5 * (GG(8, col + 1).player = HUMAN)
                        Case 8
                            If col < 5 Then value = value + Abs(10 * GG(8, 1).player = COMP)
                            If col > 4 Then value = value + Abs(10 * GG(8, 8).player = COMP)
                    End Select
                    Select Case col
                        Case 1
                            If row < 5 Then value = value + Abs(10 * GG(1, 1).player = COMP)
                            If row > 4 Then value = value + Abs(10 * GG(8, 1).player = COMP)
                        Case 2
                            If GG(row, 1).player <> COMP Then value = value + 5 * (GG(row, 1).player = HUMAN)
                            If row > 1 And GG(row - 1, 1).player <> COMP Then value = value + 5 * (GG(row - 1, 1).player = HUMAN)
                            If row < 8 And GG(row + 1, 1).player <> COMP Then value = value + 5 * (GG(row + 1, 1).player = HUMAN)
                        Case 7
                            If GG(row, 8).player <> COMP Then value = value + 5 * (GG(row, 8).player = HUMAN)
                            If row > 1 And GG(row - 1, 8).player <> COMP Then value = value + 5 * (GG(row - 1, 8).player = HUMAN)
                            If row < 8 And GG(row + 1, 8).player <> COMP Then value = value + 5 * (GG(row + 1, 8).player = HUMAN)
                        Case 8
                            If row < 5 Then value = value + Abs(10 * GG(1, 8).player = COMP)
                            If row > 4 Then value = value + Abs(10 * GG(8, 8).player = COMP)
                    End Select
                End If
                If value > BestMove Then
                    BestMove = value
                    BestRow = row
                    BestCol = col
                End If
            End If
        Next col
    Next row

    TakeBlocks BestRow, BestCol, COMP
    GS.stat = HUMAN
End Sub

Sub DisplayHelp
    Dim As Integer i
    Dim a(1 To 18) As String, k As String

    a$(1) = "The object of Reversi is to finish the game with more of your red"
    a$(2) = "circles on the board than the computer has of blue (Monochrome"
    a$(3) = "monitors will show red as white and blue as black)."
    a$(4) = ""
    a$(5) = "1) You and the computer play by the same rules."
    a$(6) = "2) To make a legal move, at least one of the computer's circles"
    a$(7) = "   must lie in a horizontal, vertical, or diagonal line between"
    a$(8) = "   one of your existing circles and the square where you want to"
    a$(9) = "   move.  Use the arrow keys to position the cursor on the square"
    a$(10) = "   and hit Enter or the Space Bar."
    a$(11) = "3) You can choose Pass from the game controls menu on your first"
    a$(12) = "   move to force the computer to play first."
    a$(13) = "4) After your first move, you cannot pass if you can make a legal"
    a$(14) = "   move."
    a$(15) = "5) If you cannot make a legal move, you must choose Pass"
    a$(16) = "6) When neither you nor the computer can make a legal move, the"
    a$(17) = "   game is over."
    a$(18) = "7) The one with the most circles wins."

    Line (0, 0)-(640, 480), BG, BF
    Line (39, 15)-(590, 450), 0, B
    If GBoard = 85 Then
        Paint (200, 200), Chr$(85), 0
    Else
        Paint (200, 200), GBoard, 0
    End If
    Line (590, 25)-(600, 460), 0, BF
    Line (50, 450)-(600, 460), 0, BF

    Locate 2, 35: Print "REVERSI HELP"
    For i = 1 To 18
        Locate 3 + i, 7
        Print a$(i)
    Next i
    Locate 23, 25: Print "- Press any key to continue -"
    Sleep: k = InKey$
    DrawGameBoard
    DrawCursor GS.curRow, GS.curCol
End Sub

Sub DisplayMsg (a As String)
    Dim As Integer sLen, LX

    sLen = Len(a$)
    LX = (640 - 8 * (sLen + 8)) / 2
    Line (LX - 1, 420)-(640 - LX, 447), 0, B
    If GBoard = 85 Then
        Paint (LX + 10, 430), Chr$(85), 0
    Else
        Paint (LX + 10, 430), GBoard, 0
    End If
    Locate 23, (80 - sLen) / 2
    Print a;
    GS.mDisplay = TRUE
End Sub

Sub DrawCursor (row As Integer, col As Integer)
    Dim As Integer lc

    If GG(row, col).nTake > 0 Then
        Circle (GG(row, col).cx, GG(row, col).cy), 15, HUMAN
        Circle (GG(row, col).cx, GG(row, col).cy), 14, HUMAN
    Else
        lc = 0
        If GG(row, col).player = 0 Then lc = 7
        Line (GG(row, col).cx, GG(row, col).cy - 15)-(GG(row, col).cx, GG(row, col).cy + 15), lc
        Line (GG(row, col).cx - 1, GG(row, col).cy - 15)-(GG(row, col).cx - 1, GG(row, col).cy + 15), lc
        Line (GG(row, col).cx + 15, GG(row, col).cy)-(GG(row, col).cx - 15, GG(row, col).cy), lc
    End If
End Sub

Sub DrawGameBoard
    Dim As Integer i, row, col

    Line (0, 0)-(640, 480), BG, BF
    Line (239, 15)-(400, 40), 0, B
    Line (39, 260)-(231, 390), 0, B
    Line (39, 70)-(231, 220), 0, B
    Line (269, 70)-(591, 390), 0, B

    If GBoard = 85 Then 'If b&w
        Paint (300, 25), Chr$(85), 0
        Paint (150, 350), Chr$(85), 0
        Paint (150, 124), Chr$(85), 0
        Paint (450, 225), Chr$(85), 0
    Else
        Paint (300, 25), GBoard, 0
        Paint (150, 350), GBoard, 0
        Paint (150, 124), GBoard, 0
        Paint (450, 225), GBoard, 0
    End If
    Line (400, 25)-(410, 50), 0, BF
    Line (250, 40)-(410, 50), 0, BF
    Line (231, 80)-(240, 230), 0, BF
    Line (50, 220)-(240, 230), 0, BF
    Line (590, 80)-(600, 400), 0, BF
    Line (280, 390)-(600, 400), 0, BF
    Line (231, 270)-(240, 400), 0, BF
    Line (50, 390)-(240, 400), 0, BF

    For i = 0 To 8
        Line (270, 70 + i * 40)-(590, 70 + i * 40), 0
        Line (270 + i * 40, 70)-(270 + i * 40, 390), 0
        Line (269 + i * 40, 70)-(269 + i * 40, 390), 0
    Next i

    Locate 2, 35: Print "R E V E R S I"

    Locate 5, 11: Print "Game Controls"
    Locate 7, 7: Print "S = Start New Game"
    Locate 8, 7: Print "P = Pass Turn"
    Locate 9, 7: Print "D = Set Difficulty"
    Locate 10, 7: Print "H = Display Help"
    Locate 11, 7: Print "Q = Quit"
    Locate 15, 12: Print "Game Status"
    Locate 17, 7: Print "Your Score:      "; GS.rScore; ""
    Locate 18, 7: Print "Computer Score:  "; GS.bScore
    Locate 20, 7: Print "Difficulty:   "; GS.dLevel

    For row = 1 To 8
        For col = 1 To 8
            If GG(row, col).player <> GBoard Then
                DrawGamePiece row, col, GG(row, col).player
            End If
        Next col
    Next row
End Sub

Sub DrawGamePiece (row As Integer, col As Integer, GpColor As Integer)
    If GBoard = 85 Then
        Line (232 + col * 40, 33 + row * 40)-(267 + col * 40, 67 + row * 40), 7, BF
        If GpColor <> GBoard Then
            Circle (GG(row, col).cx, GG(row, col).cy), 15, 0
            Paint (GG(row, col).cx, GG(row, col).cy), GpColor, 0
        End If
        Paint (235 + col * 40, 35 + row * 40), Chr$(85), 0
    Else
        Circle (GG(row, col).cx, GG(row, col).cy), 15, GpColor
        Circle (GG(row, col).cx, GG(row, col).cy), 14, GpColor
        Paint (GG(row, col).cx, GG(row, col).cy), GpColor, GpColor
    End If
End Sub

Sub GameOver
    Dim As Integer ScoreDiff

    ScoreDiff = GS.rScore - GS.bScore
    If ScoreDiff = 0 Then
        DisplayMsg "Tie Game"
    ElseIf ScoreDiff < 0 Then
        DisplayMsg "You lost by"
        Print Abs(ScoreDiff)
    Else
        DisplayMsg "You won by"
        Print ScoreDiff
    End If
    Do
        GS.stat = Asc(Right$(InKey$, 1))
    Loop Until GS.stat = QUIT Or GS.stat = START
    Line (0, 420)-(640, 447), BG, BF
End Sub

Sub InitGame
    Dim As Integer row, col, i, j

    Select Case smode
        Case 9:
            HUMAN = 4
            COMP = 1
            BG = 3
            GBoard = 8
        Case Else:
            HUMAN = 7
            COMP = 0
            BG = 7
            If smode = 10 Then
                GBoard = 1
            Else
                GBoard = 85
            End If
    End Select

    Window Screen(640, 480)-(0, 0)
    GS.curCol = 5
    GS.curRow = 3
    GS.stat = FMOVE
    GS.bScore = 2
    GS.rScore = 2
    GS.mDisplay = FALSE

    For row = 1 To 8
        For col = 1 To 8
            GG(row, col).player = GBoard
            GG(row, col).nTake = 0
            GG(row, col).cx = 270 + (col - .5) * 40
            GG(row, col).cy = 70 + (row - .5) * 40
            GW(row, col) = 2
        Next col
    Next row
    GW(1, 1) = 99
    GW(1, 8) = 99
    GW(8, 1) = 99
    GW(8, 8) = 99
    For i = 3 To 6
        For j = 1 To 8 Step 7
            GW(i, j) = 5
            GW(j, i) = 5
        Next j
    Next i
    GG(4, 4).player = HUMAN
    GG(5, 4).player = COMP
    GG(4, 5).player = COMP
    GG(5, 5).player = HUMAN
End Sub

Sub TakeBlocks (row As Integer, col As Integer, player As Integer)
    Dim As Integer i

    GG(row, col).player = player
    DrawGamePiece row, col, player

    For i = 1 To GP(row, col, 1)
        GG(row, col - i).player = player
        DrawGamePiece row, col - i, player
    Next i
    For i = 1 To GP(row, col, 2)
        GG(row, col + i).player = player
        DrawGamePiece row, col + i, player
    Next i
    For i = 1 To GP(row, col, 3)
        GG(row - i, col).player = player
        DrawGamePiece row - i, col, player
    Next i
    For i = 1 To GP(row, col, 4)
        GG(row + i, col).player = player
        DrawGamePiece row + i, col, player
    Next i
    For i = 1 To GP(row, col, 5)
        GG(row - i, col - i).player = player
        DrawGamePiece row - i, col - i, player
    Next i
    For i = 1 To GP(row, col, 6)
        GG(row + i, col + i).player = player
        DrawGamePiece row + i, col + i, player
    Next i
    For i = 1 To GP(row, col, 7)
        GG(row - i, col + i).player = player
        DrawGamePiece row - i, col + i, player
    Next i
    For i = 1 To GP(row, col, 8)
        GG(row + i, col - i).player = player
        DrawGamePiece row + i, col - i, player
    Next i

    If player = HUMAN Then
        GS.rScore = GS.rScore + GG(row, col).nTake + 1
        GS.bScore = GS.bScore - GG(row, col).nTake
    Else
        GS.bScore = GS.bScore + GG(row, col).nTake + 1
        GS.rScore = GS.rScore - GG(row, col).nTake
    End If

    Locate 17, 7: Print "Your Score:      "; GS.rScore
    Locate 18, 7: Print "Computer Score:  "; GS.bScore
End Sub

Sub UserMove
    Dim k As String
    Dim As Integer move

    DrawCursor GS.curRow, GS.curCol
    Do
        Do
            k = InKey$
        Loop Until k <> ""
        move = Asc(Right$(k, 1))
        If GS.mDisplay Then
            Line (0, 420)-(640, 447), BG, BF
            GS.mDisplay = FALSE
        End If
        Select Case move
            Case 71 TO 81:
                DrawGamePiece GS.curRow, GS.curCol, GG(GS.curRow, GS.curCol).player
                If move < 74 Then
                    If GS.curRow = BBLOCK Then
                        GS.curRow = EBLOCK
                    Else
                        GS.curRow = GS.curRow - 1
                    End If
                ElseIf move > 78 Then
                    If GS.curRow = EBLOCK Then
                        GS.curRow = BBLOCK
                    Else
                        GS.curRow = GS.curRow + 1
                    End If
                End If
                If move = 71 Or move = 75 Or move = 79 Then
                    If GS.curCol = BBLOCK Then
                        GS.curCol = EBLOCK
                    Else
                        GS.curCol = GS.curCol - 1
                    End If
                ElseIf move = 73 Or move = 77 Or move = 81 Then
                    If GS.curCol = EBLOCK Then
                        GS.curCol = BBLOCK
                    Else
                        GS.curCol = GS.curCol + 1
                    End If
                End If
                DrawCursor GS.curRow, GS.curCol
            Case START:
                GS.stat = START
            Case PASS:
                If GS.stat = FMOVE Then
                    DisplayMsg "You passed.  Computer will make first move."
                    GS.stat = COMP
                Else
                    DisplayMsg "You can only pass on your first turn."
                End If
            Case HELP:
                DisplayHelp
            Case DIFF:
                If GS.dLevel = "Novice" Then
                    GS.dLevel = "Expert"
                Else
                    GS.dLevel = "Novice"
                End If
                Locate 20, 7
                Print "Difficulty:   "; GS.dLevel;
            Case ENTER, SPACE:
                If GG(GS.curRow, GS.curCol).nTake > 0 Then
                    TakeBlocks GS.curRow, GS.curCol, HUMAN
                    GS.stat = COMP
                Else
                    DisplayMsg "Invalid move.  Move to a space where the cursor is a circle."
                End If
            Case QUIT:
                GS.stat = QUIT
        End Select
    Loop Until GS.stat <> HUMAN And GS.stat <> FMOVE
End Sub

Function ValidMove (Opponent As Integer)
    Dim As Integer row, col

    ValidMove = FALSE
    Erase GP
    For row = 1 To 8
        For col = 1 To 8
            GG(row, col).nTake = 0

            If GG(row, col).player = GBoard Then
                If col > 2 Then
                    GP(row, col, 1) = CheckPath(row, row, 0, col - 1, 0, -1, Opponent)
                    GG(row, col).nTake = GG(row, col).nTake + GP(row, col, 1)
                End If
                If col < 7 Then
                    GP(row, col, 2) = CheckPath(row, row, 0, col + 1, 9, 1, Opponent)
                    GG(row, col).nTake = GG(row, col).nTake + GP(row, col, 2)
                End If
                If row > 2 Then
                    GP(row, col, 3) = CheckPath(row - 1, 0, -1, col, col, 0, Opponent)
                    GG(row, col).nTake = GG(row, col).nTake + GP(row, col, 3)
                End If
                If row < 7 Then
                    GP(row, col, 4) = CheckPath(row + 1, 9, 1, col, col, 0, Opponent)
                    GG(row, col).nTake = GG(row, col).nTake + GP(row, col, 4)
                End If
                If col > 2 And row > 2 Then
                    GP(row, col, 5) = CheckPath(row - 1, 0, -1, col - 1, 0, -1, Opponent)
                    GG(row, col).nTake = GG(row, col).nTake + GP(row, col, 5)
                End If
                If col < 7 And row < 7 Then
                    GP(row, col, 6) = CheckPath(row + 1, 9, 1, col + 1, 9, 1, Opponent)
                    GG(row, col).nTake = GG(row, col).nTake + GP(row, col, 6)
                End If
                If col < 7 And row > 2 Then
                    GP(row, col, 7) = CheckPath(row - 1, 0, -1, col + 1, 9, 1, Opponent)
                    GG(row, col).nTake = GG(row, col).nTake + GP(row, col, 7)
                End If
                If col > 2 And row < 7 Then
                    GP(row, col, 8) = CheckPath(row + 1, 9, 1, col - 1, 0, -1, Opponent)
                    GG(row, col).nTake = GG(row, col).nTake + GP(row, col, 8)
                End If
                If GG(row, col).nTake > 0 Then ValidMove = TRUE
            End If
        Next col
    Next row
End Function

