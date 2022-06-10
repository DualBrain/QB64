'*****************************************************************************
'
'--------------------------- R A T T L E R . B A S ---------------------------
'
'---------------- Copyright (C) 2003 by Bob Seguin (Freeware) ----------------
'
'------------------------ Email: BOBSEG@sympatico.ca -------------------------
'
'--------------------- RATTLER is a graphical version of ---------------------
'--------------------- the classic QBasic game, NIBBLES ----------------------
'
'*****************************************************************************

$Resize:Smooth

DefInt A-Z

Dim Shared SnakePIT(1 To 32, 1 To 24)
Dim Shared WipeBOX(29, 21)

ReDim Shared SpriteBOX(8000)
ReDim Shared NumBOX(400)
ReDim Shared TTBox(480)
ReDim Shared BigBOX(32000)

'The following constants are used to determine sprite array indexes
Const Head = 0
Const Neck = 500
Const Shoulders = 1000
Const Body = 1500
Const Tail = 2000
Const TailEND = 2500
Const Rattle = 3000

Const Mouse = 6000
Const Frog = 6500
Const Stone = 7000
Const Blank = 7500

Const TURN = 3000

Const Left = 0
Const Up = 125
Const Right = 250
Const Down = 375

Const DL = 0
Const DR = 125
Const UR = 250
Const UL = 375
Const RD = 375
Const LD = 250
Const LU = 125
Const RU = 0

Type DiamondBACK
    Row As Integer
    Col As Integer
    BodyPART As Integer
    TURN As Integer
    WhichWAY As Integer
    RattleDIR As Integer
End Type
Dim Shared Rattler(72) As DiamondBACK

Type ScoreTYPE
    PlayerNAME As String * 20
    PlayDATE As String * 10
    PlayerSCORE As Long
End Type
Dim Shared ScoreDATA(10) As ScoreTYPE

Dim Shared SnakeLENGTH
Dim Shared SetSPEED
Dim Shared Speed
Dim Shared SpeedLEVEL
Dim Shared Level
Dim Shared Lives
Dim Shared Score
Dim Shared CrittersLEFT

Open "rattler.top" For Append As #1
Close #1

Open "rattler.top" For Input As #1
Do While Not EOF(1)
    Input #1, ScoreDATA(n).PlayerNAME
    Input #1, ScoreDATA(n).PlayDATE
    Input #1, ScoreDATA(n).PlayerSCORE
    n = n + 1
Loop
Close #1

Randomize Timer

Screen 12
_FullScreen _SquarePixels , _Smooth

GoSub DrawSPRITES
DrawSCREEN

Intro

Do
    PlayGAME
Loop

End

'------------------------- SUBROUTINE SECTION BEGINS -------------------------

DrawSPRITES:
'Creates images from compressed data

'Set all attributes to black (REM out to view the process)
For n = 1 To 15
    Out &H3C8, n
    Out &H3C9, 0
    Out &H3C9, 0
    Out &H3C9, 0
Next n

Out &H3C8, 9
Out &H3C9, 52
Out &H3C9, 42
Out &H3C9, 32
Locate 12, 32: Color 9
Print "ONE MOMENT PLEASE..."

MaxWIDTH = 19
MaxDEPTH = 279
x = 0: y = 0

Do
    Read Count, Colr
    For Reps = 1 To Count
        PSet (x, y), Colr
        x = x + 1
        If x > MaxWIDTH Then
            x = 0
            y = y + 1
        End If
    Next Reps
Loop Until y > MaxDEPTH

'Create directional sets
Index = 0
For y = 0 To 260 Step 20
    Get (0, y)-(19, y + 19), SpriteBOX(Index)
    GoSub Poses
    Index = Index + 500
Next y
Cls
Palette 9, 0
'Create stone block and erasing sprite(s)
Line (0, 0)-(19, 19), 6, BF
For Reps = 1 To 240
    x = Fix(Rnd * 20) + 1
    y = Fix(Rnd * 20) + 1
    PSet (x, y), 7
    PSet (x + 1, y + 1), 15
Next Reps
Line (0, 0)-(19, 19), 6, B
Line (1, 1)-(18, 18), 13, B
Line (1, 1)-(1, 18), 15
Line (1, 1)-(18, 1), 15
Get (0, 0)-(19, 19), SpriteBOX(Stone) 'stone tile
Line (0, 0)-(19, 19), 8, BF
Get (0, 0)-(19, 19), SpriteBOX(Blank + Left) 'erasing tile
Get (0, 0)-(19, 19), SpriteBOX(Blank + Up) 'erasing tile
Get (0, 0)-(19, 19), SpriteBOX(Blank + Right) 'erasing tile
Get (0, 0)-(19, 19), SpriteBOX(Blank + Down) 'erasing tile
Cls
Color 9
Locate 9, 31
Print "RATTLER TOP-TEN LIST"
Get (240, 130)-(398, 140), TTBox()
Locate 9, 31
Print Space$(20)

'GET numbers
For n = 0 To 9
    Locate 10, 10
    If n = 0 Then Print "O" Else Print LTrim$(Str$(n))
    For x = 72 To 80
        For y = 144 To 160
            If Point(x, y) = 0 Then PSet (x, y), 15 Else PSet (x, y), 4
        Next y
    Next x
    Get (72, 144)-(79, 156), NumBOX(NumDEX)
    NumDEX = NumDEX + 40
Next n
Line (72, 144)-(80, 160), 0, BF
Return

Poses:
'Draws/GETs the other 3 directional poses from each sprite
For i = Index To Index + 250 Step 125
    Put (100, 100), SpriteBOX(i), PSet
    For Px = 100 To 119
        For Py = 100 To 119
            PSet (219 - Py, Px - 20), Point(Px, Py)
        Next Py
    Next Px
    Get (100, 80)-(119, 99), SpriteBOX(i + 125)
Next i
Return

