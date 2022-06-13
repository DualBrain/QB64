'-----------------------------------------------------------------------------------------------------
'Future Blocks - By Michael Fogleman
'https://github.com/fogleman/FutureBlocks
'Start Date : April 20, 2000
'Finish Date: April 24, 2000
'-----------------------------------------------------------------------------------------------------

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
' All arrays should be static by default. Allocate dynamic array using ReDim
'$Static
' This allows the executable window & it's contents to be resized.
$Resize:Smooth
'FullScreen SquarePixels , Smooth
Title "Future Blocks"
'-----------------------------------------------------------------------------------------------------

'Start:
Common Shared FieldWidth%, FieldHeight%, BlockSize%, XOffset%, YOffset%, Occupied%()
Common Shared PieceData%(), CurrentColor%(), Text%(), PieceList%(), competen%
Common Shared CurrentPiece%, PieceX%, PieceY%, PieceR%, PieceC%, Grid%, CMN%
Common Shared OldPiece%, OldX%, OldY%, OldR%, GameOver%, Overlap%, Debug%
Common Shared NumComplete%, hint%, CPlay%, DestX%, DestY%, DestR%, usery%, pal%()
Common Shared LineWeight As Single, GapWeight As Single, HeightWeight As Single, ink$, NextC%, SideWeight As Single
Common Shared DispWidth%, DispHeight%, DispX%, DispY%, XShift%, messyheight%
Common Shared Lines%, Score&, GameTime As Long, StartTime As Double, PieceTime As Double, AirTime As Double, Compete%
Common Shared gap%, shadow%, Lines2%, Score2&, GameTime2 As Long, NextPiece%, Pieces&, Pieces2&
Common Shared YourLines%, YourScore&, lastmove%

Dim PieceData%(17, 3, 6)
Dim Text%(39, 34)
Dim PieceList%(999)
Dim pal%(50)
ReadData
ReadText

Cls
Screen 12
AllowFullScreen SquarePixels , Smooth

GetPal
TitleScreen
Grid% = 0
Debug% = 0
LineWeight = 3
GapWeight = 4
HeightWeight = 1
SideWeight = 1
FieldWidth% = 12
FieldHeight% = 24
BlockSize% = 16
competen% = 50

DoneComp:
Do
    Compete% = 0
    Menu
    GameOver% = 0
    Cls
    Randomize Timer
    NextPiece% = Rnd * 6 + 1
    NextC% = Rnd * 6 + 1
    GameTime2 = -1
    Lines2% = -1
    Pieces2& = -1
    Score2& = -1
    Pieces& = 0
    Lines% = 0
    Score& = 0
    DispHeight% = 440
    DispWidth% = 147
    DispY% = (480 - DispHeight%) / 2
    DispX% = 640 - DispY% - DispWidth%
    XShift% = 320 - (DispX% / 2)
    XOffset% = ((BlockSize% + 2) * FieldWidth%) / 2
    YOffset% = ((BlockSize% + 2) * FieldHeight%) / 2
    If Compete% = 1 Then GoTo CompetitionMode
    gap% = 6: shadow% = 2
    DrawField
    Dim CurrentColor%(FieldWidth%, FieldHeight%)
    Dim Occupied%(FieldWidth%, FieldHeight%)
    If messyheight% > 0 Then PreOccupy messyheight%
    NewPiece
    StartTime = Timer
    MainLoop
    GameOverScreen
    Erase Occupied%, CurrentColor%
Loop

CompetitionMode:
Dim As Integer n
hint% = 0
CMN% = 0
n% = 0
Do
    PieceList%(n%) = Rnd * 6 + 1
    n% = n% + 1
Loop While n% < 1000
CPlay% = 0
gap% = 6: shadow% = 2
DrawField
Dim CurrentColor%(FieldWidth%, FieldHeight%)
Dim Occupied%(FieldWidth%, FieldHeight%)
If messyheight% > 0 Then PreOccupy messyheight%
NewPiece
StartTime = Timer
MainLoop
GameOverScreen
YourLines% = Lines%
YourScore& = Score&
Erase Occupied%, CurrentColor%

CMN% = 0
GameOver% = 0
Cls
Randomize Timer
GameTime2 = -1
Lines2% = -1
Pieces2& = -1
Score2& = -1
Pieces& = 0
Lines% = 0
Score& = 0
gap% = 6: shadow% = 2
CPlay% = 1
DrawField
Dim CurrentColor%(FieldWidth%, FieldHeight%)
Dim Occupied%(FieldWidth%, FieldHeight%)
If messyheight% > 0 Then PreOccupy messyheight%
NewPiece
StartTime = Timer
MainLoop
GameOverScreen
Erase Occupied%, CurrentColor%
CompeteScreen
GoTo DoneComp

Piece1:
Data 2,3
Data 1,0
Data 1,1
Data 0,1
Data 3,2
Data 0,1,1
Data 1,1,0
Data 2,3
Data 1,0
Data 1,1
Data 0,1
Data 3,2
Data 0,1,1
Data 1,1,0
Piece2:
Data 2,3
Data 0,1
Data 1,1
Data 1,0
Data 3,2
Data 1,1,0
Data 0,1,1
Data 2,3
Data 0,1
Data 1,1
Data 1,0
Data 3,2
Data 1,1,0
Data 0,1,1
Piece3:
Data 2,2
Data 1,1
Data 1,1
Data 2,2
Data 1,1
Data 1,1
Data 2,2
Data 1,1
Data 1,1
Data 2,2
Data 1,1
Data 1,1
Piece4:
Data 1,4
Data 1
Data 1
Data 1
Data 1
Data 4,1
Data 1,1,1,1
Data 1,4
Data 1
Data 1
Data 1
Data 1
Data 4,1
Data 1,1,1,1
Piece5:
Data 2,3
Data 1,0
Data 1,0
Data 1,1
Data 3,2
Data 1,1,1
Data 1,0,0
Data 2,3
Data 1,1
Data 0,1
Data 0,1
Data 3,2
Data 0,0,1
Data 1,1,1
Piece6:
Data 2,3
Data 0,1
Data 0,1
Data 1,1
Data 3,2
Data 1,0,0
Data 1,1,1
Data 2,3
Data 1,1
Data 1,0
Data 1,0
Data 3,2
Data 1,1,1
Data 0,0,1
Piece7:
Data 3,2
Data 0,1,0
Data 1,1,1
Data 2,3
Data 1,0
Data 1,1
Data 1,0
Data 3,2
Data 1,1,1
Data 0,1,0
Data 2,3
Data 0,1
Data 1,1
Data 0,1

Text:
Data 0,0,1,0,0
Data 0,1,0,1,0
Data 1,0,0,0,1
Data 1,1,1,1,1
Data 1,0,0,0,1
Data 1,0,0,0,1
Data 1,0,0,0,1

Data 1,1,1,1,0
Data 1,0,0,0,1
Data 1,0,0,0,1
Data 1,1,1,1,0
Data 1,0,0,0,1
Data 1,0,0,0,1
Data 1,1,1,1,0

Data 0,1,1,1,0
Data 1,0,0,0,1
Data 1,0,0,0,0
Data 1,0,0,0,0
Data 1,0,0,0,0
Data 1,0,0,0,1
Data 0,1,1,1,0

Data 1,1,1,0,0
Data 1,0,0,1,0
Data 1,0,0,0,1
Data 1,0,0,0,1
Data 1,0,0,0,1
Data 1,0,0,1,0
Data 1,1,1,0,0

Data 1,1,1,1,1
Data 1,0,0,0,0
Data 1,0,0,0,0
Data 1,1,1,0,0
Data 1,0,0,0,0
Data 1,0,0,0,0
Data 1,1,1,1,1

Data 1,1,1,1,1
Data 1,0,0,0,0
Data 1,0,0,0,0
Data 1,1,1,0,0
Data 1,0,0,0,0
Data 1,0,0,0,0
Data 1,0,0,0,0

Data 0,1,1,1,0
Data 1,0,0,0,1
Data 1,0,0,0,0
Data 1,0,0,0,0
Data 1,0,0,1,1
Data 1,0,0,0,1
Data 0,1,1,1,0

Data 1,0,0,0,1
Data 1,0,0,0,1
Data 1,0,0,0,1
Data 1,1,1,1,1
Data 1,0,0,0,1
Data 1,0,0,0,1
Data 1,0,0,0,1

Data 1,1,1,1,1
Data 0,0,1,0,0
Data 0,0,1,0,0
Data 0,0,1,0,0
Data 0,0,1,0,0
Data 0,0,1,0,0
Data 1,1,1,1,1

Data 1,1,1,1,1
Data 0,0,1,0,0
Data 0,0,1,0,0
Data 0,0,1,0,0
Data 0,0,1,0,0
Data 0,0,1,0,0
Data 1,1,0,0,0

