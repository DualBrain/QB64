'CHDIR ".\samples\pete\wetspot"

' WETSPOT v0.9
' by Angelo Mottola (C) 1996
'
' --------------------------------------------------------------------------
' Well, this is my first game written in QBASIC.
' Sorry, but I haven't so much time to add comments to this source, but
' I think it's pretty simple to understand.
' The target of this game is to kill every monster in less than 90 seconds
' to gain next level. You control a little crab, and you must push bricks
' towards your enemies to kill them. If you push a brick and besides it
' there is another one, the block you pushed on will be destroyed, maybe
' dropping a bonus. Bonuses are various, and someone has a particular
' function (For example: Lightning will destroy every monster on the screen).
' Not all bricks can be moved. Each level has three special blocks, and when
' you put them together, you gain a special multiplier bonus (2x or 3x if
' you put together two or three blocks).
' Look out for monsters that follow you and good luck!!
'
' Controls are:
'
'        Player One              Player Two                 General
'         Left:  4                Left:  A                  Pause: P
'         Right: 6                Right: D                  Quit:  ESC
'         Up:    8                Up:    W
'         Down:  5                Down:  S
'         Fire:  \                Fire:  ENTER
'
' Since this is not the final version, it contains only 21 levels.
' Final version will contain:
'
' - 100 levels (I hope so...)
' - 8 different enemies
' - Sound Blaster music and sound effects
'
' If you have any suggestion, mail me at
'
'                                ----------
'                                eri@cdc.it
'                                ----------
'
' --------------------------------------------------------------------------
'
'$DYNAMIC
DefInt A-Z
DECLARE SUB Intro ()
DECLARE SUB MainMenu ()
DECLARE SUB GetSprites ()
DECLARE SUB PlayGame ()
DECLARE SUB OutText (x, y, t$)
DECLARE SUB PrintStatBar ()
DECLARE SUB LoadLevel ()
DECLARE SUB DrawScreen ()
DECLARE SUB Center (y, t$)
DECLARE SUB Message (t$)
DECLARE SUB CheckBlocks ()
DECLARE SUB CheckObjects ()
DECLARE SUB MoveEnemies ()
DECLARE SUB KillPlayer (num)
DECLARE SUB PrintValue (xv, yv, va)
DECLARE SUB Delay (sbDT!)
DECLARE FUNCTION PlayAgain ()

Type BlockType
    Status As Integer
    JustMoved As Integer
    MovedBy As Integer
    x As Integer
    y As Integer
End Type
Type PlayerType
    Score As Long
    Lives As Integer
    NextLife As Long
    BonusE As Integer
    BonusX As Integer
    BonusT As Integer
    BonusR As Integer
    BonusA As Integer
    Bonus As Integer
    x As Integer
    y As Integer
    dir As Integer
    NextDir As Integer
    Spd As Integer
    Cutter As Integer
    Action As Integer
    Frame As Integer
    FrameDir As Integer
    Special As Integer
    Trapped As Integer
End Type
Type ObjectType
    Typ As Integer
    Time As Integer
    x As Integer
    y As Integer
    Alone As Integer
End Type
Type EnemyType
    Typ As Integer
    dir As Integer
    x As Integer
    y As Integer
    Flag1 As Integer
    Flag2 As Integer
    Flag3 As Integer
    Changed As Integer
End Type

Const NONE = 0, MOVE = 1, FIRE = 2, NORMAL = 0, POTION = 1, WEB = -1
Const INACTIVE = 0, FIXEDBLOCK = 1, NORMALBLOCK = 2, SPECIALBLOCK = 3
Const NMOVINGDOWN = 4, NMOVINGRIGHT = 5, NMOVINGUP = 6, NMOVINGLEFT = 7
Const SMOVINGDOWN = 8, SMOVINGRIGHT = 9, SMOVINGUP = 10, SMOVINGLEFT = 11
Const FALSE = 0, TRUE = Not FALSE

Dim Shared Cel(18, 12), Player(2) As PlayerType, Block(170) As BlockType
Dim Shared Object(60) As ObjectType, Enemy(20) As EnemyType
Dim Shared Crab&(100 * 40), Expl&(100 * 3), Wall&(100), CutHole&(100)
Dim Shared Hole&(100), Life&(20 * 2), Clock&(20), Flag&(20)
Dim Shared Number&(10 * 10), Disapp&(4 * 100), Null&(100)
Dim Shared Char&(20 * 46), FBlock&(100), NBlock&(100), SBlock&(100)
Dim Shared Obj&(100 * 27), Ball&(100 * 6), Ghost&(100 * 4), Slug&(100 * 10)
Dim Shared Robot&(100 * 16), Shadow&(100 * 12), Worm&(100 * 16)
Dim Shared Putty&(100 * 20), Spider&(100 * 19), Box&(1000), Killed
Dim Shared NumPlayer, Fx, Speed, Level, TimeLeft, s$(2), Pass, Value(10)
Dim Shared NumBlock, NumEnemy, NumObject, AbortGame, xA(4), yA(4)
Dim Shared Bonus(20), PotNum, Freezed, GameMode, Multi#, LastTime$
Dim Shared BonusAlone, Change, NumChange, NumWeb, MaxLevel

xA(0) = 0: yA(0) = 0
xA(1) = 0: yA(1) = 1
xA(2) = 1: yA(2) = 0
xA(3) = 0: yA(3) = -1
xA(4) = -1: yA(4) = 0
Restore
For i = 1 To 4: Read xA(i), yA(i): Next i
For i = 1 To 8: Read Value(i): Next i


'ON ERROR GOTO ErrorHandle

Screen 13
GetSprites
Intro
Do
    MainMenu
    PlayGame
    If Not PlayAgain Then Exit Do
Loop

Screen 0: Width 80
Print "WetSpot v0.9"
Print "(C) by Angelo Mottola soft 1996"
Print: Print "Final release will include:"
Print " - 100 levels (I hope so...)"
Print " - 8 different enemies"
Print " - Sound Blaster Music and sound effects"
Print " - More and more fun !!"
Print: Print "Coming soon..."
Print: End

ErrorHandle:
Screen 0: Width 80: Cls
Color 15, 1: Locate 1, 1: Print Space$(80);
Locate 1, 1: Print "ERROR: ";
Select Case Err
    Case 53: Print "Game file not found !";
    Case 61: Print "Disk full or error accessing disk.";
    Case 70: Print "Disk access denied !";
    Case 71: Print "Error accessing disk !";
    Case Else: Print "Abnormal program termination (error code:", Err, ").";
End Select
Color 7, 0: Locate 2, 1: Print "Coming back to system ..."
End

Data 0,1,1,0,0,-1,-1,0,100,150,200,250,200,350,300,400,20,20

Rem $STATIC
Sub Center (y, t$)
    x = (320 - (Len(t$) * 7)) / 2
    OutText x, y, t$
End Sub

