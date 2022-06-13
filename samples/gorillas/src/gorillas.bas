'                         Q B a s i c   G o r i l l a s
'
'                   Copyright (C) Microsoft Corporation 1990
'
' Your mission is to hit your opponent with the exploding banana
' by varying the angle and power of your throw, taking into account
' wind speed, gravity, and the city skyline.
'
' Speed of this game is determined by the constant SPEEDCONST.  If the
' program is too slow or too fast adjust the "CONST SPEEDCONST = 500" line
' below.  The larger the number the faster the game will go.
'
' To run this game, press Shift+F5.
'
' To exit QBasic, press Alt, F, X.
'
' To get help on a BASIC keyword, move the cursor to the keyword and press
' F1 or click the right mouse button.
'

$NoPrefix

'Set default data type to integer for faster game play
DefInt A-Z

'Make all arrays Dynamic
'$DYNAMIC

$Resize:Smooth

'User-Defined TYPEs
Type XYPoint
    XCoor As Integer
    YCoor As Integer
End Type

'Constants
Const FALSE = 0, TRUE = Not FALSE
Const SPEEDCONST = 500
Const HITSELF = 1
Const BACKATTR = 0
Const OBJECTCOLOR = 1
Const WINDOWCOLOR = 14
Const SUNATTR = 3
Const SUNHAPPY = FALSE
Const SUNSHOCK = TRUE
Const RIGHTUP = 1
Const LEFTUP = 2
Const ARMSDOWN = 3

'Global Variables
Dim Shared GorillaX(1 To 2) 'Location of the two gorillas
Dim Shared GorillaY(1 To 2)
Dim Shared LastBuilding

Dim Shared LBan&(x), RBan&(x), UBan&(x), DBan&(x) 'Graphical picture of banana
Dim Shared GorD&(120) 'Graphical picture of Gorilla arms down
Dim Shared GorL&(120) 'Gorilla left arm raised
Dim Shared GorR&(120) 'Gorilla right arm raised

Dim Shared gravity#
Dim Shared Wind

'Screen Mode Variables
Dim Shared ScrHeight
Dim Shared ScrWidth
Dim Shared Mode
Dim Shared MaxCol

'Screen Color Variables
Dim Shared ExplosionColor
Dim Shared BackColor
Dim Shared SunHit

Dim Shared SunHt
Dim Shared GHeight
Dim Shared MachSpeed&

Def Seg = 0 ' Set NumLock to ON
KeyFlags = Peek(1047)
If (KeyFlags And 32) = 0 Then
    Poke 1047, KeyFlags Or 32
End If
Def Seg

GoSub InitVars
Intro
GetInputs Name1$, Name2$, NumGames
GorillaIntro Name1$, Name2$
PlayGame Name1$, Name2$, NumGames

Def Seg = 0 ' Restore NumLock state
Poke 1047, KeyFlags
Def Seg

System 0


CGABanana:
'BananaLeft
Data 327686,-252645316,60
'BananaDown
Data 196618,-1057030081,49344
'BananaUp
Data 196618,-1056980800,63
'BananaRight
Data 327686,1010580720,240

EGABanana:
'BananaLeft
Data 458758,202116096,471604224,943208448,943208448,943208448,471604224,202116096,0
'BananaDown
Data 262153,-2134835200,-2134802239,-2130771968,-2130738945,8323072,8323199,4063232,4063294
'BananaUp
Data 262153,4063232,4063294,8323072,8323199,-2130771968,-2130738945,-2134835200,-2134802239
'BananaRight
Data 458758,-1061109760,-522133504,1886416896,1886416896,1886416896,-522133504,-1061109760,0

InitVars:
'This is a clever way to pick the best graphics mode available
On Error GoTo ScreenModeError
Mode = 9
Screen Mode
FullScreen SquarePixels , Smooth
On Error GoTo PaletteError
If Mode = 9 Then Palette 4, 0 'Check for 64K EGA
On Error GoTo 0

MachSpeed& = CalcDelay&

If Mode = 9 Then
    ScrWidth = 640
    ScrHeight = 350
    GHeight = 25
    Restore EGABanana
    ReDim LBan&(8), RBan&(8), UBan&(8), DBan&(8)

    For i = 0 To 8
        Read LBan&(i)
    Next i

    For i = 0 To 8
        Read DBan&(i)
    Next i

    For i = 0 To 8
        Read UBan&(i)
    Next i

    For i = 0 To 8
        Read RBan&(i)
    Next i

    SunHt = 39