SpriteVALUES:
Data 47,8,2,12,2,0,16,8,3,5,1,12,1,13,1,12,1,13,1,12,8,8,1,0
Data 1,12,1,15,1,8,1,15,3,5,1,14,3,1,1,14,1,13,5,8,2,5,1,12
Data 1,5,4,12,3,3,1,5,1,12,1,3,1,12,1,14,1,13,2,8,1,3,14,5
Data 1,3,1,5,1,1,1,13,1,3,1,5,1,12,1,5,1,12,1,5,1,12,1,5
Data 1,12,1,5,1,12,3,5,1,12,1,5,1,12,2,3,1,1,22,5,1,12,1,5
Data 1,12,1,3,1,12,1,3,1,12,1,3,1,12,1,3,1,12,1,15,1,12,1,3
Data 1,12,1,3,1,12,1,3,2,5,1,12,1,5,1,12,1,3,1,12,1,3,1,12
Data 1,3,1,12,1,3,1,12,1,15,1,12,1,3,1,12,1,3,1,12,1,3,17,5
Data 1,3,2,5,1,3,1,5,1,12,1,5,1,12,1,5,1,12,1,5,1,12,1,5
Data 1,12,3,5,1,12,1,5,1,12,2,3,1,1,1,8,1,3,14,5,1,3,1,14
Data 1,1,1,13,2,8,2,5,1,12,1,5,4,12,2,3,1,1,1,5,1,12,1,1
Data 1,12,1,14,1,13,4,8,1,0,1,12,1,15,1,8,1,15,3,5,2,14,2,1
Data 1,14,1,13,10,8,2,5,1,14,1,12,1,13,1,12,1,13,1,12,12,8,2,12
Data 2,0,169,8,1,13,1,12,1,13,1,1,1,13,1,12,1,13,1,1,1,13,1,12
Data 1,13,1,12,1,13,1,1,1,13,1,12,1,13,1,1,1,13,1,12,1,1,1,14
Data 1,1,1,14,1,12,1,14,1,12,1,14,1,1,1,14,1,1,1,14,1,1,1,14
Data 1,12,1,14,1,12,1,14,1,1,1,14,2,3,1,5,1,12,1,5,1,12,1,5
Data 1,12,1,5,3,3,1,5,1,12,1,5,1,12,1,5,1,12,1,5,3,3,1,12
Data 1,5,1,12,1,5,1,12,1,5,1,12,1,5,2,3,1,12,1,5,1,12,1,5
Data 1,12,1,5,1,12,1,5,1,3,1,5,1,12,1,5,1,12,1,5,1,12,1,5
Data 1,12,1,5,1,3,1,5,1,12,1,5,1,12,1,5,1,12,1,5,1,12,1,5
Data 2,3,1,5,1,12,1,5,1,12,1,5,1,12,1,5,3,3,1,5,1,12,1,5
Data 1,12,1,5,1,12,1,5,1,3,1,1,1,14,1,1,1,14,1,12,1,14,1,12
Data 1,14,1,1,1,14,1,1,1,14,1,1,1,14,1,12,1,14,1,12,1,14,1,1
Data 1,14,1,13,1,12,1,13,1,1,1,13,1,12,1,13,1,1,1,13,1,12,1,13
Data 1,12,1,13,1,1,1,13,1,12,1,13,1,1,1,13,1,12,220,8,1,12,1,13
Data 1,12,1,13,1,12,1,13,1,12,1,13,1,12,1,13,1,12,1,13,1,12,1,13
Data 1,12,1,13,1,12,1,13,1,12,1,13,1,14,1,12,1,14,1,1,1,14,1,12
Data 1,14,1,1,1,14,1,12,1,14,1,12,1,14,1,1,1,14,1,12,1,14,1,1
Data 1,14,2,12,1,14,1,3,1,14,1,12,1,14,1,12,1,14,1,3,1,14,1,12
Data 1,14,1,3,1,14,1,12,1,14,1,12,1,14,1,3,1,14,1,5,1,3,1,5
Data 1,12,1,5,1,12,1,5,1,12,1,5,1,3,1,5,1,3,1,5,1,12,1,5
Data 1,12,1,5,1,12,1,5,1,3,1,15,1,5,1,12,1,5,1,12,1,5,1,12
Data 1,5,1,12,1,5,1,15,1,5,1,12,1,5,1,12,1,5,1,12,1,5,1,12
Data 1,5,1,15,1,5,1,12,1,5,1,12,1,5,1,12,1,5,1,12,1,5,1,15
Data 1,5,1,12,1,5,1,12,1,5,1,12,1,5,1,12,2,5,1,3,1,5,1,12
Data 1,5,1,12,1,5,1,12,1,5,1,3,1,5,1,3,1,5,1,12,1,5,1,12
Data 1,5,1,12,1,5,1,3,1,12,1,14,1,3,1,14,1,12,1,14,1,12,1,14
Data 1,3,1,14,1,12,1,14,1,3,1,14,1,12,1,14,1,12,1,14,1,3,2,14
Data 1,12,1,14,1,1,1,14,1,12,1,14,1,1,1,14,1,12,1,14,1,12,1,14
Data 1,1,1,14,1,12,1,14,1,1,1,14,2,12,1,13,1,12,1,13,1,12,1,13
Data 1,12,1,13,1,12,1,13,1,12,1,13,1,12,1,13,1,12,1,13,1,12,1,13
Data 1,12,1,13,180,8,1,13,1,12,1,13,1,12,1,13,1,1,1,13,1,12,1,13
Data 1,12,1,13,1,12,1,13,1,12,1,13,1,1,1,13,1,12,1,13,2,12,1,14
Data 1,12,1,14,1,1,1,5,1,1,1,14,1,12,1,14,1,12,1,14,1,12,1,14
Data 1,1,1,5,1,1,1,14,1,12,2,14,1,12,1,14,1,1,1,14,1,12,1,14
Data 1,1,1,14,1,12,1,14,1,12,1,14,1,1,1,14,1,12,1,14,1,1,1,14
Data 2,12,1,5,1,3,1,5,1,12,1,5,1,12,1,5,1,3,1,5,1,12,1,5
Data 1,3,1,5,1,12,1,5,1,12,1,5,1,3,2,5,1,3,1,5,1,12,1,5
Data 1,12,1,5,1,12,1,5,1,3,1,5,1,3,1,5,1,12,1,5,1,12,1,5
Data 1,12,1,5,1,3,1,15,1,5,1,12,1,5,1,12,1,5,1,12,1,5,1,12
Data 1,5,1,15,1,5,1,12,1,5,1,12,1,5,1,12,1,5,1,12,1,5,1,15
Data 1,5,1,12,1,5,1,12,1,5,1,12,1,5,1,12,1,5,1,15,1,5,1,12
Data 1,5,1,12,1,5,1,12,1,5,1,12,2,5,1,3,1,5,1,12,1,5,1,12
Data 1,5,1,12,1,5,1,3,1,5,1,3,1,5,1,12,1,5,1,12,1,5,1,12
Data 1,5,1,3,1,12,1,5,1,3,1,5,1,12,1,5,1,12,1,5,1,3,1,5
Data 1,12,1,5,1,3,1,5,1,12,1,5,1,12,1,5,1,3,1,5,1,14,1,12
Data 1,14,1,1,1,14,1,12,1,14,1,1,1,14,1,12,1,14,1,12,1,14,1,1
Data 1,14,1,12,1,14,1,1,1,14,2,12,1,14,1,12,1,14,1,1,1,14,1,1
Data 1,14,1,12,1,14,1,12,1,14,1,12,1,14,1,1,1,14,1,1,1,14,1,12
Data 1,14,1,13,1,12,1,13,1,12,1,13,1,1,1,13,1,12,1,13,1,12,1,13
Data 1,12,1,13,1,12,1,13,1,1,1,13,1,12,1,13,1,12,220,8,1,12,1,13
Data 1,1,1,13,1,12,1,13,1,12,1,13,1,1,1,13,1,12,1,13,1,1,1,13
Data 1,12,1,13,1,12,1,13,1,1,1,13,1,14,1,1,1,14,1,12,1,14,1,12
Data 1,14,1,12,1,14,1,1,1,14,1,1,1,14,1,12,1,14,1,12,1,14,1,12
Data 1,14,1,1,1,15,1,5,1,12,1,5,1,12,1,5,1,12,1,5,1,12,1,5
Data 1,15,1,5,1,12,1,5,1,12,1,5,1,12,1,5,1,12,1,5,1,15,1,5
Data 1,12,1,5,1,12,1,5,1,12,1,5,1,12,1,5,1,15,1,5,1,12,1,5
Data 1,12,1,5,1,12,1,5,1,12,1,5,1,14,1,1,1,14,1,12,1,14,1,12
Data 1,14,1,12,1,14,1,3,1,14,1,3,1,14,1,12,1,14,1,12,1,14,1,12
Data 1,14,1,1,1,12,1,13,1,1,1,13,1,12,1,13,1,12,1,13,1,1,1,13
Data 1,12,1,13,1,1,1,13,1,12,1,13,1,12,1,13,1,1,1,13,300,8,1,12
Data 1,13,1,12,1,13,1,3,1,13,1,3,1,13,1,3,1,13,1,12,1,13,1,12
Data 1,13,1,3,1,13,1,3,1,13,1,3,1,13,1,5,1,12,1,5,1,12,1,5
Data 1,3,1,5,1,12,2,3,1,5,1,12,1,5,1,12,1,5,1,3,1,5,1,12
Data 2,3,1,5,1,12,1,5,1,12,1,5,1,3,1,5,1,12,2,3,1,5,1,12
Data 1,5,1,12,1,5,1,3,1,5,1,12,2,3,1,12,1,13,1,12,1,13,1,3
Data 1,13,1,3,1,13,1,3,1,13,1,12,1,13,1,12,1,13,1,3,1,13,1,3
Data 1,13,1,3,1,13,286,8,2,13,1,8,2,13,1,8,2,13,1,8,2,13,8,8
Data 1,5,2,1,1,14,2,1,1,14,2,1,1,14,2,1,1,14,1,13,1,8,1,13
Data 1,3,1,13,1,3,1,13,1,1,2,3,1,14,2,3,1,14,2,3,1,14,2,3
Data 1,14,1,3,1,13,1,3,1,5,1,12,5,3,1,5,2,3,1,5,2,3,1,5
Data 2,3,1,5,3,3,1,5,1,12,5,3,1,5,2,3,1,5,2,3,1,5,2,3
Data 1,5,2,3,1,13,1,3,1,13,1,3,1,13,1,1,2,3,1,14,2,3,1,14
Data 2,3,1,14,2,3,1,14,1,3,1,13,5,8,1,5,2,1,1,12,2,1,1,12
Data 2,1,1,12,2,1,1,14,1,13,7,8,2,13,1,8,2,13,1,8,2,13,1,8
Data 2,13,129,8,1,12,1,5,1,3,2,5,1,3,1,5,1,12,12,8,1,13,1,1
Data 1,5,2,12,1,5,1,1,1,13,12,8,1,12,1,5,1,12,2,5,1,12,1,5
Data 1,12,12,8,1,13,1,12,1,5,2,12,1,5,1,12,1,13,12,8,1,12,1,5
Data 1,12,2,5,1,12,1,5,1,12,11,8,1,13,1,5,1,3,1,5,2,12,1,5
Data 1,1,1,13,6,8,1,13,1,12,1,13,1,12,1,13,1,1,1,5,1,15,1,12
Data 2,5,1,3,1,5,1,12,6,8,1,1,1,5,1,1,1,5,1,12,1,5,1,12
Data 1,5,1,15,1,5,1,3,1,5,1,1,1,13,6,8,2,3,1,5,1,12,1,5
Data 1,12,1,5,1,12,1,5,1,3,2,5,1,13,7,8,1,12,1,15,1,12,1,5
Data 1,12,1,5,1,12,1,5,1,12,2,5,1,1,1,12,7,8,1,5,1,15,1,12
Data 1,5,1,12,1,5,1,12,1,5,1,12,1,5,1,1,1,13,8,8,2,3,1,5
Data 1,12,1,5,1,12,1,5,1,12,1,5,1,3,1,12,9,8,1,1,1,5,1,1
Data 1,5,1,12,1,5,1,12,1,5,1,1,1,13,10,8,1,13,1,12,1,13,1,12
Data 1,13,1,12,1,13,1,12,137,8,1,13,1,12,1,14,1,3,2,5,1,3,1,14
Data 1,12,1,13,10,8,1,12,1,14,1,3,1,5,2,12,1,5,1,3,1,14,1,12
Data 10,8,1,13,1,1,1,5,1,12,2,5,1,12,1,5,1,1,1,13,10,8,1,12
Data 1,3,1,12,1,5,2,12,1,5,1,12,1,5,1,12,9,8,1,13,1,14,1,3
Data 2,12,2,5,1,12,1,5,1,14,1,13,5,8,1,12,1,13,1,12,1,13,1,12
Data 1,5,1,3,1,5,1,12,1,5,1,12,2,5,1,1,1,12,5,8,1,14,1,12
Data 1,14,1,1,1,3,1,12,1,5,1,15,1,5,1,12,1,5,1,12,1,3,1,14
Data 1,13,5,8,1,12,1,14,1,1,1,5,1,12,2,3,1,5,1,15,2,5,1,3
Data 1,14,1,13,6,8,1,5,1,3,1,5,1,12,1,5,1,12,1,5,1,12,1,5
Data 2,3,1,14,2,12,6,8,1,15,1,5,1,12,1,5,1,12,1,5,1,12,1,5
Data 1,3,1,12,1,14,1,12,1,13,7,8,1,15,1,5,1,12,1,5,1,12,1,5
Data 1,12,1,5,1,3,1,14,1,12,1,13,1,12,7,8,1,5,1,3,1,5,1,12
Data 1,5,1,12,1,5,1,12,2,1,1,13,1,12,8,8,1,12,1,14,1,1,1,14
Data 1,12,1,14,1,12,1,14,1,1,1,13,1,12,9,8,1,14,1,12,1,14,1,1
Data 1,14,1,12,1,14,1,13,1,12,11,8,1,12,1,13,1,12,1,13,1,12,1,13
Data 1,12,117,8,1,13,1,12,1,5,1,3,1,5,2,12,1,5,1,3,1,14,1,12
Data 1,13,8,8,1,12,1,14,1,3,1,5,1,12,2,5,1,12,1,5,1,3,1,14
Data 1,12,8,8,1,13,2,3,1,12,1,5,2,12,1,5,1,12,1,5,1,3,1,13
Data 7,8,1,13,1,14,1,3,1,12,1,5,1,12,2,5,1,12,1,5,1,12,1,5
Data 1,3,4,8,1,12,1,13,1,12,1,14,1,12,2,3,1,12,1,5,2,12,1,5
Data 1,12,1,14,1,3,1,13,4,8,1,14,1,12,3,3,1,12,1,3,1,5,1,12
Data 2,5,1,12,1,5,1,3,1,14,1,12,4,8,1,12,1,5,1,3,1,14,1,12
Data 4,3,2,12,1,5,1,3,1,5,1,12,1,13,4,8,1,14,1,3,1,5,1,12
Data 1,5,1,12,1,5,1,12,4,3,1,5,1,12,1,14,1,12,4,8,2,3,1,12
Data 1,5,1,12,1,5,1,12,1,5,1,12,1,3,3,12,1,14,1,12,5,8,1,5
Data 1,3,1,5,1,12,1,5,2,12,2,5,1,3,1,12,2,14,1,12,1,13,5,8
Data 1,5,1,3,1,5,1,12,1,5,1,12,1,5,1,12,1,14,1,3,1,14,2,12
Data 1,14,6,8,1,3,1,5,1,3,1,5,1,12,1,5,1,12,1,14,1,12,1,3
Data 1,12,2,14,1,12,6,8,1,5,1,12,1,5,1,3,1,14,1,12,1,14,1,12
Data 1,14,1,3,1,14,1,12,1,13,7,8,1,12,1,14,1,12,1,5,3,3,1,5
Data 1,3,1,5,1,12,1,13,8,8,1,14,1,12,1,14,1,12,1,14,1,12,1,14
Data 1,12,1,13,1,12,1,0,9,8,1,12,1,13,1,12,1,13,1,12,1,13,1,12
Data 1,13,1,0,98,8,1,13,1,3,2,5,1,3,1,13,14,8,1,3,1,14,2,12
Data 1,5,1,3,14,8,1,13,1,12,2,5,1,12,1,13,14,8,1,12,1,14,2,12
Data 1,14,1,12,14,8,1,13,1,12,2,5,1,12,1,13,14,8,1,3,1,14,2,12
Data 1,14,1,3,13,8,1,13,1,14,1,12,2,5,1,12,1,5,7,8,1,12,1,13
Data 1,3,1,13,1,12,1,3,1,12,1,15,1,12,1,5,1,12,1,3,1,13,7,8
Data 1,14,1,3,1,14,1,12,1,14,1,12,1,3,1,12,1,15,1,12,1,3,1,5
Data 8,8,1,15,1,5,1,12,1,5,1,12,1,5,1,12,1,5,1,12,1,5,1,12
Data 1,13,8,8,1,15,1,5,1,12,1,5,1,12,1,5,1,12,1,3,1,12,1,14
Data 1,13,9,8,1,14,1,3,1,14,1,12,1,14,1,12,1,14,1,12,1,13,1,3
Data 10,8,1,12,1,13,1,3,1,13,1,12,1,3,1,12,1,13,160,8,1,1,2,3
Data 1,1,16,8,1,1,2,3,1,1,16,8,1,13,2,12,1,13,16,8,1,3,2,5
Data 1,3,16,8,1,13,2,3,1,13,16,8,1,3,2,5,1,3,15,8,1,13,1,5
Data 1,15,1,12,1,13,14,8,1,13,1,5,1,12,2,5,1,0,8,8,1,12,1,13
Data 1,12,1,13,1,3,1,13,3,3,2,12,9,8,1,3,1,12,1,3,1,12,1,3
Data 1,15,1,5,1,12,2,3,1,0,9,8,1,5,1,12,1,5,1,12,1,5,1,15
Data 1,5,1,12,1,3,11,8,1,12,1,13,1,12,1,13,1,3,1,13,1,3,1,0
Data 257,8,2,6,3,8,2,6,1,7,7,8,1,13,1,8,1,13,1,8,3,6,1,7
Data 3,8,2,7,1,13,7,8,1,6,2,8,2,6,2,7,1,8,1,0,3,6,1,7
Data 8,8,2,7,1,15,2,7,1,8,1,0,5,6,1,7,6,8,2,7,1,8,1,15
Data 2,6,1,7,7,6,1,7,4,8,1,6,4,7,2,6,1,7,7,6,1,7,2,6
Data 2,8,1,6,4,7,2,6,1,7,7,6,1,7,1,6,1,8,1,6,2,8,2,7
Data 1,8,1,15,2,6,1,7,7,6,1,7,3,8,1,6,2,8,2,7,1,15,2,7
Data 1,8,1,0,5,6,1,7,4,8,1,6,1,8,1,6,2,8,2,6,2,7,1,8
Data 1,0,3,6,1,7,4,8,1,6,1,8,1,13,1,8,1,13,1,8,3,6,1,7
Data 3,8,2,7,1,13,3,8,1,13,7,8,2,6,3,8,2,6,1,7,5,8,1,13
Data 138,8,1,10,8,8,1,10,7,8,1,2,1,8,1,10,8,8,1,10,2,2,5,8
Data 2,11,1,2,1,8,1,2,10,8,1,2,2,8,1,10,2,2,1,8,1,2,9,8
Data 1,10,1,2,1,8,1,2,1,8,4,2,10,8,1,10,1,15,2,2,1,11,2,2
Data 2,11,2,2,8,8,1,10,1,8,1,15,1,2,2,11,2,2,2,11,3,2,6,8
Data 1,10,6,2,1,11,3,2,1,11,2,2,6,8,1,10,6,2,1,11,3,2,1,11
Data 2,2,7,8,1,10,1,8,1,15,1,2,2,11,2,2,2,11,3,2,8,8,1,10
Data 1,15,2,2,1,11,2,2,2,11,2,2,10,8,1,10,1,2,1,8,1,2,1,8
Data 4,2,14,8,1,2,2,8,1,10,2,2,1,8,1,2,9,8,1,10,2,2,5,8,2
Data 11,1,2,1,8,1,2,8,8,1,10,7,8,1,2,1,8,1,10,20,8,1,10,42,8

