$NoPrefix
DefInt A-Z
$Resize:Smooth

Const FALSE = 0
Const TRUE = Not FALSE
Const SHOTSELF = 1
Const BACKGROUND_COLOR = 0
Const TERRAINCOLOR = 1
Const EXPLOSIONCOLOR = 2
Const OBJECTCOLOR = 3

Dim Shared CastleX(1 To 2)
Dim Shared CastleY(1 To 2)

Dim Shared CastlePic&(1 To 40)
Dim Shared shot&(1 To 10)

Dim Shared gravity#
Dim Shared Wind

Dim Shared ScreenHeight
Dim Shared ScreenWidth
Dim Shared mode
Dim Shared MaxCol
Dim Shared BaseCol

Intro
GetInputs name1$, name2$, numGames, gravity#

GoSub InitializeVariables

PlayGame name1$, name2$, numGames
EndGame
End




CGAPic:
Data 589840,-12301,-1,-62915521,-62915521,64575

CGAShot:
Data 196614,3210288&

EGAPic:
Data 1048592,-806105101,0,-806105101,0,-1,0,-1,0,-1,0,-1,0,-62915521,0
Data -62915521,0,-62915521,0,-62915521,0,-62915521,0,-62915521,0,-62915521
Data 0,-62915521,0,-62915521,0,-62915521,0,0,0,-62915521,0,0,0

EGAShot:
Data 196611,57568,57568,57568



InitializeVariables:

On Error GoTo ScreenModeError
mode = 9
Screen mode
On Error GoTo 0
If mode = 9 Then
    ScreenWidth = 640
    ScreenHeight = 350

    Restore EGAPic
    For Counter = 1 To 39
        Read CastlePic&(Counter)
    Next Counter

    For Counter = 1 To 4
        Read shot&(Counter)
    Next Counter

    Color 3, 1
    Palette TERRAINCOLOR, 2 'Set color for ground
    Palette EXPLOSIONCOLOR, 4 'Explosion color
    Palette OBJECTCOLOR, 12
    BaseCol = 30
    MaxCol = 80
Else
    ScreenWidth = 320
    ScreenHeight = 200
    Restore CGAPic
    For Counter = 1 To 6
        Read CastlePic&(Counter)
    Next Counter
    For Counter = 1 To 2
        Read shot&(Counter)
    Next Counter
    Color 3, 0
    BaseCol = 10
    MaxCol = 40
End If

Return



ScreenModeError:
If mode = 1 Then
    Print "Sorry, You must have CGA, EGA, or VGA graphics to play Castles"
    End
Else
    mode = 1
    Resume
End If