Data 1,0,0,0,1
Data 1,0,0,1,0
Data 1,0,1,0,0
Data 1,1,0,0,0
Data 1,0,1,0,0
Data 1,0,0,1,0
Data 1,0,0,0,1

Data 1,0,0,0,0
Data 1,0,0,0,0
Data 1,0,0,0,0
Data 1,0,0,0,0
Data 1,0,0,0,0
Data 1,0,0,0,0
Data 1,1,1,1,1

Data 1,0,0,0,1
Data 1,1,0,1,1
Data 1,0,1,0,1
Data 1,0,0,0,1
Data 1,0,0,0,1
Data 1,0,0,0,1
Data 1,0,0,0,1

Data 1,0,0,0,1
Data 1,1,0,0,1
Data 1,1,0,0,1
Data 1,0,1,0,1
Data 1,0,1,0,1
Data 1,0,0,1,1
Data 1,0,0,0,1

Data 0,1,1,1,0
Data 1,0,0,0,1
Data 1,0,0,0,1
Data 1,0,0,0,1
Data 1,0,0,0,1
Data 1,0,0,0,1
Data 0,1,1,1,0

Data 1,1,1,1,0
Data 1,0,0,0,1
Data 1,0,0,0,1
Data 1,1,1,1,0
Data 1,0,0,0,0
Data 1,0,0,0,0
Data 1,0,0,0,0

Data 0,1,1,1,0
Data 1,0,0,0,1
Data 1,0,0,0,1
Data 1,0,0,0,1
Data 1,0,1,0,1
Data 1,0,0,1,1
Data 0,1,1,1,0

Data 1,1,1,1,0
Data 1,0,0,0,1
Data 1,0,0,0,1
Data 1,1,1,1,0
Data 1,0,1,0,0
Data 1,0,0,1,0
Data 1,0,0,0,1

Data 0,1,1,1,0
Data 1,0,0,0,1
Data 1,0,0,0,0
Data 0,1,1,1,0
Data 0,0,0,0,1
Data 1,0,0,0,1
Data 0,1,1,1,0

Data 1,1,1,1,1
Data 0,0,1,0,0
Data 0,0,1,0,0
Data 0,0,1,0,0
Data 0,0,1,0,0
Data 0,0,1,0,0
Data 0,0,1,0,0

Data 1,0,0,0,1
Data 1,0,0,0,1
Data 1,0,0,0,1
Data 1,0,0,0,1
Data 1,0,0,0,1
Data 1,0,0,0,1
Data 0,1,1,1,0

Data 1,0,0,0,1
Data 1,0,0,0,1
Data 1,0,0,0,1
Data 1,0,0,0,1
Data 1,0,0,0,1
Data 0,1,0,1,0
Data 0,0,1,0,0

Data 1,0,0,0,1
Data 1,0,0,0,1
Data 1,0,0,0,1
Data 1,0,0,0,1
Data 1,0,1,0,1
Data 1,1,0,1,1
Data 1,0,0,0,1

Data 1,0,0,0,1
Data 1,0,0,0,1
Data 0,1,0,1,0
Data 0,0,1,0,0
Data 0,1,0,1,0
Data 1,0,0,0,1
Data 1,0,0,0,1

Data 1,0,0,0,1
Data 1,0,0,0,1
Data 1,0,0,0,1
Data 0,1,0,1,0
Data 0,0,1,0,0
Data 0,0,1,0,0
Data 0,0,1,0,0

Data 1,1,1,1,1
Data 0,0,0,0,1
Data 0,0,0,1,0
Data 0,0,1,0,0
Data 0,1,0,0,0
Data 1,0,0,0,0
Data 1,1,1,1,1

Data 0,1,1,1,0
Data 1,0,0,0,1
Data 1,1,0,0,1
Data 1,0,1,0,1
Data 1,0,0,1,1
Data 1,0,0,0,1
Data 0,1,1,1,0

Data 0,0,1,0,0
Data 0,1,1,0,0
Data 0,0,1,0,0
Data 0,0,1,0,0
Data 0,0,1,0,0
Data 0,0,1,0,0
Data 0,1,1,1,0

Data 0,1,1,1,0
Data 1,0,0,0,1
Data 0,0,0,0,1
Data 0,0,0,1,0
Data 0,0,1,0,0
Data 0,1,0,0,0
Data 1,1,1,1,1

Data 0,1,1,1,0
Data 1,0,0,0,1
Data 0,0,0,0,1
Data 0,0,1,1,0
Data 0,0,0,0,1
Data 1,0,0,0,1
Data 0,1,1,1,0

Data 0,0,0,0,1
Data 1,0,0,0,1
Data 1,0,0,0,1
Data 1,1,1,1,1
Data 0,0,0,0,1
Data 0,0,0,0,1
Data 0,0,0,0,1

Data 1,1,1,1,1
Data 1,0,0,0,0
Data 1,1,1,1,0
Data 0,0,0,0,1
Data 0,0,0,0,1
Data 1,0,0,0,1
Data 0,1,1,1,0

Data 0,1,1,1,0
Data 1,0,0,0,1
Data 1,0,0,0,0
Data 1,1,1,1,0
Data 1,0,0,0,1
Data 1,0,0,0,1
Data 0,1,1,1,0

Data 1,1,1,1,1
Data 0,0,0,0,1
Data 0,0,0,0,1
Data 0,0,0,1,0
Data 0,0,1,0,0
Data 0,0,1,0,0
Data 0,0,1,0,0

Data 0,1,1,1,0
Data 1,0,0,0,1
Data 1,0,0,0,1
Data 0,1,1,1,0
Data 1,0,0,0,1
Data 1,0,0,0,1
Data 0,1,1,1,0

Data 0,1,1,1,0
Data 1,0,0,0,1
Data 1,0,0,0,1
Data 0,1,1,1,1
Data 0,0,0,0,1
Data 1,0,0,0,1
Data 0,1,1,1,0

Data 1,0,0,0,0
Data 0,1,0,0,0
Data 0,0,1,0,0
Data 0,0,1,0,0
Data 0,0,1,0,0
Data 0,1,0,0,0
Data 1,0,0,0,0

Data 0,0,0,0,0
Data 0,0,0,0,0
Data 0,0,0,0,0
Data 0,0,0,0,0
Data 0,0,0,0,0
Data 0,0,0,0,0
Data 1,0,0,0,0

Data 0,0,0,0,0
Data 0,0,1,0,0
Data 0,0,1,0,0
Data 1,1,1,1,1
Data 0,0,1,0,0
Data 0,0,1,0,0
Data 0,0,0,0,0

Data 0,0,0,0,0
Data 0,0,0,0,0
Data 0,0,0,0,0
Data 1,1,1,1,1
Data 0,0,0,0,0
Data 0,0,0,0,0
Data 0,0,0,0,0

Sub BlueColors
    Dim As Integer r, g, b, n

    r% = pal%(3)
    g% = pal%(4)
    b% = pal%(5)
    n% = 0
    Do
        Colors n%, r%, g%, b%
        n% = n% + 1
    Loop While n% < 16
End Sub

Sub CheckComplete
    Dim As Integer c(FieldHeight%), x, y, f, o, n, xn, yn

    x% = 1: y% = 1: f% = 0
    Do
        o% = Occupied%(x%, y%)
        If x% = FieldWidth% And o% > 0 Then
            If Debug% = 1 Then Locate f% + 18, 1: Print "LINE"; y%; "COMPLETE"
            Lines% = Lines% + 1
            c%(f%) = y%: f% = f% + 1: x% = 0: y% = y% + 1
        End If
        x% = x% + 1
        If o% = 0 Then x% = 1: y% = y% + 1
    Loop While y% <= FieldHeight%
    If f% = 0 Then Exit Sub

    If AirTime > 4 Then AirTime = 4
    Score& = Score& + f% * 100 * (5 - AirTime)
    n% = 0
    Do
        GoSub Shift
        n% = n% + 1
    Loop While n% < f%
    Exit Sub
    Shift:
    y% = c%(n%)
    xn% = 1: yn% = y%
    Do While yn% > 1
        Occupied%(xn%, yn%) = Occupied%(xn%, yn% - 1)
        xn% = xn% + 1
        If xn% > FieldWidth% Then xn% = 1: yn% = yn% - 1
    Loop
    RefreshField
    Return

End Sub

Sub CheckFinalMove
    ink$ = InKey$
    If ink$ = Chr$(0) + "K" Then
        MoveLeft
        lastmove% = 1
    End If
    If ink$ = Chr$(0) + "M" Then
        MoveRight
        lastmove% = 1
    End If
    If ink$ = Chr$(0) + "H" Then
        RotatePiece
        lastmove% = 1
    End If
    Exit Sub
End Sub