PaletteVALUES:
Data 18,18,18,50,44,36,0,42,0,56,50,42
Data 63,0,0,51,43,30,48,48,52,42,42,42
Data 0,14,0,54,24,63,21,63,21,0,30,0
Data 34,22,21,32,32,32,45,37,24,63,63,63

Sub DrawSCREEN

    For Col = 1 To 32
        PutSPRITE Col, 1, Stone
        PutSPRITE Col, 24, Stone
    Next Col
    For Row = 1 To 24
        PutSPRITE 1, Row, Stone
        PutSPRITE 32, Row, Stone
    Next Row

    Color 4
    Locate 3, 5: Print "LIVES:"
    Locate 3, 34: Print "R A T T L E R"
    Locate 3, 65: Print "SCORE:"
    For x = 254 To 376
        For y = 32 To 45
            PSet (x + 4, y - 30), 15
        Next y
    Next x
    For x = 254 To 376
        For y = 32 To 45
            If Point(x, y) = 4 Then
                PSet (x + 6, y - 29), 0
                PSet (x + 5, y - 30), 5
            End If
            PSet (x, y), 0
        Next y
    Next x
    Line (258, 1)-(378, 1), 0
    Line (258, 1)-(258, 15), 0
    For x = 26 To 99
        For y = 32 To 45
            PSet (x + 4, y - 30), 15
        Next y
    Next x
    For x = 26 To 99
        For y = 32 To 45
            If Point(x, y) = 4 Then PSet (x + 6, y - 30), 0
            PSet (x, y), 0
        Next y
    Next x
    Line (28, 1)-(103, 1), 0
    Line (28, 1)-(28, 15), 0
    For x = 504 To 607
        For y = 32 To 45
            If Point(x, y) = 4 Then
                PSet (x + 4, y - 30), 0
            Else
                PSet (x + 4, y - 30), 15
            End If
            PSet (x, y), 0
        Next y
    Next x
    Line (508, 1)-(611, 1), 0
    Line (508, 1)-(508, 15), 0
    Locate 28, 5: Print "LEVEL:"
    For x = 28 To 98
        For y = 432 To 445
            If Point(x, y) = 4 Then
                PSet (x, y + 32), 0
            Else
                PSet (x, y + 32), 15
            End If
            PSet (x, y), 0
        Next y
    Next x
    Line (28, 463)-(98, 463), 0
    Line (28, 463)-(28, 476), 0
    Locate 28, 70: Print "SPEED:"
    For x = 548 To 612
        For y = 432 To 445
            If Point(x, y) = 4 Then
                PSet (x, y + 32), 0
            Else
                PSet (x, y + 32), 15
            End If
            PSet (x, y), 0
        Next y
    Next x
    Line (548, 463)-(612, 463), 0
    Line (548, 463)-(548, 476), 0

    Line (267, 463)-(371, 476), 15, BF
    Line (267, 463)-(371, 463), 0
    Line (267, 463)-(267, 476), 0
    Line (20, 20)-(619, 459), 8, BF

