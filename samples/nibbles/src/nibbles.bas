'                         Q B a s i c   N i b b l e s
'
'                   Copyright (C) Microsoft Corporation 1990
'
' Nibbles is a game for one or two players.  Navigate your snakes
' around the game board trying to eat up numbers while avoiding
' running into walls or other snakes.  The more numbers you eat up,
' the more points you gain and the longer your snake becomes.
'
' To run this game, press Shift+F5.
'
' To exit QBasic, press Alt, F, X.
'
' To get help on a BASIC keyword, move the cursor to the keyword and press
' F1 or click the right mouse button.
'

'Set default data type to integer for faster game play
DefInt A-Z

'User-defined TYPEs
Type snakeBody
    row As Integer
    col As Integer
End Type

'This type defines the player's snake
Type snaketype
    head As Integer
    length As Integer
    row As Integer
    col As Integer
    direction As Integer
    lives As Integer
    score As Integer
    scolor As Integer
    alive As Integer
End Type

'This type is used to represent the playing screen in memory
'It is used to simulate graphics in text mode, and has some interesting,
'and slightly advanced methods to increasing the speed of operation.
'Instead of the normal 80x25 text graphics using chr$(219) "€", we will be
'using chr$(220)"‹" and chr$(223) "ﬂ" and chr$(219) "€" to mimic an 80x50
'pixel screen.
'Check out sub-programs SET and POINTISTHERE to see how this is implemented
'feel free to copy these (as well as arenaType and the DIM ARENA stmt and the
'initialization code in the DrawScreen subprogram) and use them in your own
'programs
Type arenaType
    realRow As Integer 'Maps the 80x50 point into the real 80x25
    acolor As Integer 'Stores the current color of the point
    sister As Integer 'Each char has 2 points in it.  .SISTER is
End Type '-1 if sister point is above, +1 if below

'Sub Declarations
DECLARE SUB SpacePause (text$)
DECLARE SUB PrintScore (NumPlayers%, score1%, score2%, lives1%, lives2%)
DECLARE SUB Intro ()
DECLARE SUB GetInputs (NumPlayers, speed, diff$, monitor$)
DECLARE SUB DrawScreen ()
DECLARE SUB PlayNibbles (NumPlayers, speed, diff$)
DECLARE SUB Set (row, col, acolor)
DECLARE SUB Center (row, text$)
DECLARE SUB Initialize ()
DECLARE SUB SparklePause ()
DECLARE SUB Level (WhatToDO, sammy() AS snaketype)
DECLARE SUB InitColors ()
DECLARE SUB EraseSnake (snake() AS ANY, snakeBod() AS ANY, snakeNum%)
DECLARE FUNCTION StillWantsToPlay ()
DECLARE FUNCTION PointIsThere (row, col, backColor)

'Constants
Const TRUE = -1
Const FALSE = Not TRUE
Const MAXSNAKELENGTH = 1000
Const STARTOVER = 1 ' Parameters to 'Level' SUB
Const SAMELEVEL = 2
Const NEXTLEVEL = 3

'Global Variables
Dim Shared arena(1 To 50, 1 To 80) As arenaType
Dim Shared curLevel, colorTable(10)

Randomize Timer
GoSub ClearKeyLocks
Intro
GetInputs NumPlayers, speed, diff$, monitor$
GoSub SetColors
DrawScreen

Do
    PlayNibbles NumPlayers, speed, diff$
Loop While StillWantsToPlay

GoSub RestoreKeyLocks
Color 15, 0
Cls
End

ClearKeyLocks:
Def Seg = 0 ' Turn off CapLock, NumLock and ScrollLock
KeyFlags = Peek(1047)
Poke 1047, &H0
Def Seg
Return

RestoreKeyLocks:
Def Seg = 0 ' Restore CapLock, NumLock and ScrollLock states
Poke 1047, KeyFlags
Def Seg
Return

SetColors:
If monitor$ = "M" Then
    Restore mono
Else
    Restore normal
End If

For a = 1 To 6
    Read colorTable(a)
Next a
Return