Sub CheckOverlap
    Dim As Integer xn(3), yn(3), s, xn, yn, xs, ys, maxn, n, c

    s% = 0
    xn% = PieceX%: yn% = PieceY%
    xs% = PieceData%(0, PieceR%, CurrentPiece% - 1)
    ys% = PieceData%(1, PieceR%, CurrentPiece% - 1)
    maxn% = xs% * ys%
    n% = 0
    Do
        c% = PieceData%(n% + 2, PieceR%, CurrentPiece% - 1)
        If c% = 0 Then
        Else
            xn%(s%) = xn%: yn%(s%) = yn%
            s% = s% + 1
        End If
        xn% = xn% + 1
        If xn% - PieceX% >= xs% Then xn% = PieceX%: yn% = yn% + 1
        n% = n% + 1
    Loop While n% < maxn%

    'Make Sure Piece Is In Bounds.
    'If not, return -1.
    n% = 0
    Overlap% = 0
    Do
        If xn%(n%) > FieldWidth% Then Overlap% = -1: Exit Sub
        If yn%(n%) > FieldHeight% Then Overlap% = -1: Exit Sub
        If xn%(n%) < 1 Then Overlap% = -1: Exit Sub
        If yn%(n%) < 1 Then Overlap% = -1: Exit Sub
        n% = n% + 1
    Loop While n% < 4

    'Check If This Location Would Overlap Another Piece.
    n% = 0
    Overlap% = 0
    Do
        If Occupied%(xn%(n%), yn%(n%)) = 0 Then
        Else
            Overlap% = Overlap% + 1
        End If
        n% = n% + 1
    Loop While n% < 4
End Sub

'This sub checks if the piece has landed on anything.
Sub CheckTouch
    Dim As Integer xSize, ySize, MaxY, xn, yn, maxn, n, c, e, lmtime

    'First, Check if piece has hit the bottom of the field.
    xSize% = PieceData%(0, PieceR%, CurrentPiece% - 1)
    ySize% = PieceData%(1, PieceR%, CurrentPiece% - 1)
    MaxY% = PieceY% + ySize%
    If MaxY% = FieldHeight% + 1 Then GoTo StopPiece

    'See if it has hit another piece.
    'Find Base Points
    Dim BaseX%(3), BaseY%(3) '4 is highest poss. number of base points.
    BaseX%(0) = PieceX%
    If xSize% > 1 Then BaseX%(1) = PieceX% + 1
    If xSize% > 2 Then BaseX%(2) = PieceX% + 2
    If xSize% > 3 Then BaseX%(3) = PieceX% + 3

    xn% = PieceX%: yn% = PieceY%
    maxn% = xSize% * ySize%
    n% = 0
    Do
        c% = PieceData%(n% + 2, PieceR%, CurrentPiece% - 1)
        If c% = 0 Then
        Else
            e% = xn% - PieceX%
            BaseY%(e%) = yn%
        End If
        xn% = xn% + 1
        If xn% - PieceX% >= xSize% Then xn% = PieceX%: yn% = yn% + 1
        n% = n% + 1
    Loop While n% < maxn%

    n% = 0
    Do
        If BaseX%(n%) = 0 Then
        Else
            If BaseY%(n%) > 0 Then
                If Occupied%(BaseX%(n%), BaseY%(n%) + 1) > 0 Then
                    If BaseY%(n%) < 2 Then GameOver% = 1: Exit Sub
                    GoTo StopPiece
                End If
            End If
        End If
        n% = n% + 1
    Loop While n% < 4

    Exit Sub
    StopPiece:
    If CPlay% = 0 Then
        lmtime = Timer
        Do
            lastmove% = 0
            CheckFinalMove
        Loop While Timer - lmtime < .5 And lastmove% = 0
    End If
    AirTime = Timer - PieceTime
    If AirTime > 7 Then AirTime = 7
    Score& = Score& + (8 - AirTime) * 5
    StoreOccupy
    RefreshField
    CheckComplete
    NewPiece
End Sub

Sub Colors (c As Integer, r As Integer, g As Integer, b As Integer)
    Out &H3C8, c%
    Out &H3C9, r%
    Out &H3C9, g%
    Out &H3C9, b%
End Sub

Sub CompComplete
    Dim As Integer x, y, f, o

    x% = 1: y% = 1: f% = 0
    Do
        o% = Occupied%(x%, y%)
        If x% = FieldWidth% And o% > 0 Then
            f% = f% + 1: x% = 0: y% = y% + 1
        End If
        x% = x% + 1
        If o% = 0 Then x% = 1: y% = y% + 1
    Loop While y% <= FieldHeight%
    NumComplete% = f%
End Sub

Sub CompeteScreen
    Dim As Integer size, x, y, sx, c
    Dim sc As String

    BlueColors
    Line (0, 0)-(640, 480), 1, BF
    gap% = 4: shadow% = 2
    DrawText 85, 25, "Competition Mode", 7, 4, 2
    size% = 6
    x% = 40: y% = 80
    sx% = x%: c% = 7
    Do
        Line (x% + 1 + shadow%, y% + 1 + shadow%)-(x% + size% + 1 + shadow%, y% + size% + 1 + shadow%), 0, BF
        Line (x% + 1, y% + 1)-(x% + size% - 1, y% + size% - 1), c%, BF
        Line (x%, y%)-(x% + size%, y%), 15
        Line (x%, y%)-(x%, y% + size%), 15
        Line (x% + size%, y%)-(x% + size%, y% + size%), 8
        Line (x%, y% + size%)-(x% + size%, y% + size%), 8
        x% = x% + size% + 1
    Loop While x% < 600
    gap% = 2: shadow% = 1
    DrawText 15, 460, "Future Software", 7, 1, 2
    DrawText 395, 460, "By Michael Fogleman", 7, 1, 2
    gap% = 4: shadow% = 1
    DrawText 80, 400, "PRESS ANY KEY TO CONTINUE", 7, 2, 2
    gap% = 4: shadow% = 2
    DrawText 80, 110, "YOU", 7, 4, 2
    DrawText 510, 110, "ME", 7, 4, 2
    DrawText 245, 150, "SCORE", 7, 4, 2
    DrawText 245, 270, "LINES", 7, 4, 2

    DrawText 5, 200, Str$(YourScore&), 7, 4, 2
    DrawText 5, 320, Str$(YourLines%), 7, 4, 2

    sc$ = Str$(Score&)
    Do While Len(sc$) < 11
        sc$ = " " + sc$
    Loop
    DrawText 280, 200, sc$, 7, 4, 2

    sc$ = Str$(Lines%)
    Do While Len(sc$) < 11
        sc$ = " " + sc$
    Loop
    DrawText 280, 320, sc$, 7, 4, 2
    RestoreColors

    Do
        ink$ = InKey$
    Loop While ink$ = ""

End Sub