End Sub

Function EndGAME

    If Lives = 0 Then
        RemainingLIVES& = 1
    Else
        RemainingLIVES& = Lives
    End If
    FinalSCORE& = Score * RemainingLIVES& * 10&

    Get (166, 152)-(472, 327), BigBOX()
    Line (166, 152)-(472, 327), 0, BF
    Line (168, 154)-(470, 325), 8, B
    Line (170, 156)-(468, 323), 7, B
    Line (172, 158)-(466, 321), 6, B

    If FinalSCORE& > ScoreDATA(9).PlayerSCORE Then
        Color 4
        Locate 12, 31
        Print "- G A M E  O V E R -"
        Color 3
        If Lives = 0 Then
            Locate 13, 30
            Print "(Sorry, no more lives)"
        Else
            Locate 13, 33
            Print "Congratulations!"
        End If

        Hundred$ = LTrim$(Str$(FinalSCORE& Mod 1000))
        If FinalSCORE& >= 1000 Then
            If Val(Hundred$) = 0 Then Hundred$ = "000"
            If Val(Hundred$) < 100 Then Hundred$ = "0" + Hundred$
            Thousand$ = LTrim$(Str$(FinalSCORE& \ 1000))
            FinalSCORE$ = Thousand$ + "," + Hundred$
        Else
            FinalSCORE$ = Hundred$
        End If
        Color 6: Locate 15, 28: Print "Your final score is ";
        Color 15: Print FinalSCORE$
        Color 9
        Locate 16, 26: Print "Enter your name to record score"
        Locate 17, 26: Print "(Just press ENTER to decline):"
        Color 15
        Locate 19, 26: Input ; Name$
        If Len(Name$) Then
            ScoreDATA(10).PlayerNAME = Left$(Name$, 20)
            ScoreDATA(10).PlayDATE = Date$
            ScoreDATA(10).PlayerSCORE = FinalSCORE&
            For a = 0 To 10
                For B = a To 10
                    If ScoreDATA(B).PlayerSCORE > ScoreDATA(a).PlayerSCORE Then
                        Swap ScoreDATA(B), ScoreDATA(a)
                    End If
                Next B
            Next a

            TopTEN

            Open "rattler.top" For Output As #1
            For Reps = 0 To 9
                Write #1, ScoreDATA(Reps).PlayerNAME
                Write #1, ScoreDATA(Reps).PlayDATE
                Write #1, ScoreDATA(Reps).PlayerSCORE
            Next Reps
            Close #1
        End If
    End If

    Line (176, 160)-(462, 317), 0, BF
    Color 4: Locate 14, 31: Print "- G A M E  O V E R -"
    Color 9
    Locate 16, 26: Print "Start new game......"
    Locate 17, 26: Print "QUIT................"
    Color 6
    Locate 16, 47: Print "Press [1]"
    Locate 17, 47: Print "Press [2]"

    Do
        k$ = InKey$
    Loop Until k$ = "1" Or k$ = "2" Or k$ = Chr$(27)
    If k$ = "1" Then EndGAME = 1: Exit Function
    Palette: Color 7: Cls
    System

End Function

Sub InitGAME

    SetSPEED = 9
    SpeedLEVEL = 3
    Level = 1
    Lives = 5
    Score = 0
    CrittersLEFT = 10

End Sub

Sub InitLEVEL

    Erase SnakePIT
    SnakeLENGTH = 11
    StartCOL = 22

    For n = 1 To SnakeLENGTH
        StartCOL = StartCOL - 1
        Rattler(n).Col = StartCOL
        Rattler(n).Row = 22
        Rattler(n).TURN = 0
        Rattler(n).WhichWAY = Right
        Select Case n
            Case 1: Rattler(n).BodyPART = Head
            Case 2: Rattler(n).BodyPART = Neck
            Case 3: Rattler(n).BodyPART = Shoulders
            Case 4: Rattler(n).BodyPART = Body
            Case 5: Rattler(n).BodyPART = Body
            Case 6: Rattler(n).BodyPART = Shoulders
            Case 7: Rattler(n).BodyPART = Neck
            Case 8: Rattler(n).BodyPART = Tail
            Case 9: Rattler(n).BodyPART = TailEND
            Case 10: Rattler(n).BodyPART = Rattle
            Case 11: Rattler(n).BodyPART = Blank
        End Select
    Next n

    PrintNUMS 1, Lives
    PrintNUMS 2, Score
    PrintNUMS 3, Level
    PrintNUMS 5, SpeedLEVEL

    For n = 1 To SnakeLENGTH
        RCol = Rattler(n).Col
        RRow = Rattler(n).Row
        RIndex = Rattler(n).BodyPART + Rattler(n).TURN + Rattler(n).WhichWAY
        PutSPRITE RCol, RRow, RIndex
    Next n
    SnakePIT(Rattler(SnakeLENGTH).Col, Rattler(SnakeLENGTH).Row) = 0

    For Col = 1 To 32
        SnakePIT(Col, 1) = -1
        SnakePIT(Col, 24) = -1
    Next Col
    For Row = 2 To 23
        SnakePIT(1, Row) = -1
        SnakePIT(32, Row) = -1
    Next Row

    Line (271, 466)-(368, 474), 15, BF
    For x = 271 To 361 Step 10
        Count = Count + 1
        If Count Mod 2 Then Colr = 11 Else Colr = 7
        Line (x, 466)-(x + 7, 474), Colr, BF
    Next x

End Sub