'snake1     snake2   Walls  Background  Dialogs-Fore  Back
mono: Data 15,7,7,0,15,0
normal: Data 14,13,12,1,15,4
End

'Center:
'  Centers text on given row
Sub Center (row, text$)
    Locate row, 41 - Len(text$) / 2
    Print text$;
End Sub

'DrawScreen:
'  Draws playing field
Sub DrawScreen

    'initialize screen
    View Print
    Color colorTable(1), colorTable(4)
    Cls

    'Print title & message
    Center 1, "Nibbles!"
    Center 11, "Initializing Playing Field..."

    'Initialize arena array
    For row = 1 To 50
        For col = 1 To 80
            arena(row, col).realRow = Int((row + 1) / 2)
            arena(row, col).sister = (row Mod 2) * 2 - 1
        Next col
    Next row
End Sub

'EraseSnake:
'  Erases snake to facilitate moving through playing field
Sub EraseSnake (snake() As snaketype, snakeBod() As snakeBody, snakeNum)

    For c = 0 To 9
        For b = snake(snakeNum).length - c To 0 Step -10
            tail = (snake(snakeNum).head + MAXSNAKELENGTH - b) Mod MAXSNAKELENGTH
            Set snakeBod(tail, snakeNum).row, snakeBod(tail, snakeNum).col, colorTable(4)
        Next b
        _Delay .03
    Next c

End Sub

'GetInputs:
'  Gets player inputs
Sub GetInputs (NumPlayers, speed, diff$, monitor$)

    Color 7, 0
    Cls

    Do
        Locate 5, 47: Print Space$(34);
        Locate 5, 20
        Input "How many players (1 or 2)"; num$
    Loop Until Val(num$) = 1 Or Val(num$) = 2
    NumPlayers = Val(num$)

    Locate 8, 21: Print "Skill level (1 to 100)"
    Locate 9, 22: Print "1   = Novice"
    Locate 10, 22: Print "90  = Expert"
    Locate 11, 22: Print "100 = Twiddle Fingers"
    Locate 12, 15: Print "(Computer speed may affect your skill level)"
    Do
        Locate 8, 44: Print Space$(35);
        Locate 8, 43
        Input gamespeed$
    Loop Until Val(gamespeed$) >= 1 And Val(gamespeed$) <= 100
    speed = Val(gamespeed$)

    speed = (100 - speed) * 2 + 1

    Do
        Locate 15, 56: Print Space$(25);
        Locate 15, 15
        Input "Increase game speed during play (Y or N)"; diff$
        diff$ = UCase$(diff$)
    Loop Until diff$ = "Y" Or diff$ = "N"

    Do
        Locate 17, 46: Print Space$(34);
        Locate 17, 17
        Input "Monochrome or color monitor (M or C)"; monitor$
        monitor$ = UCase$(monitor$)
    Loop Until monitor$ = "M" Or monitor$ = "C"

End Sub

'InitColors:
'Initializes playing field colors
Sub InitColors

    For row = 1 To 50
        For col = 1 To 80
            arena(row, col).acolor = colorTable(4)
        Next col
    Next row

    Cls

    'Set (turn on) pixels for screen border
    For col = 1 To 80
        Set 3, col, colorTable(3)
        Set 50, col, colorTable(3)
    Next col

    For row = 4 To 49
        Set row, 1, colorTable(3)
        Set row, 80, colorTable(3)
    Next row

End Sub

'Intro:
'  Displays game introduction
Sub Intro
    Screen 0
    Width 80, 25
    Color 15, 0
    Cls

    Center 4, "Q B a s i c   N i b b l e s"
    Color 7
    Center 6, "Copyright (C) Microsoft Corporation 1990"
    Center 8, "Nibbles is a game for one or two players.  Navigate your snakes"
    Center 9, "around the game board trying to eat up numbers while avoiding"
    Center 10, "running into walls or other snakes.  The more numbers you eat up,"
    Center 11, "the more points you gain and the longer your snake becomes."
    Center 13, " Game Controls "
    Center 15, "  General             Player 1               Player 2    "
    Center 16, "                        (Up)                   (Up)      "
    Center 17, "P - Pause                " + Chr$(24) + "                      W       "
    Center 18, "                     (Left) " + Chr$(27) + "   " + Chr$(26) + " (Right)   (Left) A   D (Right)  "
    Center 19, "                         " + Chr$(25) + "                      S       "
    Center 20, "                       (Down)                 (Down)     "
    Center 24, "Press any key to continue"

    Play "MBT160O1L8CDEDCDL4ECC"
    SparklePause