Else

    ScrWidth = 320
    ScrHeight = 200
    GHeight = 12
    Restore CGABanana
    ReDim LBan&(2), RBan&(2), UBan&(2), DBan&(2)
    ReDim GorL&(20), GorD&(20), GorR&(20)

    For i = 0 To 2
        Read LBan&(i)
    Next i
    For i = 0 To 2
        Read DBan&(i)
    Next i
    For i = 0 To 2
        Read UBan&(i)
    Next i
    For i = 0 To 2
        Read RBan&(i)
    Next i

    MachSpeed& = MachSpeed& * 1.3
    SunHt = 20
End If
Return

ScreenModeError:
If Mode = 1 Then
    Cls
    Locate 10, 5
    Print "Sorry, you must have CGA, EGA color, or VGA graphics to play GORILLA.BAS"
    End 1
Else
    Mode = 1
    Resume
End If

PaletteError:
Mode = 1 '64K EGA cards will run in CGA mode.
Resume Next

Rem $STATIC
'CalcDelay:
'  Checks speed of the machine.
Function CalcDelay&
    s# = Timer
    Do
        i& = i& + 1
    Loop Until Timer - s# >= .5
    CalcDelay& = i&
End Function

' Center:
'   Centers and prints a text string on a given row
' Parameters:
'   Row - screen row number
'   Text$ - text to be printed
'
Sub Center (Row, Text$)
    Col = (MaxCol - Len(Text$)) \ 2 + 1
    Locate Row, Col
    Print Text$;
End Sub