Sub Instructions

    Get (100, 100)-(539, 379), BigBOX()
    Line (100, 100)-(539, 379), 0, BF
    Line (106, 106)-(533, 373), 13, B
    Line (108, 108)-(531, 371), 7, B
    Line (110, 110)-(529, 369), 6, B

    Color 9: Locate 10, 27: Print "- I N S T R U C T I O N S -"
    Color 6
    Locate 12, 18: Print "RATTLER is a variation on the classic Microsoft"
    Locate 13, 18: Print "QBasic game NIBBLES."
    Color 15
    Locate 12, 18: Print "RATTLER": Locate 13, 30: Print "NIBBLES"
    Color 6
    Locate 15, 18: Print "Steer the Diamondback Rattler using the Arrow"
    Locate 16, 18: Print "keys, eating mice and frogs and scoring points"
    Color 15: Locate 15, 58: Print "Arrow": Color 6
    Locate 17, 18: Print "for each kill. These wary creatures cannot be"
    Locate 18, 18: Print "caught from the front or sides, however. They"
    Locate 19, 18: Print "must be snuck up on from behind, otherwise"
    Locate 20, 18: Print "they will simply jump to a new location."

    Color 13: Locate 22, 28: Print "PRESS ANY KEY TO CONTINUE..."

    a$ = Input$(1)
    Line (120, 160)-(519, 332), 0, BF
    Color 6
    Locate 12, 18: Print "With each creature eaten, the rattler grows"
    Locate 13, 18: Print "in length, making steering much more difficult"
    Locate 14, 18: Print "and increasing the chance of self-collision."
    Locate 16, 18: Print "There are ten levels, each one more hazardous"
    Locate 17, 18: Print "than the last. If the snake hits a stone wall"
    Locate 18, 18: Print "or bumps into himself, he dies. He has a total"
    Locate 19, 18: Print "of five lives. Once they are used up, the game"
    Locate 20, 18: Print "is over."
    Color 15
    Locate 16, 28: Print "ten": Locate 19, 21: Print "five"

    a$ = Input$(1)
    Line (120, 160)-(519, 332), 0, BF
    Color 6
    Locate 12, 18: Print "Often, a mouse or frog will have its back to"
    Locate 13, 18: Print "a wall, making it impossible to kill. In those"
    Locate 14, 18: Print "situations, you must attack from the front or"
    Locate 15, 18: Print "sides, forcing it to move to a location where"
    Locate 16, 18: Print "its back is exposed."
    Locate 18, 18: Print "There are five speeds to choose from. It may"
    Locate 19, 18: Print "be wise to choose a slower speed for the high-"
    Locate 20, 18: Print "er levels. The default speed is 3."
    Color 15: Locate 18, 28: Print "five": Locate 20, 50: Print "3"
    a$ = Input$(1)
    Line (120, 160)-(519, 332), 0, BF
    Color 9
    Locate 12, 18: Print "SCORING:"
    Color 6
    Locate 12, 18: Print "SCORING: Each kill scores 10 points multiplied"
    Locate 13, 18: Print "by the level of difficulty and the speed. For"
    Locate 14, 18: Print "example, at level 5, speed 3, a kill is worth"
    Locate 15, 18: Print "150 points; level 10, speed 2: 200 points."
    Locate 17, 18: Print "If you manage to complete all 10 levels, your"
    Locate 18, 18: Print "final score is then multiplied by the number"
    Locate 19, 18: Print "of remaining lives. In other words, the score"
    Locate 20, 18: Print "accurately reflects your level of achievement."
    Color 15
    Locate 12, 18: Print "SCORING"
    Locate 12, 44: Print "10": Locate 14, 36: Print "5"
    Locate 14, 45: Print "3": Locate 15, 18: Print "150"
    Locate 15, 36: Print "10": Locate 15, 46: Print "2"
    Locate 15, 49: Print "200"
    a$ = Input$(1)
    Line (120, 160)-(519, 368), 0, BF
    Color 6
    Locate 12, 18: Print "Indicators of remaining lives and the current"
    Locate 13, 18: Print "score are located at the top of the screen on"
    Color 15: Locate 12, 42: Print "lives"
    Locate 13, 18: Print "score": Color 6
    Locate 14, 18: Print "the extreme left and right, respectively."
    Locate 16, 18: Print "The current level of play can be found on the"
    Locate 17, 18: Print "bottom-left of the screen. Bottom-center you"
    Locate 18, 18: Print "will find a graph indicating the number of"
    Locate 19, 18: Print "prey remaining on the current level. The cur-"
    Locate 20, 18: Print "rent speed can be read bottom-right."
    Color 15
    Locate 16, 30: Print "level"
    Locate 18, 51: Print "number of": Locate 19, 18: Print "prey"
    Locate 20, 23: Print "speed"
    Color 13: Locate 22, 25: Print "PRESS ANY KEY TO RETURN TO GAME..."
    a$ = Input$(1)

    Put (100, 100), BigBOX(), PSet

End Sub

Sub Intro

    PutSPRITE 7, 16, Rattle + Up
    PutSPRITE 7, 15, TailEND + Up
    PutSPRITE 7, 14, Tail + Up
    PutSPRITE 7, 13, Neck + Up
    PutSPRITE 7, 12, Shoulders + Up
    PutSPRITE 7, 11, Body + Up
    PutSPRITE 7, 10, Body + TURN + UR
    PutSPRITE 8, 10, Body + Right
    PutSPRITE 9, 10, Body + TURN + RD
    PutSPRITE 9, 11, Body + TURN + DL
    PutSPRITE 8, 11, Body + TURN + LD
    PutSPRITE 8, 12, Body + TURN + DR
    PutSPRITE 9, 12, Body + TURN + RD
    PutSPRITE 9, 13, Body + Down
    PutSPRITE 9, 14, Body + TURN + DR
    PutSPRITE 10, 14, Body + TURN + RU
    PutSPRITE 10, 13, Body + Up
    PutSPRITE 10, 12, Body + Up
    PutSPRITE 10, 11, Body + Up
    PutSPRITE 10, 10, Body + TURN + UR
    PutSPRITE 11, 10, Body + Right
    PutSPRITE 12, 10, Body + TURN + RD
    PutSPRITE 12, 11, Body + Down
    PutSPRITE 12, 12, Body + Down
    PutSPRITE 12, 13, Body + Down
    PutSPRITE 12, 14, Body + TURN + DR
    PutSPRITE 13, 14, Body + Right
    PutSPRITE 11, 12, Body + Right
    PutSPRITE 13, 10, Body + Right
    PutSPRITE 14, 10, Body + Right
    PutSPRITE 15, 10, Body + Right
    PutSPRITE 16, 10, Body + Right
    PutSPRITE 17, 10, Body + Right
    PutSPRITE 14, 11, Body + Down
    PutSPRITE 14, 12, Body + Down
    PutSPRITE 14, 13, Body + Down
    PutSPRITE 14, 14, Body + TURN + DR
    PutSPRITE 15, 14, Body + Right
    PutSPRITE 16, 11, Body + Down
    PutSPRITE 16, 12, Body + Down
    PutSPRITE 16, 13, Body + Down
    PutSPRITE 16, 14, Body + TURN + DR
    PutSPRITE 17, 14, Body + Right
    PutSPRITE 18, 10, Body + Down
    PutSPRITE 18, 11, Body + Down
    PutSPRITE 18, 12, Body + Down
    PutSPRITE 18, 13, Body + Down
    PutSPRITE 18, 14, Body + TURN + DR
    PutSPRITE 19, 14, Body + Right
    PutSPRITE 20, 10, Body + TURN + UR
    PutSPRITE 21, 12, Body + Right
    PutSPRITE 21, 10, Body + Right
    PutSPRITE 20, 11, Body + Down
    PutSPRITE 20, 12, Body + Down
    PutSPRITE 20, 13, Body + Down
    PutSPRITE 20, 14, Body + TURN + DR
    PutSPRITE 21, 14, Body + Right
    PutSPRITE 22, 16, Rattle + Up
    PutSPRITE 22, 15, TailEND + Up
    PutSPRITE 22, 14, Tail + Up
    PutSPRITE 22, 13, Neck + Up
    PutSPRITE 22, 12, Shoulders + Up
    PutSPRITE 22, 11, Body + Up
    PutSPRITE 22, 10, Body + TURN + UR
    PutSPRITE 23, 10, Body + Right
    PutSPRITE 24, 10, Body + TURN + RD
    PutSPRITE 24, 11, Body + TURN + DL
    PutSPRITE 23, 11, Body + TURN + LD
    PutSPRITE 23, 12, Body + TURN + DR
    PutSPRITE 24, 12, Body + TURN + RD
    PutSPRITE 24, 13, Body + Down
    PutSPRITE 24, 14, Body + TURN + DR
    PutSPRITE 25, 14, Body + Right
    PutSPRITE 26, 14, Shoulders + TURN + RU
    PutSPRITE 26, 13, Neck + Up
    PutSPRITE 26, 12, Head + Up
    Color 13
    Locate 22, 20
    Print "Copyright (C) 2003 by Bob Seguin (Freeware)"
    For x = 152 To 496
        For y = 336 To 352
            If Point(x, y) = 0 Then PSet (x, y), 8
        Next y
    Next x
    Line (80, 106)-(560, 386), 13, B
    Line (76, 102)-(564, 390), 7, B
    SetPALETTE


    Play "MFMST200L32O0AP16AP16AP16DP16AP16AP16AP16>C<P16A"
    For Reps = 1 To 18
        GoSub Rattle1
    Next Reps

    Wipe

    Exit Sub

    '------------------------ SUBROUTINE SECTION BEGINS --------------------------
    Rattle1:
    If Reps Mod 3 = 0 Then
        Line (509, 215)-(510, 219), 4, B
        Line (508, 210)-(508, 214), 4
        Line (511, 210)-(511, 214), 4
    End If
    Hula = Hula + 1
    Play "MFT220L64O0C"
    Wait &H3DA, 8
    Wait &H3DA, 8, 8
    Select Case Hula Mod 2
        Case 0
            Put (418, 300), SpriteBOX(Rattle + Up), PSet
        Case 1
            Put (422, 300), SpriteBOX(Rattle + Up), PSet
    End Select
    Sound 30000, 1
    Wait &H3DA, 8
    Wait &H3DA, 8, 8
    Put (420, 300), SpriteBOX(Rattle + Up), PSet
    If Reps Mod 3 = 0 Then
        Line (508, 210)-(511, 219), 8, BF
    End If
    Return