End Sub

'Level:
'Sets game level
Sub Level (WhatToDO, sammy() As snaketype) Static

    Select Case (WhatToDO)

        Case STARTOVER
            curLevel = 1
        Case NEXTLEVEL
            curLevel = curLevel + 1
    End Select

    sammy(1).head = 1 'Initialize Snakes
    sammy(1).length = 2
    sammy(1).alive = TRUE
    sammy(2).head = 1
    sammy(2).length = 2
    sammy(2).alive = TRUE

    InitColors

    Select Case curLevel
        Case 1
            sammy(1).row = 25: sammy(2).row = 25
            sammy(1).col = 50: sammy(2).col = 30
            sammy(1).direction = 4: sammy(2).direction = 3


        Case 2
            For i = 20 To 60
                Set 25, i, colorTable(3)
            Next i
            sammy(1).row = 7: sammy(2).row = 43
            sammy(1).col = 60: sammy(2).col = 20
            sammy(1).direction = 3: sammy(2).direction = 4

        Case 3
            For i = 10 To 40
                Set i, 20, colorTable(3)
                Set i, 60, colorTable(3)
            Next i
            sammy(1).row = 25: sammy(2).row = 25
            sammy(1).col = 50: sammy(2).col = 30
            sammy(1).direction = 1: sammy(2).direction = 2

        Case 4
            For i = 4 To 30
                Set i, 20, colorTable(3)
                Set 53 - i, 60, colorTable(3)
            Next i
            For i = 2 To 40
                Set 38, i, colorTable(3)
                Set 15, 81 - i, colorTable(3)
            Next i
            sammy(1).row = 7: sammy(2).row = 43
            sammy(1).col = 60: sammy(2).col = 20
            sammy(1).direction = 3: sammy(2).direction = 4

        Case 5
            For i = 13 To 39
                Set i, 21, colorTable(3)
                Set i, 59, colorTable(3)
            Next i
            For i = 23 To 57
                Set 11, i, colorTable(3)
                Set 41, i, colorTable(3)
            Next i
            sammy(1).row = 25: sammy(2).row = 25
            sammy(1).col = 50: sammy(2).col = 30
            sammy(1).direction = 1: sammy(2).direction = 2

        Case 6
            For i = 4 To 49
                If i > 30 Or i < 23 Then
                    Set i, 10, colorTable(3)
                    Set i, 20, colorTable(3)
                    Set i, 30, colorTable(3)
                    Set i, 40, colorTable(3)
                    Set i, 50, colorTable(3)
                    Set i, 60, colorTable(3)
                    Set i, 70, colorTable(3)
                End If
            Next i
            sammy(1).row = 7: sammy(2).row = 43
            sammy(1).col = 65: sammy(2).col = 15
            sammy(1).direction = 2: sammy(2).direction = 1

        Case 7
            For i = 4 To 49 Step 2
                Set i, 40, colorTable(3)
            Next i
            sammy(1).row = 7: sammy(2).row = 43
            sammy(1).col = 65: sammy(2).col = 15
            sammy(1).direction = 2: sammy(2).direction = 1

        Case 8
            For i = 4 To 40
                Set i, 10, colorTable(3)
                Set 53 - i, 20, colorTable(3)
                Set i, 30, colorTable(3)
                Set 53 - i, 40, colorTable(3)
                Set i, 50, colorTable(3)
                Set 53 - i, 60, colorTable(3)
                Set i, 70, colorTable(3)
            Next i
            sammy(1).row = 7: sammy(2).row = 43
            sammy(1).col = 65: sammy(2).col = 15
            sammy(1).direction = 2: sammy(2).direction = 1

        Case 9
            For i = 6 To 47
                Set i, i, colorTable(3)
                Set i, i + 28, colorTable(3)
            Next i
            sammy(1).row = 40: sammy(2).row = 15
            sammy(1).col = 75: sammy(2).col = 5
            sammy(1).direction = 1: sammy(2).direction = 2

        Case Else
            For i = 4 To 49 Step 2
                Set i, 10, colorTable(3)
                Set i + 1, 20, colorTable(3)
                Set i, 30, colorTable(3)
                Set i + 1, 40, colorTable(3)
                Set i, 50, colorTable(3)
                Set i + 1, 60, colorTable(3)
                Set i, 70, colorTable(3)
            Next i
            sammy(1).row = 7: sammy(2).row = 43
            sammy(1).col = 65: sammy(2).col = 15
            sammy(1).direction = 2: sammy(2).direction = 1

    End Select