' DoExplosion:
'   Produces explosion when a shot is fired
' Parameters:
'   X#, Y# - location of explosion
'
Sub DoExplosion (x#, y#)
    Play "MBO0L32EFGEFDC"
    Radius = ScrHeight / 50
    If Mode = 9 Then Inc# = .5 Else Inc# = .41
    For c# = 0 To Radius Step Inc#
        Circle (x#, y#), c#, ExplosionColor
    Next c#
    For c# = Radius To 0 Step (-1 * Inc#)
        Circle (x#, y#), c#, BACKATTR
        Rest .005
    Next c#
End Sub

' DoShot:
'   Controls banana shots by accepting player input and plotting
'   shot angle
' Parameters:
'   PlayerNum - Player
'   x, y - Player's gorilla position
'
Function DoShot (PlayerNum, x, y)
    'Input shot
    If PlayerNum = 1 Then
        LocateCol = 1
    Else
        If Mode = 9 Then
            LocateCol = 66
        Else
            LocateCol = 26
        End If
    End If

    Locate 2, LocateCol
    Print "Angle:";
    Angle# = GetNum#(2, LocateCol + 7)

    Locate 3, LocateCol
    Print "Velocity:";
    Velocity = GetNum#(3, LocateCol + 10)

    If PlayerNum = 2 Then
        Angle# = 180 - Angle#
    End If

    'Erase input
    For i = 1 To 4
        Locate i, 1
        Print Space$(30 \ (80 \ MaxCol));
        Locate i, (50 \ (80 \ MaxCol))
        Print Space$(30 \ (80 \ MaxCol));
    Next

    SunHit = FALSE
    PlayerHit = PlotShot(x, y, Angle#, Velocity, PlayerNum)
    If PlayerHit = 0 Then
        DoShot = FALSE
    Else
        DoShot = TRUE
        If PlayerHit = PlayerNum Then PlayerNum = 3 - PlayerNum
        VictoryDance PlayerNum
    End If
End Function

' DoSun:
'   Draws the sun at the top of the screen.
' Parameters:
'   Mouth - If TRUE draws "O" mouth else draws a smile mouth.
'
Sub DoSun (Mouth)
    'set position of sun
    x = ScrWidth \ 2: y = Scl(25)

    'clear old sun
    Line (x - Scl(22), y - Scl(18))-(x + Scl(22), y + Scl(18)), BACKATTR, BF

    'draw new sun:
    'body
    Circle (x, y), Scl(12), SUNATTR
    Paint (x, y), SUNATTR

    'rays
    Line (x - Scl(20), y)-(x + Scl(20), y), SUNATTR
    Line (x, y - Scl(15))-(x, y + Scl(15)), SUNATTR

    Line (x - Scl(15), y - Scl(10))-(x + Scl(15), y + Scl(10)), SUNATTR
    Line (x - Scl(15), y + Scl(10))-(x + Scl(15), y - Scl(10)), SUNATTR

    Line (x - Scl(8), y - Scl(13))-(x + Scl(8), y + Scl(13)), SUNATTR
    Line (x - Scl(8), y + Scl(13))-(x + Scl(8), y - Scl(13)), SUNATTR

    Line (x - Scl(18), y - Scl(5))-(x + Scl(18), y + Scl(5)), SUNATTR
    Line (x - Scl(18), y + Scl(5))-(x + Scl(18), y - Scl(5)), SUNATTR

    'mouth
    If Mouth Then 'draw "o" mouth
        Circle (x, y + Scl(5)), Scl(2.9), 0
        Paint (x, y + Scl(5)), 0, 0
    Else 'draw smile
        Circle (x, y), Scl(8), 0, (210 * Pi / 180), (330 * Pi / 180)
    End If

    'eyes
    Circle (x - 3, y - 2), 1, 0
    Circle (x + 3, y - 2), 1, 0
    PSet (x - 3, y - 2), 0
    PSet (x + 3, y - 2), 0
End Sub

'DrawBan:
'  Draws the banana
'Parameters:
'  xc# - Horizontal Coordinate
'  yc# - Vertical Coordinate
'  r - rotation position (0-3). (  \_/  ) /-\
'  bc - if TRUE then DrawBan draws the banana ELSE it erases the banana
Sub DrawBan (xc#, yc#, r, bc)
    Select Case r
        Case 0
            If bc Then Put (xc#, yc#), LBan&(), PSet Else Put (xc#, yc#), LBan&(), Xor
        Case 1
            If bc Then Put (xc#, yc#), UBan&(), PSet Else Put (xc#, yc#), UBan&(), Xor
        Case 2
            If bc Then Put (xc#, yc#), RBan&(), PSet Else Put (xc#, yc#), RBan&(), Xor
        Case 3
            If bc Then Put (xc#, yc#), DBan&(), PSet Else Put (xc#, yc#), DBan&(), Xor
    End Select

End Sub

'DrawGorilla:
'  Draws the Gorilla in either CGA or EGA mode
'  and saves the graphics data in an array.
'Parameters:
'  x - x coordinate of gorilla
'  y - y coordinate of the gorilla
'  arms - either Left up, Right up, or both down
Sub DrawGorilla (x, y, arms)
    Dim i As Single ' Local index must be single precision

    'draw head
    Line (x - Scl(4), y)-(x + Scl(2.9), y + Scl(6)), OBJECTCOLOR, BF
    Line (x - Scl(5), y + Scl(2))-(x + Scl(4), y + Scl(4)), OBJECTCOLOR, BF

    'draw eyes/brow
    Line (x - Scl(3), y + Scl(2))-(x + Scl(2), y + Scl(2)), 0

    'draw nose if ega
    If Mode = 9 Then
        For i = -2 To -1
            PSet (x + i, y + 4), 0
            PSet (x + i + 3, y + 4), 0
        Next i
    End If

    'neck
    Line (x - Scl(3), y + Scl(7))-(x + Scl(2), y + Scl(7)), OBJECTCOLOR

    'body
    Line (x - Scl(8), y + Scl(8))-(x + Scl(6.9), y + Scl(14)), OBJECTCOLOR, BF
    Line (x - Scl(6), y + Scl(15))-(x + Scl(4.9), y + Scl(20)), OBJECTCOLOR, BF

    'legs
    For i = 0 To 4
        Circle (x + Scl(i), y + Scl(25)), Scl(10), OBJECTCOLOR, 3 * Pi / 4, 9 * Pi / 8
        Circle (x + Scl(-6) + Scl(i - .1), y + Scl(25)), Scl(10), OBJECTCOLOR, 15 * Pi / 8, Pi / 4
    Next

    'chest
    Circle (x - Scl(4.9), y + Scl(10)), Scl(4.9), 0, 3 * Pi / 2, 0
    Circle (x + Scl(4.9), y + Scl(10)), Scl(4.9), 0, Pi, 3 * Pi / 2

    For i = -5 To -1
        Select Case arms
            Case 1
                'Right arm up
                Circle (x + Scl(i - .1), y + Scl(14)), Scl(9), OBJECTCOLOR, 3 * Pi / 4, 5 * Pi / 4
                Circle (x + Scl(4.9) + Scl(i), y + Scl(4)), Scl(9), OBJECTCOLOR, 7 * Pi / 4, Pi / 4
                Get (x - Scl(15), y - Scl(1))-(x + Scl(14), y + Scl(28)), GorR&()
            Case 2
                'Left arm up
                Circle (x + Scl(i - .1), y + Scl(4)), Scl(9), OBJECTCOLOR, 3 * Pi / 4, 5 * Pi / 4
                Circle (x + Scl(4.9) + Scl(i), y + Scl(14)), Scl(9), OBJECTCOLOR, 7 * Pi / 4, Pi / 4
                Get (x - Scl(15), y - Scl(1))-(x + Scl(14), y + Scl(28)), GorL&()
            Case 3
                'Both arms down
                Circle (x + Scl(i - .1), y + Scl(14)), Scl(9), OBJECTCOLOR, 3 * Pi / 4, 5 * Pi / 4
                Circle (x + Scl(4.9) + Scl(i), y + Scl(14)), Scl(9), OBJECTCOLOR, 7 * Pi / 4, Pi / 4
                Get (x - Scl(15), y - Scl(1))-(x + Scl(14), y + Scl(28)), GorD&()
        End Select
    Next i
End Sub

'ExplodeGorilla:
'  Causes gorilla explosion when a direct hit occurs
'Parameters:
'  X# - shot X-location
Function ExplodeGorilla (x#)
    YAdj = Scl(12)
    XAdj = Scl(5)
    SclX# = ScrWidth / 320
    SclY# = ScrHeight / 200
    If x# < ScrWidth / 2 Then PlayerHit = 1 Else PlayerHit = 2
    Play "MBO0L16EFGEFDC"

    For i = 1 To 8 * SclX#
        Circle (GorillaX(PlayerHit) + 3.5 * SclX# + XAdj, GorillaY(PlayerHit) + 7 * SclY# + YAdj), i, ExplosionColor, , , -1.57
        Line (GorillaX(PlayerHit) + 7 * SclX#, GorillaY(PlayerHit) + 9 * SclY# - i)-(GorillaX(PlayerHit), GorillaY(PlayerHit) + 9 * SclY# - i), ExplosionColor
        Rest .005
    Next i

    For i = 1 To 16 * SclX#
        If i < (8 * SclX#) Then Circle (GorillaX(PlayerHit) + 3.5 * SclX# + XAdj, GorillaY(PlayerHit) + 7 * SclY# + YAdj), (8 * SclX# + 1) - i, BACKATTR, , , -1.57
        Circle (GorillaX(PlayerHit) + 3.5 * SclX# + XAdj, GorillaY(PlayerHit) + YAdj), i, i Mod 2 + 1, , , -1.57
        Rest .005
    Next i

    For i = 24 * SclX# To 1 Step -1
        Circle (GorillaX(PlayerHit) + 3.5 * SclX# + XAdj, GorillaY(PlayerHit) + YAdj), i, BACKATTR, , , -1.57
        Rest .01
    Next i

    ExplodeGorilla = PlayerHit
End Function

Function FnRan (x)
    FnRan = Int(Rnd(1) * x) + 1
End Function

'GetInputs:
'  Gets user inputs at beginning of game
'Parameters:
'  Player1$, Player2$ - player names
'  NumGames - number of games to play
Sub GetInputs (Player1$, Player2$, NumGames)
    Color 7, 0
    Cls

    Locate 8, 15
    Line Input "Name of Player 1 (Default = 'Player 1'): "; Player1$
    If Player1$ = "" Then
        Player1$ = "Player 1"
    Else
        Player1$ = Left$(Player1$, 10)
    End If

    Locate 10, 15
    Line Input "Name of Player 2 (Default = 'Player 2'): "; Player2$
    If Player2$ = "" Then
        Player2$ = "Player 2"
    Else
        Player2$ = Left$(Player2$, 10)
    End If

    Do
        Locate 12, 56: Print Space$(25);
        Locate 12, 13
        Input "Play to how many total points (Default = 3)"; game$
        NumGames = Val(Left$(game$, 2))
    Loop Until NumGames > 0 And Len(game$) < 3 Or Len(game$) = 0
    If NumGames = 0 Then NumGames = 3

    Do
        Locate 14, 53: Print Space$(28);
        Locate 14, 17
        Input "Gravity in Meters/Sec (Earth = 9.8)"; grav$
        gravity# = Val(grav$)
    Loop Until gravity# > 0 Or Len(grav$) = 0
    If gravity# = 0 Then gravity# = 9.8
End Sub

'GetNum:
'  Gets valid numeric input from user
'Parameters:
'  Row, Col - location to echo input
Function GetNum# (Row, Col)
    Result$ = ""
    Done = FALSE
    While InKey$ <> "": Wend 'Clear keyboard buffer

    Do While Not Done

        Locate Row, Col
        Print Result$; Chr$(95); "    ";

        Kbd$ = InKey$
        Select Case Kbd$
            Case "0" TO "9"
                Result$ = Result$ + Kbd$
            Case "."
                If InStr(Result$, ".") = 0 Then
                    Result$ = Result$ + Kbd$
                End If
            Case Chr$(13)
                If Val(Result$) > 360 Then
                    Result$ = ""
                Else
                    Done = TRUE
                End If
            Case Chr$(8)
                If Len(Result$) > 0 Then
                    Result$ = Left$(Result$, Len(Result$) - 1)
                End If
            Case Else
                If Len(Kbd$) > 0 Then
                    Beep
                End If
        End Select
    Loop

    Locate Row, Col
    Print Result$; " ";

    GetNum# = Val(Result$)
End Function

'GorillaIntro:
'  Displays gorillas on screen for the first time
'  allows the graphical data to be put into an array
'Parameters:
'  Player1$, Player2$ - The names of the players
'
Sub GorillaIntro (Player1$, Player2$)
    Locate 16, 34: Print "--------------"
    Locate 18, 34: Print "V = View Intro"
    Locate 19, 34: Print "P = Play Game"
    Locate 21, 35: Print "Your Choice?"

    Do While Char$ = ""
        Char$ = InKey$
    Loop

    If Mode = 1 Then
        x = 125
        y = 100
    Else
        x = 278
        y = 175
    End If

    Screen Mode
    SetScreen

    If Mode = 1 Then Center 5, "Please wait while gorillas are drawn."

    View Print 9 To 24

    If Mode = 9 Then Palette OBJECTCOLOR, BackColor

    DrawGorilla x, y, ARMSDOWN
    Cls 2
    DrawGorilla x, y, LEFTUP
    Cls 2
    DrawGorilla x, y, RIGHTUP
    Cls 2

    View Print 1 To 25
    If Mode = 9 Then Palette OBJECTCOLOR, 46

    If UCase$(Char$) = "V" Then
        Center 2, "Q B A S I C   G O R I L L A S"
        Center 5, "             STARRING:               "
        P$ = Player1$ + " AND " + Player2$
        Center 7, P$

        Put (x - 13, y), GorD&(), PSet
        Put (x + 47, y), GorD&(), PSet
        Rest 1

        Put (x - 13, y), GorL&(), PSet
        Put (x + 47, y), GorR&(), PSet
        before# = Timer(.001)
        Play "t120o1l16b9n0baan0bn0bn0baaan0b9n0baan0b"
        Rest .3 + 2.944 - (Timer(.001) - before#)

        Put (x - 13, y), GorR&(), PSet
        Put (x + 47, y), GorL&(), PSet
        before# = Timer(.001)
        Play "o2l16e-9n0e-d-d-n0e-n0e-n0e-d-d-d-n0e-9n0e-d-d-n0e-"
        Rest .3 + 2.944 - (Timer(.001) - before#)

        Put (x - 13, y), GorL&(), PSet
        Put (x + 47, y), GorR&(), PSet
        before# = Timer(.001)
        Play "o2l16g-9n0g-een0g-n0g-n0g-eeen0g-9n0g-een0g-"
        Rest .3 + 2.944 - (Timer(.001) - before#)

        Put (x - 13, y), GorR&(), PSet
        Put (x + 47, y), GorL&(), PSet
        before# = Timer(.001)
        Play "o2l16b9n0baan0g-n0g-n0g-eeen0o1b9n0baan0b"
        Rest .3 + 2.944 - (Timer(.001) - before#)

        For i = 1 To 4
            Put (x - 13, y), GorL&(), PSet
            Put (x + 47, y), GorR&(), PSet
            before# = Timer(.001)
            Play "T160O0L32EFGEFDC"
            Rest .1 + .328 - (Timer(.001) - before#)
            Put (x - 13, y), GorR&(), PSet
            Put (x + 47, y), GorL&(), PSet
            before# = Timer(.001)
            Play "T160O0L32EFGEFDC"
            Rest .1 + .328 - (Timer(.001) - before#)
        Next
    End If
End Sub

'Intro:
'  Displays game introduction
Sub Intro
    Screen 0
    Width 80, 25
    MaxCol = 80
    Color 15, 0
    Cls

    Center 4, "Q B a s i c    G O R I L L A S"
    Color 7
    Center 6, "Copyright (C) Microsoft Corporation 1990"
    Center 8, "Your mission is to hit your opponent with the exploding"
    Center 9, "banana by varying the angle and power of your throw, taking"
    Center 10, "into account wind speed, gravity, and the city skyline."
    Center 11, "The wind speed is shown by a directional arrow at the bottom"
    Center 12, "of the playing field, its length relative to its strength."
    Center 24, "Press any key to continue"

    Play "MBT160O1L8CDEDCDL4ECC"
    SparklePause
    If Mode = 1 Then MaxCol = 40
End Sub

'MakeCityScape:
'  Creates random skyline for game
'Parameters:
'  BCoor() - a user-defined type array which stores the coordinates of
'  the upper left corner of each building.
Sub MakeCityScape (BCoor() As XYPoint)
    x = 2

    'Set the sloping trend of the city scape. NewHt is new building height
    Slope = FnRan(6)
    Select Case Slope
        Case 1: NewHt = 15 'Upward slope
        Case 2: NewHt = 130 'Downward slope
        Case 3 TO 5: NewHt = 15 '"V" slope - most common
        Case 6: NewHt = 130 'Inverted "V" slope
    End Select

    If Mode = 9 Then
        BottomLine = 335 'Bottom of building
        HtInc = 10 'Increase value for new height
        DefBWidth = 37 'Default building height
        RandomHeight = 120 'Random height difference
        WWidth = 3 'Window width
        WHeight = 6 'Window height
        WDifV = 15 'Counter for window spacing - vertical
        WDifh = 10 'Counter for window spacing - horizontal
    Else
        BottomLine = 190
        HtInc = 6
        NewHt = NewHt * 20 \ 35 'Adjust for CGA
        DefBWidth = 18
        RandomHeight = 54
        WWidth = 1
        WHeight = 2
        WDifV = 5
        WDifh = 4
    End If

    CurBuilding = 1
    Do

        Select Case Slope
            Case 1
                NewHt = NewHt + HtInc
            Case 2
                NewHt = NewHt - HtInc
            Case 3 TO 5
                If x > ScrWidth \ 2 Then
                    NewHt = NewHt - 2 * HtInc
                Else
                    NewHt = NewHt + 2 * HtInc
                End If
            Case 4
                If x > ScrWidth \ 2 Then
                    NewHt = NewHt + 2 * HtInc
                Else
                    NewHt = NewHt - 2 * HtInc
                End If
        End Select

        'Set width of building and check to see if it would go off the screen
        BWidth = FnRan(DefBWidth) + DefBWidth
        If x + BWidth > ScrWidth Then BWidth = ScrWidth - x - 2

        'Set height of building and check to see if it goes below screen
        BHeight = FnRan(RandomHeight) + NewHt
        If BHeight < HtInc Then BHeight = HtInc

        'Check to see if Building is too high
        If BottomLine - BHeight <= MaxHeight + GHeight Then BHeight = MaxHeight + GHeight - 5

        'Set the coordinates of the building into the array
        BCoor(CurBuilding).XCoor = x
        BCoor(CurBuilding).YCoor = BottomLine - BHeight

        If Mode = 9 Then BuildingColor = FnRan(3) + 4 Else BuildingColor = 2

        'Draw the building, outline first, then filled
        Line (x - 1, BottomLine + 1)-(x + BWidth + 1, BottomLine - BHeight - 1), BACKGROUND, B
        Line (x, BottomLine)-(x + BWidth, BottomLine - BHeight), BuildingColor, BF

        'Draw the windows
        c = x + 3
        Do
            For i = BHeight - 3 To 7 Step -WDifV
                If Mode <> 9 Then
                    WinColr = (FnRan(2) - 2) * -3
                ElseIf FnRan(4) = 1 Then
                    WinColr = 8
                Else
                    WinColr = WINDOWCOLOR
                End If
                Line (c, BottomLine - i)-(c + WWidth, BottomLine - i + WHeight), WinColr, BF
            Next
            c = c + WDifh
        Loop Until c >= x + BWidth - 3

        x = x + BWidth + 2

        CurBuilding = CurBuilding + 1

    Loop Until x > ScrWidth - HtInc

    LastBuilding = CurBuilding - 1

    'Set Wind speed
    Wind = FnRan(10) - 5
    If FnRan(3) = 1 Then
        If Wind > 0 Then
            Wind = Wind + FnRan(10)
        Else
            Wind = Wind - FnRan(10)
        End If
    End If

    'Draw Wind speed arrow
    If Wind <> 0 Then
        WindLine = Wind * 3 * (ScrWidth \ 320)
        Line (ScrWidth \ 2, ScrHeight - 5)-(ScrWidth \ 2 + WindLine, ScrHeight - 5), ExplosionColor
        If Wind > 0 Then ArrowDir = -2 Else ArrowDir = 2
        Line (ScrWidth / 2 + WindLine, ScrHeight - 5)-(ScrWidth / 2 + WindLine + ArrowDir, ScrHeight - 5 - 2), ExplosionColor
        Line (ScrWidth / 2 + WindLine, ScrHeight - 5)-(ScrWidth / 2 + WindLine + ArrowDir, ScrHeight - 5 + 2), ExplosionColor
    End If
End Sub

'PlaceGorillas:
'  PUTs the Gorillas on top of the buildings.  Must have drawn
'  Gorillas first.
'Parameters:
'  BCoor() - user-defined TYPE array which stores upper left coordinates
'  of each building.
Sub PlaceGorillas (BCoor() As XYPoint)
    If Mode = 9 Then
        XAdj = 14
        YAdj = 30
    Else
        XAdj = 7
        YAdj = 16
    End If
    SclX# = ScrWidth / 320
    SclY# = ScrHeight / 200

    'Place gorillas on second or third building from edge
    For i = 1 To 2
        If i = 1 Then BNum = FnRan(2) + 1 Else BNum = LastBuilding - FnRan(2)

        BWidth = BCoor(BNum + 1).XCoor - BCoor(BNum).XCoor
        GorillaX(i) = BCoor(BNum).XCoor + BWidth / 2 - XAdj
        GorillaY(i) = BCoor(BNum).YCoor - YAdj
        Put (GorillaX(i), GorillaY(i)), GorD&(), PSet
    Next i
End Sub

'PlayGame:
'  Main game play routine
'Parameters:
'  Player1$, Player2$ - player names
'  NumGames - number of games to play
Sub PlayGame (Player1$, Player2$, NumGames)
    Dim BCoor(0 To 30) As XYPoint
    Dim TotalWins(1 To 2)

    J = 1

    For i = 1 To NumGames

        Cls
        Randomize (Timer)
        Call MakeCityScape(BCoor())
        Call PlaceGorillas(BCoor())
        DoSun SUNHAPPY
        Hit = FALSE
        Do While Hit = FALSE
            J = 1 - J
            Locate 1, 1
            Print Player1$
            Locate 1, (MaxCol - 1 - Len(Player2$))
            Print Player2$
            Center 23, LTrim$(Str$(TotalWins(1))) + ">Score<" + LTrim$(Str$(TotalWins(2)))
            Tosser = J + 1: Tossee = 3 - J

            'Plot the shot.  Hit is true if Gorilla gets hit.
            Hit = DoShot(Tosser, GorillaX(Tosser), GorillaY(Tosser))

            'Reset the sun, if it got hit
            If SunHit Then DoSun SUNHAPPY

            If Hit = TRUE Then Call UpdateScores(TotalWins(), Tosser, Hit)
        Loop
        Sleep 1
    Next i

    Screen 0
    Width 80, 25
    Color 7, 0
    MaxCol = 80
    Cls

    Center 8, "GAME OVER!"
    Center 10, "Score:"
    Locate 11, 30: Print Player1$; Tab(50); TotalWins(1)
    Locate 12, 30: Print Player2$; Tab(50); TotalWins(2)
    Center 24, "Press any key to continue"
    SparklePause
    Color 7, 0
    Cls
End Sub

'PlayGame:
'  Plots banana shot across the screen
'Parameters:
'  StartX, StartY - starting shot location
'  Angle - shot angle
'  Velocity - shot velocity
'  PlayerNum - the banana thrower
Function PlotShot (StartX, StartY, Angle#, Velocity, PlayerNum)
    Angle# = Angle# / 180 * Pi 'Convert degree angle to radians
    Radius = Mode Mod 7

    InitXVel# = Cos(Angle#) * Velocity
    InitYVel# = Sin(Angle#) * Velocity

    oldx# = StartX
    oldy# = StartY

    'draw gorilla toss
    If PlayerNum = 1 Then
        Put (StartX, StartY), GorL&(), PSet
    Else
        Put (StartX, StartY), GorR&(), PSet
    End If

    'throw sound
    Play "MBo0L32A-L64CL16BL64A+"
    Rest .1

    'redraw gorilla
    Put (StartX, StartY), GorD&(), PSet

    adjust = Scl(4) 'For scaling CGA

    xedge = Scl(9) * (2 - PlayerNum) 'Find leading edge of banana for check

    Impact = FALSE
    ShotInSun = FALSE
    OnScreen = TRUE
    PlayerHit = 0
    NeedErase = FALSE

    StartXPos = StartX
    StartYPos = StartY - adjust - 3

    If PlayerNum = 2 Then
        StartXPos = StartXPos + Scl(25)
        direction = Scl(4)
    Else
        direction = Scl(-4)
    End If

    If Velocity < 2 Then 'Shot too slow - hit self
        x# = StartX
        y# = StartY
        pointval = OBJECTCOLOR
    End If

    Do While (Not Impact) And OnScreen

        Rest .02

        'Erase old banana, if necessary
        If NeedErase Then
            NeedErase = FALSE
            Call DrawBan(oldx#, oldy#, oldrot, FALSE)
        End If

        x# = StartXPos + (InitXVel# * t#) + (.5 * (Wind / 5) * t# ^ 2)
        y# = StartYPos + ((-1 * (InitYVel# * t#)) + (.5 * gravity# * t# ^ 2)) * (ScrHeight / 350)

        If (x# >= ScrWidth - Scl(10)) Or (x# <= 3) Or (y# >= ScrHeight - 3) Then
            OnScreen = FALSE
        End If


        If OnScreen And y# > 0 Then

            'check it
            LookY = 0
            LookX = Scl(8 * (2 - PlayerNum))
            Do
                pointval = Point(x# + LookX, y# + LookY)
                If pointval = 0 Then
                    Impact = FALSE
                    If ShotInSun = TRUE Then
                        If Abs(ScrWidth \ 2 - x#) > Scl(20) Or y# > SunHt Then ShotInSun = FALSE
                    End If
                ElseIf pointval = SUNATTR And y# < SunHt Then
                    If Not SunHit Then DoSun SUNSHOCK
                    SunHit = TRUE
                    ShotInSun = TRUE
                Else
                    Impact = TRUE
                End If
                LookX = LookX + direction
                LookY = LookY + Scl(6)
            Loop Until Impact Or LookX <> Scl(4)

            If Not ShotInSun And Not Impact Then
                'plot it
                rot = (t# * 10) Mod 4
                Call DrawBan(x#, y#, rot, TRUE)
                NeedErase = TRUE
            End If

            oldx# = x#
            oldy# = y#
            oldrot = rot

        End If


        t# = t# + .1

    Loop

    If pointval <> OBJECTCOLOR And Impact Then
        Call DoExplosion(x# + adjust, y# + adjust)
    ElseIf pointval = OBJECTCOLOR Then
        PlayerHit = ExplodeGorilla(x#)
    End If

    PlotShot = PlayerHit
End Function

'Rest:
'  pauses the program
Sub Rest (t#)
    If (t# > 0) Then Delay t#
End Sub

'Scl:
'  Pass the number in to scaling for cga.  If the number is a decimal, then we
'  want to scale down for cga or scale up for ega.  This allows a full range
'  of numbers to be generated for scaling.
'  (i.e. for 3 to get scaled to 1, pass in 2.9)
Function Scl (n!)
    If n! <> Int(n!) Then
        If Mode = 1 Then n! = n! - 1
    End If
    If Mode = 1 Then
        Scl = CInt(n! / 2 + .1)
    Else
        Scl = CInt(n!)
    End If
End Function

'SetScreen:
'  Sets the appropriate color statements
Sub SetScreen
    If Mode = 9 Then
        ExplosionColor = 2
        BackColor = 1
        Palette 0, 1
        Palette 1, 46
        Palette 2, 44
        Palette 3, 54
        Palette 5, 7
        Palette 6, 4
        Palette 7, 3
        Palette 9, 63 'Display Color
    Else
        ExplosionColor = 2
        BackColor = 0
        Color BackColor, 2
    End If
End Sub

'SparklePause:
'  Creates flashing border for intro and game over screens
Sub SparklePause
    Color 4, 0
    A$ = "*    *    *    *    *    *    *    *    *    *    *    *    *    *    *    *    *    "
    While InKey$ <> "": Wend 'Clear keyboard buffer

    While InKey$ = ""
        For A = 1 To 5
            Locate 1, 1 'print horizontal sparkles
            Print Mid$(A$, A, 80);
            Locate 22, 1
            Print Mid$(A$, 6 - A, 80);

            For b = 2 To 21 'Print Vertical sparkles
                c = (A + b) Mod 5
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
            Rest .06
        Next A
    Wend
End Sub

'UpdateScores:
'  Updates players' scores
'Parameters:
'  Record - players' scores
'  PlayerNum - player
'  Results - results of player's shot
Sub UpdateScores (Record(), PlayerNum, Results)
    If Results = HITSELF Then
        Record(Abs(PlayerNum - 3)) = Record(Abs(PlayerNum - 3)) + 1
    Else
        Record(PlayerNum) = Record(PlayerNum) + 1
    End If
End Sub

'VictoryDance:
'  gorilla dances after he has eliminated his opponent
'Parameters:
'  Player - which gorilla is dancing
Sub VictoryDance (Player)
    For i# = 1 To 4
        Put (GorillaX(Player), GorillaY(Player)), GorL&(), PSet
        before# = Timer(.001)
        Play "O0L32EFGEFDC"
        Rest .2 + .328 - (Timer(.001) - before#)
        Put (GorillaX(Player), GorillaY(Player)), GorR&(), PSet
        before# = Timer(.001)
        Play "O0L32EFGEFDC"
        Rest .2 + .328 - (Timer(.001) - before#)
    Next
End Sub