End Sub

Sub PauseMENU (Item)

    Do
        Get (166, 162)-(472, 317), BigBOX()
        Line (166, 162)-(472, 317), 0, BF
        Line (168, 164)-(470, 315), 8, B
        Line (170, 166)-(468, 313), 7, B
        Line (172, 168)-(466, 311), 6, B

        Select Case Item
            Case 1
                Color 4: Locate 13, 34: Print "L E V E L -"; (Str$(Level))
                Color 15: Locate 15, 30: Print "PRESS SPACE TO BEGIN..."
                Color 9: Locate 16, 26: Print "Instructions:[I] SetSPEED:[S]"
                Locate 17, 24: Print "EXIT:[Esc] TopTEN:[T] ReSTART:[R]"
                Color 7: Locate 19, 25: Print "To pause during play press SPACE"
            Case 2
                Color 4: Locate 14, 29: Print "- G A M E  P A U S E D -"
                Color 6: Locate 15, 29: Print "Press SPACE to continue..."
                Color 9: Locate 17, 26: Print "Instructions:[I] SetSPEED:[S]"
                Locate 18, 24: Print "EXIT:[Esc] TopTEN:[T] ReSTART:[R]"
        End Select

        Do: Loop Until InKey$ = "" 'Clear INKEY$ buffer

        Do
            Do
                k$ = UCase$(InKey$)
            Loop While k$ = ""
            Select Case k$
                Case "I": GoSub CloseMENU: Instructions: Exit Do
                Case "S": GoSub CloseMENU: SpeedSET: Exit Do
                Case "R": GoSub CloseMENU: Item = -1: Exit Sub
                Case "T": GoSub CloseMENU: TopTEN: Exit Do
                Case Chr$(27): System
                Case " ": GoSub CloseMENU: Exit Sub
            End Select
        Loop
    Loop
    GoSub CloseMENU

    Exit Sub

    CloseMENU:
    Put (166, 162), BigBOX(), PSet
    Return

End Sub

Sub PlayGAME

    If Level = 0 Then InitGAME
    InitLEVEL
    SetSTONES Level
    Speed = SetSPEED

    GoSub PutPREY

    Col = 21: Row = 22
    RowINC = 0: ColINC = 1
    Direction = Right: OldDIRECTION = Right
    Increase = 0: Item = 1

    Do: Loop Until InKey$ = "" 'Clear INKEY$ buffer

    PauseMENU Item
    If Item = -1 Then GoSub ReSTART

    For Reps = 1 To 6
        GoSub Rattle2
    Next Reps

    Do
        k$ = InKey$
        Select Case k$
            Case Chr$(0) + "H"
                If RowINC <> 1 Then RowINC = -1: ColINC = 0: Direction = Up
            Case Chr$(0) + "P"
                If RowINC <> -1 Then RowINC = 1: ColINC = 0: Direction = Down
            Case Chr$(0) + "K"
                If ColINC <> 1 Then ColINC = -1: RowINC = 0: Direction = Left
            Case Chr$(0) + "M"
                If ColINC <> -1 Then ColINC = 1: RowINC = 0: Direction = Right
            Case " "
                Item = 2
                PauseMENU Item
                If Item = -1 Then GoSub ReSTART:
        End Select

        Row = Row + RowINC
        Col = Col + ColINC

        'Lengthen snake if prey has been eaten
        If Increase Then
            SnakeLENGTH = SnakeLENGTH + 1
            For n = SnakeLENGTH To SnakeLENGTH - 7 Step -1
                Rattler(n).BodyPART = Rattler(n - 1).BodyPART
            Next n
            Increase = Increase - 1
            'If snake length has been increased significantly, adjust speed
            If Increase = 0 Then
                Select Case SnakeLENGTH
                    Case 36 To 46: Speed = SetSPEED - 1
                    Case Is > 46: Speed = SetSPEED - 2
                End Select
            End If
        End If

        For n = SnakeLENGTH To 2 Step -1
            Swap Rattler(n).Row, Rattler(n - 1).Row
            Swap Rattler(n).Col, Rattler(n - 1).Col
            Swap Rattler(n).TURN, Rattler(n - 1).TURN
            Swap Rattler(n).WhichWAY, Rattler(n - 1).WhichWAY
            Swap Rattler(n).RattleDIR, Rattler(n - 1).RattleDIR
        Next n

        If Direction <> OldDIRECTION Then
            Rattler(2).TURN = TURN
            Select Case OldDIRECTION
                Case Up
                    Select Case Direction
                        Case Left: Rattler(2).WhichWAY = UL
                        Case Right: Rattler(2).WhichWAY = UR
                    End Select
                    Rattler(2).RattleDIR = Up
                Case Down
                    Select Case Direction
                        Case Left: Rattler(2).WhichWAY = DL
                        Case Right: Rattler(2).WhichWAY = DR
                    End Select
                    Rattler(2).RattleDIR = Down
                Case Left
                    Select Case Direction
                        Case Up: Rattler(2).WhichWAY = LU
                        Case Down: Rattler(2).WhichWAY = LD
                    End Select
                    Rattler(2).RattleDIR = Left
                Case Right
                    Select Case Direction
                        Case Up: Rattler(2).WhichWAY = RU
                        Case Down: Rattler(2).WhichWAY = RD
                    End Select
                    Rattler(2).RattleDIR = Right
            End Select
        End If

        Rattler(1).Row = Row
        Rattler(1).Col = Col
        Rattler(1).TURN = 0
        Rattler(1).WhichWAY = Direction
        Rattler(SnakeLENGTH).TURN = 0
        Rattler(SnakeLENGTH - 1).TURN = 0

        If Rattler(SnakeLENGTH - 2).TURN = 0 Then
            Rattler(SnakeLENGTH - 1).WhichWAY = Rattler(SnakeLENGTH - 2).WhichWAY
        Else
            Rattler(SnakeLENGTH - 1).WhichWAY = Rattler(SnakeLENGTH - 2).RattleDIR
        End If

        OldDIRECTION = Direction

        'TEST Map values
        Select Case SnakePIT(Col, Row)
            Case Is >= 1000
                If SnakePIT(Col, Row) Mod 1000 = Rattler(1).WhichWAY Then
                    If SnakePIT(Col, Row) \ 1000 = 1 Then Play "MBMST220L64O0BP16BO1P64B"
                    If SnakePIT(Col, Row) \ 1000 = 2 Then Play "MBT160L32O6A-B-B"
                    SnakePIT(Col, Row) = 0
                    PreySCORE = PreySCORE + 1
                    Score = Score + (Level * SpeedLEVEL)
                    PrintNUMS 2, Score
                    Increase = Increase + 5
                    CrittersLEFT = CrittersLEFT - 1
                    PrintNUMS 4, CrittersLEFT
                    If PreySCORE = 10 Then
                        PutSPRITE Col, Row, Blank
                        Wipe
                        PreySCORE = 0
                        CrittersLEFT = 10
                        Level = Level + 1
                        If Level = 11 Then Choice = EndGAME
                        If Choice Then GoSub ReSTART
                        PrintNUMS 3, Level
                        Exit Sub
                    End If
                    SetPREY = 1
                Else
                    SetPREY = 2
                End If
            Case Is < 0
                Play "MBMST100O0L32GFEDC"
                Lives = Lives - 1
                PrintNUMS 1, Lives
                PreySCORE = 0
                Get (188, 184)-(450, 295), BigBOX()
                Line (188, 184)-(450, 295), 0, BF
                Line (190, 186)-(448, 293), 8, B
                Line (192, 188)-(446, 291), 7, B
                Line (194, 190)-(444, 289), 6, B
                Line (196, 192)-(442, 287), 6, B
                If SnakePIT(Col, Row) = -1 Then
                    Color 4: Locate 15, 35: Print "G L O R N K !"
                    Color 9: Locate 16, 35: Print "HIT THE WALL!"
                Else
                    Color 4: Locate 15, 37: Print "O U C H !"
                    Color 9: Locate 16, 35: Print "BIT YOURSELF!"
                End If
                StartTIME! = Timer: Do: Loop While Timer < StartTIME! + 1
                Put (188, 184), BigBOX(), PSet
                If Lives = 0 Then Choice = EndGAME
                If Choice Then GoSub ReSTART
                CrittersLEFT = 10
                Wipe
                Exit Sub
        End Select

        Wait &H3DA, 8
        For n = SnakeLENGTH To 1 Step -1
            RCol = Rattler(n).Col
            RRow = Rattler(n).Row
            RIndex = Rattler(n).BodyPART + Rattler(n).TURN + Rattler(n).WhichWAY
            PutSPRITE RCol, RRow, RIndex
            If Rattler(n).BodyPART = Body Then
                For nn = n To 1 Step -1
                    If Rattler(n).BodyPART = Shoulders Then
                        n = nn
                        Exit For
                    End If
                Next nn
            End If
        Next n

        If SetPREY Then
            If SetPREY = 2 Then
                If WhichPREY = 1 Then WhichPREY = 0 Else WhichPREY = 1
            End If
            GoSub PutPREY
            SetPREY = 0
        End If

        SnakePIT(Rattler(SnakeLENGTH).Col, Rattler(SnakeLENGTH).Row) = 0

        For Reps = 1 To Speed
            Wait &H3DA, 8
            Wait &H3DA, 8, 8
        Next Reps

    Loop

    Exit Sub

    '------------------------ SUBROUTINE SECTION BEGINS --------------------------

    Rattle2:
    If Reps Mod 3 = 0 Then
        Line (420, 429)-(425, 430), 4, B
        Line (426, 428)-(430, 428), 4
        Line (426, 431)-(430, 431), 4
    End If
    Hula = Hula + 1
    Play "MFT220L64O0C"
    Wait &H3DA, 8
    Wait &H3DA, 8, 8
    Select Case Hula Mod 2
        Case 0: Put (220, 418), SpriteBOX(Rattle + Right), PSet
        Case 1: Put (220, 422), SpriteBOX(Rattle + Right), PSet
    End Select
    Sound 30000, 1
    Wait &H3DA, 8
    Wait &H3DA, 8, 8
    Put (220, 420), SpriteBOX(Rattle + Right), PSet
    If Reps Mod 3 = 0 Then
        Line (420, 428)-(430, 431), 8, BF
    End If
    If Level = 8 Then PutSPRITE 12, 21, Stone
    Return

    PutPREY:
    Do
        PreyCOL = Int(Rnd * 30) + 2
        PreyROW = Int(Rnd * 22) + 2
    Loop While SnakePIT(PreyCOL, PreyROW) <> 0
    WhichDIR = Int(Rnd * 4)
    Select Case WhichDIR
        Case 0: Way = Left
        Case 1: Way = Up
        Case 2: Way = Right
        Case 3: Way = Down
    End Select
    If WhichPREY = 1 Then
        PutSPRITE PreyCOL, PreyROW, Frog + Way
        SnakePIT(PreyCOL, PreyROW) = 1000 + Way
        WhichPREY = 0
    Else
        PutSPRITE PreyCOL, PreyROW, Mouse + Way
        SnakePIT(PreyCOL, PreyROW) = 2000 + Way
        WhichPREY = 1
    End If
    Return

    ReSTART:
    Play "MBMST200L32O0AP16AP16AP16DP16AP16AP16AP16>C<P16A"
    Level = 0
    Item = 0
    Choice = 0
    Wipe
    Exit Sub
    Return