'This is the brain! Computer plays tetris.
Sub ComputerPlay (nDisplay As Integer)
    Dim sTime As Double
    Dim As Integer xSize, ySize, PrevX, PrevY, PrevR, gaps, maxeval, mineval
    Dim As Integer n, xn, r, n1, n2, yn, maxn, bn, c, e, en

    'First, find all possible placement positions.
    sTime = Timer
    xSize% = PieceData%(0, PieceR%, CurrentPiece% - 1)
    ySize% = PieceData%(1, PieceR%, CurrentPiece% - 1)
    PrevX% = PieceX%
    PrevY% = PieceY%
    PrevR% = PieceR%
    'Dim picks%(100)
    Dim BaseX%(3), BaseY%(3)
    Dim PossibleX%(100)
    Dim PossibleY%(100)
    Dim PossibleR%(100)
    Dim Evaluation%(100)
    GoSub NegEval
    'X and R are the controlled variables, find Y for each combination.
    n% = 0
    xn% = 1
    Do
        r% = 0
        Do
            GoSub GetY
            PossibleX%(n%) = xn%
            PossibleY%(n%) = PieceY%
            PossibleR%(n%) = r%
            n% = n% + 1
            r% = r% + 1
        Loop While r% < 4
        xn% = xn% + 1
    Loop While xn% < FieldWidth% + 2

    'Now, evaluate each position. This is the tough part.
    'Copy the occupied array, so we can see if any moves complete a line.
    Dim TempOccupied%(FieldWidth%, FieldHeight%)
    n1% = 0: n2% = 0
    Do
        TempOccupied%(n1%, n2%) = Occupied%(n1%, n2%)
        n1% = n1% + 1
        If n1% > FieldWidth% Then n1% = 0: n2% = n2% + 1
    Loop While n2% <= FieldHeight%

    'Put each possible position/rotation in. Check for complete line.
    n% = 0
    Do
        PieceX% = PossibleX%(n%)
        PieceY% = PossibleY%(n%)
        PieceR% = PossibleR%(n%)
        If PieceY% > 0 Then
            'LOCATE 1, 40: PRINT PieceX%; PieceY%; PieceR%; n%
            Evaluation%(n%) = PieceY% * HeightWeight
            StoreOccupy
            CompComplete
            Evaluation%(n%) = Evaluation%(n%) + NumComplete% * LineWeight
            GoSub RestoreArray
        End If
        n% = n% + 1
    Loop While n% < 101
 
    'Check if next to any pieces.
    n% = 0
    Do
        PieceX% = PossibleX%(n%)
        PieceY% = PossibleY%(n%)
        PieceR% = PossibleR%(n%)
        xSize% = PieceData%(0, PieceR%, CurrentPiece% - 1)
        ySize% = PieceData%(1, PieceR%, CurrentPiece% - 1)
        Do
            If PieceX% - 1 > 0 And PieceX% - 1 <= FieldWidth% And PieceY% > 0 And PieceY% <= FieldHeight% Then
                'DrawBlock PieceX% - 1, PieceY%, -1
                If Occupied%(PieceX% - 1, PieceY%) > 0 Then
                    Evaluation%(n%) = Evaluation%(n%) + SideWeight
                End If
            End If
            If PieceX% + xSize% > 0 And PieceX% + xSize% <= FieldWidth% And PieceY% > 0 And PieceY% <= FieldHeight% Then
                'DrawBlock PieceX% - 1, PieceY%, -1
                If Occupied%(PieceX% + xSize%, PieceY%) > 0 Then
                    Evaluation%(n%) = Evaluation%(n%) + SideWeight
                End If
            End If
            PieceY% = PieceY% + 1
        Loop While PieceY% - PossibleY%(n%) < ySize%
        n% = n% + 1
    Loop While n% < 101


    'Check For Gaps Under Piece.
    'This is similar to CheckTouch Sub.
    n% = 0
    Do
        PieceX% = PossibleX%(n%)
        PieceY% = PossibleY%(n%)
        PieceR% = PossibleR%(n%)
        If PieceY% > 0 Then
            xSize% = PieceData%(0, PieceR%, CurrentPiece% - 1)
            ySize% = PieceData%(1, PieceR%, CurrentPiece% - 1)
            BaseX%(0) = 0: BaseX%(1) = 0: BaseX%(2) = 0: BaseX%(3) = 0
            BaseY%(0) = 0: BaseY%(1) = 0: BaseY%(2) = 0: BaseY%(3) = 0
            BaseX%(0) = PieceX%
            If xSize% > 1 Then BaseX%(1) = PieceX% + 1
            If xSize% > 2 Then BaseX%(2) = PieceX% + 2
            If xSize% > 3 Then BaseX%(3) = PieceX% + 3
            xn% = PieceX%: yn% = PieceY%
            maxn% = xSize% * ySize%
            bn% = 0
            Do
                c% = PieceData%(bn% + 2, PieceR%, CurrentPiece% - 1)
                If c% = 0 Then
                Else
                    e% = xn% - PieceX%
                    BaseY%(e%) = yn%
                End If
                xn% = xn% + 1
                If xn% - PieceX% >= xSize% Then xn% = PieceX%: yn% = yn% + 1
                bn% = bn% + 1
            Loop While bn% < maxn%

            gaps% = 0
            bn% = 0
            Do
                If BaseX%(bn%) = 0 Then
                Else
                    If BaseY%(bn%) > 0 And BaseY%(bn%) < FieldHeight% Then
                        If Occupied%(BaseX%(bn%), BaseY%(bn%) + 1) = 0 Then
                            gaps% = gaps% + 1
                        End If
                    End If
                End If
                bn% = bn% + 1
            Loop While bn% < 4
            Evaluation%(n%) = Evaluation%(n%) - gaps% * GapWeight
        End If
        n% = n% + 1
    Loop While n% < 101
 
    'Find Max/Min Evaluation.
    n% = 0
    maxeval% = -1000
    mineval% = 1000
    Do
        If Evaluation%(n%) < mineval% Then mineval% = Evaluation%(n%)
        If Evaluation%(n%) > maxeval% Then
            maxeval% = Evaluation%(n%)
        End If
        n% = n% + 1
    Loop While n% < 101

    Do
        n% = Rnd * 100
    Loop While Evaluation%(n%) < maxeval% Or PossibleX%(n%) = 0 Or PossibleY%(n%) = 0
    PieceX% = PossibleX%(n%)
    PieceY% = PossibleY%(n%)
    PieceR% = PossibleR%(n%)
    If nDisplay% = 1 Then
        DrawPiece PieceX%, PieceY%, CurrentPiece%, PieceR%, -1
    End If
    'LOCATE 13, 73: PRINT USING "#####"; Evaluation%(n%)

    'Rid of unnecessary rotation.
    If CurrentPiece% = 1 Or CurrentPiece% = 2 Or CurrentPiece% = 4 Then
        If PieceR% = 3 Then PieceR% = 1
        If PieceR% = 2 Then PieceR% = 0
    End If
    If CurrentPiece% = 3 Then PieceR% = 0

    'n% = 0
    'DO
    PieceX% = PossibleX%(n%)
    PieceY% = PossibleY%(n%)
    PieceR% = PossibleR%(n%)
    xSize% = PieceData%(0, PieceR%, CurrentPiece% - 1)
    ySize% = PieceData%(1, PieceR%, CurrentPiece% - 1)
    Do
        If PieceX% - 1 > 0 And PieceX% - 1 <= FieldWidth% And PieceY% > 0 And PieceY% <= FieldHeight% Then
            'DrawBlock PieceX% - 1, PieceY%, -1
            If Occupied%(PieceX% - 1, PieceY%) > 0 Then
                Evaluation%(n%) = Evaluation%(n%) + SideWeight
            End If
        End If
        If PieceX% + xSize% > 0 And PieceX% + xSize% <= FieldWidth% And PieceY% > 0 And PieceY% <= FieldHeight% Then
            'DrawBlock PieceX% + XSize%, PieceY%, -1
            If Occupied%(PieceX% + xSize%, PieceY%) > 0 Then
                Evaluation%(n%) = Evaluation%(n%) + SideWeight
            End If
        End If
        PieceY% = PieceY% + 1
    Loop While PieceY% - PossibleY%(n%) < ySize%
    'n% = n% + 1
    'LOOP WHILE n% < 101


    DestX% = PieceX%
    DestY% = PieceY%
    DestR% = PieceR%

    PieceX% = PrevX%
    PieceY% = PrevY%
    PieceR% = PrevR%
    Exit Sub

    GetY:
    yn% = 1
    PieceX% = xn%
    PieceY% = yn%
    PieceR% = r%
    CheckOverlap
    If Overlap% = 0 Then
    Else
        PieceY% = 0
        Return
    End If
    Do
        PieceY% = PieceY% + 1
        CheckOverlap
    Loop While Overlap% = 0
    PieceY% = PieceY% - 1
    Return
    RestoreArray:
    n1% = 0: n2% = 0
    Do
        Occupied%(n1%, n2%) = TempOccupied%(n1%, n2%)
        n1% = n1% + 1
        If n1% > FieldWidth% Then n1% = 0: n2% = n2% + 1
    Loop While n2% <= FieldHeight%
    Return
    NegEval:
    en% = 0
    Do
        Evaluation%(en%) = -100
        en% = en% + 1
    Loop While en% < 101
    Return
End Sub

Sub DebugDisplay
    Locate 1, 1
    Print "Debugging"
    Print "   Information"
    Print
    Print "X       :"; PieceX%
    Print "Y       :"; PieceY%
    Print "Piece   :"; CurrentPiece%
    Print "Rotation:"; PieceR%
    Print
    Print "Field Width :"; FieldWidth%
    Print "Field Height:"; FieldHeight%
    Print
    Print "Field Coordinates:"
    Print " X1:"; 320 - XOffset%
    Print " Y1:"; 240 - YOffset%
    Print " X2:"; 320 + XOffset%
    Print " Y2:"; 240 + YOffset%
End Sub

Sub DrawBlock (xn As Integer, yn As Integer, c As Integer)
    Dim As Integer x, y

    If xn% < 1 Or yn% < 1 Then Exit Sub
    If CurrentColor%(xn%, yn%) = c% Then Exit Sub
    CurrentColor%(xn%, yn%) = c%
    If xn% > FieldWidth% Or yn% > FieldHeight% Then Exit Sub
    x% = 320 - XOffset% + 1 + (xn% - 1) * (BlockSize% + 2) - XShift%
    y% = 240 - YOffset% + 1 + (yn% - 1) * (BlockSize% + 2)
    'IF c% > -1 THEN LINE (x%, y%)-(x% + BlockSize%, y% + BlockSize%), c%, BF
    If c% = 0 Then Line (x%, y%)-(x% + BlockSize%, y% + BlockSize%), c%, BF
    If c% > 0 Then
        Line (x% + 1, y% + 1)-(x% + BlockSize% - 1, y% + BlockSize% - 1), c%, BF
        Line (x%, y%)-(x% + BlockSize%, y%), 15
        Line (x%, y%)-(x%, y% + BlockSize%), 15
        Line (x% + BlockSize%, y%)-(x% + BlockSize%, y% + BlockSize%), 8
        Line (x%, y% + BlockSize%)-(x% + BlockSize%, y% + BlockSize%), 8
    End If
    If c% = -1 Then Line (x%, y%)-(x% + BlockSize%, y% + BlockSize%), 15, B