'Rest:
'  pauses the program
Sub Rest (t#)
    If (t# > 0) Then Delay t#
End Sub


Sub Center (row, text$)
    Locate row, 41 - Len(text$) / 2
    Print text$;
End Sub


Sub CyclePalette
    If mode = 9 Then
        Palette EXPLOSIONCOLOR, 38
        Palette EXPLOSIONCOLOR, 44
    Else
        Color 12, EXPLOSIONCOLOR
        Color 14, EXPLOSIONCOLOR
        Color 3, EXPLOSIONCOLOR
    End If
End Sub

Sub DoExplosion (x#, y#)
    Play "MBO0L32EFGEFDC"
    Radius = ScreenHeight / 70
    If mode = 9 Then Increment# = .5 Else Increment# = 1.2
    For Counter# = 0 To Radius Step Increment#
        Circle (x#, y#), Counter#, EXPLOSIONCOLOR
        Call CyclePalette
    Next Counter#
    For Counter# = Radius To 0 Step (-1 * Increment#)
        Circle (x#, y#), Counter#, BACKGROUND_COLOR
        Rest .005
    Next Counter#
End Sub

Function DoShot (PlayerNum, XPos, YPos)
    If PlayerNum = 1 Then
        locateCol = 1
    Else
        If mode = 9 Then
            locateCol = 66
        Else
            locateCol = 26
        End If
    End If
    YShotPos = YPos - 3
    Locate 2, locateCol
    Print "Angle:";
    Angle# = GetNum#(2, locateCol + 7)

    Locate 3, locateCol
    Print "Velocity:";
    Velocity = GetNum#(3, locateCol + 10)

    If PlayerNum = 2 Then Angle# = 180 - Angle#

    View Print 1 To 4
    Cls 2
    View Print 1 To 25

    PlayerHit = PlotShot(XPos, YShotPos, Angle#, Velocity)
    If PlayerHit = PlayerNum Then
        DoShot = SHOTSELF
    ElseIf PlayerHit <> 0 Then
        DoShot = TRUE
    Else
        DoShot = FALSE
    End If
End Function

Sub EndGame
    Screen 0
    Color 15, 0
    Cls
End Sub

Function ExplodeCastle (x#)
    Shared CastleX(), CastleY()
    ScaleX# = ScreenWidth / 320
    ScaleY# = ScreenHeight / 200
    If x# < ScreenWidth / 2 Then PlayerHit = 1 Else PlayerHit = 2
    Play "MBO0L16EFGEFDC"
    For Blast = 1 To 8 * ScaleX#
        Circle (CastleX(PlayerHit) + 3.5 * ScaleX#, CastleY(PlayerHit) + 7 * ScaleY#), Blast, EXPLOSIONCOLOR, , , -1.57
        Line (CastleX(PlayerHit) + 7 * ScaleX#, CastleY(PlayerHit) + 9 * ScaleY# - Blast)-(CastleX(PlayerHit), CastleY(PlayerHit) + 9 * ScaleY# - Blast), EXPLOSIONCOLOR
        If Blast Mod (10 - mode) < 3 Then Call CyclePalette
        Rest .005
    Next Blast
    For Cloud = 1 To 16 * ScaleX#
        If Cloud < (8 * ScaleX#) Then Circle (CastleX(PlayerHit) + 3.5 * ScaleX#, CastleY(PlayerHit) + 7 * ScaleY#), (8 * ScaleX# + 1) - Cloud, BACKGROUND_COLOR, , , -1.57
        Circle (CastleX(PlayerHit) + 3.5 * ScaleX#, CastleY(PlayerHit)), Cloud, EXPLOSIONCOLOR, , , -1.57
        If Cloud Mod (10 - mode) < 3 Then Call CyclePalette
        Rest .005
    Next Cloud
    For Cloud = 16 * ScaleX# To 1 Step -1
        Circle (CastleX(PlayerHit) + 3.5 * ScaleX#, CastleY(PlayerHit)), Cloud, BACKGROUND_COLOR, , , -1.57
        Rest .01
    Next Cloud
    ExplodeCastle = PlayerHit
End Function

Sub GetInputs (player1$, player2$, numGames, gravity#)
    Screen 0
    Color 14, 1
    Cls

    Do
        Locate 9, 30
        Line Input "Name of Player 1 :"; player1$
    Loop Until player1$ <> ""

    Do
        Locate 10, 30
        Line Input "Name of Player 2 :"; player2$
    Loop Until player2$ <> ""

    Locate 12, 26
    Input "Play to how many points"; numGames

    Do
        Locate 14, 22
        Input "Gravity in Meters/Sec (Earth = 9.8)"; gravity#
    Loop Until gravity# > 0
End Sub

Function GetNum# (row, col)
    result$ = ""
    finished = FALSE

    Do While Not finished

        Locate row, col
        Print result$; Chr$(95); " ";

        kbd$ = InKey$
        Select Case kbd$
            Case "0" TO "9"
                result$ = result$ + kbd$
            Case "."
                If InStr(result$, ".") = 0 Then
                    result$ = result$ + kbd$
                End If
            Case Chr$(13)
                finished = TRUE
            Case Chr$(8)
                If Len(result$) > 0 Then
                    result$ = Left$(result$, Len(result$) - 1)
                End If
            Case Else
                If Len(kbd$) > 0 Then
                    Beep
                End If
        End Select
    Loop

    Locate row, col
    Print result$; " ";

    GetNum# = Val(result$)
End Function

Sub Intro
    Screen 0
    Color 12, 1
    Cls
    Center 8, "Q u i c k B A S I C   C A S T L E S"
    Color 14
    Center 10, "Your mission is to destroy your opponent's castle"
    Center 11, "by varying the angle and power of your catapult"
    Center 12, "taking into account wind speed, gravity and terrain."
    Center 24, "Push Any Key To Continue"
    Color 15
    Play "T160O1L8CDEDCDL4ECC"
    SparklePause
End Sub

Sub MakeBattleField (TerrainHeight())
    If mode = 9 Then Increment = 2 Else Increment = 1
    TerrainHeight(0) = ScreenHeight - (10 + Int((ScreenHeight / 3) * Rnd + 1))
    For Counter = 1 To ScreenWidth
        Motion = Int(20 * Rnd + 1)
        If Counter < (ScreenWidth / 2) Then OnFirstHalfScreen = TRUE Else OnFirstHalfScreen = FALSE
        If Int(4 * Rnd + 1) = 1 Then ShouldCheckScreenPos = TRUE Else ShouldCheckScreenPos = FLASE
        Select Case Motion
            Case 1 TO 10
                If (ShouldCheckScreenPos And OnFirstHalfScreen) Then
                    Trend = Trend - Increment
                ElseIf (ShouldCheckScreenPos And (Not OnFirstHalfScreen)) Then
                    Trend = Trend + Increment
                ElseIf Motion < 6 Then
                    Trend = Trend - Increment
                Else
                    Trend = Trend + Increment
                End If
            Case 11 TO 14
                If (ShouldCheckScreenPos And OnFirstHalfScreen) Then
                    Trend = Trend - Increment * 2
                ElseIf (ShouldCheckScreenPos And (Not OnFirstHalfScreen)) Then
                    Trend = Trend + Increment * 2
                ElseIf Motion < 13 Then
                    Trend = Trend - Increment * 2
                Else
                    Trend = Trend + Increment * 2
                End If
            Case 15
                Trend = 0
            Case 16
                Trend = 1
            Case 17
                Trend = -1
            Case Else
        End Select
        Select Case Trend
            Case Is < -10
                TerrainHeight(Counter) = TerrainHeight(Counter - 1) - 3
            Case Is < 0
                TerrainHeight(Counter) = TerrainHeight(Counter - 1) - 1
            Case Is > 10
                TerrainHeight(Counter) = TerrainHeight(Counter - 1) + 3
            Case Is > 0
                TerrainHeight(Counter) = TerrainHeight(Counter - 1) + 1
            Case Else
                TerrainHeight(Counter) = TerrainHeight(Counter - 1)
        End Select
        If TerrainHeight(Counter) > (ScreenHeight - (8 + mode)) Then
            TerrainHeight(Counter) = (ScreenHeight - (8 + mode))
            If OnFirstHalfScreen Then Trend = -9 Else Trend = -3
        Else
            If TerrainHeight(Counter) < (ScreenHeight / 2.2) Then
                TerrainHeight(Counter) = (ScreenHeight / 2.2)
                If OnFirstHalfScreen Then Trend = 9 Else Trend = 3
            End If
        End If
        Line (Counter, ScreenHeight)-(Counter, TerrainHeight(Counter)), TERRAINCOLOR
    Next Counter
    Wind = Int(10 * Rnd + 1) - 5
    If (Int(3 * Rnd + 1) = 1) Then
        If Wind > 0 Then
            Wind = Wind + Int(10 * Rnd + 1)
        Else
            Wind = Wind - Int(10 * Rnd + 1)
        End If
    End If
    If Wind <> 0 Then
        WindLineLength = Wind * (ScreenWidth / 320)
        Line (ScreenWidth / 2, ScreenHeight - 15)-(ScreenWidth / 2 + WindLineLength, ScreenHeight - 15), EXPLOSIONCOLOR
        If Wind > 0 Then ArrowDir = -2 Else ArrowDir = 2
        Line (ScreenWidth / 2 + WindLineLength, ScreenHeight - 15)-(ScreenWidth / 2 + WindLineLength + ArrowDir, ScreenHeight - 15 - 2), EXPLOSIONCOLOR
        Line (ScreenWidth / 2 + WindLineLength, ScreenHeight - 15)-(ScreenWidth / 2 + WindLineLength + ArrowDir, ScreenHeight - 15 + 2), EXPLOSIONCOLOR
    End If
End Sub

Sub PlaceCastles (CastleX(), CastleY(), TerrainHeight())
    ScaleX# = ScreenWidth / 320
    ScaleY# = ScreenHeight / 200
    For Counter = 1 To 2
        CastleX(Counter) = Int((ScreenWidth / 3.2) * Rnd + ((ScreenWidth / 1.6 - 3) * (Counter - 1))) + 2
        CastleY(Counter) = TerrainHeight(CastleX(Counter)) - (9 * ScaleY#)
        Put (CastleX(Counter), CastleY(Counter)), CastlePic&(), PSet
        For FixTerrain = CastleX(Counter) To CastleX(Counter) + (7 * ScaleX#)
            Line (FixTerrain, ScreenHeight)-(FixTerrain, CastleY(Counter) + (9 * ScaleY#)), TERRAINCOLOR
            Line (FixTerrain, 0)-(FixTerrain, CastleY(Counter) - 1), BACKGROUND_COLOR
        Next FixTerrain
    Next Counter
End Sub

Sub PlayGame (player1$, player2$, numGames)
    Dim TerrainHeight(0 To 640)
    Dim TotalWins(1 To 2)

    Randomize (Timer)

    If mode = 9 Then
        Palette OBJECTCOLOR, 63
    Else
        Color 3, 0
    End If

    For Counter = 1 To numGames
        Cls
        Call MakeBattleField(TerrainHeight())
        Call PlaceCastles(CastleX(), CastleY(), TerrainHeight())
        DirectHit = FALSE
        Do While DirectHit = FALSE
            Locate 1, 1
            Print player1$
            Locate 1, (MaxCol - 1 - Len(player2$))
            Print player2$
            Locate 1, BaseCol + 3
            Print TotalWins(1); ">Score<"; TotalWins(2)
            If Counter Mod 2 Then FirstPlayer = 1 Else FirstPlayer = 2
            SecondPlayer = Abs(FirstPlayer - 3)
            DirectHit = DoShot(FirstPlayer, CastleX(FirstPlayer), CastleY(FirstPlayer))
            If DirectHit = FALSE Then
                Locate 1, 1
                Print player1$
                Locate 1, (MaxCol - 1 - Len(player2$))
                Print player2$
                DirectHit = DoShot(SecondPlayer, CastleX(SecondPlayer), CastleY(SecondPlayer))
                If DirectHit <> FALSE Then Call UpdateScores(TotalWins(), SecondPlayer, DirectHit)
            Else
                Call UpdateScores(TotalWins(), FirstPlayer, DirectHit)
            End If
        Loop
        Sleep 1
    Next Counter

    Screen 0
    Color 14, 1
    Cls
    Locate 8, 35: Print "GAME OVER!"
    Locate 10, 30: Print "Score:"
    Locate 11, 34: Print player1$; Tab(30 + 20); TotalWins(1)
    Locate 12, 34: Print player2$; Tab(30 + 20); TotalWins(2)
    Center 24, "Push Any Key To Continue"
    Color 14
    SparklePause
End Sub

Function PlotShot (StartX, StartY, Angle#, Velocity)
    Angle# = Angle# / 180 * Pi 'Convert degree angle to radians
    Radius = mode Mod 7

    InitialXVelocity# = Cos(Angle#) * Velocity
    InitialYVelocity# = Sin(Angle#) * Velocity

    Oldx# = StartX
    Oldy# = StartY

    Play "MBo0L32A-L64CL16BL64A+"
    Rest .1

    DirectHit = FALSE
    Impact = FALSE
    OnScreen = TRUE
    PlayerHit = 0
    NEEDERASE = FALSE

    If Velocity < 2 Then 'Shot too slow - hit self
        x# = StartX
        y# = StartY
        Impact = TRUE
        DirectHit = TRUE
    End If

    Do While (Not Impact) And OnScreen
        Rest .02
        x# = StartX + (InitialXVelocity# * t#) + (.5 * (Wind / 5) * t# ^ 2)
        y# = StartY + ((-1 * (InitialYVelocity# * t#)) + (.5 * gravity# * t# ^ 2)) * (ScreenHeight / 350)
        If (x# >= ScreenWidth - 3) Or (x# <= 3) Or (y# >= ScreenHeight - 3) Then
            OnScreen = FALSE
        End If
        If NEEDERASE Then
            Put (Oldx#, Oldy#), shot&(), Xor
        End If
        For LookX = -1 To 1
            For LookY = -1 To 1
                If Point(x# + LookX, y# + LookY) = TERRAINCOLOR Or Point(x# + LookX, y# + LookY) = OBJECTCOLOR Then Impact = TRUE
            Next
        Next
        If OnScreen And Not Impact And y# > 0 Then
            Put (x#, y#), shot&(), PSet
            NEEDERASE = TRUE
            Oldx# = x#
            Oldy# = y#
        Else
            NEEDERASE = FALSE
            If Not OnScreen Or y# < 0 Then
                Oldx# = 0
                Oldy# = 0
            Else
                For LookX = -1 To 1
                    For LookY = -1 To 1
                        If Point(x# + LookX, y# + LookY) = OBJECTCOLOR Then DirectHit = TRUE
                    Next
                Next
            End If
        End If
        t# = t# + .1
    Loop
    If Impact Then Call DoExplosion(x#, y#)
    If DirectHit Then PlayerHit = ExplodeCastle(x#)
    PlotShot = PlayerHit
End Function

Sub SparklePause
    Color 15, 1

    a$ = "*    *    *    *    *    *    *    *    *    *    *    *    *    *    *    *    *    "

    While InKey$ = ""
        For a = 1 To 5
            Locate 1, 1
            Print Mid$(a$, a, 80);
            Locate 20, 1
            Print Mid$(a$, 6 - a, 80);

            For b = 2 To 19
                c = (a + b) Mod 5
                If c = 1 Then
                    Locate b, 80
                    Print "*";
                    Locate 21 - b, 1
                    Print "*";
                Else
                    Locate b, 80
                    Print " ";
                    Locate 21 - b, 1
                    Print " ";
                End If
            Next b
            Rest .06
        Next a
    Wend
End Sub

Sub UpdateScores (Record(), PlayerNum, Results)
    If Results = SHOTSELF Then
        Record(Abs(PlayerNum - 3)) = Record(Abs(PlayerNum - 3)) + 1
    Else
        Record(PlayerNum) = Record(PlayerNum) + 1
    End If
End Sub