End Sub

Sub PrintNUMS (Item, Value)

    PrintSCORE& = Value * 10&

    Select Case Item
        Case 1 'Lives
            Num$ = LTrim$(Str$(Value))
            PrintX = 89: PrintY = 2
        Case 2 'Score
            Select Case PrintSCORE&
                Case 0 To 9: Num$ = "0000"
                Case 10 To 99: Num$ = "000"
                Case 100 To 999: Num$ = "00"
                Case 1000 To 9999: Num$ = "0"
            End Select
            Num$ = Num$ + LTrim$(Str$(PrintSCORE&))
            PrintX = 568: PrintY = 2
        Case 3 'Level
            Num$ = LTrim$(Str$(Value))
            PrintX = 82: PrintY = 464
            Line (PrintX, PrintY)-(PrintX + 15, PrintY + 10), 15, BF
        Case 4 'Remaining prey
            x = Value * 10 + 271
            Line (x, 466)-(x + 8, 474), 15, BF
        Case 5 'Speed
            Num$ = LTrim$(Str$(Value))
            PrintX = 602: PrintY = 464
    End Select

    For n = 1 To Len(Num$)
        Char$ = Mid$(Num$, n, 1)
        NumDEX = (Asc(Char$) - 48) * 40
        Put (PrintX, PrintY), NumBOX(NumDEX), PSet
        PrintX = PrintX + 8
    Next n

End Sub

Sub PutSPRITE (Col, Row, Index)

    Put ((Col - 1) * 20, (Row - 1) * 20), SpriteBOX(Index), PSet

    Select Case Index
        Case Stone: SnakePIT(Col, Row) = -1
        Case Else: SnakePIT(Col, Row) = -2
    End Select

End Sub

Sub SetPALETTE

    Restore PaletteVALUES
    For Colr = 0 To 15
        Out &H3C8, Colr
        Read Red: Out &H3C9, Red
        Read Grn: Out &H3C9, Grn
        Read Blu: Out &H3C9, Blu
    Next Colr

End Sub