End Sub

Sub DrawBlock2 (x As Integer, y As Integer, c As Integer)
    If c% = 0 Then Line (x%, y%)-(x% + 16, y% + 16), c%, BF
    If c% > 0 Then
        Line (x% + 1, y% + 1)-(x% + 16 - 1, y% + 16 - 1), c%, BF
        Line (x%, y%)-(x% + 16, y%), 15
        Line (x%, y%)-(x%, y% + 16), 15
        Line (x% + 16, y%)-(x% + 16, y% + 16), 8
        Line (x%, y% + 16)-(x% + 16, y% + 16), 8
    End If
    If c% = -1 Then Line (x%, y%)-(x% + 16, y% + 16), 15, B
End Sub

Sub DrawField
    Dim As Integer size, x, y, sx, c, x1, y1, x2, y2

    BlueColors
    size% = 67
    x% = -1 * size% / 2: y% = -1 * size% / 2
    sx% = x%
    c% = Rnd * 4
    If c% = 4 Then c% = 7
    Do
        Line (x% + 1, y% + 1)-(x% + size% - 1, y% + size% - 1), c%, BF
        Line (x%, y%)-(x% + size%, y%), 15
        Line (x%, y%)-(x%, y% + size%), 15
        Line (x% + size%, y%)-(x% + size%, y% + size%), 8
        Line (x%, y% + size%)-(x% + size%, y% + size%), 8
        x% = x% + size% + 2
        If x% > 640 Then x% = sx%: y% = y% + size% + 2
    Loop While y% < 480

    Line (320 - XOffset% - XShift% - 4, 240 - YOffset% - 4)-(320 + XOffset% - XShift% + 4, 240 + YOffset% + 4), 0, BF
    Line (320 - XOffset% - XShift% - 4, 240 - YOffset% - 4)-(320 + XOffset% - XShift% + 4, 240 + YOffset% + 4), 15, B
    Line (320 - XOffset% - XShift% - 2, 240 - YOffset% - 2)-(320 + XOffset% - XShift% + 2, 240 + YOffset% + 2), 7, B
    Line (DispX% - 4, DispY% - 4)-(DispX% + DispWidth% + 4, DispY% + DispHeight% + 4), 0, BF
    Line (DispX% - 2, DispY% - 2)-(DispX% + DispWidth% + 2, DispY% + DispHeight% + 2), 7, B
    Line (DispX% - 4, DispY% - 4)-(DispX% + DispWidth% + 4, DispY% + DispHeight% + 4), 15, B
    'LOCATE 3, 61: PRINT "Score:"
    'LOCATE 4, 69: PRINT USING "#########"; 0
    'LOCATE 6, 61: PRINT "Lines Cleared:"
    'LOCATE 7, 73: PRINT USING "#####"; 0
    'LOCATE 9, 61: PRINT "Game Time:"
    'LOCATE 10, 73: PRINT USING "#####"; 0
    'LOCATE 12, 61: PRINT "Evaluation:"

    gap% = 2: shadow% = 1
    DrawText DispX% + 7, 25, "SCORE", 7, 1, 2
    DrawText DispX% + 7, 95, "LINES", 7, 1, 2
    DrawText DispX% + 7, 165, "TIME", 7, 1, 2
    DrawText DispX% + 7, 355, "NEXT PIECE", 7, 1, 2
    DrawText DispX% + 7, 237, "PIECES", 7, 1, 2

    If Grid% = 1 Then
        x1% = 320 - XOffset%: y1% = 240 - YOffset%
        x2% = 320 + XOffset%: y2% = 240 + YOffset%
        Do
            Line (x1%, y1%)-(x1%, y2%), 8
            x1% = x1% + BlockSize% + 2
        Loop While x1% < x2%

        x1% = 320 - XOffset%: y1% = 240 - YOffset%
        x2% = 320 + XOffset%: y2% = 240 + YOffset%
        Do
            Line (x1%, y1%)-(x2%, y1%), 8
            y1% = y1% + BlockSize% + 2
        Loop While y1% < y2%
    End If
    RestoreColors
End Sub

Sub DrawLetter (x As Integer, y As Integer, letter As Integer, c As Integer, size As Integer, typ As Integer)
    Dim As Integer sx, sy, xn, yn, n, d

    sx% = x%: sy% = y%
    xn% = 0: yn% = 0
    n% = 0
    Do
        d% = Text%(letter%, n%)
        If d% = 1 Then
            If typ% = 0 Then
                Line (x% + 1, y% + 1)-(x% + size% - 1, y% + size% - 1), c%, BF
                Line (x%, y%)-(x% + size%, y%), 15
                Line (x%, y%)-(x%, y% + size%), 15
                Line (x% + size%, y%)-(x% + size%, y% + size%), 8
                Line (x%, y% + size%)-(x% + size%, y% + size%), 8
            End If
            If typ% = 1 Then
                Line (x%, y%)-(x% + size%, y% + size%), c%, BF
            End If
            If typ% = 2 Then
                Line (x% + 1 + shadow%, y% + 1 + shadow%)-(x% + size% + 1 + shadow%, y% + size% + 1 + shadow%), 0, BF
                Line (x% + 1, y% + 1)-(x% + size% - 1, y% + size% - 1), c%, BF
                Line (x%, y%)-(x% + size%, y%), 15
                Line (x%, y%)-(x%, y% + size%), 15
                Line (x% + size%, y%)-(x% + size%, y% + size%), 8
                Line (x%, y% + size%)-(x% + size%, y% + size%), 8
            End If
        End If
        n% = n% + 1
        xn% = xn% + 1
        x% = x% + size% + 1
        If xn% > 4 Then xn% = 0: x% = sx%: y% = y% + size% + 1
    Loop While n% < 35
End Sub

Sub DrawPiece (xn As Integer, yn As Integer, piece As Integer, r As Integer, col As Integer)
    Dim As Integer x, y, Xs, Ys, n, c, dc

    x% = xn%: y% = yn%
    Xs% = PieceData%(0, r%, piece% - 1)
    Ys% = PieceData%(1, r%, piece% - 1)
    n% = 0
    Do
        c% = PieceData%(n% + 2, r%, piece% - 1)
        dc% = 0
        If c% = 0 Then Else dc% = 1
        If dc% = 1 Then DrawBlock xn%, yn%, col%
        xn% = xn% + 1
        If xn% - x% >= Xs% Then xn% = x%: yn% = yn% + 1
        n% = n% + 1
    Loop While yn% < y% + Ys%
End Sub

Sub DrawPiece2 (px As Integer, py As Integer, piece As Integer, col As Integer)
    Dim As Integer x, y, xn, yn, Xs, Ys, n, c, dc

    x% = px%: y% = py%
    xn% = 0: yn% = 0
    Xs% = PieceData%(0, 1, piece% - 1)
    Ys% = PieceData%(1, 1, piece% - 1)
    n% = 0
    Do
        c% = PieceData%(n% + 2, 1, piece% - 1)
        dc% = 0
        If c% = 0 Then Else dc% = 1
        If dc% = 1 Then DrawBlock2 x%, y%, col%
        x% = x% + 18 'BlockSize% + 2
        xn% = xn% + 1
        If xn% >= Xs% Then xn% = 0: x% = px%: y% = y% + 18: yn% = yn% + 1
        n% = n% + 1
    Loop While yn% < Ys%
End Sub

Sub DrawText (x As Integer, y As Integer, txt As String, c As Integer, size As Integer, typ As Integer)
    Dim As Integer sx, sy, n, t
    Dim s As String

    txt$ = UCase$(txt$)
    sx% = x%: sy% = y%
    n% = 1
    Do
        s = Mid$(txt$, n%, 1)
        t% = Asc(s)
        If t% = 32 Then GoTo Skip
        If t% = 41 Then t% = 36
        If t% = 46 Then t% = 37
        If t% = 43 Then t% = 38
        If t% = 45 Then t% = 39
        If t% > 64 And t% < 91 Then
            t% = t% - 65
        End If
        If t% > 47 And t% < 58 Then
            t% = t% - 22
        End If
        DrawLetter x%, y%, t%, c%, size%, typ%
        Skip:
        y% = sy%
        x% = x% + (size% + 1) * 5 + gap%
        n% = n% + 1
    Loop While n% < Len(txt$) + 1
End Sub