End Sub

'PlayNibbles:
'  Main routine that controls game play
Sub PlayNibbles (NumPlayers, speed, diff$)

    'Initialize Snakes
    Dim sammyBody(MAXSNAKELENGTH - 1, 1 To 2) As snakeBody
    Dim sammy(1 To 2) As snaketype
    sammy(1).lives = 5
    sammy(1).score = 0
    sammy(1).scolor = colorTable(1)
    sammy(2).lives = 5
    sammy(2).score = 0
    sammy(2).scolor = colorTable(2)

    Level STARTOVER, sammy()
    startRow1 = sammy(1).row: startCol1 = sammy(1).col
    startRow2 = sammy(2).row: startCol2 = sammy(2).col

    curSpeed = speed

    'play Nibbles until finished

    SpacePause "     Level" + Str$(curLevel) + ",  Push Space"
    gameOver = FALSE
    Do
        If NumPlayers = 1 Then
            sammy(2).row = 0
        End If

        number = 1 'Current number that snakes are trying to run into
        nonum = TRUE 'nonum = TRUE if a number is not on the screen

        playerDied = FALSE
        PrintScore NumPlayers, sammy(1).score, sammy(2).score, sammy(1).lives, sammy(2).lives
        Play "T160O1>L20CDEDCDL10ECC"

        Do
            'Print number if no number exists
            If nonum = TRUE Then
                Do
                    numberRow = Int(Rnd(1) * 47 + 3)
                    NumberCol = Int(Rnd(1) * 78 + 2)
                    sisterRow = numberRow + arena(numberRow, NumberCol).sister
                Loop Until Not PointIsThere(numberRow, NumberCol, colorTable(4)) And Not PointIsThere(sisterRow, NumberCol, colorTable(4))
                numberRow = arena(numberRow, NumberCol).realRow
                nonum = FALSE
                Color colorTable(1), colorTable(4)
                Locate numberRow, NumberCol
                Print Right$(Str$(number), 1);
                count = 0
            End If

            'Delay game
            _Delay .016 + .00042 * curSpeed

            'Get keyboard input & Change direction accordingly
            kbd$ = InKey$
            Select Case kbd$
                Case "w", "W": If sammy(2).direction <> 2 Then sammy(2).direction = 1
                Case "s", "S": If sammy(2).direction <> 1 Then sammy(2).direction = 2
                Case "a", "A": If sammy(2).direction <> 4 Then sammy(2).direction = 3
                Case "d", "D": If sammy(2).direction <> 3 Then sammy(2).direction = 4
                Case Chr$(0) + "H": If sammy(1).direction <> 2 Then sammy(1).direction = 1
                Case Chr$(0) + "P": If sammy(1).direction <> 1 Then sammy(1).direction = 2
                Case Chr$(0) + "K": If sammy(1).direction <> 4 Then sammy(1).direction = 3
                Case Chr$(0) + "M": If sammy(1).direction <> 3 Then sammy(1).direction = 4
                Case "p", "P": SpacePause " Game Paused ... Push Space  "
                Case Else
            End Select

            For a = 1 To NumPlayers
                'Move Snake
                Select Case sammy(a).direction
                    Case 1: sammy(a).row = sammy(a).row - 1
                    Case 2: sammy(a).row = sammy(a).row + 1
                    Case 3: sammy(a).col = sammy(a).col - 1
                    Case 4: sammy(a).col = sammy(a).col + 1
                End Select

                'If snake hits number, respond accordingly
                If numberRow = Int((sammy(a).row + 1) / 2) And NumberCol = sammy(a).col Then
                    Play "MBO0L16>CCCE"
                    If sammy(a).length < (MAXSNAKELENGTH - 30) Then
                        sammy(a).length = sammy(a).length + number * 4
                    End If
                    sammy(a).score = sammy(a).score + number
                    PrintScore NumPlayers, sammy(1).score, sammy(2).score, sammy(1).lives, sammy(2).lives
                    number = number + 1
                    If number = 10 Then
                        For b = 1 To NumPlayers
                            EraseSnake sammy(), sammyBody(), b
                        Next b
                        Locate numberRow, NumberCol: Print " "
                        Level NEXTLEVEL, sammy()
                        PrintScore NumPlayers, sammy(1).score, sammy(2).score, sammy(1).lives, sammy(2).lives
                        SpacePause "     Level" + Str$(curLevel) + ",  Push Space"
                        If NumPlayers = 1 Then sammy(2).row = 0
                        number = 1
                        If diff$ = "Y" Then curSpeed = curSpeed - 10
                    End If
                    nonum = TRUE
                    If curSpeed < 1 Then curSpeed = 1
                End If
            Next a

            For a = 1 To NumPlayers
                'If player runs into any point, or the head of the other snake, it dies.
                If PointIsThere(sammy(a).row, sammy(a).col, colorTable(4)) Or (sammy(1).row = sammy(2).row And sammy(1).col = sammy(2).col) Then
                    Play "MBO0L32EFGEFDC"
                    Color , colorTable(4)
                    Locate numberRow, NumberCol
                    Print " "

                    playerDied = TRUE
                    sammy(a).alive = FALSE
                    sammy(a).lives = sammy(a).lives - 1

                    'Otherwise, move the snake, and erase the tail
                Else
                    sammy(a).head = (sammy(a).head + 1) Mod MAXSNAKELENGTH
                    sammyBody(sammy(a).head, a).row = sammy(a).row
                    sammyBody(sammy(a).head, a).col = sammy(a).col
                    tail = (sammy(a).head + MAXSNAKELENGTH - sammy(a).length) Mod MAXSNAKELENGTH
                    Set sammyBody(tail, a).row, sammyBody(tail, a).col, colorTable(4)
                    sammyBody(tail, a).row = 0
                    Set sammy(a).row, sammy(a).col, sammy(a).scolor
                End If
            Next a

        Loop Until playerDied

        curSpeed = speed ' reset speed to initial value

        For a = 1 To NumPlayers
            EraseSnake sammy(), sammyBody(), a

            'If dead, then erase snake in really cool way
            If sammy(a).alive = FALSE Then
                'Update score
                sammy(a).score = sammy(a).score - 10
                PrintScore NumPlayers, sammy(1).score, sammy(2).score, sammy(1).lives, sammy(2).lives

                If a = 1 Then
                    SpacePause " Sammy Dies! Push Space! --->"
                Else
                    SpacePause " <---- Jake Dies! Push Space "
                End If
            End If
        Next a

        Level SAMELEVEL, sammy()
        PrintScore NumPlayers, sammy(1).score, sammy(2).score, sammy(1).lives, sammy(2).lives

        'Play next round, until either of snake's lives have run out.
    Loop Until sammy(1).lives = 0 Or sammy(2).lives = 0