Sub SetSTONES (Level)

    Select Case Level
        Case 2
            For Col = 10 To 23
                PutSPRITE Col, 12, Stone
                PutSPRITE Col, 13, Stone
            Next Col
        Case 3
            Row1 = 8: Row2 = 17
            For Col = 10 To 23
                PutSPRITE Col, Row1, Stone
                PutSPRITE Col, Row2, Stone
            Next Col
        Case 4
            Col1 = 9: Col2 = 24
            For Row = 7 To 18
                If Row = 12 Then Row = 14
                PutSPRITE Col1, Row, Stone
                PutSPRITE Col2, Row, Stone
            Next Row
            For Col = 10 To 23
                PutSPRITE Col, 7, Stone
                PutSPRITE Col, 18, Stone
            Next Col
        Case 5
            Col1 = 9: Col2 = 24
            For Row = 6 To 19
                PutSPRITE Col1, Row, Stone
                PutSPRITE Col2, Row, Stone
            Next Row
            For Col = 10 To 23
                If Col = 16 Then Col = 18
                PutSPRITE Col, 6, Stone
                PutSPRITE Col, 19, Stone
            Next Col
            Row = 12
            For Col = 2 To 31
                If Col = 3 Then Col = 5
                If Col = 9 Then Col = 24
                If Col = 29 Then Col = 31
                PutSPRITE Col, Row, Stone
                PutSPRITE Col, Row + 1, Stone
            Next Col
        Case 6
            Row1 = 5: Row2 = 20
            For Col = 5 To 28
                PutSPRITE Col, Row1, Stone
                PutSPRITE Col, Row2, Stone
            Next Col
            Row1 = 8: Row2 = 17
            For Col = 8 To 25
                PutSPRITE Col, Row1, Stone
                PutSPRITE Col, Row2, Stone
            Next Col
            For Row = 9 To 16
                If Row = 12 Then Row = 14
                PutSPRITE 8, Row, Stone
                PutSPRITE 25, Row, Stone
            Next Row
            Col1 = 5: Col2 = 28
            For Row = 6 To 19
                If Row = 12 Then Row = 14
                PutSPRITE Col1, Row, Stone
                PutSPRITE Col2, Row, Stone
            Next Row
            For Col = 11 To 22
                PutSPRITE Col, 11, Stone
                PutSPRITE Col, 14, Stone
            Next Col
            For Row = 2 To 23 Step 21
                PutSPRITE 16, Row, Stone
                PutSPRITE 17, Row, Stone
            Next Row
            For Col = 2 To 31 Step 29
                PutSPRITE Col, 12, Stone
                PutSPRITE Col, 13, Stone
            Next Col
        Case 7
            For Col = 14 To 19
                PutSPRITE Col, 5, Stone
            Next Col
            For Col = 12 To 13
                PutSPRITE Col, 6, Stone
                PutSPRITE Col + 8, 6, Stone
            Next Col
            PutSPRITE 11, 7, Stone
            PutSPRITE 10, 8, Stone
            PutSPRITE 9, 9, Stone
            PutSPRITE 22, 7, Stone
            PutSPRITE 23, 8, Stone
            PutSPRITE 24, 9, Stone
            For Row = 10 To 11
                PutSPRITE 8, Row, Stone
                PutSPRITE 25, Row, Stone
            Next Row
            For Col = 14 To 19
                PutSPRITE Col, 19, Stone
            Next Col
            For Col = 12 To 13
                PutSPRITE Col, 18, Stone
                PutSPRITE Col + 8, 18, Stone
            Next Col
            PutSPRITE 11, 17, Stone
            PutSPRITE 10, 16, Stone
            PutSPRITE 9, 15, Stone
            PutSPRITE 22, 17, Stone
            PutSPRITE 23, 16, Stone
            PutSPRITE 24, 15, Stone
            For Row = 13 To 14
                PutSPRITE 8, Row, Stone
                PutSPRITE 25, Row, Stone
            Next Row
            For Col = 4 To 10
                PutSPRITE Col, 4, Stone
                PutSPRITE 33 - Col, 4, Stone
                PutSPRITE Col, 20, Stone
                PutSPRITE 33 - Col, 20, Stone
            Next Col
            For Row = 4 To 11
                PutSPRITE 4, Row, Stone
                PutSPRITE 4, 24 - Row, Stone
                PutSPRITE 29, Row, Stone
                PutSPRITE 29, 24 - Row, Stone
            Next Row
            For Row = 7 To 17
                If Row = 9 Then Row = 16
                PutSPRITE 9, Row, Stone
                PutSPRITE 24, Row, Stone
            Next Row
            PutSPRITE 10, 7, Stone
            PutSPRITE 10, 17, Stone
            PutSPRITE 23, 7, Stone
            PutSPRITE 23, 17, Stone
        Case 8
            For Col = 5 To 25 Step 6
                If Col = 17 Then Col = 18
                For Row = 5 To 21 Step 4
                    PutSPRITE Col, Row, Stone
                    PutSPRITE Col + 1, Row, Stone
                    PutSPRITE Col + 3, Row, Stone
                    PutSPRITE Col + 4, Row, Stone
                Next Row
            Next Col
            For Row = 5 To 20
                For Col = 5 To 29 Step 6
                    If Col = 17 Then Col = 22
                    PutSPRITE Col, Row, Stone
                Next Col
            Next Row
            For Col = 2 To 31
                If Col = 4 Then Col = 30
                PutSPRITE Col, 12, Stone
                PutSPRITE Col, 13, Stone
            Next Col
            For Row = 2 To 3
                PutSPRITE 16, Row, Stone
                PutSPRITE 17, Row, Stone
            Next Row
        Case 9
            For Col = 6 To 24 Step 8
                For Row = 7 To 16 Step 9
                    PutSPRITE Col, Row, Stone
                    PutSPRITE Col + 1, Row - 1, Stone
                    PutSPRITE Col + 2, Row - 2, Stone
                    PutSPRITE Col + 3, Row - 2, Stone
                    PutSPRITE Col + 4, Row - 1, Stone
                    PutSPRITE Col + 5, Row, Stone
                    PutSPRITE Col, Row + 2, Stone
                    PutSPRITE Col + 1, Row + 3, Stone
                    PutSPRITE Col + 2, Row + 4, Stone
                    PutSPRITE Col + 3, Row + 4, Stone
                    PutSPRITE Col + 4, Row + 3, Stone
                    PutSPRITE Col + 5, Row + 2, Stone
                Next Row
            Next Col
            For Col = 4 To 31 Step 8
                For Row = 12 To 13
                    PutSPRITE Col, Row, Stone
                    PutSPRITE Col + 1, Row, Stone
                Next Row
            Next Col
        Case 10
            For Col = 7 To 25 Step 6
                For Row = 7 To 17 Step 5
                    For Col2 = Col To Col + 1
                        For Row2 = Row To Row + 1
                            PutSPRITE Col2, Row2, Stone
                        Next Row2
                    Next Col2
                    PutSPRITE Col - 1, Row - 1, Stone
                    PutSPRITE Col - 1, Row + 2, Stone
                    PutSPRITE Col + 2, Row - 1, Stone
                    PutSPRITE Col + 2, Row + 2, Stone
                Next Row
            Next Col
            For Col = 2 To 30 Step 28
                For Row = 2 To 22 Step 20
                    PutSPRITE Col, Row, Stone
                    PutSPRITE Col + 1, Row, Stone
                    PutSPRITE Col, Row + 1, Stone
                    PutSPRITE Col + 1, Row + 1, Stone
                Next Row
            Next Col
            PutSPRITE 4, 4, Stone
            PutSPRITE 29, 4, Stone
            PutSPRITE 4, 21, Stone
            PutSPRITE 29, 21, Stone
            For Col = 2 To 31
                If Col = 5 Then Col = 29
                PutSPRITE Col, 11, Stone
                PutSPRITE Col, 14, Stone
            Next Col
    End Select

End Sub

Sub SpeedSET

    Get (166, 142)-(472, 337), BigBOX()
    Line (166, 142)-(472, 337), 0, BF
    Line (168, 144)-(470, 335), 8, B
    Line (170, 146)-(468, 333), 7, B
    Line (172, 148)-(466, 331), 6, B

    Color 4
    Locate 12, 31: Print "- S E T  S P E E D -"
    Color 9
    Locate 13, 26: Print "The current speed setting is ";
    Print LTrim$(RTrim$(Str$(SpeedLEVEL))); "."
    Color 7
    Locate 15, 28: Print "Slow............ Press [1]"
    Locate 16, 28: Print "Moderate........ Press [2]"
    Locate 17, 28: Print "Medium.......... Press [3]"
    Locate 18, 28: Print "Quick........... Press [4]"
    Locate 19, 28: Print "Fast............ Press [5]"
    Color 6
    Locate 15, 28: Print "Slow"
    Locate 16, 28: Print "Moderate"
    Locate 17, 28: Print "Medium"
    Locate 18, 28: Print "Quick"
    Locate 19, 28: Print "Fast"
    Color 15
    Locate 15, 52: Print "1"
    Locate 16, 52: Print "2"
    Locate 17, 52: Print "3"
    Locate 18, 52: Print "4"
    Locate 19, 52: Print "5"

    Do
        n$ = InKey$
    Loop While n$ = ""
    Select Case n$
        Case "1": SpeedLEVEL = 1: SetSPEED = 25
        Case "2": SpeedLEVEL = 2: SetSPEED = 15
        Case "3": SpeedLEVEL = 3: SetSPEED = 8
        Case "4": SpeedLEVEL = 4: SetSPEED = 5
        Case "5": SpeedLEVEL = 5: SetSPEED = 2
    End Select

    PrintNUMS 5, SpeedLEVEL
    Speed = SetSPEED

    Put (166, 142), BigBOX(), PSet

End Sub

Sub TopTEN

    Get (84, 119)-(554, 359), BigBOX()
    Line (84, 119)-(554, 359), 0, BF
    Put (240, 137), TTBox(), PSet
    Color 9
    Locate 11, 15
    Print "#"; Space$(2); "NAME"; Space$(21); "DATE"; Space$(10); "SCORE"
    Color 7
    Locate 22, 26
    Print "PRESS ANY KEY TO RETURN TO GAME"
    PrintROW = 12
    For c = 0 To 9
        Locate PrintROW, 14
        Color 9: Print Using "##"; c + 1
        Color 3
        If ScoreDATA(c).PlayerSCORE > 0 Then
            Locate PrintROW, 18
            Print ScoreDATA(c).PlayerNAME
            Locate PrintROW, 40
            Print ScoreDATA(c).PlayDATE
            Locate PrintROW, 56
            Print Using "###,###"; ScoreDATA(c).PlayerSCORE
        End If
        PrintROW = PrintROW + 1
    Next c
    Line (87, 121)-(551, 357), 13, B
    Line (89, 123)-(549, 355), 13, B
    PSet (89, 123), 15
    Line (91, 125)-(547, 353), 13, B
    PSet (91, 125), 15
    Line (100, 157)-(538, 334), 13, B
    For LR = 174 To 334 Step 16
        Line (100, LR)-(538, LR), 13
    Next LR
    Line (124, 158)-(124, 334), 13
    Line (300, 158)-(300, 334), 13
    Line (402, 158)-(402, 334), 13

    a$ = Input$(1)
    Put (84, 119), BigBOX(), PSet

End Sub

Sub Wipe

    For n = 1 To 660
        Do
            x = Int(Rnd * 30)
            y = Int(Rnd * 22)
            xx = x + 1: yy = y + 1
        Loop Until WipeBOX(x, y) = 0
        Line (xx * 20, yy * 20)-(xx * 20 + 19, yy * 20 + 19), 9, BF
        Line (xx * 20, yy * 20)-(xx * 20 + 19, yy * 20 + 19), 4, BF
        Line (xx * 20, yy * 20)-(xx * 20 + 19, yy * 20 + 19), 10, BF
        Line (xx * 20, yy * 20)-(xx * 20 + 19, yy * 20 + 19), 15, BF
        Line (xx * 20, yy * 20)-(xx * 20 + 19, yy * 20 + 19), 10, BF
        Line (xx * 20, yy * 20)-(xx * 20 + 19, yy * 20 + 19), 8, BF
        WipeBOX(x, y) = 1
    Next n

    Erase WipeBOX

End Sub