Sub GameOverScreen
    Dim As Integer gap, size, x, y, sx, c
    Dim sc As String

    BlueColors
    Line (0, 0)-(640, 480), 1, BF
    gap% = 6: shadow% = 3
    DrawText 135, 20, "Game Over", 7, 6, 2
    size% = 6
    x% = 40: y% = 80
    sx% = x%: c% = 7
    Do
        Line (x% + 1 + shadow%, y% + 1 + shadow%)-(x% + size% + 1 + shadow%, y% + size% + 1 + shadow%), 0, BF
        Line (x% + 1, y% + 1)-(x% + size% - 1, y% + size% - 1), c%, BF
        Line (x%, y%)-(x% + size%, y%), 15
        Line (x%, y%)-(x%, y% + size%), 15
        Line (x% + size%, y%)-(x% + size%, y% + size%), 8
        Line (x%, y% + size%)-(x% + size%, y% + size%), 8
        x% = x% + size% + 1
    Loop While x% < 600
    gap% = 2: shadow% = 1
    DrawText 15, 460, "Future Software", 7, 1, 2
    DrawText 395, 460, "By Michael Fogleman", 7, 1, 2
    gap% = 4: shadow% = 1
    DrawText 80, 400, "PRESS ANY KEY TO CONTINUE", 7, 2, 2

    gap% = 4: shadow% = 2
    DrawText 65, 120, "Score", 7, 4, 2
    DrawText 65, 180, "Lines", 7, 4, 2
    DrawText 65, 240, "Time", 7, 4, 2
    DrawText 65, 300, "Pieces", 7, 4, 2

    sc$ = Str$(Score&)
    Do While Len(sc$) < 11
        sc$ = " " + sc$
    Loop
    DrawText 265, 120, sc$, 7, 4, 2

    sc$ = Str$(Lines%)
    Do While Len(sc$) < 11
        sc$ = " " + sc$
    Loop
    DrawText 265, 180, sc$, 7, 4, 2

    sc$ = Str$(GameTime)
    Do While Len(sc$) < 11
        sc$ = " " + sc$
    Loop
    DrawText 265, 240, sc$, 7, 4, 2

    sc$ = Str$(Pieces&)
    Do While Len(sc$) < 11
        sc$ = " " + sc$
    Loop
    DrawText 265, 300, sc$, 7, 4, 2
    RestoreColors

    Do
        ink$ = InKey$
    Loop While ink$ = ""

End Sub

Sub GetPal
    Dim As Integer n, c, rr, gg, bb

    n% = 0: c% = 0
    Do
        Out &H3C6, &HFF
        Out &H3C7, c%
        rr% = Inp(&H3C9)
        gg% = Inp(&H3C9)
        bb% = Inp(&H3C9)
        pal%(n%) = rr%
        pal%(n% + 1) = gg%
        pal%(n% + 2) = bb%
        n% = n% + 3: c% = c% + 1
    Loop While c% < 16
End Sub

Sub InfoDisplay
    Dim sc As String

    'LOCATE 4, 69: PRINT USING "#########"; Score&
    'LOCATE 7, 73: PRINT USING "#####"; Lines%
    'LOCATE 10, 73: PRINT USING "#####"; GameTime&
    gap% = 2: shadow% = 1

    If Score& = Score2& Then
    Else
        Line (DispX% + 5, 44)-(DispX% + DispWidth% - 2, 62), 0, BF
        sc$ = Str$(Score&)
        Do While Len(sc$) < 11
            sc$ = " " + sc$
        Loop
        DrawText DispX% + 9, 45, sc$, 7, 1, 2
        Score2& = Score&
    End If

    If Lines% = Lines2% Then
    Else
        Line (DispX% + 5, 114)-(DispX% + DispWidth% - 2, 132), 0, BF
        sc$ = Str$(Lines%)
        Do While Len(sc$) < 11
            sc$ = " " + sc$
        Loop
        DrawText DispX% + 9, 115, sc$, 7, 1, 2
        Lines2% = Lines%
    End If

    If GameTime = GameTime2 Then
    Else
        Line (DispX% + 5, 184)-(DispX% + DispWidth% - 2, 202), 0, BF
        sc$ = Str$(GameTime)
        Do While Len(sc$) < 11
            sc$ = " " + sc$
        Loop
        DrawText DispX% + 9, 185, sc$, 7, 1, 2
        GameTime2 = GameTime
    End If

    If Pieces& = Pieces2& Then
    Else
        Line (DispX% + 5, 254)-(DispX% + DispWidth% - 2, 272), 0, BF
        sc$ = Str$(Pieces&)
        Do While Len(sc$) < 11
            sc$ = " " + sc$
        Loop
        DrawText DispX% + 9, 255, sc$, 7, 1, 2
        Pieces2& = Pieces&
    End If

End Sub

Sub MainLoop
    Dim As Integer CPlay, x, y, p, r, c, cmove, a
    Dim PauseTime As Double, sTime As Double, cTime As Double
    Dim k As String

    OldPiece% = 1
    Do

        If CPlay% = 0 Then PauseTime = .225 Else PauseTime = 0
        sTime = Timer
        Do

            x% = OldX%: y% = OldY%: p% = OldPiece%: r% = OldR%
            'Delay .01

            GameTime = Timer - StartTime
            InfoDisplay

            Wait 986, 8
            DrawPiece x%, y%, p%, r%, 0
            x% = PieceX%: y% = PieceY%: p% = CurrentPiece%: r% = PieceR%: c% = PieceC%
            DrawPiece x%, y%, p%, r%, c%
            If Debug% = 1 Then DebugDisplay
            CheckTouch
            If GameOver% = 1 Then Exit Sub
            OldX% = PieceX%: OldY% = PieceY%: OldPiece% = CurrentPiece%: OldR% = PieceR%

            Do
                ink$ = InKey$
                If ink$ = Chr$(27) Then GameOver% = 1
                cmove% = 0
                If CPlay% = 1 Then
                    If Timer - cTime > -1 Then
                        If cmove% = 0 Then
                            If PieceR% = DestR% Then
                            Else
                                'RotatePiece
                                ink$ = Chr$(0) + "H"
                                cmove% = 1
                                cTime = Timer
                            End If
                        End If
                        If PieceX% < DestX% And cmove% = 0 Then
                            'MoveRight
                            ink$ = Chr$(0) + "M"
                            cmove% = 1
                            cTime = Timer
                        End If
                        If PieceX% > DestX% And cmove% = 0 Then
                            'MoveLeft
                            ink$ = Chr$(0) + "K"
                            cmove% = 1
                            cTime = Timer
                        End If
                    End If
                End If
            Loop While Timer - sTime < PauseTime And ink$ = ""

            usery% = 0
            If ink$ = Chr$(0) + "P" Then
                PieceY% = PieceY% + 1
                usery% = 1
            End If
            If ink$ = Chr$(0) + "K" Then
                MoveLeft
            End If
            If ink$ = Chr$(0) + "M" Then
                MoveRight
            End If
            If ink$ = Chr$(0) + "H" Then
                RotatePiece
            End If
            For a = 1 To 15
                k = InKey$
            Next
        Loop While Timer - sTime < PauseTime
        If Compete% = 1 Then
            If CMN% > competen% Then Exit Sub
        End If
        If usery% = 0 Then PieceY% = PieceY% + 1
    Loop
End Sub