Sub CheckBlocks
    For B = 1 To 170
        If Block(B).Status <> 0 Then
            Select Case Block(B).Status
                Case Is > 3
                    Put (Block(B).x * 16, -8 + (Block(B).y * 16)), Null&(), PSet
                    Select Case Block(B).Status
                        Case NMOVINGDOWN
                            If Cel(Block(B).x, Block(B).y + 1) < 1 Then
                                Cel(Block(B).x, Block(B).y) = 0: Block(B).y = Block(B).y + 1
                                Cel(Block(B).x, Block(B).y) = NORMALBLOCK
                                For nb = 1 To 170
                                    If Block(nb).x = Block(B).x And Block(nb).y = Block(B).y And nb <> B Then Block(nb).Status = 0: Exit For
                                Next nb
                                Put (Block(B).x * 16, -8 + (Block(B).y * 16)), NBlock&(), PSet
                                Block(B).JustMoved = FALSE
                            Else
                                If Block(B).JustMoved = FALSE Then
                                    Block(B).Status = NORMALBLOCK
                                    Put (Block(B).x * 16, -8 + (Block(B).y * 16)), NBlock&(), PSet
                                Else
                                    For o = 1 To 60
                                        If Object(o).Typ = 0 And Object(o + 1).Typ = 0 Then Exit For
                                    Next o
                                    Player(Block(B).MovedBy).Score = Player(Block(B).MovedBy).Score + (10 * Multi#): PrintStatBar
                                    Object(o).Typ = -3: Object(o).Time = 1: Object(o).Alone = FALSE
                                    Object(o).x = Block(B).x * 16: Object(o).y = -8 + (Block(B).y * 16)
                                    Block(B).Status = NONE: Cel(Block(B).x, Block(B).y) = 0
                                    Put (Block(B).x * 16, -8 + (Block(B).y * 16)), Null&(), PSet
                                    Randomize Timer
                                    m = Int(Rnd(1) * 3) + 1
                                    If m = 1 Then
                                        w = Int(Rnd(1) * 20) + 1
                                        If Bonus(w) = 15 Then Bonus(w) = 14
                                        Object(o + 1).Typ = Bonus(w): Object(o + 1).Time = 50
                                        Object(o + 1).x = Block(B).x * 16: Object(o + 1).y = -8 + (Block(B).y * 16)
                                    End If
                                End If
                            End If
                        Case SMOVINGDOWN
                            If Cel(Block(B).x, Block(B).y + 1) < 1 Then
                                Cel(Block(B).x, Block(B).y) = 0: Block(B).y = Block(B).y + 1
                                Cel(Block(B).x, Block(B).y) = SPECIALBLOCK
                                For nb = 1 To 170
                                    If Block(nb).x = Block(B).x And Block(nb).y = Block(B).y And nb <> B Then Block(nb).Status = 0: Exit For
                                Next nb
                                Put (Block(B).x * 16, -8 + (Block(B).y * 16)), SBlock&(), PSet
                                Block(B).JustMoved = FALSE
                            Else
                                If Block(B).JustMoved = FALSE Then
                                    Block(B).Status = SPECIALBLOCK
                                    Put (Block(B).x * 16, -8 + (Block(B).y * 16)), SBlock&(), PSet
                                Else
                                    For o = 1 To 60
                                        If Object(o).Typ = 0 And Object(o + 1).Typ = 0 Then Exit For
                                    Next o
                                    Player(Block(B).MovedBy).Score = Player(Block(B).MovedBy).Score + (10 * Multi#): PrintStatBar
                                    Object(o).Typ = -3: Object(o).Time = 1: Object(o).Alone = FALSE
                                    Object(o).x = Block(B).x * 16: Object(o).y = -8 + (Block(B).y * 16)
                                    Block(B).Status = NONE: Cel(Block(B).x, Block(B).y) = 0
                                    Put (Block(B).x * 16, -8 + (Block(B).y * 16)), Null&(), PSet
                                    Randomize Timer
                                    m = Int(Rnd(1) * 3) + 1
                                    If m = 1 Then
                                        w = Int(Rnd(1) * 20) + 1
                                        If Bonus(w) = 15 Then Bonus(w) = 14
                                        Object(o + 1).Typ = Bonus(w): Object(o + 1).Time = 50
                                        Object(o + 1).x = Block(B).x * 16: Object(o + 1).y = -8 + (Block(B).y * 16)
                                    End If
                                End If
                            End If
                        Case NMOVINGRIGHT
                            If Cel(Block(B).x + 1, Block(B).y) < 1 Then
                                Cel(Block(B).x, Block(B).y) = 0: Block(B).x = Block(B).x + 1
                                Cel(Block(B).x, Block(B).y) = NORMALBLOCK
                                For nb = 1 To 170
                                    If Block(nb).x = Block(B).x And Block(nb).y = Block(B).y And nb <> B Then Block(nb).Status = 0: Exit For
                                Next nb
                                Put (Block(B).x * 16, -8 + (Block(B).y * 16)), NBlock&(), PSet
                                Block(B).JustMoved = FALSE
                            Else
                                If Block(B).JustMoved = FALSE Then
                                    Block(B).Status = NORMALBLOCK
                                    Put (Block(B).x * 16, -8 + (Block(B).y * 16)), NBlock&(), PSet
                                Else
                                    For o = 1 To 60
                                        If Object(o).Typ = 0 And Object(o + 1).Typ = 0 Then Exit For
                                    Next o
                                    Player(Block(B).MovedBy).Score = Player(Block(B).MovedBy).Score + (10 * Multi#): PrintStatBar
                                    Object(o).Typ = -3: Object(o).Time = 1: Object(o).Alone = FALSE
                                    Object(o).x = Block(B).x * 16: Object(o).y = -8 + (Block(B).y * 16)
                                    Block(B).Status = NONE: Cel(Block(B).x, Block(B).y) = 0
                                    Put (Block(B).x * 16, -8 + (Block(B).y * 16)), Null&(), PSet
                                    Randomize Timer
                                    m = Int(Rnd(1) * 3) + 1
                                    If m = 1 Then
                                        w = Int(Rnd(1) * 20) + 1
                                        If Bonus(w) = 15 Then Bonus(w) = 14
                                        Object(o + 1).Typ = Bonus(w): Object(o + 1).Time = 50
                                        Object(o + 1).x = Block(B).x * 16: Object(o + 1).y = -8 + (Block(B).y * 16)
                                    End If
                                End If
                            End If
                        Case SMOVINGRIGHT
                            If Cel(Block(B).x + 1, Block(B).y) < 1 Then
                                Cel(Block(B).x, Block(B).y) = 0: Block(B).x = Block(B).x + 1
                                Cel(Block(B).x, Block(B).y) = SPECIALBLOCK
                                For nb = 1 To 170
                                    If Block(nb).x = Block(B).x And Block(nb).y = Block(B).y And nb <> B Then Block(nb).Status = 0: Exit For
                                Next nb
                                Put (Block(B).x * 16, -8 + (Block(B).y * 16)), SBlock&(), PSet
                                Block(B).JustMoved = FALSE
                            Else
                                If Block(B).JustMoved = FALSE Then
                                    Block(B).Status = SPECIALBLOCK
                                    Put (Block(B).x * 16, -8 + (Block(B).y * 16)), SBlock&(), PSet
                                Else
                                    For o = 1 To 60
                                        If Object(o).Typ = 0 And Object(o + 1).Typ = 0 Then Exit For
                                    Next o
                                    Player(Block(B).MovedBy).Score = Player(Block(B).MovedBy).Score + (10 * Multi#): PrintStatBar
                                    Object(o).Typ = -3: Object(o).Time = 1: Object(o).Alone = FALSE
                                    Object(o).x = Block(B).x * 16: Object(o).y = -8 + (Block(B).y * 16)
                                    Block(B).Status = NONE: Cel(Block(B).x, Block(B).y) = 0
                                    Put (Block(B).x * 16, -8 + (Block(B).y * 16)), Null&(), PSet
                                    Randomize Timer
                                    m = Int(Rnd(1) * 3) + 1
                                    If m = 1 Then
                                        w = Int(Rnd(1) * 20) + 1
                                        If Bonus(w) = 15 Then Bonus(w) = 14
                                        Object(o + 1).Typ = Bonus(w): Object(o + 1).Time = 50
                                        Object(o + 1).x = Block(B).x * 16: Object(o + 1).y = -8 + (Block(B).y * 16)
                                    End If
                                End If
                            End If
                        Case NMOVINGUP
                            If Cel(Block(B).x, Block(B).y - 1) < 1 Then
                                Cel(Block(B).x, Block(B).y) = 0: Block(B).y = Block(B).y - 1
                                Cel(Block(B).x, Block(B).y) = NORMALBLOCK
                                For nb = 1 To 170
                                    If Block(nb).x = Block(B).x And Block(nb).y = Block(B).y And nb <> B Then Block(nb).Status = 0: Exit For
                                Next nb
                                Put (Block(B).x * 16, -8 + (Block(B).y * 16)), NBlock&(), PSet
                                Block(B).JustMoved = FALSE
                            Else
                                If Block(B).JustMoved = FALSE Then
                                    Block(B).Status = NORMALBLOCK
                                    Put (Block(B).x * 16, -8 + (Block(B).y * 16)), NBlock&(), PSet
                                Else
                                    For o = 1 To 60
                                        If Object(o).Typ = 0 And Object(o + 1).Typ = 0 Then Exit For
                                    Next o
                                    Player(Block(B).MovedBy).Score = Player(Block(B).MovedBy).Score + (10 * Multi#): PrintStatBar
                                    Object(o).Typ = -3: Object(o).Time = 1: Object(o).Alone = FALSE
                                    Object(o).x = Block(B).x * 16: Object(o).y = -8 + (Block(B).y * 16)
                                    Block(B).Status = NONE: Cel(Block(B).x, Block(B).y) = 0
                                    Put (Block(B).x * 16, -8 + (Block(B).y * 16)), Null&(), PSet
                                    Randomize Timer
                                    m = Int(Rnd(1) * 3) + 1
                                    If m = 1 Then
                                        w = Int(Rnd(1) * 20) + 1
                                        If Bonus(w) = 15 Then Bonus(w) = 14
                                        Object(o + 1).Typ = Bonus(w): Object(o + 1).Time = 50
                                        Object(o + 1).x = Block(B).x * 16: Object(o + 1).y = -8 + (Block(B).y * 16)
                                    End If
                                End If
                            End If
                        Case SMOVINGUP
                            If Cel(Block(B).x, Block(B).y - 1) < 1 Then
                                Cel(Block(B).x, Block(B).y) = 0: Block(B).y = Block(B).y - 1
                                Cel(Block(B).x, Block(B).y) = SPECIALBLOCK
                                For nb = 1 To 170
                                    If Block(nb).x = Block(B).x And Block(nb).y = Block(B).y And nb <> B Then Block(nb).Status = 0: Exit For
                                Next nb
                                Put (Block(B).x * 16, -8 + (Block(B).y * 16)), SBlock&(), PSet
                                Block(B).JustMoved = FALSE
                            Else
                                If Block(B).JustMoved = FALSE Then
                                    Block(B).Status = SPECIALBLOCK
                                    Put (Block(B).x * 16, -8 + (Block(B).y * 16)), SBlock&(), PSet
                                Else
                                    For o = 1 To 60
                                        If Object(o).Typ = 0 And Object(o + 1).Typ = 0 Then Exit For
                                    Next o
                                    Player(Block(B).MovedBy).Score = Player(Block(B).MovedBy).Score + (10 * Multi#): PrintStatBar
                                    Object(o).Typ = -3: Object(o).Time = 1: Object(o).Alone = FALSE
                                    Object(o).x = Block(B).x * 16: Object(o).y = -8 + (Block(B).y * 16)
                                    Block(B).Status = NONE: Cel(Block(B).x, Block(B).y) = 0
                                    Put (Block(B).x * 16, -8 + (Block(B).y * 16)), Null&(), PSet
                                    Randomize Timer
                                    m = Int(Rnd(1) * 3) + 1
                                    If m = 1 Then
                                        w = Int(Rnd(1) * 20) + 1
                                        If Bonus(w) = 15 Then Bonus(w) = 14
                                        Object(o + 1).Typ = Bonus(w): Object(o + 1).Time = 50
                                        Object(o + 1).x = Block(B).x * 16: Object(o + 1).y = -8 + (Block(B).y * 16)
                                    End If
                                End If
                            End If
                        Case NMOVINGLEFT
                            If Cel(Block(B).x - 1, Block(B).y) < 1 Then
                                Cel(Block(B).x, Block(B).y) = 0: Block(B).x = Block(B).x - 1
                                Cel(Block(B).x, Block(B).y) = NORMALBLOCK
                                For nb = 1 To 170
                                    If Block(nb).x = Block(B).x And Block(nb).y = Block(B).y And nb <> B Then Block(nb).Status = 0: Exit For
                                Next nb
                                Put (Block(B).x * 16, -8 + (Block(B).y * 16)), NBlock&(), PSet
                                Block(B).JustMoved = FALSE
                            Else
                                If Block(B).JustMoved = FALSE Then
                                    Block(B).Status = NORMALBLOCK
                                    Put (Block(B).x * 16, -8 + (Block(B).y * 16)), NBlock&(), PSet
                                Else
                                    For o = 1 To 60
                                        If Object(o).Typ = 0 And Object(o + 1).Typ = 0 Then Exit For
                                    Next o
                                    Player(Block(B).MovedBy).Score = Player(Block(B).MovedBy).Score + (10 * Multi#): PrintStatBar
                                    Object(o).Typ = -3: Object(o).Time = 1: Object(o).Alone = FALSE
                                    Object(o).x = Block(B).x * 16: Object(o).y = -8 + (Block(B).y * 16)
                                    Block(B).Status = NONE: Cel(Block(B).x, Block(B).y) = 0
                                    Put (Block(B).x * 16, -8 + (Block(B).y * 16)), Null&(), PSet
                                    Randomize Timer
                                    m = Int(Rnd(1) * 3) + 1
                                    If m = 1 Then
                                        w = Int(Rnd(1) * 20) + 1
                                        If Bonus(w) = 15 Then Bonus(w) = 14
                                        Object(o + 1).Typ = Bonus(w): Object(o + 1).Time = 50
                                        Object(o + 1).x = Block(B).x * 16: Object(o + 1).y = -8 + (Block(B).y * 16)
                                    End If
                                End If
                            End If
                        Case SMOVINGLEFT
                            If Cel(Block(B).x - 1, Block(B).y) < 1 Then
                                Cel(Block(B).x, Block(B).y) = 0: Block(B).x = Block(B).x - 1
                                Cel(Block(B).x, Block(B).y) = SPECIALBLOCK
                                For nb = 1 To 170
                                    If Block(nb).x = Block(B).x And Block(nb).y = Block(B).y And nb <> B Then Block(nb).Status = 0: Exit For
                                Next nb
                                Put (Block(B).x * 16, -8 + (Block(B).y * 16)), SBlock&(), PSet
                                Block(B).JustMoved = FALSE
                            Else
                                If Block(B).JustMoved = FALSE Then
                                    Block(B).Status = SPECIALBLOCK
                                    Put (Block(B).x * 16, -8 + (Block(B).y * 16)), SBlock&(), PSet
                                Else
                                    For o = 1 To 60
                                        If Object(o).Typ = 0 And Object(o + 1).Typ = 0 Then Exit For
                                    Next o
                                    Player(Block(B).MovedBy).Score = Player(Block(B).MovedBy).Score + (10 * Multi#): PrintStatBar
                                    Object(o).Typ = -3: Object(o).Time = 1: Object(o).Alone = FALSE
                                    Object(o).x = Block(B).x * 16: Object(o).y = -8 + (Block(B).y * 16)
                                    Block(B).Status = NONE: Cel(Block(B).x, Block(B).y) = 0
                                    Put (Block(B).x * 16, -8 + (Block(B).y * 16)), Null&(), PSet
                                    Randomize Timer
                                    m = Int(Rnd(1) * 3) + 1
                                    If m = 1 Then
                                        w = Int(Rnd(1) * 20) + 1
                                        If Bonus(w) = 15 Then Bonus(w) = 14
                                        Object(o + 1).Typ = Bonus(w): Object(o + 1).Time = 50
                                        Object(o + 1).x = Block(B).x * 16: Object(o + 1).y = -8 + (Block(B).y * 16)
                                    End If
                                End If
                            End If
                    End Select
                    xb = Block(B).x * 16: yb = -8 + (Block(B).y * 16)
                    For e = 1 To 20
                        If Enemy(e).Typ <> 0 Then
                            If Enemy(e).x > xb - 16 And Enemy(e).x < xb + 16 Then
                                If Enemy(e).y > yb - 16 And Enemy(e).y < yb + 16 Then
                                    For o = 1 To 60: If Object(o).Typ = 0 And Object(o + 1).Typ = 0 Then Exit For
                                    Next o
                                    Object(o).Typ = -3: Object(o).Time = 1
                                    Object(o).x = Enemy(e).x: Object(o).y = -8 + Enemy(e).y
                                    Put (Enemy(e).x, -8 + Enemy(e).y), Null&(), PSet
                                    If Enemy(e).Typ = 3 And Enemy(e).Flag3 <> 0 Then Put (Enemy(e).Flag1, -8 + Enemy(e).Flag2), Null&(), PSet
                                    Object(o + 1).Typ = (Value(Enemy(e).Typ) * Multi#): Object(o + 1).Time = 50
                                    Object(o + 1).x = Enemy(e).x: Object(o + 1).y = -8 + Enemy(e).y
                                    NumEnemy = NumEnemy - 1
                                    Player(Block(B).MovedBy).Score = Player(Block(B).MovedBy).Score + (Value(Enemy(e).Typ) * Multi#)
                                    Enemy(e).Typ = 0: PrintStatBar
                                End If
                            End If
                        End If
                    Next e
                    For u = 1 To NumPlayer
                        If Player(u).x > xb - 16 And Player(u).x < xb + 16 Then
                            If -8 + Player(u).y > yb - 16 And -8 + Player(u).y < yb + 16 Then
                                KillPlayer u
                                Player(u).Lives = Player(u).Lives - 1
                                Killed = TRUE: PrintStatBar
                            End If
                        End If
                    Next u
                Case FIXEDBLOCK
                    Put (Block(B).x * 16, -8 + (Block(B).y * 16)), FBlock&(), PSet
                Case NORMALBLOCK
                    Put (Block(B).x * 16, -8 + (Block(B).y * 16)), NBlock&(), PSet
                Case SPECIALBLOCK
                    Put (Block(B).x * 16, -8 + (Block(B).y * 16)), SBlock&(), PSet
                    If Multi# = 1 Then
                        If Cel(Block(B).x + 1, Block(B).y) = SPECIALBLOCK Then Multi# = 2
                        If Cel(Block(B).x - 1, Block(B).y) = SPECIALBLOCK Then Multi# = 2
                        If Cel(Block(B).x, Block(B).y + 1) = SPECIALBLOCK Then Multi# = 2
                        If Cel(Block(B).x, Block(B).y - 1) = SPECIALBLOCK Then Multi# = 2
                    End If
                    If Multi# = 2 Then
                        If (Cel(Block(B).x, Block(B).y + 1) = SPECIALBLOCK) And (Cel(Block(B).x, Block(B).y - 1) = SPECIALBLOCK) Then Multi# = 3
                        If (Cel(Block(B).x + 1, Block(B).y) = SPECIALBLOCK) And (Cel(Block(B).x - 1, Block(B).y) = SPECIALBLOCK) Then Multi# = 3
                    End If
                Case WEB
                    Put (Block(B).x * 16, -8 + (Block(B).y * 16)), Spider&(1600), PSet
            End Select
        End If
    Next B

End Sub

Sub CheckObjects
    For o = 1 To 60
        If Object(o).Typ <> 0 Then
            Object(o).Time = Object(o).Time - 1
            Select Case Object(o).Typ
                Case -7
                    Put (Object(o).x, Object(o).y), Disapp&(0), PSet
                    If Object(o).Time = 0 Then Object(o).Typ = -6: Object(o).Time = 3
                Case -6
                    Put (Object(o).x, Object(o).y), Disapp&(100), PSet
                    If Object(o).Time = 0 Then Object(o).Typ = -5: Object(o).Time = 3
                Case -5
                    Put (Object(o).x, Object(o).y), Disapp&(200), PSet
                    If Object(o).Time = 0 Then Object(o).Typ = -4: Object(o).Time = 3
                Case -4
                    Put (Object(o).x, Object(o).y), Disapp&(300), PSet
                    If Object(o).Time = 0 Then Object(o).Typ = 0: Put (Object(o).x, Object(o).y), Null&(), PSet
                Case -3
                    Put (Object(o).x, Object(o).y), Expl&(0), PSet
                    If Object(o).Time = 0 Then Object(o).Typ = -2: Object(o).Time = 1
                Case -2
                    Put (Object(o).x, Object(o).y), Expl&(100), PSet
                    If Object(o).Time = 0 Then Object(o).Typ = -1: Object(o).Time = 1
                Case -1
                    Put (Object(o).x, Object(o).y), Expl&(200), PSet
                    If Object(o).Time = 0 Then Object(o).Typ = 0: Put (Object(o).x, Object(o).y), Null&(), PSet
                Case 1 TO 27
                    Put (Object(o).x, Object(o).y), Obj&((Object(o).Typ - 1) * 100), PSet
                    For p = 1 To NumPlayer
                        If Object(o).x > Player(p).x - 16 And Object(o).x < Player(p).x + 16 Then
                            If Object(o).y > Player(p).y - 24 And Object(o).y < Player(p).y + 8 Then
                                Select Case Object(o).Typ
                                    Case 1 TO 9
                                        If Object(o).Alone = TRUE Then Object(o).Alone = FALSE: BonusAlone = FALSE
                                        Player(p).Score = Player(p).Score + ((Object(o).Typ * 100) * Multi#)
                                        PrintStatBar
                                        Object(o).Typ = (Object(o).Typ * 100) * Multi#
                                        Object(o).Time = 50
                                    Case 10 TO 12
                                        If Object(o).Alone = TRUE Then Object(o).Alone = FALSE: BonusAlone = FALSE
                                        Player(p).Score = Player(p).Score + ((1000 + ((Object(o).Typ - 10) * 500)) * Multi#)
                                        PrintStatBar
                                        Object(o).Typ = ((1000 + ((Object(o).Typ - 10) * 500)) * Multi#): Object(o).Time = 50
                                    Case 13
                                        Player(p).Score = Player(p).Score + (500 * Multi#)
                                        PrintStatBar
                                        Object(o).Typ = (500 * Multi#): Object(o).Time = 50
                                        Player(p).Cutter = TRUE
                                        Put ((304 * (p - 1)), 8), CutHole&(), PSet
                                        Put ((304 * (p - 1)), 8), Obj&(1200), Xor
                                    Case 14
                                        Randomize Timer
                                        m = Int(Rnd(1) * 4) + 1
                                        Select Case m
                                            Case 1
                                                Player(p).Score = Player(p).Score + (3000 * Multi#)
                                                PrintStatBar
                                                Object(o).Typ = (3000 * Multi#): Object(o).Time = 50
                                            Case 2
                                                Randomize Timer
                                                g = Int(Rnd(1) * 5) + 1
                                                Change = g: NumChange = 0
                                                For r = 1 To 20
                                                    If Enemy(r).Typ <> 0 Then
                                                        Enemy(r).Changed = FALSE: NumChange = NumChange + 1
                                                    End If
                                                Next r
                                                Object(o).Typ = (50 * Multi#): Object(o).Time = 50
                                                Player(p).Score = Player(p).Score + (50 * Multi#): PrintStatBar
                                            Case 3
                                                Player(p).Spd = 1
                                                Object(o).Typ = (50 * Multi#): Object(o).Time = 50
                                                Player(p).Score = Player(p).Score + (50 * Multi#): PrintStatBar
                                            Case 4
                                                Player(p).Lives = Player(p).Lives + 1
                                                Object(o).Typ = (500 * Multi#): Object(o).Time = 50
                                                Player(p).Score = Player(p).Score + (500 * Multi#): PrintStatBar
                                        End Select
                                    Case 15
                                        GameMode = POTION: NumEnemy = 1: Pass = -1
                                        For f = 1 To 170: If Block(f).Status <> 0 Then Block(f).Status = FIXEDBLOCK: Put (Block(f).x * 16, -8 + (Block(f).y * 16)), FBlock&(), PSet
                                        Next f
                                        For f = 1 To 20: Enemy(f).Typ = 0: Next f
                                        For f = 1 To 60: Object(f).Typ = 0: Next f
                                        PotNum = 0
                                        For v = 1 To 12: For vv = 1 To 18
                                            If Cel(vv, v) = 0 Then
                                                Put (vv * 16, -8 + (v * 16)), Null&(), PSet
                                                Randomize Timer * TimeLeft
                                                g = Int(Rnd(1) * 4) + 1
                                                If g = 1 And PotNum < 50 Then
                                                    PotNum = PotNum + 1
                                                    Object(PotNum).Typ = 21: Object(PotNum).Time = -1
                                                    Object(PotNum).x = vv * 16: Object(PotNum).y = -8 + (v * 16)
                                                    End If
                                                End If
                                        Next vv, v
                                        TimeLeft = PotNum + (PotNum / 8)
                                        Player(1).Special = 0: Player(2).Special = 0
                                    Case 16
                                        Player(p).Score = Player(p).Score + (500 * Multi#)
                                        PrintStatBar
                                        Object(o).Typ = (500 * Multi#): Object(o).Time = 50
                                        TimeLeft = TimeLeft + 10
                                    Case 17
                                        For w = 1 To 20
                                            If Enemy(w).Typ <> 0 Then
                                                Enemy(w).Typ = 0
                                                For j = 1 To 60: If Object(j).Typ = 0 Then Exit For
                                                Next j
                                                Object(j).Typ = -3: Object(j).Time = 3
                                                Object(j).x = Enemy(w).x: Object(j).y = -8 + Enemy(w).y
                                            End If
                                        Next w
                                        NumEnemy = 0
                                        Player(p).Score = Player(p).Score + (500 * Multi#)
                                        Object(o).Typ = (500 * Multi#): Object(o).Time = 50
                                    Case 18
                                        Freezed = 500
                                        Player(p).Score = Player(p).Score + (1000 * Multi#)
                                        PrintStatBar
                                        Object(o).Typ = (500 * Multi#): Object(o).Time = 50
                                    Case 19
                                        Pass = 1: Message "YOU ENTERED!": Level = Level + Int(Rnd(1) * 5)
                                    Case 20
                                        Player(p).Lives = Player(p).Lives + 1
                                        Player(p).Score = Player(p).Score + (500 * Multi#)
                                        PrintStatBar
                                        Object(o).Typ = (500 * Multi#): Object(o).Time = 50
                                    Case 21
                                        Player(p).Special = Player(p).Special + 1
                                        Object(o).Typ = 200: Object(o).Time = 50
                                        PotNum = PotNum - 1: If PotNum = 0 Then Pass = 1
                                    Case 22 TO 26
                                        Player(p).Score = Player(p).Score + (300 * Multi#)
                                        PrintStatBar
                                        Select Case Object(o).Typ
                                            Case 22
                                                If Player(p).BonusE <> TRUE Then Player(p).BonusE = TRUE: Player(p).Bonus = Player(p).Bonus + 1
                                            Case 23
                                                If Player(p).BonusX <> TRUE Then Player(p).BonusX = TRUE: Player(p).Bonus = Player(p).Bonus + 1
                                            Case 24
                                                If Player(p).BonusT <> TRUE Then Player(p).BonusT = TRUE: Player(p).Bonus = Player(p).Bonus + 1
                                            Case 25
                                                If Player(p).BonusR <> TRUE Then Player(p).BonusR = TRUE: Player(p).Bonus = Player(p).Bonus + 1
                                            Case 26
                                                If Player(p).BonusA <> TRUE Then Player(p).BonusA = TRUE: Player(p).Bonus = Player(p).Bonus + 1
                                        End Select
                                        Put ((p - 1) * 304, 64 + ((Object(o).Typ - 22) * 16)), Hole&(), PSet
                                        Put ((p - 1) * 304, 64 + ((Object(o).Typ - 22) * 16)), Obj&((Object(o).Typ - 1) * 100), Xor
                                        If Player(p).Bonus = 5 Then
                                            Player(p).Bonus = 0
                                            Player(p).BonusE = FALSE
                                            Player(p).BonusX = FALSE
                                            Player(p).BonusT = FALSE
                                            Player(p).BonusR = FALSE
                                            Player(p).BonusA = FALSE
                                            Player(p).Lives = Player(p).Lives + 1: PrintStatBar
                                            For Z = 0 To 11: Put ((p - 1) * 304, 8 + (Z * 16)), Wall&(), PSet: Next Z
                                        End If
                                        Object(o).Typ = 300: Object(o).Time = 50
                                    Case 27
                                        Randomize Timer
                                        ty = Int(Rnd(1) * 12) + 1
                                        For bo = 1 To 15
                                            For sel = 1 To 60
                                                If Object(sel).Typ = 0 Then
                                                    Object(sel).Typ = ty: Object(sel).Time = 500
                                                    Do
                                                        Randomize Timer
                                                        xo = Int(Rnd(1) * 18) + 1: yo = Int(Rnd(1) * 12) + 1
                                                        If Cel(xo, yo) = 0 Then Exit Do
                                                    Loop
                                                    Object(sel).x = xo * 16: Object(sel).y = -8 + (yo * 16)
                                                    Exit For
                                                End If
                                            Next sel
                                        Next bo
                                        Object(o).Typ = 0: Put (Object(o).x, Object(o).y), Null&(), PSet
                                End Select
                            End If
                        End If
                    Next p
                    If Object(o).Time = 0 Then Object(o).Typ = -7: Object(o).Time = 3
                Case Is > 30
                    PrintValue Object(o).x, Object(o).y, Object(o).Typ
                    If Object(o).Time = 0 Then Object(o).Typ = 0: Put (Object(o).x, Object(o).y), Null&(), PSet
            End Select
        End If
    Next o
End Sub

Sub Delay (sbDT!)
    If sbDT! = 0! Then Exit Sub
    sbstart! = Timer
    Do While Timer <= (sbstart! + sbDT!): Loop
End Sub

Sub DrawScreen
    For i = 1 To 18: For ii = 1 To 12
        Select Case Cel(i, ii)
            Case WEB: Put (i * 16, -8 + (ii * 16)), Spider&(1600), PSet
            Case FIXEDBLOCK: Put (i * 16, -8 + (ii * 16)), FBlock&(), PSet
                Case NORMALBLOCK: Put (i * 16, -8 + (ii * 16)), NBlock&(), PSet
                Case SPECIALBLOCK: Put (i * 16, -8 + (ii * 16)), SBlock&(), PSet
            End Select
    Next ii, i
End Sub

Sub GetSprites
    Cls: For i = 0 To 255: Palette i, 0: Next i
    Def Seg = &HA000: BLoad "wetspot.p13", 0
    For i = 0 To 1: For ii = 0 To 19
        Get (ii * 16, i * 16)-((ii * 16) + 15, (i * 16) + 15), Crab&((2000 * i) + (100 * ii))
    Next ii, i
    For i = 0 To 2: Get (i * 16, 32)-((i * 16) + 15, 47), Expl&(i * 100): Next i
    For i = 0 To 4: Get ((i * 16) + 48, 32)-((i * 16) + 63, 47), Obj&((i * 100) + 2100): Next i
    Get (128, 32)-(143, 47), Wall&(): Get (144, 32)-(159, 47), Hole&()
    Get (304, 32)-(319, 47), CutHole&()
    For i = 0 To 1: Get (160 + (i * 8), 32)-(167 + (i * 8), 39), Life&(i * 20): Next i
    For i = 0 To 9: Get (177 + (i * 4), 32)-(180 + (i * 4), 35), Number&(i * 10): Next i
    Get (160, 40)-(167, 47), Clock&(): Get (168, 40)-(175, 47), Flag&()
    For i = 0 To 3: Get (224 + (i * 16), 32)-(239 + (i * 16), 47), Disapp&(i * 100): Next i
    Get (288, 32)-(303, 47), Obj&(2600)
    For i = 0 To 44: Get (i * 7, 48)-((i * 7) + 6, 55), Char&(i * 20): Next i
    Get (0, 190)-(6, 197), Char&(900): Get (0, 180)-(15, 195), Null&()
    For i = 0 To 19: Get (i * 16, 56)-((i * 16) + 15, 71), Obj&(i * 100): Next i
    For i = 0 To 5: Get (i * 16, 72)-((i * 16) + 15, 87), Ball&(i * 100): Next i
    For i = 0 To 3: Get (96 + (i * 16), 72)-(111 + (i * 16), 87), Ghost&(i * 100): Next i
    For i = 0 To 9: Get (160 + (i * 16), 72)-(175 + (i * 16), 87), Slug&(i * 100): Next i
    For i = 0 To 15: Get (i * 16, 88)-((i * 16) + 15, 103), Robot&(i * 100): Next i
    For i = 0 To 15: Get (i * 16, 104)-((i * 16) + 15, 119), Worm&(i * 100): Next i
    For i = 0 To 19: Get (i * 16, 120)-((i * 16) + 15, 135), Putty&(i * 100): Next i
    For i = 0 To 18: Get (i * 16, 136)-((i * 16) + 15, 151), Spider&(i * 100): Next i
    For i = 0 To 11: Get (i * 16, 152)-((i * 16) + 15, 167), Shadow&(i * 100): Next i
    Cls: Palette
End Sub

Sub Intro
    ' Sorry, but I haven't so much time to do an Intro for this game !!!
End Sub

Sub KillPlayer (num)
    'TIMER OFF
    Put (Player(num).x, -8 + Player(num).y), Crab&(((num - 1) * 2000) + 1900), PSet
    Delay .08
    For q = 0 To 2
        Put (Player(num).x, -8 + Player(num).y), Expl&(q * 100), PSet
        Delay .08
    Next q
    Put (Player(num).x, -8 + Player(num).y), Null&(), PSet
End Sub

Sub LoadLevel
    If Level > MaxLevel Then
        Screen 0: Width 80
        Print "WetSpot v0.9"
        Print "(C) by Angelo Mottola soft 1996"
        Print: Print "Sorry, this demo version supports only" + Str$(MaxLevel) + " levels"
        Print: Print "Final release will include:"
        Print " - 100 levels (I hope so...)"
        Print " - 8 different enemies"
        Print " - Sound Blaster Music and sound effects"
        Print " - More and more fun !!"
        Print: Print "Coming soon..."
        Print: End
    End If
    Cls: For p = 0 To 255: Palette p, 0: Next p
    Def Seg = &HA000: BLoad "level" + LTrim$(Str$(Level)) + ".p13", 0
    Get (0, 0)-(15, 15), FBlock&(): Get (16, 0)-(31, 15), NBlock&()
    Get (32, 0)-(47, 15), SBlock&(): Get (68, 0)-(83, 15), Obj&(2000)
    For i = 1 To 18: For ii = 1 To 12: Cel(i, ii) = 0: Next ii, i
    NumBlock = 0: NumEnemy = 0
    For i = 1 To 170: Block(i).Status = INACTIVE: Next i
    For i = 1 To 20: Enemy(i).Typ = 0: Next i
    For i = 1 To 60: Object(i).Typ = 0: Next i

    For i = 1 To 18: For ii = 1 To 12
        Select Case Point(47 + i, ii - 1)
            Case 1
                Cel(i, ii) = FIXEDBLOCK: NumBlock = NumBlock + 1
                Block(NumBlock).Status = FIXEDBLOCK
                Block(NumBlock).x = i: Block(NumBlock).y = ii
            Case 2
                    Cel(i, ii) = NORMALBLOCK: NumBlock = NumBlock + 1
                    Block(NumBlock).Status = NORMALBLOCK
                    Block(NumBlock).x = i: Block(NumBlock).y = ii
                Case 3
                    Cel(i, ii) = SPECIALBLOCK: NumBlock = NumBlock + 1
                    Block(NumBlock).Status = SPECIALBLOCK
                    Block(NumBlock).x = i: Block(NumBlock).y = ii
                Case 4
                    Player(1).x = i * 16: Player(1).y = ii * 16
                Case 5
                    Player(2).x = i * 16: Player(2).y = ii * 16
                Case 6, 7, 8, 9, 10, 11, 12, 13
                    NumEnemy = NumEnemy + 1
                    Enemy(NumEnemy).Typ = Point(47 + i, ii - 1) - 5
                    Enemy(NumEnemy).dir = 1: Enemy(NumEnemy).x = i * 16: Enemy(NumEnemy).y = ii * 16
                    Select Case Point(47 + i, ii - 1)
                        Case 6: Enemy(NumEnemy).Flag1 = 1: Enemy(NumEnemy).dir = 2
                        Case 7: Enemy(NumEnemy).Flag1 = 1: Enemy(NumEnemy).Flag2 = Int(Rnd(1) * NumPlayer) + 1
                        Case 8: Enemy(NumEnemy).Flag3 = 0
                        Case 9: Enemy(NumEnemy).Flag1 = 1: Enemy(NumEnemy).Flag2 = FALSE: Enemy(NumEnemy).Flag3 = 1
                        Case 10: Enemy(NumEnemy).Flag1 = 2: Enemy(NumEnemy).Flag2 = 1: Enemy(NumEnemy).Flag3 = 0
                        Case 11: Enemy(NumEnemy).Flag1 = 1
                        Case 12: Enemy(NumEnemy).Flag1 = 2
                        Case 13: Enemy(NumEnemy).Flag1 = 4
                    End Select
                Case 14
                    Cel(i, ii) = WEB: NumBlock = NumBlock + 1
                    Block(NumBlock).Status = WEB
                    Block(NumBlock).x = i: Block(NumBlock).y = ii
            End Select
    Next ii, i
    For i = 1 To 20: Bonus(i) = Point(47 + i, 12): Next i
    Cls
    Palette
End Sub

Sub MainMenu
    Cls
    Def Seg = &HA000: BLoad "title.p13", 0
    Palette
    Center 58, "BY ANGELO MOTTOLA SOFT 1996"
    Center 82, "VERSION 0.9"
    Center 103, "PRESS 1 FOR 1 PLAYER GAME"
    Center 113, "PRESS 2 FOR 2 PLAYERS GAME"
    Center 123, "PRESS ESC TO QUIT GAME!"
    Center 145, "- FINAL VERSION COMING SOON !! -"
    Do
        k$ = InKey$
        If k$ = "1" Then NumPlayer = 1: Exit Do
        If k$ = "2" Then NumPlayer = 2: Exit Do
        If k$ = Chr$(27) Then NumPlayer = 0: Exit Do
    Loop

    If NumPlayer = 0 Then
        Screen 0: Width 80
        Print "WetSpot v0.9"
        Print "(C) by Angelo Mottola soft 1996"
        Print: Print "Final version coming soon!!"
        Print: End
    End If

    Cls
End Sub

Sub Message (t$)
    For i = 192 To 96 Step -4
        Get (0, i)-(319, i + 7), Box&()
        Center i, t$
        For t = 0 To 5000: Next t
        Put (0, i), Box&(), PSet
    Next i
    Get (0, 96)-(319, 103), Box&()
    Center 96, t$
    q$ = InKey$: While (q$ <> Chr$(13) And q$ <> "\"): q$ = InKey$: Wend
    Put (0, 96), Box&(), PSet
    For i = 96 To 8 Step -4
        Get (0, i)-(319, i + 7), Box&()
        Center i, t$
        For t = 0 To 5000: Next t
        Put (0, i), Box&(), PSet
    Next i
End Sub

Sub MoveEnemies
    For e = 1 To 20
        If Enemy(e).Typ <> 0 Then
            If Change <> FALSE Then
                If Enemy(e).Changed = FALSE Then
                    If Enemy(e).x Mod 16 = 0 And Enemy(e).y Mod 16 = 0 Then
                        Enemy(e).Changed = TRUE: Enemy(e).Typ = Change
                        NumChange = NumChange - 1
                        Select Case Change
                            Case 1
                                Enemy(e).Flag1 = 1
                                If Enemy(e).dir = 1 Or Enemy(e).dir = 2 Then Enemy(e).Flag2 = 1 Else Enemy(e).Flag2 = -1
                            Case 2
                                Enemy(e).Flag1 = 1: Enemy(e).Flag2 = Int(Rnd(1) * NumPlayer) + 1
                            Case 3
                                Enemy(e).Flag3 = 0
                            Case 4
                                Enemy(e).Flag1 = 1: Enemy(e).Flag2 = FALSE: Enemy(e).Flag3 = 1
                            Case 5
                                Enemy(e).Flag1 = 2: Enemy(e).Flag2 = 1: Enemy(e).Flag3 = 0
                        End Select
                        If NumChange = 0 Then Change = FALSE
                    End If
                End If
            End If
            Select Case Enemy(e).Typ
                Case 1
                    If Freezed = FALSE Then
                        If Enemy(e).x Mod 16 = 0 And Enemy(e).y Mod 16 = 0 Then
                            Enemy(e).dir = 0
                            For h = 1 To 20
                                Randomize Timer * TimeLeft
                                d = Int(Rnd(1) * 4) + 1
                                If Cel((Enemy(e).x / 16) + xA(d), (Enemy(e).y / 16) + yA(d)) < 1 Then
                                    Enemy(e).dir = d: Enemy(e).Flag1 = 1
                                    If Enemy(e).dir = 1 Or Enemy(e).dir = 2 Then Enemy(e).Flag2 = 1 Else Enemy(e).Flag2 = -1
                                    Exit For
                                End If
                                d = 0
                            Next h
                        End If
                        Put (Enemy(e).x, -8 + Enemy(e).y), Null&(), PSet
                        Enemy(e).x = Enemy(e).x + xA(Enemy(e).dir)
                        Enemy(e).y = Enemy(e).y + yA(Enemy(e).dir)
                        Enemy(e).Flag1 = Enemy(e).Flag1 + Enemy(e).Flag2
                        If Enemy(e).Flag1 = 0 Then
                            Enemy(e).Flag1 = 8
                        ElseIf Enemy(e).Flag1 = 9 Then
                            Enemy(e).Flag1 = 1
                        End If
                    End If
                    If Enemy(e).dir = 0 Then Enemy(e).dir = 2
                    If Enemy(e).dir = 1 Or Enemy(e).dir = 3 Then h = 0 Else h = 1
                    Put (Enemy(e).x, -8 + Enemy(e).y), Worm&((h * 800) + ((Enemy(e).Flag1 - 1) * 100)), PSet
                Case 2
                    If Freezed = FALSE Then
                        If Enemy(e).x Mod 16 = 0 And Enemy(e).y Mod 16 = 0 Then
                            Randomize Timer * TimeLeft
                            k = Int(Rnd(1) * 4) + 1
                            If k < 4 Then
                                k = Int(Rnd(1) * 100) + 1
                                If k = 1 Then Enemy(e).Flag2 = Int(Rnd(1) * NumPlayer) + 1
                                If Player(Enemy(e).Flag2).x < Enemy(e).x Then d = 4
                                If Player(Enemy(e).Flag2).x > Enemy(e).x Then d = 2
                                If (Cel((Enemy(e).x / 16) + xA(d), (Enemy(e).y / 16) + yA(d)) <> 0) Then
                                    If Player(Enemy(e).Flag2).y < Enemy(e).y Then d = 3
                                    If Player(Enemy(e).Flag2).y > Enemy(e).y Then d = 1
                                End If
                                If Player(Enemy(e).Flag2).x = Enemy(e).x Then
                                    If Player(Enemy(e).Flag2).y < Enemy(e).y Then d = 3
                                    If Player(Enemy(e).Flag2).y > Enemy(e).y Then d = 1
                                End If
                            Else
                                d = Int(Rnd(1) * 4) + 1
                            End If
                            If Cel((Enemy(e).x / 16) + xA(d), (Enemy(e).y / 16) + yA(d)) <> 0 Then
                                For h = 1 To 20
                                    Randomize Timer * TimeLeft
                                    d = Int(Rnd(1) * 4) + 1
                                    If Cel((Enemy(e).x / 16) + xA(d), (Enemy(e).y / 16) + yA(d)) = 0 Then
                                        Exit For
                                    End If
                                    d = 0
                                Next h
                            End If
                            Enemy(e).dir = d
                        End If
                        Put (Enemy(e).x, -8 + Enemy(e).y), Null&(), PSet
                        Enemy(e).x = Enemy(e).x + (xA(Enemy(e).dir) * 2)
                        Enemy(e).y = Enemy(e).y + (yA(Enemy(e).dir) * 2)
                        Enemy(e).Flag1 = Enemy(e).Flag1 + 1
                        If Enemy(e).Flag1 = 5 Then Enemy(e).Flag1 = 1
                    End If
                    If Enemy(e).dir = 0 Then Enemy(e).dir = 1
                    Put (Enemy(e).x, -8 + Enemy(e).y), Robot&(((Enemy(e).dir - 1) * 400) + ((Enemy(e).Flag1 - 1) * 100)), PSet
                Case 3
                    If Freezed = FALSE Then
                        If Enemy(e).Flag3 > 0 Then
                            Enemy(e).Flag3 = Enemy(e).Flag3 - 1
                            If Enemy(e).Flag3 Mod 2 = 0 Then
                                Put (Enemy(e).x, -8 + Enemy(e).y), Ghost&((Enemy(e).dir - 1) * 100), PSet
                                Put (Enemy(e).Flag1, -8 + Enemy(e).Flag2), Null&(), PSet
                            Else
                                Put (Enemy(e).x, -8 + Enemy(e).y), Null&(), PSet
                                Put (Enemy(e).Flag1, -8 + Enemy(e).Flag2), Ghost&((Enemy(e).dir - 1) * 100), PSet
                            End If
                        Else
                            If Enemy(e).x Mod 16 = 0 And Enemy(e).y Mod 16 = 0 Then
                                Enemy(e).dir = 0
                                If Cel((Enemy(e).x / 16) + xA(Enemy(e).dir), (Enemy(e).y / 16) + yA(Enemy(e).dir)) < 1 Then
                                    For h = 1 To 20
                                        Randomize Timer * TimeLeft
                                        d = Int(Rnd(1) * 4) + 1
                                        If Cel((Enemy(e).x / 16) + xA(d), (Enemy(e).y / 16) + yA(d)) < 1 Then
                                            Enemy(e).dir = d
                                            Exit For
                                        End If
                                        d = 0
                                    Next h
                                Else
                                    Randomize Timer * TimeLeft
                                    s = Int(Rnd(1) * 2) + 1
                                    If s = 1 Then
                                        k = Int(Rnd(1) * NunmPlayer) + 1
                                        If Player(k).x < Enemy(e).x Then d = 4
                                        If Player(k).x > Enemy(e).x Then d = 2
                                        If Player(k).y < Enemy(e).y Then d = 3
                                        If Player(k).y > Enemy(e).y Then d = 1
                                        If Cel((Enemy(e).x / 16) + xA(d), (Enemy(e).y / 16) + yA(d)) < 1 Then
                                            For h = 1 To 20
                                                Randomize Timer * TimeLeft
                                                d = Int(Rnd(1) * 4) + 1
                                                If Cel((Enemy(e).x / 16) + xA(d), (Enemy(e).y / 16) + yA(d)) < 1 Then
                                                    Enemy(e).dir = d
                                                    Exit For
                                                End If
                                            Next h
                                        Else
                                            Enemy(e).dir = d
                                        End If
                                    End If
                                End If
                                k = Int(Rnd(1) * 25) + 1
                                If k = 1 Then
                                    Do
                                        Randomize Timer * TimeLeft
                                        xc = Int(Rnd(1) * 18) + 1: yc = Int(Rnd(1) * 12) + 1
                                        If Cel(xc, yc) = 0 Then Exit Do
                                    Loop
                                    Enemy(e).Flag1 = Enemy(e).x: Enemy(e).Flag2 = Enemy(e).y
                                    Enemy(e).Flag3 = 50: Enemy(e).dir = Int(Rnd(1) * 4) + 1
                                    Enemy(e).x = xc * 16: Enemy(e).y = yc * 16
                                End If
                            End If
                            If Enemy(e).Flag3 = 0 Then
                                Put (Enemy(e).x, -8 + Enemy(e).y), Null&(), PSet
                                Enemy(e).x = Enemy(e).x + xA(Enemy(e).dir)
                                Enemy(e).y = Enemy(e).y + yA(Enemy(e).dir)
                                If Enemy(e).dir = 0 Then Enemy(e).dir = 1
                                Put (Enemy(e).x, -8 + Enemy(e).y), Ghost&((Enemy(e).dir - 1) * 100), PSet
                            End If
                        End If
                    Else
                        Put (Enemy(e).x, -8 + Enemy(e).y), Ghost&((Enemy(e).dir - 1) * 100), PSet
                    End If
                Case 4
                    If Freezed = FALSE Then
                        If Enemy(e).Flag2 > FALSE Then
                            Enemy(e).Flag2 = Enemy(e).Flag2 - 1
                            If Enemy(e).Flag2 = 5 Then
                                For k = 1 To 4
                                    Find = FALSE
                                    For h = 1 To 20
                                        If Enemy(h).Typ < 1 Then Find = TRUE: Exit For
                                    Next h
                                    If Find = TRUE Then
                                        If Cel((Enemy(e).x / 16) + xA(k), (Enemy(e).y / 16) + yA(k)) = 0 Then
                                            Enemy(h).Typ = 9: Enemy(h).dir = k
                                            Enemy(h).x = Enemy(e).x + (xA(k) * 16)
                                            Enemy(h).y = Enemy(e).y + (yA(k) * 16)
                                        End If
                                    End If
                                Next k
                            End If
                            Put (Enemy(e).x, -8 + Enemy(e).y), Slug&(800), PSet
                        Else
                            If Enemy(e).x Mod 16 = 0 And Enemy(e).y Mod 16 = 0 Then
                                k = Int(Rnd(1) * 15) + 1
                                If k = 1 Then Enemy(e).Flag2 = 40: Enemy(e).dir = 0
                                If k <> 1 Then
                                    If Cel((Enemy(e).x / 16) + xA(Enemy(e).dir), (Enemy(e).y / 16) + yA(Enemy(e).dir)) <> 0 Then
                                        Randomize Timer * TimeLeft
                                        s = Int(Rnd(1) * 2) + 1
                                        If s = 1 Then
                                            k = Int(Rnd(1) * NunmPlayer) + 1
                                            If Player(k).x < Enemy(e).x Then d = 4
                                            If Player(k).x > Enemy(e).x Then d = 2
                                            If Player(k).y < Enemy(e).y Then d = 3
                                            If Player(k).y > Enemy(e).y Then d = 1
                                            If Cel((Enemy(e).x / 16) + xA(d), (Enemy(e).y / 16) + yA(d)) <> 0 Then
                                                For h = 1 To 20
                                                    Randomize Timer * TimeLeft
                                                    d = Int(Rnd(1) * 4) + 1
                                                    If Cel((Enemy(e).x / 16) + xA(d), (Enemy(e).y / 16) + yA(d)) = 0 Then
                                                        Enemy(e).dir = d
                                                        Exit For
                                                    Else
                                                        Enemy(e).dir = 0
                                                    End If
                                                Next h
                                            Else
                                                Enemy(e).dir = d
                                            End If
                                        Else
                                            For h = 1 To 20
                                                Randomize Timer * TimeLeft
                                                d = Int(Rnd(1) * 4) + 1
                                                If Cel((Enemy(e).x / 16) + xA(d), (Enemy(e).y / 16) + yA(d)) = 0 Then
                                                    Exit For
                                                Else
                                                    d = 0
                                                End If
                                            Next h
                                            Enemy(e).dir = d
                                        End If
                                    Else
                                        For h = 1 To 20
                                            Randomize Timer * TimeLeft
                                            d = Int(Rnd(1) * 4) + 1
                                            If Cel((Enemy(e).x / 16) + xA(d), (Enemy(e).y / 16) + yA(d)) = 0 Then
                                                Enemy(e).dir = d
                                                Exit For
                                            Else
                                                d = 0
                                            End If
                                        Next h
                                    End If
                                End If
                            End If
                            Put (Enemy(e).x, -8 + Enemy(e).y), Null&(), PSet
                            Enemy(e).x = Enemy(e).x + xA(Enemy(e).dir)
                            Enemy(e).y = Enemy(e).y + yA(Enemy(e).dir)
                            Enemy(e).Flag3 = Enemy(e).Flag3 + 1
                            If Enemy(e).Flag3 = 20 Then Enemy(e).Flag3 = 1
                            If Enemy(e).Flag3 > 10 Then j = 1 Else j = 0
                            If Enemy(e).dir = 0 Then Enemy(e).dir = 1
                            Put (Enemy(e).x, -8 + Enemy(e).y), Slug&(((Enemy(e).dir - 1) * 200) + (j * 100)), PSet
                            If Enemy(e).dir = 0 Then Enemy(e).dir = 1
                        End If
                    Else
                        If Enemy(e).Flag2 > FALSE Then
                            Put (Enemy(e).x, -8 + Enemy(e).y), Slug&(800), PSet
                        Else
                            If Enemy(e).Flag3 > 10 Then j = 1 Else j = 0
                            Put (Enemy(e).x, -8 + Enemy(e).y), Slug&(((Enemy(e).dir - 1) * 200) + (j * 100)), PSet
                        End If
                    End If
                Case 5
                    If Freezed = FALSE Then
                        If Enemy(e).Flag3 > 0 Then
                            Enemy(e).Flag3 = Enemy(e).Flag3 - 1
                            If Enemy(e).Flag3 Mod 4 = 0 Then
                                Put (Enemy(e).x, -8 + Enemy(e).y), Spider&(1200 + ((Enemy(e).dir - 1) * 100)), PSet
                            Else
                                Put (Enemy(e).x, -8 + Enemy(e).y), Spider&(((Enemy(e).dir - 1) * 300) + 100), PSet
                            End If
                            If Enemy(e).Flag3 = 0 Then
                                For nb = 1 To 170
                                    If Block(nb).Status = 0 Then Exit For
                                Next nb
                                Block(nb).x = Enemy(e).x / 16: Block(nb).y = Enemy(e).y / 16
                                Block(nb).Status = WEB: Cel(Enemy(e).x / 16, Enemy(e).y / 16) = WEB
                                NumWeb = NumWeb + 1
                            End If
                        Else
                            If Enemy(e).x Mod 16 = 0 And Enemy(e).y Mod 16 = 0 Then
                                Enemy(e).dir = 0
                                If Cel((Enemy(e).x / 16) + xA(Enemy(e).dir), (Enemy(e).y / 16) + yA(Enemy(e).dir)) < 1 Then
                                    For h = 1 To 20
                                        Randomize Timer * TimeLeft
                                        d = Int(Rnd(1) * 4) + 1
                                        If Cel((Enemy(e).x / 16) + xA(d), (Enemy(e).y / 16) + yA(d)) < 1 Then
                                            Enemy(e).dir = d
                                            Exit For
                                        End If
                                        d = 0
                                    Next h
                                Else
                                    Randomize Timer * TimeLeft
                                    s = Int(Rnd(1) * 4) + 1
                                    If s = 1 Then
                                        k = Int(Rnd(1) * NunmPlayer) + 1
                                        If Player(k).x < Enemy(e).x Then d = 4
                                        If Player(k).x > Enemy(e).x Then d = 2
                                        If Player(k).y < Enemy(e).y Then d = 3
                                        If Player(k).y > Enemy(e).y Then d = 1
                                        If Cel((Enemy(e).x / 16) + xA(d), (Enemy(e).y / 16) + yA(d)) < 1 Then
                                            For h = 1 To 20
                                                Randomize Timer * TimeLeft
                                                d = Int(Rnd(1) * 4) + 1
                                                If Cel((Enemy(e).x / 16) + xA(d), (Enemy(e).y / 16) + yA(d)) < 1 Then
                                                    Enemy(e).dir = d
                                                    Exit For
                                                End If
                                            Next h
                                        Else
                                            Enemy(e).dir = d
                                        End If
                                    End If
                                End If
                                k = Int(Rnd(1) * 20) + 1
                                If k = 1 And Cel(Enemy(e).x / 16, Enemy(e).y / 16) <> WEB Then
                                    If NumWeb < 11 Then Enemy(e).Flag3 = 50
                                End If
                            End If
                            If Enemy(e).Flag3 = 0 Then
                                Put (Enemy(e).x, -8 + Enemy(e).y), Null&(), PSet
                                Enemy(e).x = Enemy(e).x + xA(Enemy(e).dir)
                                Enemy(e).y = Enemy(e).y + yA(Enemy(e).dir)
                                Enemy(e).Flag1 = Enemy(e).Flag1 + Enemy(e).Flag2
                                If Enemy(e).Flag1 <> 2 Then Enemy(e).Flag2 = -Enemy(e).Flag2
                                If Enemy(e).dir = 0 Then Enemy(e).dir = 1
                                Put (Enemy(e).x, -8 + Enemy(e).y), Spider&(((Enemy(e).dir - 1) * 300) + ((Enemy(e).Flag1 - 1) * 100)), PSet
                            End If
                        End If
                    Else
                        Put (Enemy(e).x, -8 + Enemy(e).y), Spider&(((Enemy(e).dir - 1) * 300) + ((Enemy(e).Flag1 - 1) * 100)), PSet
                    End If
                    If Enemy(e).dir = 0 Then Enemy(e).dir = 1
                Case 9
                    If Freezed = FALSE Then
                        Put (Enemy(e).x, -8 + Enemy(e).y), Null&(), PSet
                        If Enemy(e).x Mod 16 = 0 And Enemy(e).y Mod 16 = 0 Then
                            If Cel((Enemy(e).x / 16) + xA(Enemy(e).dir), (Enemy(e).y / 16) + yA(Enemy(e).dir)) < 1 Then
                                Enemy(e).x = Enemy(e).x + (xA(Enemy(e).dir) * 8)
                                Enemy(e).y = Enemy(e).y + (yA(Enemy(e).dir) * 8)
                                Put (Enemy(e).x, -8 + Enemy(e).y), Slug&(900), PSet
                            Else
                                Enemy(e).Typ = 0
                                For h = 1 To 60
                                    If Object(h).Typ = 0 Then Exit For
                                Next h
                                Object(h).Typ = -3: Object(h).Time = 3
                                Object(h).x = Enemy(e).x
                                Object(h).y = -8 + Enemy(e).y
                            End If
                        Else
                            Enemy(e).x = Enemy(e).x + (xA(Enemy(e).dir) * 8)
                            Enemy(e).y = Enemy(e).y + (yA(Enemy(e).dir) * 8)
                            Put (Enemy(e).x, -8 + Enemy(e).y), Slug&(900), PSet
                        End If
                    Else
                        Put (Enemy(e).x, -8 + Enemy(e).y), Slug&(900), PSet
                    End If
            End Select
            GoOn = FALSE
            For C = 1 To NumPlayer
                If Enemy(e).x > Player(C).x - 16 And Enemy(e).x < Player(C).x + 16 Then
                    If Enemy(e).y > Player(C).y - 16 And Enemy(e).y < Player(C).y + 16 Then
                        If Enemy(e).Typ = 3 And Enemy(e).Flag3 <> 0 Then GoOn = TRUE
                        If GoOn = FALSE Then
                            KillPlayer C
                            Killed = TRUE ': TIMER OFF
                            Player(C).Lives = Player(C).Lives - 1: Exit Sub
                        End If
                    End If
                End If
            Next C
        End If
    Next e

End Sub

Sub OutText (x, y, t$)
    For i = 1 To Len(t$)
        ChCode = Asc(Mid$(t$, i, 1))
        Select Case ChCode
            Case 65 TO 90: Ch = ChCode - 65
            Case 48 TO 57: Ch = ChCode - 22
            Case 46: Ch = 36
            Case 58: Ch = 37
            Case 44: Ch = 38
            Case 59: Ch = 39
            Case 33: Ch = 40
            Case 63: Ch = 41
            Case 45: Ch = 42
            Case 43: Ch = 43
            Case 95: Ch = 44
            Case 32: Ch = 45
        End Select
        Put (x, y), Char&(Ch * 20), PSet
        x = x + 7
    Next i
End Sub

Function PlayAgain
    '
    Center 96, "PLAY AGAIN ?"
    Do
        k$ = InKey$: k$ = UCase$(k$)
        If k$ = "Y" Then PlayAgain = TRUE: Exit Do
        If k$ = "N" Then PlayAgain = FALSE: Exit Do
    Loop
  
End Function

Sub PlayGame

    MaxLevel = 21
    Level = 1
    For i = 1 To 2
        Player(i).Score = 0
        Player(i).Lives = 3
        Player(i).NextLife = 30000
        Player(i).BonusE = FALSE
        Player(i).BonusX = FALSE
        Player(i).BonusT = FALSE
        Player(i).BonusR = FALSE
        Player(i).BonusA = FALSE
        Player(i).Bonus = 0
        Player(i).Cutter = FALSE
        Player(i).Trapped = FALSE
    Next i
    If NumPlayer = 1 Then Player(2).Lives = 0
    AbortGame = FALSE
    Do
        LoadLevel
        For i = 0 To 11: Put (0, 8 + (i * 16)), Wall&(), PSet
        Put (304, 8 + (i * 16)), Wall&(), PSet: Next i
        If Player(1).Cutter = TRUE Then Put (0, 8), CutHole&(), PSet: Put (0, 8), Obj&(1200), Xor
        If Player(2).Cutter = TRUE Then Put (304, 8), CutHole&(), PSet: Put (304, 8), Obj&(1200), Xor
        OutText 0, 0, "1UP": OutText 204, 0, "2UP"
        Put (128, 0), Clock&(), PSet: Put (167, 0), Flag&(), PSet
        PrintStatBar
        DrawScreen
        For i = 1 To NumPlayer
            Player(i).dir = 1
            Player(i).NextDir = 0
            Player(i).Frame = 2
            Player(i).FrameDir = 1
            Player(i).Action = NONE
            Player(i).Spd = 2
            If Player(i).BonusE = TRUE Then Put ((i - 1) * 304, 64), Hole&(), PSet: Put ((i - 1) * 304, 64), Obj&(2100), Xor
            If Player(i).BonusX = TRUE Then Put ((i - 1) * 304, 80), Hole&(), PSet: Put ((i - 1) * 304, 80), Obj&(2200), Xor
            If Player(i).BonusT = TRUE Then Put ((i - 1) * 304, 96), Hole&(), PSet: Put ((i - 1) * 304, 96), Obj&(2300), Xor
            If Player(i).BonusR = TRUE Then Put ((i - 1) * 304, 112), Hole&(), PSet: Put ((i - 1) * 304, 112), Obj&(2400), Xor
            If Player(i).BonusA = TRUE Then Put ((i - 1) * 304, 128), Hole&(), PSet: Put ((i - 1) * 304, 128), Obj&(2500), Xor
            Put (Player(i).x, -8 + Player(i).y), Crab&(((i - 1) * 2000) + ((Player(i).dir - 1) * 300) + ((Player(i).Frame - 1) * 100)), PSet
            Player(i).Trapped = FALSE
        Next i
        For i = 1 To 20
            Select Case Enemy(i).Typ
                Case 1: Put (Enemy(i).x, -8 + Enemy(i).y), Worm&(800), PSet
                Case 2: Put (Enemy(i).x, -8 + Enemy(i).y), Robot&(0), PSet
                Case 3: Put (Enemy(i).x, -8 + Enemy(i).y), Ghost&(0), PSet
                Case 4: Put (Enemy(i).x, -8 + Enemy(i).y), Slug&(0), PSet
                Case 5: Put (Enemy(i).x, -8 + Enemy(i).y), Spider&(100), PSet
                Case 6: Put (Enemy(i).x, -8 + Enemy(i).y), Shadow&(0), PSet
                Case 7: Put (Enemy(i).x, -8 + Enemy(i).y), Putty&(100), PSet
                Case 8: Put (Enemy(i).x, -8 + Enemy(i).y), Ball&(300), PSet
            End Select
        Next i
        TimeLeft = 90: PrintStatBar
        Message "READY!"
        Pass = -1: Killed = FALSE
        GameMode = NORMAL: Freezed = FALSE: Multi# = 1: Killed = FALSE
        LastTime$ = Time$: BonusAlone = FALSE: Change = FALSE
        Do
            StartT! = Timer

            Do: time1! = Timer: Loop Until time1! <> time2!
            time2! = time1!

            k$ = InKey$: k$ = UCase$(k$)
            Select Case k$
                Case "2"
                    If Player(1).Action <> FIRE Then
                        If Player(1).NextDir = 0 And Player(1).Action = NONE Then
                            Player(1).dir = 1: Player(1).NextDir = 1: Player(1).Action = MOVE
                        Else
                            Player(1).NextDir = 1: Player(1).Action = MOVE
                        End If
                    End If
                Case "6"
                    If Player(1).Action <> FIRE Then
                        If Player(1).NextDir = 0 And Player(1).Action = NONE Then
                            Player(1).dir = 2: Player(1).NextDir = 2: Player(1).Action = MOVE
                        Else
                            Player(1).NextDir = 2: Player(1).Action = MOVE
                        End If
                    End If
                Case "8"
                    If Player(1).Action <> FIRE Then
                        If Player(1).NextDir = 0 And Player(1).Action = NONE Then
                            Player(1).dir = 3: Player(1).NextDir = 3: Player(1).Action = MOVE
                        Else
                            Player(1).NextDir = 3: Player(1).Action = MOVE
                        End If
                    End If
                Case "4"
                    If Player(1).Action <> FIRE Then
                        If Player(1).NextDir = 0 And Player(1).Action = NONE Then
                            Player(1).dir = 4: Player(1).NextDir = 4: Player(1).Action = MOVE
                        Else
                            Player(1).NextDir = 4: Player(1).Action = MOVE
                        End If
                    End If
                Case "5": If Player(1).Action <> FIRE Then Player(1).NextDir = 0: Player(1).Action = MOVE
                Case Chr$(13)
                    If Player(1).Action = NONE Then Player(1).Action = FIRE: Player(1).Frame = 1
                Case "X"
                    If Player(2).Action <> FIRE Then
                        If Player(2).NextDir = 0 And Player(2).Action = NONE Then
                            Player(2).dir = 1: Player(2).NextDir = 1: Player(2).Action = MOVE
                        Else
                            Player(2).NextDir = 1: Player(2).Action = MOVE
                        End If
                    End If
                Case "D"
                    If Player(2).Action <> FIRE Then
                        If Player(2).NextDir = 0 And Player(2).Action = NONE Then
                            Player(2).dir = 2: Player(2).NextDir = 2: Player(2).Action = MOVE
                        Else
                            Player(2).NextDir = 2: Player(2).Action = MOVE
                        End If
                    End If
                Case "W"
                    If Player(2).Action <> FIRE Then
                        If Player(2).NextDir = 0 And Player(2).Action = NONE Then
                            Player(2).dir = 3: Player(2).NextDir = 3: Player(2).Action = MOVE
                        Else
                            Player(2).NextDir = 3: Player(2).Action = MOVE
                        End If
                    End If
                Case "A"
                    If Player(2).Action <> FIRE Then
                        If Player(2).NextDir = 0 And Player(2).Action = NONE Then
                            Player(2).dir = 4: Player(2).NextDir = 4: Player(2).Action = MOVE
                        Else
                            Player(2).NextDir = 4: Player(2).Action = MOVE
                        End If
                    End If
                Case "S": If Player(2).Action <> FIRE Then Player(2).NextDir = 0: Player(2).Action = MOVE
                Case "\"
                    If Player(2).Action = NONE Then Player(2).Action = FIRE: Player(2).Frame = 1
                Case "P"
                    Message "PAUSE!"
                Case Chr$(27): AbortGame = TRUE: Exit Do
            End Select
            For i = 1 To NumPlayer
                If Player(i).Trapped = FALSE Then
                    If Player(i).Action <> NONE Then Put (Player(i).x, -8 + Player(i).y), Null&(), PSet
                    Select Case Player(i).Action
                        Case MOVE
                            Select Case Player(i).NextDir
                                Case 0
                                    If Player(i).x Mod 16 = 0 And Player(i).y Mod 16 = 0 Then
                                        Player(i).Action = NONE: Player(i).Frame = 2
                                    End If
                                Case 1
                                    If Player(i).x Mod 16 = 0 And Player(i).y Mod 16 = 0 Then
                                        If Cel(Player(i).x / 16, (Player(i).y / 16) + 1) < 1 Then Player(i).dir = Player(i).NextDir Else Player(i).dir = Player(i).NextDir: Player(i).Action = NONE
                                    End If
                                Case 2
                                    If Player(i).x Mod 16 = 0 And Player(i).y Mod 16 = 0 Then
                                        If Cel((Player(i).x / 16) + 1, Player(i).y / 16) < 1 Then Player(i).dir = Player(i).NextDir Else Player(i).dir = Player(i).NextDir: Player(i).Action = NONE
                                    End If
                                Case 3
                                    If Player(i).x Mod 16 = 0 And Player(i).y Mod 16 = 0 Then
                                        If Cel(Player(i).x / 16, (Player(i).y / 16) - 1) < 1 Then Player(i).dir = Player(i).NextDir Else Player(i).dir = Player(i).NextDir: Player(i).Action = NONE
                                    End If
                                Case 4
                                    If Player(i).x Mod 16 = 0 And Player(i).y Mod 16 = 0 Then
                                        If Cel((Player(i).x / 16) - 1, Player(i).y / 16) < 1 Then Player(i).dir = Player(i).NextDir Else Player(i).dir = Player(i).NextDir: Player(i).Action = NONE
                                    End If
                            End Select
                            Select Case Player(i).dir
                                Case 1
                                    If (Player(i).y) Mod 16 = 0 Then
                                        If Cel(Player(i).x / 16, ((Player(i).y) / 16) + 1) > 0 Then Player(i).Action = NONE: Player(i).Frame = 2
                                    End If
                                    If Player(i).Action = MOVE Then
                                        Player(i).y = Player(i).y + Player(i).Spd
                                        Player(i).Frame = Player(i).Frame + Player(i).FrameDir
                                        If Player(i).Frame = 3 Or Player(i).Frame = 1 Then Player(i).FrameDir = -Player(i).FrameDir
                                    End If
                                Case 2
                                    If (Player(i).x) Mod 16 = 0 Then
                                        If Cel((Player(i).x / 16) + 1, (Player(i).y) / 16) > 0 Then Player(i).Action = NONE: Player(i).Frame = 2
                                    End If
                                    If Player(i).Action = MOVE Then
                                        Player(i).x = Player(i).x + Player(i).Spd
                                        Player(i).Frame = Player(i).Frame + Player(i).FrameDir
                                        If Player(i).Frame = 3 Or Player(i).Frame = 1 Then Player(i).FrameDir = -Player(i).FrameDir
                                    End If
                                Case 3
                                    If (Player(i).y) Mod 16 = 0 Then
                                        If Cel(Player(i).x / 16, ((Player(i).y) / 16) - 1) > 0 Then Player(i).Action = NONE: Player(i).Frame = 2
                                    End If
                                    If Player(i).Action = MOVE Then
                                        Player(i).y = Player(i).y - Player(i).Spd
                                        Player(i).Frame = Player(i).Frame + Player(i).FrameDir
                                        If Player(i).Frame = 3 Or Player(i).Frame = 1 Then Player(i).FrameDir = -Player(i).FrameDir
                                    End If
                                Case 4
                                    If (Player(i).x) Mod 16 = 0 Then
                                        If Cel((Player(i).x / 16) - 1, (Player(i).y) / 16) > 0 Then Player(i).Action = NONE: Player(i).Frame = 2
                                    End If
                                    If Player(i).Action = MOVE Then
                                        Player(i).x = Player(i).x - Player(i).Spd
                                        Player(i).Frame = Player(i).Frame + Player(i).FrameDir
                                        If Player(i).Frame = 3 Or Player(i).Frame = 1 Then Player(i).FrameDir = -Player(i).FrameDir
                                    End If
                            End Select
                            Put (Player(i).x, -8 + Player(i).y), Crab&(((i - 1) * 2000) + ((Player(i).dir - 1) * 300) + ((Player(i).Frame - 1) * 100)), PSet
                        Case NONE
                            Put (Player(i).x, -8 + Player(i).y), Crab&(((i - 1) * 2000) + ((Player(i).dir - 1) * 300) + ((Player(i).Frame - 1) * 100)), PSet
                        Case FIRE
                            Select Case Player(i).Frame
                                Case 1
                                    Put (Player(i).x, -8 + Player(i).y), Crab&(((i - 1) * 2000) + ((Player(i).dir - 1) * 300) + 100), PSet
                                    Player(i).Frame = Player(i).Frame + 1
                                Case 2, 3, 4
                                    Put (Player(i).x, -8 + Player(i).y), Crab&(((i - 1) * 2000) + 1200 + ((Player(i).dir - 1) * 100)), PSet
                                    Player(i).Frame = Player(i).Frame + 1
                                Case 5
                                    Put (Player(i).x, -8 + Player(i).y), Crab&(((i - 1) * 2000) + 1200 + ((Player(i).dir - 1) * 100)), PSet
                                    If Player(i).dir = 1 Then
                                        For B = 1 To 170
                                            If Block(B).Status = NORMALBLOCK Or Block(B).Status = SPECIALBLOCK Then
                                                If Block(B).x = Player(i).x / 16 And Block(B).y = (Player(i).y / 16) + 1 Then
                                                    Block(B).Status = NMOVINGDOWN + ((Block(B).Status - 2) * 4)
                                                    Block(B).JustMoved = TRUE: Block(B).MovedBy = i
                                                End If
                                            End If
                                        Next B
                                    End If
                                    If Player(i).dir = 2 Then
                                        For B = 1 To 170
                                            If Block(B).Status = NORMALBLOCK Or Block(B).Status = SPECIALBLOCK Then
                                                If Block(B).x = (Player(i).x / 16) + 1 And Block(B).y = Player(i).y / 16 Then
                                                    Block(B).Status = NMOVINGRIGHT + ((Block(B).Status - 2) * 4)
                                                    Block(B).JustMoved = TRUE: Block(B).MovedBy = i
                                                End If
                                            End If
                                        Next B
                                    End If
                                    If Player(i).dir = 3 Then
                                        For B = 1 To 170
                                            If Block(B).Status = NORMALBLOCK Or Block(B).Status = SPECIALBLOCK Then
                                                If Block(B).x = Player(i).x / 16 And Block(B).y = (Player(i).y / 16) - 1 Then
                                                    Block(B).Status = NMOVINGUP + ((Block(B).Status - 2) * 4)
                                                    Block(B).JustMoved = TRUE: Block(B).MovedBy = i
                                                End If
                                            End If
                                        Next B
                                    End If
                                    If Player(i).dir = 4 Then
                                        For B = 1 To 170
                                            If Block(B).Status = NORMALBLOCK Or Block(B).Status = SPECIALBLOCK Then
                                                If Block(B).x = (Player(i).x / 16) - 1 And Block(B).y = Player(i).y / 16 Then
                                                    Block(B).Status = NMOVINGLEFT + ((Block(B).Status - 2) * 4)
                                                    Block(B).JustMoved = TRUE: Block(B).MovedBy = i
                                                End If
                                            End If
                                        Next B
                                    End If
                                    Player(i).Frame = Player(i).Frame + 1
                                Case 6
                                    Put (Player(i).x, -8 + Player(i).y), Crab&(((i - 1) * 2000) + ((Player(i).dir - 1) * 300) + 100), PSet
                                    Player(i).Action = NONE: Player(i).NextDir = 0: Player(i).Frame = 2
                            End Select
                    End Select
                Else
                    Player(i).Trapped = Player(i).Trapped - 1
                    If Player(i).Trapped = 0 Then Player(i).NextDir = 0
                    Put (Player(i).x, -8 + Player(i).y), Spider&(1700 + ((i - 1) * 100)), PSet
                End If
                If Player(i).x Mod 16 = 0 And Player(i).y Mod 16 = 0 Then
                    If Cel(Player(i).x / 16, Player(i).y / 16) = -1 Then
                        If Player(i).Cutter = FALSE Then Player(i).Trapped = 150
                        NumWeb = NumWeb - 1
                        For nb = 1 To 170
                            If Block(nb).x = Player(i).x / 16 And Block(nb).y = Player(i).y / 16 Then Block(nb).Status = 0: Exit For
                        Next nb
                        Cel(Player(i).x / 16, Player(i).y / 16) = 0
                    End If
                End If
            Next i
            CheckObjects
            MoveEnemies
            CheckBlocks
            If BonusAlone = FALSE And GameMode = NORMAL Then
                Randomize Timer
                l = Int(Rnd(1) * 100) + 1
                If l = 1 Then
                    For k = 1 To 60: If Object(k).Typ = 0 Then Exit For
                    Next k
                    Object(k).Typ = Bonus(Int(Rnd(1) * 20) + 1)
                    Do
                        xo = Int(Rnd(1) * 18) + 1
                        yo = Int(Rnd(1) * 12) + 1
                        If Cel(xo, yo) = 0 Then Exit Do
                    Loop
                    Object(k).x = xo * 16
                    Object(k).y = -8 + (yo) * 16
                    Object(k).Time = 400
                    Object(k).Alone = TRUE
                    BonusAlone = TRUE
                End If
            End If
            If Time$ <> LastTime$ And Pass = -1 Then
                LastTime$ = Time$
                TimeLeft = TimeLeft - 1
                cl$ = LTrim$(Str$(TimeLeft))
                If Len(cl$) < 3 Then cl$ = String$(3 - Len(cl$), "0") + cl$
                OutText 137, 0, cl$
            End If
            If TimeLeft = 0 Then
                Pass = 0
                If GameMode = NORMAL Then
                    For q = 1 To NumPlayer: Player(q).Lives = Player(q).Lives - 1
                    Put (Player(q).x, -8 + Player(q).y), Crab&(((q - 1) * 2000) + 1900), PSet: Next q
                    Message "TIME UP!"
                    For i = 1 To NumPlayer
                        KillPlayer i
                    Next i
                    Pass = -1
                End If
                Exit Do
            End If
            If Freezed > FALSE Then Freezed = Freezed - 1
            If Killed = TRUE Then Pass = -1: Exit Do
            If NumEnemy = 0 And Pass = -1 Then Pass = 150
            If Pass <> -1 Then Pass = Pass - 1: If Pass = 0 Then Exit Do
            Do: Loop While Timer < StartT! + .001
        Loop
        If AbortGame = TRUE Then
            Message "GAME ABORTED!"
            Screen 0: Width 80
            Print "WetSpot v0.9"
            Print "(C) by Angelo Mottola soft 1996"
            Print: Print "Final release will include:"
            Print " - 100 levels (I hope so...)"
            Print " - 8 different enemies"
            Print " - Sound Blaster Music and sound effects"
            Print " - More and more fun !!"
            Print: Print "Coming soon..."
            Print: End
        End If
        If Pass = 0 Then
            If GameMode = NORMAL Then
                For i = 1 To NumPlayer
                    Put (Player(i).x, -8 + Player(i).y), Crab&(((i - 1) * 2000) + 100), PSet
                Next i
                Delay .08
                For i = 1 To NumPlayer
                    Put (Player(i).x, -8 + Player(i).y), Crab&(((i - 1) * 2000) + 1600), PSet
                Next i
                Delay .08
                For i = 1 To NumPlayer
                    Put (Player(i).x, -8 + Player(i).y), Crab&(((i - 1) * 2000) + 1700), PSet
                Next i
                Delay .08
                For i = 1 To NumPlayer
                    Put (Player(i).x, -8 + Player(i).y), Crab&(((i - 1) * 2000) + 1800), PSet
                Next i
                While InKey$ <> "": Wend
                q$ = InKey$: While (q$ <> Chr$(13) And q$ <> "\"): q$ = InKey$: Wend
                Level = Level + 1
            Else
                For i = 1 To NumPlayer
                    Line (((i - 1) * 160) + 20, 50)-(((i - 1) * 160) + 140, 150), 0, BF
                    Line (((i - 1) * 160) + 21, 51)-(((i - 1) * 160) + 139, 149), 27, B
                    Line (((i - 1) * 160) + 22, 52)-(((i - 1) * 160) + 138, 148), 29, B
                    Line (((i - 1) * 160) + 23, 53)-(((i - 1) * 160) + 137, 147), 31, B
                    OutText (((i - 1) * 160) + 39), 60, "POTION BONUS"
                    Line (((i - 1) * 160) + 27, 75)-(((i - 1) * 160) + 133, 137), 29, B
                    Put ((((i - 1) * 160) + 30), 79), Obj&(2000), PSet
                    te$ = "X " + LTrim$(Str$(Player(i).Special)) + ": " + LTrim$(Str$(Player(i).Special * 200))
                    OutText (((i - 1) * 160) + 53), 84, te$
                    Put ((((i - 1) * 160) + 30), 97), Obj&(1500), PSet
                    te$ = "X " + LTrim$(Str$(TimeLeft)) + ": " + LTrim$(Str$(TimeLeft * 1000))
                    OutText (((i - 1) * 160) + 53), 102, te$
                    OutText (((i - 1) * 160) + 30), 115, "MULTIPLIER X" + LTrim$(Str$(Multi#))
                    Tot# = (((Player(i).Special * 200) + (TimeLeft * 1000))) * Multi#
                    OutText (((i - 1) * 160) + 30), 125, "TOTAL : " + LTrim$(Str$(Tot#))
                    Player(i).Score = Player(i).Score + Tot#
                    PrintStatBar
                Next i
                While InKey$ <> "": Wend
                q$ = InKey$: While (q$ <> Chr$(13) And q$ <> "\"): q$ = InKey$: Wend
                Level = Level + 1
            End If
        ElseIf Pass = -1 Then
            Player(1).Cutter = FALSE: Player(2).Cutter = FALSE
            While InKey$ <> "": Wend
            q$ = InKey$: While (q$ <> Chr$(13) And q$ <> "\"): q$ = InKey$: Wend
        Else
            While InKey$ <> "": Wend
            q$ = InKey$: While (q$ <> Chr$(13) And q$ <> "\"): q$ = InKey$: Wend
        End If
        If NumPlayer = 2 Then
            If Player(1).Lives < 0 Or Player(2).Lives < 0 Then Exit Do
        Else
            If Player(1).Lives < 0 Then Exit Do
        End If
    Loop
    Message "GAME OVER!"
End Sub

Sub PrintStatBar
    For i = 1 To 2
        If Player(i).Score > Player(i).NextLife Then Player(i).NextLife = Player(i).NextLife * 2: Player(i).Lives = Player(i).Lives + 1
        s$(i) = LTrim$(Str$(Player(i).Score))
        If Player(i).Score = 0 Then s$(i) = "00"
        If Len(s$(i)) < 7 Then s$(i) = String$(7 - Len(s$(i)), " ") + s$(i)
        OutText (((i - 1) * 204) + 28), 0, s$(i)
        If Player(i).Lives > 3 Then
            For ii = 0 To 2: Put ((((i - 1) * 204) + 91) + (ii * 8), 0), Life&((i - 1) * 20), PSet: Next ii
            OutText (((i - 1) * 204) + 85), 0, LTrim$(Str$(Player(i).Lives))
        Else
            For ii = 0 To Player(i).Lives - 1: Put ((((i - 1) * 204) + 91) + (ii * 8), 0), Life&((i - 1) * 20), PSet: Next ii
        End If
    Next i
    s$(1) = LTrim$(Str$(TimeLeft))
    If Len(s$(1)) < 3 Then s$(1) = String$(3 - Len(s$(1)), "0") + s$(1)
    OutText 137, 0, s$(1)
    s$(2) = LTrim$(Str$(Level))
    If Len(s$(2)) < 2 Then s$(2) = String$(2 - Len(s$(2)), "0") + s$(2)
    OutText 176, 0, s$(2)

End Sub

Sub PrintValue (xv, yv, va)
    v$ = LTrim$(Str$(va))
    ad = (16 - (Len(v$) * 4)) / 2
    For l = 1 To Len(v$)
        Put (xv + ad, yv + 6), Number&((Asc(Mid$(v$, l, 1)) - 48) * 10), PSet
        ad = ad + 4
    Next l
End Sub