End Sub

'PointIsThere:
'  Checks the global  arena array to see if the boolean flag is set
Function PointIsThere (row, col, acolor)
    If row <> 0 Then
        If arena(row, col).acolor <> acolor Then
            PointIsThere = TRUE
        Else
            PointIsThere = FALSE
        End If
    End If
End Function

'PrintScore:
'  Prints players scores and number of lives remaining
Sub PrintScore (NumPlayers, score1, score2, lives1, lives2)
    Color 15, colorTable(4)

    If NumPlayers = 2 Then
        Locate 1, 1
        Print Using "#,###,#00  Lives: #  <--JAKE"; score2; lives2
    End If

    Locate 1, 49
    Print Using "SAMMY-->  Lives: #     #,###,#00"; lives1; score1
End Sub

'Set:
'  Sets row and column on playing field to given color to facilitate moving
'  of snakes around the field.
Sub Set (row, col, acolor)
    If row <> 0 Then
        arena(row, col).acolor = acolor 'assign color to arena
        realRow = arena(row, col).realRow 'Get real row of pixel
        topFlag = arena(row, col).sister + 1 / 2 'Deduce whether pixel
        'is on topﬂ, or bottom‹
        sisterRow = row + arena(row, col).sister 'Get arena row of sister
        sisterColor = arena(sisterRow, col).acolor 'Determine sister's color

        Locate realRow, col

        If acolor = sisterColor Then 'If both points are same
            Color acolor, acolor 'Print chr$(219) "€"
            Print Chr$(219);
        Else
            If topFlag Then 'Since you cannot have
                If acolor > 7 Then 'bright backgrounds
                    Color acolor, sisterColor 'determine best combo
                    Print Chr$(223); 'to use.
                Else
                    Color sisterColor, acolor
                    Print Chr$(220);
                End If
            Else
                If acolor > 7 Then
                    Color acolor, sisterColor
                    Print Chr$(220);
                Else
                    Color sisterColor, acolor
                    Print Chr$(223);
                End If
            End If
        End If
    End If