Sub Menu
    Dim As Integer size, x, y, sx, c

    lblMenu:
    BlueColors
    Line (0, 0)-(640, 480), 1, BF
    gap% = 6: shadow% = 3
    DrawText 55, 20, "Future Blocks", 7, 6, 2
    gap% = 4: shadow% = 2
    DrawText 65, 110, "1.Normal Game Mode", 7, 3, 2
    DrawText 65, 160, "2.Hint Mode", 7, 3, 2
    DrawText 65, 210, "3.Computer Mode", 7, 3, 2
    DrawText 65, 260, "4.Competition Mode", 7, 3, 2
    DrawText 65, 310, "5.Options", 7, 3, 2
    DrawText 65, 360, "6.Exit", 7, 3, 2
    gap% = 2: shadow% = 1
    DrawText 15, 460, "Future Software", 7, 1, 2
    DrawText 395, 460, "By Michael Fogleman", 7, 1, 2

    size% = 6
    x% = 40: y% = 80
    sx% = x%: c% = 7
    Do
        Line (x% + 1 + shadow%, y% + 1 + shadow%)-(x% + size% + 1 + shadow%, y% + size% + 1 + shadow%), 0, BF
        Line (x% + 1, y% + 1)-(x% + size% - 1, y% + size% - 1), c%, BF
        Line (x%, y%)-(x% + size%, y%), 15
        Line (x%, y%)-(x%, y% + size%), 15
        Line (x% + size%, y%)-(x% + size%, y% + size%), 8
        Line (x%, y% + size%)-(x% + size%, y% + size%), 8
        x% = x% + size% + 1
    Loop While x% < 600
    RestoreColors
    BadKey:
    Do
        ink$ = InKey$
    Loop While ink$ = ""
    If ink$ = "1" Then hint% = 0: CPlay% = 0: Exit Sub
    If ink$ = "2" Then hint% = 1: CPlay% = 0: Exit Sub
    If ink$ = "3" Then hint% = 0: CPlay% = 1: Exit Sub
    If ink$ = "4" Then GoTo Compete
    If ink$ = "5" Then GoTo Options
    If ink$ = "6" Then Cls: System 0
    GoTo BadKey

    Compete:
    BlueColors
    Line (0, 0)-(640, 480), 1, BF
    Compete% = 1
    GoSub Header
    gap% = 4: shadow% = 2
    DrawText 85, 115, "Competition Mode", 7, 4, 2
    DrawText 230, 180, "Play to", 7, 3, 2
    DrawText 265, 220, Str$(competen%), 7, 3, 2
    DrawText 240, 260, "Blocks", 7, 3, 2
    GoSub InfoHeader
    RestoreColors
    Do
        ink$ = InKey$
        If ink$ = "+" Then
            competen% = competen% + 1
            Line (260, 218)-(400, 255), 1, BF
            DrawText 265, 220, Str$(competen%), 7, 3, 2
        End If
        If ink$ = "-" Then
            competen% = competen% - 1
            Line (260, 218)-(400, 255), 1, BF
            DrawText 265, 220, Str$(competen%), 7, 3, 2
        End If
    Loop While Not ink$ = Chr$(27)
    Exit Sub

    Options:
    BlueColors
    GoSub Header
    gap% = 4: shadow% = 2
    DrawText 65, 100, "1.PreStack", 7, 3, 2
    DrawText 465, 100, Str$(messyheight%), 7, 3, 2
    DrawText 65, 140, "2.Field Width", 7, 3, 2
    DrawText 465, 140, Str$(FieldWidth%), 7, 3, 2
    DrawText 65, 180, "3.Field Height", 7, 3, 2
    DrawText 465, 180, Str$(FieldHeight%), 7, 3, 2
    DrawText 65, 220, "4.Block Size", 7, 3, 2
    DrawText 465, 220, Str$(BlockSize%), 7, 3, 2
    DrawText 65, 260, "5.Line Weight", 7, 3, 2
    DrawText 465, 260, Str$(LineWeight), 7, 3, 2
    DrawText 65, 300, "6.Gap Weight", 7, 3, 2
    DrawText 465, 300, Str$(GapWeight), 7, 3, 2
    DrawText 65, 340, "7.Stack Weight", 7, 3, 2
    DrawText 465, 340, Str$(HeightWeight), 7, 3, 2
    DrawText 65, 380, "8.Side Weight", 7, 3, 2
    DrawText 465, 380, Str$(SideWeight), 7, 3, 2
    DrawText 65, 420, "9.Menu", 7, 3, 2
    gap% = 2: shadow% = 1
    DrawText 15, 460, "Future Software", 7, 1, 2
    DrawText 395, 460, "By Michael Fogleman", 7, 1, 2
    RestoreColors
    BadKey2:
    Do
        ink$ = InKey$
    Loop While ink$ = ""
    If ink$ = "9" Then GoTo lblMenu
    If ink$ = "1" Then
        BlueColors
        GoSub Header
        GoSub InfoHeader
        gap% = 4: shadow% = 2
        DrawText 65, 200, "PreStack", 7, 3, 2
        DrawText 465, 200, Str$(messyheight%), 7, 3, 2
        RestoreColors
        Do
            ink$ = InKey$
            If ink$ = "+" Then
                messyheight% = messyheight% + 1
                Line (460, 190)-(639, 230), 1, BF
                DrawText 465, 200, Str$(messyheight%), 7, 3, 2
            End If
            If ink$ = "-" Then
                messyheight% = messyheight% - 1
                Line (460, 190)-(639, 230), 1, BF
                DrawText 465, 200, Str$(messyheight%), 7, 3, 2
            End If
        Loop While Not ink$ = Chr$(27)
        GoTo Options
    End If

    If ink$ = "2" Then
        BlueColors
        GoSub Header
        GoSub InfoHeader
        gap% = 4: shadow% = 2
        DrawText 65, 200, "Field Width", 7, 3, 2
        DrawText 465, 200, Str$(FieldWidth%), 7, 3, 2
        RestoreColors
        Do
            ink$ = InKey$
            If ink$ = "+" Then
                FieldWidth% = FieldWidth% + 1
                Line (460, 190)-(639, 230), 1, BF
                DrawText 465, 200, Str$(FieldWidth%), 7, 3, 2
            End If
            If ink$ = "-" Then
                FieldWidth% = FieldWidth% - 1
                Line (460, 190)-(639, 230), 1, BF
                DrawText 465, 200, Str$(FieldWidth%), 7, 3, 2
            End If
        Loop While Not ink$ = Chr$(27)
        GoTo Options
    End If

    If ink$ = "3" Then
        BlueColors
        GoSub Header
        GoSub InfoHeader
        gap% = 4: shadow% = 2
        DrawText 65, 200, "Field Height", 7, 3, 2
        DrawText 465, 200, Str$(FieldHeight%), 7, 3, 2
        RestoreColors
        Do
            ink$ = InKey$
            If ink$ = "+" Then
                FieldHeight% = FieldHeight% + 1
                Line (460, 190)-(639, 230), 1, BF
                DrawText 465, 200, Str$(FieldHeight%), 7, 3, 2
            End If
            If ink$ = "-" Then
                FieldHeight% = FieldHeight% - 1
                Line (460, 190)-(639, 230), 1, BF
                DrawText 465, 200, Str$(FieldHeight%), 7, 3, 2
            End If
        Loop While Not ink$ = Chr$(27)
        GoTo Options
    End If

    If ink$ = "4" Then
        BlueColors
        GoSub Header
        GoSub InfoHeader
        gap% = 4: shadow% = 2
        DrawText 65, 200, "Block Size", 7, 3, 2
        DrawText 465, 200, Str$(BlockSize%), 7, 3, 2
        RestoreColors
        Do
            ink$ = InKey$
            If ink$ = "+" Then
                BlockSize% = BlockSize% + 1
                Line (460, 190)-(639, 230), 1, BF
                DrawText 465, 200, Str$(BlockSize%), 7, 3, 2
            End If
            If ink$ = "-" Then
                BlockSize% = BlockSize% - 1
                Line (460, 190)-(639, 230), 1, BF
                DrawText 465, 200, Str$(BlockSize%), 7, 3, 2
            End If
        Loop While Not ink$ = Chr$(27)
        GoTo Options
    End If

    If ink$ = "5" Then
        BlueColors
        GoSub Header
        GoSub InfoHeader
        gap% = 4: shadow% = 2
        DrawText 65, 200, "Line Weight", 7, 3, 2
        DrawText 465, 200, Str$(LineWeight), 7, 3, 2
        RestoreColors
        Do
            ink$ = InKey$
            If ink$ = "+" Then
                LineWeight = LineWeight + 1
                Line (460, 190)-(639, 230), 1, BF
                DrawText 465, 200, Str$(LineWeight), 7, 3, 2
            End If
            If ink$ = "-" Then
                LineWeight = LineWeight - 1
                Line (460, 190)-(639, 230), 1, BF
                DrawText 465, 200, Str$(LineWeight), 7, 3, 2
            End If
        Loop While Not ink$ = Chr$(27)
        GoTo Options
    End If

    If ink$ = "6" Then
        BlueColors
        GoSub Header
        GoSub InfoHeader
        gap% = 4: shadow% = 2
        DrawText 65, 200, "Gap Weight", 7, 3, 2
        DrawText 465, 200, Str$(GapWeight), 7, 3, 2
        RestoreColors
        Do
            ink$ = InKey$
            If ink$ = "+" Then
                GapWeight = GapWeight + 1
                Line (460, 190)-(639, 230), 1, BF
                DrawText 465, 200, Str$(GapWeight), 7, 3, 2
            End If
            If ink$ = "-" Then
                GapWeight = GapWeight - 1
                Line (460, 190)-(639, 230), 1, BF
                DrawText 465, 200, Str$(GapWeight), 7, 3, 2
            End If
        Loop While Not ink$ = Chr$(27)
        GoTo Options
    End If

    If ink$ = "7" Then
        BlueColors
        GoSub Header
        GoSub InfoHeader
        gap% = 4: shadow% = 2
        DrawText 65, 200, "Stack Weight", 7, 3, 2
        DrawText 465, 200, Str$(HeightWeight), 7, 3, 2
        RestoreColors
        Do
            ink$ = InKey$
            If ink$ = "+" Then
                HeightWeight = HeightWeight + 1
                Line (460, 190)-(639, 230), 1, BF
                DrawText 465, 200, Str$(HeightWeight), 7, 3, 2
            End If
            If ink$ = "-" Then
                HeightWeight = HeightWeight - 1
                Line (460, 190)-(639, 230), 1, BF
                DrawText 465, 200, Str$(HeightWeight), 7, 3, 2
            End If
        Loop While Not ink$ = Chr$(27)
        GoTo Options
    End If

    If ink$ = "8" Then
        BlueColors
        GoSub Header
        GoSub InfoHeader
        gap% = 4: shadow% = 2
        DrawText 65, 200, "Side Weight", 7, 3, 2
        DrawText 465, 200, Str$(SideWeight), 7, 3, 2
        RestoreColors
        Do
            ink$ = InKey$
            If ink$ = "+" Then
                SideWeight = SideWeight + 1
                Line (460, 190)-(639, 230), 1, BF
                DrawText 465, 200, Str$(SideWeight), 7, 3, 2
            End If
            If ink$ = "-" Then
                SideWeight = SideWeight - 1
                Line (460, 190)-(639, 230), 1, BF
                DrawText 465, 200, Str$(SideWeight), 7, 3, 2
            End If
        Loop While Not ink$ = Chr$(27)
        GoTo Options
    End If
    GoTo BadKey2
 
    InfoHeader:
    gap% = 4: shadow% = 2
    DrawText 115, 360, "Use + and - To Change", 7, 2, 2
    DrawText 135, 390, "Press ESC When Done", 7, 2, 2
    gap% = 2: shadow% = 1
    DrawText 15, 460, "Future Software", 7, 1, 2
    DrawText 395, 460, "By Michael Fogleman", 7, 1, 2
    Return
    Header:
    Line (0, 0)-(640, 480), 1, BF
    gap% = 6: shadow% = 3 '2
    DrawText 55, 20, "Future Blocks", 7, 6, 2
    size% = 6
    x% = 40: y% = 80
    sx% = x%: c% = 7
    Do
        Line (x% + 1 + shadow%, y% + 1 + shadow%)-(x% + size% + 1 + shadow%, y% + size% + 1 + shadow%), 0, BF
        Line (x% + 1, y% + 1)-(x% + size% - 1, y% + size% - 1), c%, BF
        Line (x%, y%)-(x% + size%, y%), 15
        Line (x%, y%)-(x%, y% + size%), 15
        Line (x% + size%, y%)-(x% + size%, y% + size%), 8
        Line (x%, y% + size%)-(x% + size%, y% + size%), 8
        x% = x% + size% + 1
    Loop While x% < 600
    Return
End Sub

Sub MoveLeft
    Dim As Integer PrevX

    PrevX% = PieceX%
    If PieceX% > 1 Then PieceX% = PieceX% - 1
    Overlap% = 0
    CheckOverlap
    If Overlap% = 0 Then Else PieceX% = PrevX%
End Sub

Sub MoveRight
    Dim As Integer PrevX, XSize

    PrevX% = PieceX%
    XSize% = PieceData%(0, PieceR%, CurrentPiece% - 1)
    If PieceX% <= FieldWidth% - XSize% Then PieceX% = PieceX% + 1
    Overlap% = 0
    CheckOverlap
    If Overlap% = 0 Then Else PieceX% = PrevX%
End Sub

Sub NewPiece
    Dim As Integer XSize, YSize, Xs

    Pieces& = Pieces& + 1
    If Compete% = 0 Then CurrentPiece% = NextPiece%
    If Compete% = 1 Then CurrentPiece% = PieceList%(CMN%): CMN% = CMN% + 1
    BadPiece:
    If Compete% = 0 Then
        NextPiece% = Rnd * 100 + 1
        If NextPiece% > 7 Then GoTo BadPiece
    End If
    If Compete% = 1 Then
        NextPiece% = PieceList%(CMN%)
    End If
    PieceX% = FieldWidth% / 2
    PieceR% = 0
    XSize% = PieceData%(0, PieceR%, CurrentPiece% - 1)
    YSize% = PieceData%(1, PieceR%, CurrentPiece% - 1)
    PieceY% = -1 * YSize%
    PieceC% = NextC%
    BadColor:
    NextC% = Rnd * 13 + 1
    If NextC% = 8 Then GoTo BadColor
    ComputerPlay 0
    If hint% = 1 Then ComputerPlay 1
    Line (DispX% + 7, 383)-(DispX% + DispWidth% - 7, 385 + 16 * 4.5), 0, BF
    Xs% = PieceData%(0, 1, NextPiece% - 1) + 1
    DrawPiece2 DispX% + DispWidth% / 2 - BlockSize% * Xs% / 2, 385, NextPiece%, NextC%
    PieceTime = Timer
End Sub

Sub PreOccupy (nHeight As Integer)
    Dim As Integer xn, yn, a, c

    xn% = 1: yn% = FieldHeight% - nHeight + 1
    Do
        a% = Rnd
        BCol:
        c% = Rnd * 13 + 1
        If c% = 8 Then GoTo BCol
        If a% = 1 Then Occupied%(xn%, yn%) = c%
        xn% = xn% + 1
        If xn% > FieldWidth% Then xn% = 1: yn% = yn% + 1
    Loop While yn% <= FieldHeight%
    RefreshField
End Sub

Sub ReadData
    Dim As Integer piece, r, Xs, Ys, b, n

    Restore Piece1
    piece% = 0
    Do
        r% = 0
        Do
            Read Xs%, Ys%
            PieceData%(0, r%, piece%) = Xs%
            PieceData%(1, r%, piece%) = Ys%
            b% = Xs% * Ys%
            n% = 0
            Do
                Read PieceData%(n% + 2, r%, piece%)
                n% = n% + 1
            Loop While n% < b%
            r% = r% + 1
        Loop While r% < 4
        piece% = piece% + 1
    Loop While piece% < 7
End Sub

Sub ReadText
    Dim As Integer letter, n

    Restore Text
    letter% = 0
    Do
        n% = 0
        Do
            Read Text%(letter%, n%)
            n% = n% + 1
        Loop While n% < 35
        letter% = letter% + 1
    Loop While letter% < 40
End Sub

Sub RefreshField
    Dim As Integer xn, yn

    xn% = 1: yn% = 1
    Do
        DrawBlock xn%, yn%, Occupied%(xn%, yn%)
        xn% = xn% + 1
        If xn% > FieldWidth% Then xn% = 1: yn% = yn% + 1
    Loop While yn% < FieldHeight% + 1
End Sub

Sub RestoreColors
    Dim As Integer n, c, r, g, b

    n% = 0: c% = 0
    Do
        r% = pal%(n%)
        g% = pal%(n% + 1)
        b% = pal%(n% + 2)
        Colors c%, r%, g%, b%
        n% = n% + 3
        c% = c% + 1
    Loop While c% < 16
End Sub

Sub RotatePiece
    Dim As Integer PrevR, PrevX, PrevY

    PrevR% = PieceR%
    PrevX% = PieceX%
    PrevY% = PieceY%

    usery% = 1
    PieceR% = PieceR% + 1
    If PieceR% > 3 Then PieceR% = 0
    Overlap% = 0
    CheckOverlap
    If Overlap% = 0 Then Exit Sub

    PieceX% = PieceX% - 1
    Overlap% = 0
    CheckOverlap
    If Overlap% = 0 Then Exit Sub
    PieceX% = PieceX% - 1
    Overlap% = 0
    CheckOverlap
    If Overlap% = 0 Then Exit Sub
    usery% = 0
    PieceR% = PrevR%
    PieceX% = PrevX%
End Sub

Sub StoreOccupy
    Dim As Integer xn, yn, Xs, Ys, maxn, n, c

    xn% = PieceX%: yn% = PieceY%
    Xs% = PieceData%(0, PieceR%, CurrentPiece% - 1)
    Ys% = PieceData%(1, PieceR%, CurrentPiece% - 1)
    maxn% = Xs% * Ys%
    n% = 0
    Do
        c% = PieceData%(n% + 2, PieceR%, CurrentPiece% - 1)
        If c% = 0 Then
        Else
            If xn% > 0 And yn% > 0 And xn% <= FieldWidth% And yn% <= FieldHeight% Then
                Occupied%(xn%, yn%) = PieceC%
            End If
        End If
        xn% = xn% + 1
        If xn% - PieceX% >= Xs% Then xn% = PieceX%: yn% = yn% + 1
        n% = n% + 1
    Loop While n% < maxn%
End Sub

Sub TitleScreen
    Dim As Integer a
    Dim k As String

    BlueColors
    Line (0, 0)-(640, 480), 1, BF
    gap% = 10: shadow% = 3
    DrawText 50, 50, "FUTURE", 2, 14, 2
    DrawText 100, 200, "BLOCKS", 2, 14, 2
    gap% = 4: shadow% = 2
    DrawText 45, 340, "BY MICHAEL FOGLEMAN", 9, 4, 2
    RestoreColors
    Delay 2
    gap% = 4: shadow% = 1
    DrawText 80, 440, "PRESS ANY KEY TO CONTINUE", 7, 2, 2
    For a = 1 To 15
        k = InKey$
    Next
    Do
    Loop While InKey$ = ""
End Sub