End Sub

'SpacePause:
'  Pauses game play and waits for space bar to be pressed before continuing
Sub SpacePause (text$)

    Color colorTable(5), colorTable(6)
    Center 11, "€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€"
    Center 12, "€ " + Left$(text$ + Space$(29), 29) + " €"
    Center 13, "€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€"
    While InKey$ <> "": Wend
    While InKey$ <> " ": Wend
    Color 15, colorTable(4)

    For i = 21 To 26 ' Restore the screen background
        For j = 24 To 56
            Set i, j, arena(i, j).acolor
        Next j
    Next i

End Sub

'SparklePause:
'  Creates flashing border for intro screen
Sub SparklePause

    Color 4, 0
    a$ = "*    *    *    *    *    *    *    *    *    *    *    *    *    *    *    *    *    "
    While InKey$ <> "": Wend 'Clear keyboard buffer

    While InKey$ = ""
        For a = 1 To 5
            Locate 1, 1 'print horizontal sparkles
            Print Mid$(a$, a, 80);
            Locate 22, 1
            Print Mid$(a$, 6 - a, 80);

            For b = 2 To 21 'Print Vertical sparkles
                c = (a + b) Mod 5
                If c = 1 Then
                    Locate b, 80
                    Print "*";
                    Locate 23 - b, 1
                    Print "*";
                Else
                    Locate b, 80
                    Print " ";
                    Locate 23 - b, 1
                    Print " ";
                End If
            Next b
            _Delay .06
        Next a
    Wend

End Sub

'StillWantsToPlay:
'  Determines if users want to play game again.
Function StillWantsToPlay

    Color colorTable(5), colorTable(6)
    Center 10, "€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€"
    Center 11, "€       G A M E   O V E R       €"
    Center 12, "€                               €"
    Center 13, "€      Play Again?   (Y/N)      €"
    Center 14, "€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€"

    While InKey$ <> "": Wend
    Do
        kbd$ = UCase$(InKey$)
    Loop Until kbd$ = "Y" Or kbd$ = "N"

    Color 15, colorTable(4)
    Center 10, "                                 "
    Center 11, "                                 "
    Center 12, "                                 "
    Center 13, "                                 "
    Center 14, "                                 "

    If kbd$ = "Y" Then
        StillWantsToPlay = TRUE
    Else
        StillWantsToPlay = FALSE
        Color 7, 0
        Cls
    End If

End Function

